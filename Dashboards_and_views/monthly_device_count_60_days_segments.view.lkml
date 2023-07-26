view: monthly_device_count_60_days_segments {
  derived_table: {
    sql: SELECT
  COUNT(DISTINCT CASE WHEN viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -1) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN device_id END) AS between_0_to_30_days,
  COUNT(DISTINCT CASE WHEN viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -2) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN device_id END) AS between_0_to_60_days,
  COUNT(DISTINCT CASE WHEN viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -3) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN device_id END) AS between_0_to_90_days,
  COUNT(DISTINCT CASE WHEN viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -1) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN ip END) AS ip_between_0_to_30_days,
  COUNT(DISTINCT CASE WHEN viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -2) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN ip END) AS ip_between_0_to_60_days,
  COUNT(DISTINCT CASE WHEN viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -3) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN ip END) AS ip_between_0_to_90_days
FROM dragon.viewership_content_sessions_combined_daily AA

 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }



  measure: between_0_to_30_days {
    type: average
    sql: ${TABLE}.between_0_to_30_days ;;
  }

  measure: between_0_to_60_days {
    type: average
    sql: ${TABLE}.between_0_to_60_days ;;
  }

  measure: between_0_to_90_days {
    type: average
    sql: ${TABLE}.between_0_to_90_days ;;
  }

  measure: ip_between_0_to_30_days {
    type: average
    sql: ${TABLE}.between_0_to_30_days ;;
  }

  measure: ip_between_0_to_60_days {
    type: average
    sql: ${TABLE}.between_0_to_60_days ;;
  }

  measure: ip_between_0_to_90_days {
    type: average
    sql: ${TABLE}.between_0_to_90_days ;;
  }


  set: detail {
    fields: [between_0_to_30_days, between_0_to_60_days, between_0_to_90_days,ip_between_0_to_30_days, ip_between_0_to_60_days, ip_between_0_to_90_days]
  }
}
