view: acr_weekly_app_os_device_count {
  derived_table: {
    sql: SELECT DATE_TRUNC('WEEK',AA.viewing_start_utc) as week_date,
       BB.os,
       AA.tv_app_name,
       COUNT(DISTINCT AA.device_id) AS distinct_ip_count
FROM dragon.viewership_content_sessions_combined AA
LEFT JOIN dragon.device_info_r BB
ON AA.device_id = BB.device_id
GROUP BY 1,2,3
ORDER BY 1,2
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: week_year {
    type: date_week
    sql: ${TABLE}.week_year ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
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
    fields: [week_year, os, tv_app_name, distinct_ip_count]
  }
}
