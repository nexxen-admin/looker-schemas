view: peerlogix_daily_device_ip_count {
  derived_table: {
    sql: SELECT date(AA.viewing_start_utc) as date,
       COUNT(DISTINCT AA.ip) as distinct_ip_count,
       COUNT(DISTINCT AA.device_id) as distinct_device_count
FROM dragon.viewership_content_peerlogix_daily AA
GROUP BY 1
 ;;
  }




  dimension_group: date {
    label: " "
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."date" ;;
  }




  measure: distinct_ip_count {
    type: average
    sql: ${TABLE}."distinct_ip_count" ;;
  }

  measure: distinct_device_count {
    type: average
    sql: ${TABLE}."distinct_device_count" ;;
  }

  set: detail {
    fields: [distinct_ip_count,distinct_device_count]
  }
}
