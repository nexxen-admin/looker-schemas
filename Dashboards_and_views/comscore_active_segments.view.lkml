
view: comscore_active_segments {
  derived_table: {
    sql: SELECT * FROM Andromeda.rx_dim_segment where type = 'comscore' and status = 'active' ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: snapshot_time_utc {
    type: time
    sql: ${TABLE}.snapshot_time_utc ;;
  }

  dimension: segment_id {
    type: string
    sql: ${TABLE}.segment_id ;;
  }

  dimension: segment_name {
    type: string
    sql: ${TABLE}.segment_name ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}."type" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: cpm {
    type: number
    sql: ${TABLE}.CPM ;;
  }

  set: detail {
    fields: [
        snapshot_time_utc_time,
  segment_id,
  segment_name,
  display_name,
  description,
  type,
  status,
  cpm
    ]
  }
}
