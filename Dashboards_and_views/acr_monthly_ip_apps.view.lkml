view: acr_monthly_ip_apps {
  derived_table: {
    sql: SELECT concat(concat(year(viewership_content_sessions_combined.viewing_start_utc),'-'),week(viewership_content_sessions_combined.viewing_start_utc)) as week_year,
       viewership_content_sessions_combined.tv_app_name,
       COUNT(DISTINCT viewership_content_sessions_combined.ip) AS distinct_ip_count
FROM dragon.viewership_content_sessions_combined
GROUP BY 1,2
ORDER BY 1,2
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: week_year {
    type: string
    sql: ${TABLE}.week_year ;;
  }

  measure: tv_app_name {
    type: string
    sql: ${TABLE}.tv_app_name ;;
  }

  measure: distinct_ip_count {
    type: average
    sql: ${TABLE}.distinct_ip_count ;;
  }

  set: detail {
    fields: [week_year, tv_app_name, distinct_ip_count]
  }
}
