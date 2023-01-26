view: ip_per_day_try {
  derived_table: {
    sql: SELECT date(viewership_content_sessions_combined.viewing_start_utc),
                viewership_content_sessions_combined.device_id
FROM dragon.viewership_content_sessions_combined
GROUP BY 1
ORDER BY 1
 ;;
  }

  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }

  measure: count {
    type: count_distinct
    sql: ${TABLE}.COUNT ;;
  }

  set: detail {
    fields: [date, count]
  }
}
