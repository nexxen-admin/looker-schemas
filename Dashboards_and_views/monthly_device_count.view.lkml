view: monthly_device_count {
  derived_table: {
    sql: SELECT
       CASE  WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -1) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN 'between_0_to_30_days'
                             WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -2) and ADD_MONTHS(CURRENT_TIMESTAMP, -1) THEN 'between_30_to_60_days'
                             WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -3) and ADD_MONTHS(CURRENT_TIMESTAMP, -2) THEN 'between_60_to_90_days'
                             WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -4) and ADD_MONTHS(CURRENT_TIMESTAMP, -3) THEN 'between_90_to_120_days'
                             ELSE null
                             END AS date_segment,
       COUNT(DISTINCT AA.device_id) as count_devices,
       COUNT(DISTINCT AA.ip) as count_ip
FROM dragon.viewership_content_sessions_combined_daily AA
GROUP BY 1
ORDER BY 1 DESC
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date_segment {
    type: string
    sql: ${TABLE}.date_segment ;;
  }


  measure: count_devices {
    type: average
    sql: ${TABLE}.count_devices ;;
  }

  measure: count_ip {
    type: average
    sql: ${TABLE}.count_ip ;;
  }



  set: detail {
    fields: [date_segment, count_devices,count_ip]
  }
}
