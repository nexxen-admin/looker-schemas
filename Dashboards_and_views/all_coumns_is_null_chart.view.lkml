view: all_coumns_is_null_chart {
  derived_table: {
    sql: SELECT date(viewing_start_utc) as date,
       ROUND(SUM(CASE WHEN device_id is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as device_id,
       ROUND(SUM(CASE WHEN source is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as source,
       ROUND(SUM(CASE WHEN tv_program_tremor_id is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as tv_program_tremor_id,
       ROUND(SUM(CASE WHEN viewing_start_utc is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as viewing_start_utc,
       ROUND(SUM(CASE WHEN viewing_end_utc is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as viewing_end_utc,
       ROUND(SUM(CASE WHEN timezone_offset is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as timezone_offset,
       ROUND(SUM(CASE WHEN tv_app_name is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as tv_app_name,
       ROUND(SUM(CASE WHEN tv_source_type is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as tv_source_type,
       ROUND(SUM(CASE WHEN tv_tuner_channel is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as tv_tuner_channel,
       ROUND(SUM(CASE WHEN ip is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as ip,
       ROUND(SUM(CASE WHEN message_count is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as message_count,
       ROUND(SUM(CASE WHEN viewing_duration is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as viewing_duration,
       ROUND(SUM(CASE WHEN viewing_offset is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as viewing_offset,
       ROUND(SUM(CASE WHEN session_start_utc is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as session_start_utc,
       ROUND(SUM(CASE WHEN session_end_utc is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as session_end_utc,
       ROUND(SUM(CASE WHEN dat_track_id is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as dat_track_id,
       ROUND(SUM(CASE WHEN station_tremor_id is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as station_tremor_id,
       ROUND(SUM(CASE WHEN airing_tremor_id is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as airing_tremor_id,
       ROUND(SUM(CASE WHEN aggregated_at is not null THEN 1 ELSE 0 END)*1.0/COUNT(*),2) as aggregated_at
FROM dragon.viewership_content_sessions_combined
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

  dimension: device_id {
    type: number
    sql: ${TABLE}.device_id ;;
  }

  dimension: source {
    type: number
    sql: ${TABLE}."source" ;;
  }

  dimension: tv_program_tremor_id {
    type: number
    sql: ${TABLE}.tv_program_tremor_id ;;
  }

  dimension: viewing_start_utc {
    type: number
    sql: ${TABLE}.viewing_start_utc ;;
  }

  dimension: viewing_end_utc {
    type: number
    sql: ${TABLE}.viewing_end_utc ;;
  }

  dimension: timezone_offset {
    type: number
    sql: ${TABLE}.timezone_offset ;;
  }

  dimension: tv_app_name {
    type: number
    sql: ${TABLE}.tv_app_name ;;
  }

  dimension: tv_source_type {
    type: number
    sql: ${TABLE}.tv_source_type ;;
  }

  dimension: tv_tuner_channel {
    type: number
    sql: ${TABLE}.tv_tuner_channel ;;
  }

  dimension: ip {
    type: number
    sql: ${TABLE}.ip ;;
  }

  dimension: message_count {
    type: number
    sql: ${TABLE}.message_count ;;
  }

  dimension: viewing_duration {
    type: number
    sql: ${TABLE}.viewing_duration ;;
  }

  dimension: viewing_offset {
    type: number
    sql: ${TABLE}.viewing_offset ;;
  }

  dimension: session_start_utc {
    type: number
    sql: ${TABLE}.session_start_utc ;;
  }

  dimension: session_end_utc {
    type: number
    sql: ${TABLE}.session_end_utc ;;
  }

  dimension: dat_track_id {
    type: number
    sql: ${TABLE}.dat_track_id ;;
  }

  dimension: station_tremor_id {
    type: number
    sql: ${TABLE}.station_tremor_id ;;
  }

  dimension: airing_tremor_id {
    type: number
    sql: ${TABLE}.airing_tremor_id ;;
  }

  dimension: aggregated_at {
    type: number
    sql: ${TABLE}.aggregated_at ;;
  }

  set: detail {
    fields: [
      date,
      device_id,
      source,
      tv_program_tremor_id,
      viewing_start_utc,
      viewing_end_utc,
      timezone_offset,
      tv_app_name,
      tv_source_type,
      tv_tuner_channel,
      ip,
      message_count,
      viewing_duration,
      viewing_offset,
      session_start_utc,
      session_end_utc,
      dat_track_id,
      station_tremor_id,
      airing_tremor_id,
      aggregated_at
    ]
  }
}
