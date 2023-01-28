view: daily_null_count_all_col {
  derived_table: {
    sql: SELECT date(AA.viewing_start_utc),
       SUM(CASE WHEN CC.episode_number is not null THEN 1 ELSE 0 END)/count(*) as count_events_with_episode_numbers,
       SUM(CASE WHEN CC.season_number is not null THEN 1 ELSE 0 END)/count(*) as count_events_with_season_number,
       SUM(CASE WHEN BB.genre_tremor_id is not null THEN 1 ELSE 0 END)/count(*) as count_events_with_genre_tremor_id,
       SUM(CASE WHEN AA.tv_program_tremor_id is not null THEN 1 ELSE 0 END)/count(*) as tv_program_tremor_id
FROM dragon.viewership_content_sessions_combined AA
RIGHT JOIN dragon.program_genre BB
ON AA.tv_program_tremor_id=BB.tv_program_tremor_id
RIGHT JOIN dragon.program CC
ON AA.tv_program_tremor_id=CC.tv_program_tremor_id
GROUP BY 1
ORDER BY 1
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }

  dimension: count_events_with_episode_numbers {
    type: number
    sql: ${TABLE}.count_events_with_episode_numbers ;;
  }

  dimension: count_events_with_season_number {
    type: number
    sql: ${TABLE}.count_events_with_season_number ;;
  }

  dimension: count_events_with_genre_tremor_id {
    type: number
    sql: ${TABLE}.count_events_with_genre_tremor_id ;;
  }

  dimension: tv_program_tremor_id {
    type: number
    sql: ${TABLE}.tv_program_tremor_id ;;
  }

  set: detail {
    fields: [date, count_events_with_episode_numbers, count_events_with_season_number, count_events_with_genre_tremor_id, tv_program_tremor_id]
  }
}
