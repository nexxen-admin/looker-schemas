view: ACR_daily_ip_per_day_try {
  derived_table: {
    sql: SELECT date(viewership_content_sessions_combined.viewing_start_utc),
                viewership_content_sessions_combined.device_id
FROM dragon.viewership_content_sessions_combined
 ;;
  }

  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }

  dimension: device_id {
    type: string
    sql: ${TABLE}."device_id" ;;
  }

  set: detail {
    fields: [date, device_id]
  }
}
