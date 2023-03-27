view: converged_report_queue_detail {
  sql_table_name: dbo.converged_report_queue_detail ;;

  dimension_group: changedon {
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
    sql: ${TABLE}.changedon ;;
  }

  dimension_group: createdon {
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
    sql: ${TABLE}.createdon ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: report_id {
    type: number
    sql: ${TABLE}.report_id ;;
    value_format_name: id
  }

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension: step_id {
    type: number
    sql: ${TABLE}.step_id ;;
    value_format_name: id
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
