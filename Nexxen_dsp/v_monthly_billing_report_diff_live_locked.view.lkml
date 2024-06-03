# The name of this view in Looker is "V Monthly Billing Report Diff Live Locked"
view: v_monthly_billing_report_diff_live_locked {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.v_monthly_billing_report_diff_live_locked ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Booked Budget From Live Report" in Explore.

  dimension: total_booked_budget_live {
    type: number
    sql: ${TABLE}.total_Booked_Budget_from_live_report ;;
    value_format: "#,##0.00"
  }

  dimension: total_booked_budget_locked {
    type: number
    sql: ${TABLE}.total_Booked_Budget_from_locked_report ;;
    value_format: "#,##0.00"
  }

  dimension: booked_units_live {
    type: number
    sql: ${TABLE}.Booked_Units_from_live_report ;;
  }

  dimension: booked_units_locked {
    type: number
    sql: ${TABLE}.Booked_Units_from_locked_report ;;
  }

  measure: capped_revenue_before_adj_live {
    type: sum
    sql: ${TABLE}.capped_revenue_before_adj_from_live_report ;;
    value_format: "#,##0.00"
  }

  measure: capped_revenue_before_adj_locked {
    type: sum
    sql: ${TABLE}.capped_revenue_before_adj_from_locked_report ;;
    value_format: "#,##0.00"
  }

  dimension: case_safe_opp_line_item_id_locked {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id_locked ;;
  }

  dimension: case_safe_opp_line_item_id_live {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id_live ;;
  }

  dimension: modified_case_safe_live {
    type: string
    sql: ${TABLE}.modified_case_safe_from_live_report ;;
  }

  dimension: modified_case_safe_locked {
    type: string
    sql: ${TABLE}.modified_case_safe_from_locked_report ;;
  }

  measure: clicks_live {
    type: sum
    label: "1P Clicks Live"
    sql: ${TABLE}.Clicks_from_live_report ;;
  }

  measure: clicks_locked {
    type: sum
    label: "1P Clicks Locked"
    sql: ${TABLE}.Clicks_locked_report ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key ;;
  }

  dimension: diff_columns {
    type: string
    sql: ${TABLE}.diff_columns ;;
  }

  dimension: diff_reason {
    type: string
    sql: ${TABLE}.diff_reason ;;
  }

  measure: final_billable_revenue_after_adj_live {
    type: sum
    sql: ${TABLE}.final_billable_revenue_after_adj_from_live_report ;;
    value_format: "#,##0.00"
  }

  measure: final_billable_revenue_after_adj_locked {
    type: sum
    sql: ${TABLE}.final_billable_revenue_after_adj_from_locked_report ;;
    value_format: "#,##0.00"
  }

  measure: impressions_live {
    type: sum
    label: "1P Impressions Live"
    sql: ${TABLE}.impressions_from_live_report ;;
  }

  measure: impressions_locked {
    type: sum
    label: "1P Impressions Locked"
    sql: ${TABLE}.impressions_from_locked_report ;;
  }

  measure: p_rev_live {
    type: sum
    label: "1P rev live"
    sql: ${TABLE}.one_p_rev_from_live_report ;;
    value_format: "#,##0.00"
  }

  measure: p_rev_locked {
    type: sum
    label: "1P rev locked"
    sql: ${TABLE}.one_p_rev_from_locked_report ;;
    value_format: "#,##0.00"
  }

  dimension: passed_bill_amount_live {
    type: number
    sql: ${TABLE}.Passed_Bill_Amount_from_live_report ;;
    value_format: "#,##0.00"
  }

  dimension: passed_bill_amount_locked {
    type: number
    sql: ${TABLE}.Passed_Bill_Amount_from_locked_report ;;
    value_format: "#,##0.00"
  }

  dimension: rate_live {
    type: number
    sql: ${TABLE}.Rate_from_live_report ;;
    value_format: "#,##0.00"
  }

  dimension: rate_locked {
    type: number
    sql: ${TABLE}.Rate_from_locked_report ;;
    value_format: "#,##0.00"
  }

  measure: third_party_impressions_live {
    type: sum
    label: "3P Impressions Live"
    sql: ${TABLE}.third_party_impressions_from_live_report ;;
  }

  measure: third_party_impressions_locked {
    type: sum
    label: "3P Impressions Locked"
    sql: ${TABLE}.third_party_impressions_locked_report ;;
  }

  measure: uncapped_revenue_live {
    type: sum
    sql: ${TABLE}.uncapped_revenue_from_live_report ;;
    value_format: "#,##0.00"
  }

  measure: uncapped_revenue_locked {
    type: sum
    sql: ${TABLE}.uncapped_revenue_from_locked_report ;;
    value_format: "#,##0.00"
  }

  measure: adv_invoice_locked {
    type: sum
    label: "Adv Invoice Locked"
    sql: ${TABLE}.adv_invoice_from_locked_report ;;
    value_format: "#,##0.00"
  }

  measure: adv_invoice_live {
    type: sum
    label: "Adv Invoice Live"
    sql: ${TABLE}.adv_invoice_from_live_report ;;
    value_format: "#,##0.00"
  }

  measure: complete_events_locked {
    type: sum
    label: "1P Complete Events Locked"
    sql: ${TABLE}.complete_events_from_locked_report ;;
    value_format: "#,##0"
  }

  measure: complete_events_live {
    type: sum
    label: "1P Complete Events Live"
    sql: ${TABLE}.complete_events_from_live_report ;;
    value_format: "#,##0"
  }

  measure: third_party_complete_events_locked {
    type: sum
    label: "3P Complete Events Locked"
    sql: ${TABLE}.third_party_complete_events_from_locked_report ;;
    value_format: "#,##0"
  }

  measure: third_party_complete_events_live {
    type: sum
    label: "3P Complete Events Live"
    sql: ${TABLE}.third_party_complete_events_from_live_report ;;
    value_format: "#,##0"
  }

  measure: third_party_clicks_locked {
    type: sum
    label: "3P Clicks Locked"
    sql: ${TABLE}.third_party_clicks_from_locked_report ;;
    value_format: "#,##0"
  }

  measure: third_party_clicks_live {
    type: sum
    label: "3P Clicks Live"
    sql: ${TABLE}.third_party_clicks_from_live_report ;;
    value_format: "#,##0"
  }

  dimension: opportunity_start_date_locked {
    type: string
    sql: ${TABLE}.opportunity_start_date_from_locked_report;;
  }

  dimension: opportunity_start_date_live {
    type: string
    sql: ${TABLE}.opportunity_start_date_from_live_report;;
  }

  dimension: opportunity_end_date_locked {
    type: string
    sql: ${TABLE}.opportunity_end_date_from_locked_report;;
  }

  dimension: opportunity_end_date_live {
    type: string
    sql: ${TABLE}.opportunity_end_date_from_live_report;;
  }

  dimension: line_item_name_locked {
    type: string
    sql: ${TABLE}.line_item_name_from_locked_report ;;
  }

  dimension: line_item_name_live {
    type: string
    sql: ${TABLE}.line_item_name_from_live_report ;;
  }

  dimension: opportunity_name_locked {
    type: string
    sql: ${TABLE}.opportunity_name_from_locked_report ;;
  }

  dimension: opportunity_name_live {
    type: string
    sql: ${TABLE}.opportunity_name_from_live_report ;;
  }

  dimension: related_brand_id_locked {
    type: string
    sql: ${TABLE}.related_brand_id_from_locked_report ;;
  }

  dimension: related_brand_id_live {
    type: string
    sql: ${TABLE}.related_brand_id_from_live_report ;;
  }

  dimension: account_name_locked {
    type: string
    sql: ${TABLE}.account_name_from_locked_report ;;
  }

  dimension: account_name_live {
    type: string
    sql: ${TABLE}.account_name_from_live_report ;;
  }

  dimension: account_manager_name_locked {
    type: string
    sql: ${TABLE}.account_manager_name_from_locked_report ;;
  }

  dimension: account_manager_name_live{
    type: string
    sql: ${TABLE}.account_manager_name_from_live_report ;;
  }

  dimension: opportunity_trader_live {
    type: string
    sql: ${TABLE}.opportunity_trader_from_live_report ;;
  }

  dimension: opportunity_trader_locked{
    type: string
    sql: ${TABLE}.opportunity_trader_from_locked_report ;;
  }

  dimension: opportunity_region_live {
    type: string
    sql: ${TABLE}.opportunity_region_from_live_report ;;
  }

  dimension: opportunity_region_locked {
    type: string
    sql: ${TABLE}.opportunity_region_from_locked_report ;;
  }


  measure: count {
    type: count
  }
}
