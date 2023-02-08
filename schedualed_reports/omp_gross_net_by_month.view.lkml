view: omp_gross_net_by_month {
  derived_table: {
    sql: With NC_Pubs as
      (Select spts.publisher_id,
        nc.placement_id
      From
      (Select distinct placement_id::varchar(500) from
                    sandbox.SVC_NewsCorp_MRG_Placements
                 Union
                  Select spl.placement_id
                  From andromeda.rx_dim_supply_placement spl
                      left outer join andromeda.rx_dim_Supply_publisher_traffic_source spts on spts.pub_ts_id::varchar(500) = spl.pub_ts_id::varchar(500)
                  Where spts.publisher_id = '100730') nc
         left outer join andromeda.rx_dim_supply_placement spl on spl.placement_id = nc.placement_id
         left outer join andromeda.rx_dim_Supply_publisher_traffic_source spts on spts.pub_ts_id = spl.pub_ts_id
      Group by 1, 2 ),

      Imp_data as
      (Select event_time::date as Event_Date,
      add.pub_id,
      add.media_id,
      add.datacenter,
      add.rx_dsp_name,
      da.rx_dsp_account_name,
      s.rx_ssp_name_display,
      CASE WHEN add.datacenter = 'ams' and add.country_code in ('GB','FR','DE','IT','ES') THEN add.country_code
      WHEN add.datacenter = 'ap' and add.country_code in ('SG','ID','TH','VN','PH','IN','AU','NZ','JP','TW','HK','KR','MY') THEN add.country_code
      WHEN add.datacenter in ('iad','usw') and add.country_code in ('US','CA') THEN add.country_code
      ELSE 'Other' End as Country_Code,
      CASE WHEN add.revenue_type = 'firstparty' THEN '1st Party Demand'
      WHEN dt.rx_deal_type_name is NULL then 'OMP'
      Else 'PMP' End as Classification,
      add.rx_device_type,
      dt.rx_deal_type_name,
      sum(add.revenue) as Revenue,
      sum(add.revenue) - sum(add.cogs) AS Net_Revenue,
      sum(add.Impression_pixel) as Impressions
      From andromeda.ad_data_daily add
      Left outer join andromeda.rx_dim_deal dd on dd.deal_id_external = add.rx_deal_id
      Left outer join andromeda.rx_dim_deal_type dt on dd.rx_deal_type_id = dt.rx_deal_type_id
      left outer join andromeda.rx_dim_dsp dsp on dsp.rx_dsp_name = add.rx_dsp_name
      left outer join andromeda.rx_dim_dsp_account da on da.rx_dsp_account_id = dsp.rx_dsp_account_id
      left outer join andromeda.rx_dim_ssp s on s.rx_ssp_name = add.rx_ssp_name
      Where add.event_time >=  '2021-01-01' --DATE_TRUNC('QUARTER', current_date-63)
      and add.event_time < current_date
      and (add.revenue + add.impression_pixel) > 0
      Group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11)


      Select
      imp.event_date,
      imp.classification,
      imp.rx_deal_type_name as deal_type,
      CASE WHEN imp.datacenter = 'ams' THEN 'EMEA'
      WHEN imp.datacenter = 'ap' THEN 'APAC'
      WHEN imp.datacenter = 'iad' THEN 'US-East'
      WHEN imp.datacenter = 'usw' THEN 'US-West'
      Else 'Unknown' END as Region,
      Coalesce(c.country,'Other') as Country,
      imp.rx_dsp_name,
      imp.rx_dsp_account_name,
      imp.rx_ssp_name_display as rx_ssp_name,
      Case WHEN pl.placement_id is NULL then 'NO'
      ELSE 'YES' END as NC_Check,
      imp.rx_device_type as device_type,
      sum(imp.revenue) as Revenue,
      sum(imp.Net_Revenue) AS Net_Revenue,
      sum(imp.impressions) as Impressions
      From Imp_data imp
      left outer join NC_Pubs pl on pl.publisher_id::varchar(500) = imp.pub_id
      and pl.placement_id::varchar(500) = imp.media_id
      Left Outer Join andromeda.rx_dim_country c on c.country_code = imp.country_code
      WHERE imp.classification = 'OMP'
      Group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
      ORDER BY 1 ASC
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: event {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_date ;;
  }

  dimension: classification {
    type: string
    label: "Classification"
    sql: ${TABLE}.classification ;;
  }

  dimension: deal_type {
    type: string
    label: "Deal Type"
    sql: ${TABLE}.deal_type ;;
  }

  dimension: region {
    type: string
    label: "Region"
    sql: ${TABLE}.Region ;;
  }

  dimension: country {
    type: string
    label: "Country"
    sql: ${TABLE}.Country ;;
  }

  dimension: rx_dsp_name {
    type: string
    label: "DSP"
    sql: ${TABLE}.rx_dsp_name ;;
  }

  dimension: rx_dsp_account_name {
    type: string
    label: "DSP Account Name"
    sql: ${TABLE}.rx_dsp_account_name ;;
  }

  dimension: rx_ssp_name {
    type: string
    label: "SSP"
    sql: ${TABLE}.rx_ssp_name ;;
  }

  dimension: nc_check {
    type: string
    label: "NC Check"
    sql: ${TABLE}.NC_Check ;;
  }

  dimension: device_type {
    type: string
    label: "Device Type"
    sql: ${TABLE}.device_type ;;
  }

  measure: revenue {
    type: sum
    value_format: "#,##0.00"
    label: "Revenue"
    sql: ${TABLE}.Revenue ;;
  }

  measure: net_revenue {
    type: sum
    value_format: "#,##0.00"
    label: "Net Revenue"
    sql: ${TABLE}.Net_Revenue ;;
  }

  measure: impressions {
    type: sum
    label: "Impressions"
    sql: ${TABLE}.Impressions ;;
  }

  set: detail {
    fields: [
      event_date,
      classification,
      deal_type,
      region,
      country,
      rx_dsp_name,
      rx_dsp_account_name,
      rx_ssp_name,
      nc_check,
      device_type,
      revenue,
      net_revenue,
      impressions
    ]
  }
}
