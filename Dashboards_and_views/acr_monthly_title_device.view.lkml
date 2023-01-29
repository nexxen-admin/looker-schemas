view: acr_monthly_title_device {
  derived_table: {
    sql: SELECT concat(concat(year(AA.viewing_start_utc),'-'),week(AA.viewing_start_utc)) as year_week,
       AA.tv_program_tremor_id,
       PP.title,
       COUNT(DISTINCT device_id) as count_devices
FROM dragon.viewership_content_sessions_combined AA
LEFT JOIN dragon.program PP
ON AA.tv_program_tremor_id=PP.tv_program_tremor_id
GROUP BY 1,2,3
HAVING count_devices>50
ORDER BY 1 DESC
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: year_week {
    type: string
    sql: ${TABLE}.year_week ;;
  }

  dimension: tv_program_tremor_id {
    type: number
    sql: ${TABLE}.tv_program_tremor_id ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  measure: count_devices {
    type: sum
    sql: ${TABLE}.count_devices ;;
  }

  set: detail {
    fields: [year_week, tv_program_tremor_id, title, count_devices]
  }
}
