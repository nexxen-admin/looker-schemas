view: unique_tremor_programs_id_app {
  derived_table: {
    sql: SELECT concat(concat(year(viewership_content_sessions_combined.viewing_start_utc),'-'),week(viewership_content_sessions_combined.viewing_start_utc)) as year_week,
       viewership_content_sessions_combined.tv_app_name,
       COUNT(DISTINCT tv_program_tremor_id) AS distinct_program_count
FROM dragon.viewership_content_sessions_combined
where source='vod'
GROUP BY 1,2
ORDER BY 1,2 DESC
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

  dimension: tv_app_name {
    type: string
    sql: ${TABLE}.tv_app_name ;;
  }

  measure: distinct_program_count {
    type: average
    sql: ${TABLE}.distinct_program_count ;;
  }

  set: detail {
    fields: [year_week, tv_app_name, distinct_program_count]
  }
}
