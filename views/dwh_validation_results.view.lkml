view: dwh_validation_results {
  sql_table_name: BI_DSP.dwh_validation_results ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    label: "Result ID"
  }

  dimension: validation_id {
    type: number
    sql: ${TABLE}.validation_id ;;
    hidden: yes
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    label: "Status"
    suggest_persist_for: "30 minutes"
  }

  dimension: details {
    type: string
    sql: ${TABLE}.details ;;
    label: "Details"
  }

  dimension: process_name {
    type: string
    sql: ${TABLE}.process_name ;;
    label: "Process Name"
    suggest_persist_for: "1 hour"
  }

  dimension_group: run_timestamp {
    type: time
    timeframes: [raw, date, week, month]
    sql: ${TABLE}.run_timestamp ;;
    label: "Run"
  }

  measure: count {
    type: count
    label: "Total Runs"
  }

  measure: count_passed {
    type: count
    label: "Passed"
    filters: [status: "passed"]
  }

  measure: count_failed {
    type: count
    label: "Failed"
    filters: [status: "failed"]
  }

  measure: count_warning {
    type: count
    label: "Warning"
    filters: [status: "warning"]
  }
}
