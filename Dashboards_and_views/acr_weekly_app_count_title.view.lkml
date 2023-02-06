view: acr_weekly_app_count_title {
  derived_table: {
    sql: SELECT concat(concat(year(AA.viewing_start_utc),'-'),week(AA.viewing_start_utc)) as year_week,
       AA.tv_app_name,
       COUNT(DISTINCT pp.title) AS distinct_program_count
FROM dragon.viewership_content_sessions_combined AA
LEFT JOIN dragon.program PP
ON AA.tv_program_tremor_id=PP.tv_program_tremor_id
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

  measure: distinct_title_count {
    type: average
    sql: ${TABLE}.distinct_program_count ;;
  }

  set: detail {
    fields: [year_week, tv_app_name, distinct_title_count]
  }
}
