view: count_device_id_per_os {
  derived_table: {
    sql: SELECT date(AA.viewing_start_utc),
       BB.os,
       COUNT(DISTINCT AA.device_id) as device_count_per_os
FROM dragon.viewership_content_sessions_combined AA
LEFT JOIN dragon.device_info_r BB
ON AA.device_id = BB.device_id
GROUP BY 1,2
ORDER BY 1 DESC
 ;;
  }

  dimension: count {
    type: number
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: device_count_per_os {
    type: number
    sql: ${TABLE}.device_count_per_os ;;
  }

  set: detail {
    fields: [date, os, device_count_per_os]
  }
}
