view: acr_weekly_ip_apps {
  derived_table: {
    sql: SELECT DATE_TRUNC('WEEK',AA.viewing_start_utc) as week_date,
       AA.tv_app_name,
       COUNT(DISTINCT AA.ip) AS distinct_ip_count
FROM dragon.viewership_content_sessions_combined AA
GROUP BY 1,2
ORDER BY 1,2
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: week_date {
    type: date_week
    sql: ${TABLE}.week_date ;;
  }

  dimension: tv_app_name {
    type: string
    sql: ${TABLE}.tv_app_name ;;
  }

  measure: distinct_ip_count {
    type: average
    sql: ${TABLE}.distinct_ip_count ;;
  }

  set: detail {
    fields: [week_date, tv_app_name, distinct_ip_count]
  }
}
