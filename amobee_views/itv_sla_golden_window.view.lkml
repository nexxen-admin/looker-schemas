view: golden_window {
  sql_table_name: SLA.GOLDEN_WINDOW ;;
  drill_fields: [golden_window_id]

  dimension: golden_window_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."GOLDEN_WINDOW_ID" ;;
    value_format_name: id
  }

  dimension: description {
    type: string
    sql: ${TABLE}."DESCRIPTION" ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."END_TIME" ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."START_TIME" ;;
  }

  measure: count {
    type: count
    drill_fields: [golden_window_id, derived_gw_metric_daily.count]
  }
}
