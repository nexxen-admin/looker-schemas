view: acr_weekly_title_device {
  derived_table: {
    sql: SELECT DATE_TRUNC('WEEK',AA.viewing_start_utc) as week_date,
       PP.title,
       COUNT(DISTINCT device_id) as count_devices
FROM dragon.viewership_content_sessions_combined AA
LEFT JOIN dragon.program PP
ON AA.tv_program_tremor_id=PP.tv_program_tremor_id
GROUP BY 1,2
ORDER BY 1 DESC
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


  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  measure: count_devices {
    type: average
    sql: ${TABLE}.count_devices ;;
  }

  set: detail {
    fields: [week_date, title, count_devices]
  }
}
