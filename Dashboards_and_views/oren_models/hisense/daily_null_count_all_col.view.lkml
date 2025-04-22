view: daily_null_count_all_col {
  derived_table: {
    sql:
SELECT date,
       country,
       sum(count_events_with_episode_numbers) as count_events_with_episode_numbers,
       sum(count_events_with_season_number) as count_events_with_season_number,
       sum(count_events_with_genre_tremor_id) as count_events_with_genre_tremor_id,
       sum(tv_program_tremor_id) as tv_program_tremor_id
FROM bi_new.daily_null_count_all_col
group by 1,2
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

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
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
    fields: [date,country, count_events_with_episode_numbers, count_events_with_season_number, count_events_with_genre_tremor_id, tv_program_tremor_id]
  }
}
