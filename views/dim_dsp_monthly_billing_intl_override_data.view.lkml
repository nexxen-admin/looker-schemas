view: dim_dsp_monthly_billing_intl_override_data {
  sql_table_name: BI_DSP.dim_dsp_monthly_billing_intl_override_data ;;

  dimension: account_manager {
    type: string
    sql: ${TABLE}.account_manager ;;
  }
  dimension: account_manager_id {
    type: string
    sql: ${TABLE}.account_manager_id ;;
  }
  dimension: actions_override_1p {
    type: number
    sql: ${TABLE}.actions_override_1p ;;
  }
  dimension: advertiser_invoice_override {
    type: number
    sql: ${TABLE}.advertiser_invoice_override ;;
  }
  dimension_group: approved {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.approved_date ;;
  }
  dimension: approver {
    type: string
    sql: ${TABLE}.approver ;;
  }
  dimension: approver_id {
    type: string
    sql: ${TABLE}.approver_id ;;
  }
  dimension_group: billing_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.billing_month ;;
  }
  dimension: billing_override_data_key {
    type: number
    sql: ${TABLE}.billing_override_data_key ;;
  }
  dimension: clicks_override_1p {
    type: number
    sql: ${TABLE}.clicks_override_1p ;;
  }
  dimension: completed_views_override_1p {
    type: number
    sql: ${TABLE}.completed_views_override_1p ;;
  }
  dimension: cost_override_3p {
    type: number
    sql: ${TABLE}.cost_override_3p ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created ;;
  }
  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }
  dimension: events_override_25 {
    type: number
    sql: ${TABLE}.events_override_25 ;;
  }
  dimension: events_override_50 {
    type: number
    sql: ${TABLE}.events_override_50 ;;
  }
  dimension: events_override_75 {
    type: number
    sql: ${TABLE}.events_override_75 ;;
  }
  dimension: final_override_actions {
    type: number
    sql: ${TABLE}.final_override_actions ;;
  }
  dimension: final_override_click {
    type: number
    sql: ${TABLE}.final_override_click ;;
  }
  dimension: final_override_completed_views {
    type: number
    sql: ${TABLE}.final_override_completed_views ;;
  }
  dimension: final_override_delivery_units {
    type: number
    sql: ${TABLE}.final_override_delivery_units ;;
  }
  dimension: final_override_impression {
    type: number
    sql: ${TABLE}.final_override_impression ;;
  }
  dimension: impressions_override_1p {
    type: number
    sql: ${TABLE}.impressions_override_1p ;;
  }
  dimension: jira_issue_id {
    type: string
    sql: ${TABLE}.jira_issue_id ;;
  }
  dimension: jira_issue_key {
    type: string
    sql: ${TABLE}.jira_issue_key ;;
  }
  dimension: opportunitylineitem {
    type: string
    sql: ${TABLE}.opportunitylineitem ;;
  }
  dimension: opportunitylineitem_key {
    type: number
    sql: ${TABLE}.opportunitylineitem_key ;;
  }
  dimension: override_delivery_units_1p {
    type: number
    sql: ${TABLE}.override_delivery_units_1p ;;
  }
  dimension: override_reason {
    type: string
    sql: ${TABLE}.override_reason ;;
  }
  dimension: override_uncapped_revenue {
    type: number
    sql: ${TABLE}.override_uncapped_revenue ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }
  dimension: reporter {
    type: string
    sql: ${TABLE}.reporter ;;
  }
  dimension: reporter_id {
    type: string
    sql: ${TABLE}.reporter_id ;;
  }
  dimension: sf_line_item_id {
    type: string
    sql: ${TABLE}.sf_line_item_id ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  measure: count {
    type: count
  }
}
