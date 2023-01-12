view: bd_comm_report {
  derived_table: {
    sql: Select date_trunc('Month',r.event_date)::date as Event_Month,
          t.start_date,
          r.pub_id,
          r.publisher_name,
          r.bizdev_owner,
          r.bd_user_id,
          coalesce(bd.location,'Unknown') as BD_Office,
          coalesce(c.country,'Unknown') as BD_Country,
          sum(r.impressions) as Impressions,
          sum(r.revenue) as revenue,
          sum(r.cogs) as COGS,
          sum(r.revenue) - sum(r.cogs) as profit
       From
        (Select imp.event_time::date as event_date,
            imp.pub_id,
            pub.publisher_name,
            pb.name as bizdev_owner,
            pb.user_id as bd_user_id,
            sum(imp.impression_pixel) as Impressions,
            sum(imp.revenue) as Revenue,
            sum(imp.cogs) as COGS
        From andromeda.ad_data_daily imp
            inner join andromeda.rx_dim_publisher_info pi on pi.publisher_id = imp.pub_id
            inner join andromeda.rx_dim_publisher_bizdev_owner pb on pb.user_id = pi.bizdev_owner_id
            left outer join andromeda.rx_dim_supply_publisher pub on pub.publisher_id::varchar = imp.pub_id
        Where imp.event_time >= GREATEST(date('2021-01-01'),TIMESTAMPADD('Quarter', -5, date_trunc('Quarter',(CURRENT_TIMESTAMP)::date))::date)  --Change to 1 year before start of Quarter
            and imp.event_time < current_date() --'2020-10-01' end of quarter
            and imp.rx_ssp_name ilike 'rmp%'
            and imp.rx_ssp_name not ilike 'rmpak%'
        Group by 1, 2, 3, 4, 5
        ) r
        inner join (Select pub_id,  --limiting the data to new "keys" based on the dimensions below
              publisher_name,
              bd_user_id,
              bizdev_owner,
              min(start_date)::date as Start_Date
              From
              (
              Select pub_id,  /*top query here is standard but excludes publishers that need a date exception*/
                    pub.publisher_name,
                    pb.name as bizdev_owner,
                    pb.user_id as bd_user_id,
                    min(imp.event_time)::date as Start_Date
                From andromeda.ad_data_daily imp
                    inner join andromeda.rx_dim_publisher_info pi on pi.publisher_id = imp.pub_id
                    inner join andromeda.rx_dim_publisher_bizdev_owner pb on pb.user_id = pi.bizdev_owner_id
                    left outer join andromeda.rx_dim_supply_publisher pub on pub.publisher_id::varchar = imp.pub_id
                Where imp.event_time >= GREATEST(date('2020-12-01'),TIMESTAMPADD('Quarter', -9, date_trunc('Quarter',(CURRENT_TIMESTAMP)::date))::date) --Change to 2 years before start of Quarter, or 2020-06-01...whichever is more recent.
                    and imp.event_time < current_date()  --end of current quarter
                    and imp.rx_ssp_name ilike 'rmp%'
                    and imp.rx_ssp_name not ilike 'rmpak%'
                    and imp.revenue > 0
                    and imp.pub_id != '102404'  --exception (request of Ken)
                Group by 1, 2, 3, 4

      UNION

      Select pub_id,  /*this query here includes publishers that need a date exception*/
      pub.publisher_name,
      pb.name as bizdev_owner,
      pb.user_id as bd_user_id,
      min(imp.event_time)::date as Start_Date
      From andromeda.ad_data_daily imp
      inner join andromeda.rx_dim_publisher_info pi on pi.publisher_id = imp.pub_id
      inner join andromeda.rx_dim_publisher_bizdev_owner pb on pb.user_id = pi.bizdev_owner_id
      left outer join andromeda.rx_dim_supply_publisher pub on pub.publisher_id::varchar = imp.pub_id
      Where imp.event_time >= GREATEST(date('2020-09-01'),TIMESTAMPADD('Quarter', -9, date_trunc('Quarter',(CURRENT_TIMESTAMP)::date))::date) --Change to 2 years before start of Quarter, or 2020-06-01...whichever is more recent.
      and imp.event_time < current_date()  --end of current quarter
      and imp.rx_ssp_name ilike 'rmp%'
      and imp.rx_ssp_name not ilike 'rmpak%'
      and imp.revenue > 0
      and imp.pub_id = '102404'
      Group by 1, 2, 3, 4
      ) t
      Group by 1, 2, 3, 4) t on t.pub_id = r.pub_id
      and t.publisher_name = r.publisher_name
      and t.bizdev_owner = r.bizdev_owner
      and t.bd_user_id = r.bd_user_id
      and t.start_date >= case when t.pub_id = '102404' then GREATEST(date('2020-09-01'),TIMESTAMPADD('Quarter', -5, date_trunc('Quarter',(CURRENT_TIMESTAMP)::date))::date) --added for exception publishers
      else GREATEST(date('2021-01-01'),TIMESTAMPADD('Quarter', -5, date_trunc('Quarter',(CURRENT_TIMESTAMP)::date))::date) end  --Change to 1 year before start of Quarter
      and t.start_date <= r.event_date
      and timestampadd(DAY,365,t.start_date) >= r.event_date
      left outer join sandbox.svc_rmp_bizdev_mgrs bd on bd.userid = r.bd_user_id
      left outer join andromeda.rx_dim_country c on c.country_code = bd.country_code
      Where (bd.country_code != 'US' or bd.country_code is NULL)
      and r.bd_user_id not in ('12','20','24','30','39','25') --excluding legacy BDs
      Group by 1, 2, 3, 4, 5, 6, 7, 8
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_month {
    type: date
    sql: ${TABLE}.Event_Month ;;
  }

  dimension: start_date {
    type: date
    sql: ${TABLE}.start_date ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.pub_id ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  dimension: bizdev_owner {
    type: string
    sql: ${TABLE}.bizdev_owner ;;
  }

  dimension: bd_user_id {
    type: number
    sql: ${TABLE}.bd_user_id ;;
  }

  dimension: bd_office {
    type: string
    sql: ${TABLE}.BD_Office ;;
  }

  dimension: bd_country {
    type: string
    sql: ${TABLE}.BD_Country ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.Impressions ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: cogs {
    type: number
    sql: ${TABLE}.COGS ;;
  }

  dimension: profit {
    type: number
    sql: ${TABLE}.profit ;;
  }

  set: detail {
    fields: [
      event_month,
      start_date,
      pub_id,
      publisher_name,
      bizdev_owner,
      bd_user_id,
      bd_office,
      bd_country,
      impressions,
      revenue,
      cogs,
      profit
    ]
  }
}
