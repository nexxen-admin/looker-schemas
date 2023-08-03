view: ACR_daily_count_unique_ip {
  derived_table: {
    sql: SELECT date(AA.viewing_start_utc) as date,
       COUNT(DISTINCT AA.ip) as distinct_ip_count
FROM dragon.viewership_content_sessions_combined_daily AA
GROUP BY 1
 ;;
  }


  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }


  measure: distinct_ip_count {
    type: average
    sql: ${TABLE}."distinct_ip_count" ;;
  }


  set: detail {
    fields: [date, distinct_ip_count]
  }
}
