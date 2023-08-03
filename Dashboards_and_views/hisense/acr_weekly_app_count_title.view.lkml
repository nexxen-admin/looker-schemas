view: acr_weekly_app_count_title {
  derived_table: {
    sql: SELECT DATE_TRUNC('WEEK',AA.viewing_start_utc) as week_date,
       AA.tv_app_name,
       COUNT(DISTINCT pp.title) AS distinct_program_count
FROM dragon.viewership_content_sessions_combined_daily AA
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

  dimension: week_date {
    type: date_week
    sql: ${TABLE}.week_date ;;
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
    fields: [week_date, tv_app_name, distinct_title_count]
  }
}
