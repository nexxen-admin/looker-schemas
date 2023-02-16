view: ACR_daily_count_unique_ip {
  derived_table: {
    sql: SELECT date(AA.viewing_start_utc) as date,
       COUNT(DISTINCT AA.ip) as distinct_ip_count
FROM dragon.viewership_content_sessions_combined AA
 ;;
  }


  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }


  dimension: distinct_ip_count {
    type: number
    sql: ${TABLE}."distinct_ip_count" ;;
  }


  set: detail {
    fields: [date, distinct_ip_count]
  }
}
