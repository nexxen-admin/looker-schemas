view: v_billing_unified_revenue {
  sql_table_name: BI_DSP.v_billing_unified_revenue ;;

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    # using _month ensures it's a string, avoiding type errors in Vertica
    sql: ${case_safe_opp_line_item_id} || '-' || ${date_key_month} ;;
  }

  dimension: case_safe_opp_line_item_id {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id ;;
  }
  dimension_group: date_key {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date_key ;;
  }
  dimension: final_billable_revenue_after_adj {
    type: number
    sql: ${TABLE}.final_billable_revenue_after_adj ;;
  }
  dimension: final_billable_revenue_after_adj_usd {
    type: number
    sql: ${TABLE}.final_billable_revenue_after_adj_usd ;;
  }
  dimension: locked_final_billable_revenue_after_adj {
    type: number
    sql: ${TABLE}.locked_final_billable_revenue_after_adj ;;
  }
  dimension: locked_final_billable_revenue_after_adj_usd {
    type: number
    sql: ${TABLE}.locked_final_billable_revenue_after_adj_usd ;;
  }

  measure: locked_final_billable_revenue_after_adj_measure {
    type: sum
    label: "Final Billable Revenue (Locked)"
    description: "Billable Revenue after Adjustments in Opp Currency (Locked by Finance)"
    sql: ${TABLE}.locked_final_billable_revenue_after_adj ;;
  }

  measure: locked_final_billable_revenue_after_adj_usd_measure {
    type: sum
    label: "Final Billable Revenue USD (Locked)"
    description: "Billable Revenue after Adjustments in USD  (Locked by Finance)"
    sql: ${TABLE}.locked_final_billable_revenue_after_adj_usd ;;
  }

  dimension_group: max_live_db_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.max_live_db_update ;;
  }
  dimension_group: max_locked_db_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.max_locked_db_update ;;
  }
  dimension: modified_case_safe {
    type: string
    sql: ${TABLE}.modified_case_safe ;;
  }
  dimension: source {
    type: string
    sql: ${TABLE}."source" ;;
  }
  measure: count {
    type: count
  }
}
