view: dsrs_requests {
  sql_table_name: dsrs_request.main_request ;;

  dimension: request_id {
    type: string
    sql: ${TABLE}.request_id ;;
  }

  dimension: request_type {
    type: string
    sql: ${TABLE}.request_type ;;
  }

  dimension_group: request_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.request_ts ;;
  }

  dimension_group: updated_at {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: count {
    type: count
  }
}
