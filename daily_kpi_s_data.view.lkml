view: daily_kpi_s_data {
  derived_table: {
    sql: SELECT
      event_time,
      sum(revenue)/457 as revenue,
      sum(responses)/457 as responses ,
      sum(requests)/457 as bid_requests,
      sum(impression_pixel)/457 as impressions ,
      sum(impression_win)/457 as wins
      from andromeda.ad_data_daily
      where event_time >= CURRENT_DATE-7
      group by 1
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
