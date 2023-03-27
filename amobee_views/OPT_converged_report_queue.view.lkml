view: converged_report_queue {
  sql_table_name: dbo.converged_report_queue ;;

  dimension: action_id {
    type: number
    sql: ${TABLE}.action_id ;;
    value_format_name: id
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

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

  dimension: email_address {
    type: string
    sql: ${TABLE}.email_address ;;
  }

  dimension: exclude_from_sla_metrics {
    type: number
    sql: ${TABLE}.exclude_from_sla_metrics ;;
  }

  dimension: is_sent {
    type: number
    sql: ${TABLE}.is_sent ;;
  }

  dimension: is_stock_plan {
    type: number
    sql: ${TABLE}.is_stock_plan ;;
    value_format_name: id
  }

  dimension: media_plan_id {
    type: number
    sql: ${TABLE}.media_plan_id ;;
    value_format_name: id
  }

  dimension: num_tries {
    type: number
    sql: ${TABLE}.num_tries ;;
  }

  dimension: opt_run_id {
    type: number
    sql: ${TABLE}.opt_run_id ;;
    value_format_name: id
  }

  dimension: report_id {
    type: number
    sql: ${TABLE}.report_id ;;
    value_format_name: id
  }

  dimension: send_progress_email {
    type: number
    sql: ${TABLE}.send_progress_email ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
