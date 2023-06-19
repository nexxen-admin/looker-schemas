view: monthly_device_count {
  derived_table: {
    sql: SELECT
       CASE  WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -1) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN 'between_0_to_30_days'
                             WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -2) and ADD_MONTHS(CURRENT_TIMESTAMP, -1) THEN 'between_30_to_60_days'
                             WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -3) and ADD_MONTHS(CURRENT_TIMESTAMP, -2) THEN 'between_60_to_90_days'
                             WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -4) and ADD_MONTHS(CURRENT_TIMESTAMP, -3) THEN 'between_90_to_120_days'
                             ELSE null
                             END AS date_segment,
       CASE  WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -2) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN 'between_0_to_60_days'
                             ELSE null
                             END AS date_segment_2_month,
       CASE  WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -3) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN 'between_0_to_90_days'
                             ELSE null
                             END AS date_segment_3_month,
       CASE  WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -4) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN 'between_0_to_120_days'
                             ELSE null
                             END AS date_segment_4_month,
       COUNT(DISTINCT AA.device_id) as count_devices
FROM dragon.viewership_content_sessions_combined_daily AA
GROUP BY 1,2,3,4
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

  dimension: date_segment_2_month {
    type: string
    sql: ${TABLE}.date_segment_2_month ;;
  }

  dimension: date_segment_3_month {
    type: string
    sql: ${TABLE}.date_segment_3_month ;;
  }

  measure: count_devices {
    type: average
    sql: ${TABLE}.count_devices ;;
  }

  set: detail {
    fields: [date_segment, count_devices]
  }
}
