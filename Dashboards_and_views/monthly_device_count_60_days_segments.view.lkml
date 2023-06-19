view: monthly_device_count_60_days_segments {
  derived_table: {
    sql: SELECT
  COUNT(DISTINCT CASE WHEN viewing_start_utc >= CURRENT_DATE - INTERVAL '1 MONTH' THEN device_id END) AS users_1_month,
  COUNT(DISTINCT CASE WHEN viewing_start_utc >= CURRENT_DATE - INTERVAL '2 MONTH' THEN device_id END) AS users_2_months,
  COUNT(DISTINCT CASE WHEN viewing_start_utc >= CURRENT_DATE - INTERVAL '3 MONTH' THEN device_id END) AS users_3_months
FROM dragon.viewership_content_sessions_combined_daily AA

 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date_segment {
    type: string
    sql: ${TABLE}.date_segment ;;
  }


  measure: count_devices {
    type: average
    sql: ${TABLE}.count_devices ;;
  }

  set: detail {
    fields: [date_segment, count_devices]
  }
}
