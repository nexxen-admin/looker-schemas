view: monthly_device_count {
  derived_table: {
    sql: SELECT concat(concat(year(AA.viewing_start_utc),'-'),month(AA.viewing_start_utc)) as year_month,
       COUNT(DISTINCT AA.device_id) as count_devices
FROM dragon.viewership_content_sessions_combined AA
GROUP BY 1
ORDER BY 1
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: year_month {
    type: string
    sql: ${TABLE}.year_month ;;
  }

  measure: count_devices {
    type: average
    sql: ${TABLE}.count_devices ;;
  }

  set: detail {
    fields: [year_month, count_devices]
  }
}
