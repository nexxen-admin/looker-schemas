view: monthly_device_count_60_days_segments {
  derived_table: {
    sql: SELECT
  COUNT(DISTINCT CASE WHEN viewing_start_utc >= CURRENT_DATE - INTERVAL '1 MONTH' THEN device_id END) AS between_0_to_30_days,
  COUNT(DISTINCT CASE WHEN viewing_start_utc >= CURRENT_DATE - INTERVAL '2 MONTH' THEN device_id END) AS between_0_to_60_days,
  COUNT(DISTINCT CASE WHEN viewing_start_utc >= CURRENT_DATE - INTERVAL '3 MONTH' THEN device_id END) AS between_0_to_90_days
FROM dragon.viewership_content_sessions_combined_daily AA

 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }



  measure: users_1_month {
    type: average
    sql: ${TABLE}.users_1_month ;;
  }

  measure: users_2_month {
    type: average
    sql: ${TABLE}.users_2_month ;;
  }

  measure: users_3_month {
    type: average
    sql: ${TABLE}.users_3_month ;;
  }

  set: detail {
    fields: [users_1_month, users_2_month, users_3_month]
  }
}
