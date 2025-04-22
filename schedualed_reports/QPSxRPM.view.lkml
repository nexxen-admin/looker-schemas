view: QPSxRPM {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: With Request_Data as (
      Select event_time::date as event_date,
        case when ad.rx_ssp_name ilike 'rmp%' then 'Unruly' else '3P' end as Supply_Source,
        case when ad.rx_ssp_name not ilike 'rmp%' then ssp.rx_ssp_name_display
          else sp.publisher_name end as Supply_Name,
        sum(case when (ad.rx_request_status is NULL or ad.rx_request_status in ('nodsp','nodspbids','bidresponse'))
            then ad.requests else 0 end) as Valid_Requests,
        sum(ad.revenue) as Revenue
      From andromeda.ad_data_daily ad
        left outer join andromeda.rx_dim_ssp ssp on ssp.rx_ssp_name = ad.rx_ssp_name
        left outer join andromeda.rx_dim_supply_publisher sp on sp.publisher_id::varchar = ad.pub_id
                and ad.rx_ssp_name ilike 'rmp%'
      Where ad.event_time >= current_date()-1
        and ad.event_time < current_date()
        and (ad.requests > 0 or revenue > 0)
      Group by 1, 2, 3)--,


      Select event_date,
        supply_source,
        supply_name,
        revenue,
        valid_requests as Request,
        round(valid_requests / (24*60*60),0) as QPS,
        round(revenue / (valid_requests / 1000000),1) as RPM,
        sum(Valid_Requests) over (partition by event_date) as Daily_Requests,
        valid_requests / sum(Valid_Requests) over (partition by event_date) as Pct_of_Total_Requests
      From Request_Data
      where Valid_Requests >= '500000'
      Group by 1, 2, 3, 4, 5
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_date {
    type: date
    sql: ${TABLE}.event_date ;;
  }

  dimension: supply_source {
    type: string
    sql: ${TABLE}.supply_source ;;
  }

  dimension: supply_name {
    type: string
    sql: ${TABLE}.supply_name ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: request {
    type: number
    sql: ${TABLE}.Request ;;
  }

  dimension: qps {
    type: number
    sql: ${TABLE}.QPS ;;
  }

  dimension: rpm {
    type: number
    sql: ${TABLE}.RPM ;;
  }

  dimension: daily_requests {
    type: number
    sql: ${TABLE}.Daily_Requests ;;
  }

  dimension: pct_of_total_requests {
    type: number
    sql: ${TABLE}.Pct_of_Total_Requests ;;
  }

  set: detail {
    fields: [
      event_date,
      supply_source,
      supply_name,
      revenue,
      request,
      qps,
      rpm,
      daily_requests,
      pct_of_total_requests
    ]
  }
}
