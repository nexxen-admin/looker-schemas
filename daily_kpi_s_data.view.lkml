view: daily_kpi_s_data {
  derived_table: {
    sql: SELECT
      event_time,
      country_code,
      pub_id,
      cast(sum(revenue)/4.5 as number) as revenue,
      cast(sum(responses)/4.5 as  number) responses ,
      cast(sum(requests)/4.5 as number) as bid_requests,
      cast(sum(impression_pixel)/4.5 as number) as impressions ,
      cast(sum(impression_win)/4.5 as number) as wins
      from andromeda.ad_data_daily
      where event_time >= CURRENT_DATE-7 and rx_ssp_name ilike 'rmp%'
      group by 1,2,3
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  dimension_group: event_time {
    type: time
    sql: ${TABLE}.event_time ;;
  }
  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }

  dimension: publisher_id {
    type: string
    sql: ${TABLE}.pub_id ;;
  }
  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  measure: responses {
    type: sum
    sql: ${TABLE}.responses ;;
  }

  measure: bid_requests {
    type: sum
    sql: ${TABLE}.bid_requests ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  measure: wins {
    type: sum
    sql: ${TABLE}.wins ;;
  }

  set: detail {
    fields: [
      event_time_time,
      revenue,
      responses,
      bid_requests,
      impressions,
      wins
    ]

  }
}
