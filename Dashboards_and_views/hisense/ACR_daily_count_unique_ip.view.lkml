view: ACR_daily_count_unique_ip {
  derived_table: {
    sql: SELECT date(AA.viewing_start_utc) as date,
    country,
       COUNT(DISTINCT AA.ip) as distinct_ip_count
FROM dragon.viewership_content_sessions_combined_daily AA
where AA.viewing_start_utc>current_date - INTERVAL '1 month'
GROUP BY 1,2
 ;;
  }


  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  measure: distinct_ip_count {
    type: average
    sql: ${TABLE}."distinct_ip_count" ;;
  }


  set: detail {
    fields: [date,country, distinct_ip_count]
  }
}
