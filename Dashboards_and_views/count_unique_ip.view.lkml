view: count_unique_ip {
  derived_table: {
    sql: SELECT date(AA.viewing_start_utc) as date,
       AA.ip as ip
FROM dragon.viewership_content_sessions_combined AA
 ;;
  }


  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }


  dimension: ip {
    type: string
    sql: ${TABLE}."ip" ;;
  }


  set: detail {
    fields: [date, ip]
  }
}
