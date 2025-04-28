
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
    case_sensitive: no
  }

  dimension: segment_name {
    type: string
    sql: ${TABLE}.segment_name ;;
    case_sensitive: no
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
    case_sensitive: no
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    case_sensitive: no
  }

  dimension: type {
    type: string
    sql: ${TABLE}."type" ;;
    case_sensitive: no
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    case_sensitive: no
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
