view: fifa_dsp_metrics {
  derived_table: {
    sql:       Select   sp.publisher_id,
        sp.publisher_name,
        spl.placement_name,
        spl.placement_id,
        ad.country_code,
        dig.country_name,
        dig.sales_region as geo_region,
        da.rx_dsp_account_name as DSP_Account,
       -- Case when ad.media_id in ('253822','253646','253821','253645') then NULL else ad.rx_device_type end as Device_Type,
        --Case when ad.media_id in ('253822','253646','253821','253645') then NULL else ad.rx_imp_type end as Imp_Type,

        Case when ad.pub_id = '105362' then ad.rx_device_type
          when ad.media_id in ('253821','253822') then 'ctv' else 'non-ctv' end as Device_Type,
        Case when ad.pub_id = '105362' then ad.rx_imp_type else 'video' end as Imp_Type,

        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-1
            and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()
            THEN ad.responses else 0 end) as Bids_Y,
        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-2
            and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()-1
            THEN ad.responses else 0 end) as Bids_YM1,
        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-1
           and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()
         THEN ad.impression_pixel else 0 end) as Impressions_Y,
        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-2
           and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()-1
           THEN ad.impression_pixel else 0 end) as Impressions_YM1,
        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-1
           and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()
           THEN ad.revenue else 0 end) as revenue_Y,
        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-2
            and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()-1
            THEN ad.revenue else 0 end) as revenue_YM1
      From andromeda.ad_data_hourly ad
        left outer join andromeda.rx_dim_supply_placement spl on spl.placement_id = ad.media_id
        left outer join andromeda.rx_dim_supply_publisher_traffic_source spts on spts.pub_ts_id = spl.pub_ts_id
        left outer join andromeda.rx_dim_supply_publisher sp on sp.publisher_id = spts.publisher_id
        left outer join bi.svc_di_geo_classification dig on dig.country_code = ad.country_code
        left outer join andromeda.rx_dim_dsp dsp on dsp.rx_dsp_name = ad.rx_dsp_name
        left outer join andromeda.rx_dim_dsp_account da on da.rx_dsp_account_id = dsp.rx_dsp_account_id
      Where NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-2
        and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()
       and ad.rx_ssp_name ilike 'rmp%'
       and ad.pub_id in ('105254','105362')
       and (ad.responses > 0 or ad.impression_pixel > 0)
      Group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

    dimension: publisher_id {
      type: string
      label: "Pub ID"
      sql: ${TABLE}.publisher_id ;;
    }

    dimension: publisher_name {
      type: string
      label: "Publisher"
      sql: ${TABLE}.publisher_name ;;
    }

    dimension: placement_name {
      type: string
      label: "Placement"
      sql: ${TABLE}.placement_name ;;
    }

    dimension: placement_id {
      type: string
      label: "Placement ID"
      sql: ${TABLE}.placement_id ;;
    }

  dimension: Country_Code {
    type: string
    label: "Country Code"
    sql: ${TABLE}.Country_Code ;;
  }

    dimension: Country_Name {
      type: string
      label: "Country"
      sql: ${TABLE}.country_name ;;
    }

    dimension: Geo_Region {
      type: string
      label: "Geo Region"
      sql: ${TABLE}.Geo_Region ;;
    }

  dimension: dsp_account {
    type: string
    label: "DSP Account"
    sql: ${TABLE}.DSP_Account ;;
  }

      dimension: device_type {
        type: string
        label: "Device Type"
        sql: ${TABLE}.device_type ;;
      }

      dimension: imp_type {
        type: string
        label: "Imp Type"
        sql: ${TABLE}.imp_type ;;
      }

  measure: bids_y {
    type: sum
    label: "Bids Yesterday"
    value_format: "#,##0"
    sql: ${TABLE}.Bids_Y ;;
  }

  measure: bids_ym1 {
    type: sum
    label: "Bids Previous Day"
    value_format: "#,##0"
    sql: ${TABLE}.Bids_YM1 ;;
  }

  measure: impressions_y {
    type: sum
    label: "Imps Yesterday"
    value_format: "#,##0"
    sql: ${TABLE}.Impressions_Y ;;
  }

  measure: impressions_ym1 {
    type: sum
    label: "Imps Previous Day"
    value_format: "#,##0"
    sql: ${TABLE}.Impressions_YM1 ;;
  }

  measure: revenue_y {
    type: sum
    label: "Revenue Yesterday"
    value_format: "$#,##0"
    sql: ${TABLE}.revenue_Y ;;
  }

  measure: revenue_ym1 {
    type: sum
    label: "Revenue Previous Day"
    value_format: "$#,##0"
    sql: ${TABLE}.revenue_YM1 ;;
  }


  set: detail {
    fields: [
      publisher_id,
      publisher_name,
      placement_name,
      placement_id,
      Country_Code,
      Country_Name,
      Geo_Region,
      dsp_account,
      device_type,
      imp_type
    ]
  }
}
