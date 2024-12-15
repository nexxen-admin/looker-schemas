view: acr_weekly_ip_apps {
  derived_table: {
    sql: SELECT DATE_TRUNC('WEEK',AA.viewing_start_utc) as week_date,
       AA.tv_app_name,
      country,
       COUNT(DISTINCT AA.ip) AS distinct_ip_count
FROM dragon.viewership_content_sessions_combined_daily AA
where AA.viewing_start_utc>current_date - INTERVAL '1 month'
GROUP BY 1,2,3
ORDER BY 1,2,3
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

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }


  measure: distinct_ip_count {
    type: average
    sql: ${TABLE}.distinct_ip_count ;;
  }

  set: detail {
    fields: [week_date, tv_app_name,country, distinct_ip_count]
  }
}
