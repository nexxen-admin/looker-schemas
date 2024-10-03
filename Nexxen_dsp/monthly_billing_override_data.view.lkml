
view: monthly_billing_override_data {
  derived_table: {
    sql: Select * FROM BI_DSP.monthly_billing_override_data ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: jira_issue_key {
    type: string
    sql: ${TABLE}.Jira_Issue_Key ;;
  }

  dimension: issue_id {
    type: number
    sql: ${TABLE}.Issue_ID ;;
  }

  dimension: summary {
    type: string
    sql: ${TABLE}.Summary ;;
  }

  dimension: reporter {
    type: string
    sql: ${TABLE}.Reporter ;;
  }

  dimension: reporter_id {
    type: string
    sql: ${TABLE}.Reporter_ID ;;
  }

  dimension: sf_line_item_id {
    type: string
    sql: ${TABLE}.SF_Line_Item_ID ;;
  }

  dimension: impressions_override_1_p {
    type: number
    sql: ${TABLE}.Impressions_Override_1P ;;
  }

  dimension: clicks_override_1_p {
    type: number
    sql: ${TABLE}.Clicks_Override_1P ;;
  }

  dimension: completed_views_override_1_p {
    type: number
    sql: ${TABLE}.Completed_Views_Override_1P ;;
  }

  dimension: actions_override_1_p {
    type: number
    sql: ${TABLE}.Actions_Override_1P ;;
  }

  dimension: impressions_override_3_p {
    type: number
    sql: ${TABLE}.Impressions_Override_3P ;;
  }

  dimension: clicks_override_3_p {
    type: number
    sql: ${TABLE}.Clicks_Override_3P ;;
  }

  dimension: completed_views_override_3_p {
    type: number
    sql: ${TABLE}.Completed_Views_Override_3P ;;
  }

  dimension: conversions_override_3_p {
    type: number
    sql: ${TABLE}.Conversions_Override_3P ;;
  }

  dimension: advertiser_invoice_override {
    type: number
    sql: ${TABLE}.Advertiser_Invoice_Override ;;
  }

  dimension: reason {
    type: string
    sql: ${TABLE}.Reason ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: approver {
    type: string
    sql: ${TABLE}.Approver ;;
  }

  dimension: approver_id {
    type: string
    sql: ${TABLE}.Approver_ID ;;
  }

  dimension_group: approved_date {
    type: time
    sql: ${TABLE}.Approved_Date ;;
  }

  dimension: account_manager_id {
    type: string
    sql: ${TABLE}.Account_manager_ID ;;
  }

  dimension: account_manager_name {
    type: string
    sql: ${TABLE}.Account_manager_Name ;;
  }

  dimension: billing_month {
    type: date
    sql: ${TABLE}.Billing_Month ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.Created ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension_group: db_created_date {
    type: time
    sql: ${TABLE}.db_created_date ;;
  }

  set: detail {
    fields: [
        jira_issue_key,
  issue_id,
  summary,
  reporter,
  reporter_id,
  sf_line_item_id,
  impressions_override_1_p,
  clicks_override_1_p,
  completed_views_override_1_p,
  actions_override_1_p,
  impressions_override_3_p,
  clicks_override_3_p,
  completed_views_override_3_p,
  conversions_override_3_p,
  advertiser_invoice_override,
  reason,
  region,
  approver,
  approver_id,
  approved_date_time,
  account_manager_id,
  account_manager_name,
  billing_month,
  created_time,
  status,
  db_created_date_time
    ]
  }
}
