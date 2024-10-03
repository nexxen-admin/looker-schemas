# The name of this view in Looker is "Monthly Billing Override Data"
view: monthly_billing_override_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.monthly_billing_override_data ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account Manager ID" in Explore.

  dimension: account_manager_id {
    type: string
    label: "Account Manager Name"
    sql: ${TABLE}.Account_manager_ID ;;
  }

  dimension: account_manager_name {
    type: string
    label: "Account Manager ID"
    sql: ${TABLE}.Account_manager_Name ;;
  }

  dimension: actions_override_1_p {
    type: number
    sql: ${TABLE}.Actions_Override_1P ;;
  }

  dimension: advertiser_invoice_override {
    type: number
    sql: ${TABLE}.Advertiser_Invoice_Override ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: approved {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Approved_Date ;;
  }

  dimension: approver {
    type: string
    sql: ${TABLE}.Approver ;;
  }

  dimension: approver_id {
    type: string
    sql: ${TABLE}.Approver_ID ;;
  }

  dimension_group: billing_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Billing_Month ;;
  }

  dimension: clicks_override_1_p {
    type: number
    sql: ${TABLE}.Clicks_Override_1P ;;
  }

  dimension: clicks_override_3_p {
    type: number
    sql: ${TABLE}.Clicks_Override_3P ;;
  }

  dimension: completed_views_override_1_p {
    type: number
    sql: ${TABLE}.Completed_Views_Override_1P ;;
  }

  dimension: completed_views_override_3_p {
    type: number
    sql: ${TABLE}.Completed_Views_Override_3P ;;
  }

  dimension: conversions_override_3_p {
    type: number
    sql: ${TABLE}.Conversions_Override_3P ;;
  }

  dimension_group: created {
    type: time
    label: "JIRA Create Date"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Created ;;
  }

  dimension_group: db_created {
    type: time
    label: "Upload Date"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }

  dimension: impressions_override_1_p {
    type: number
    sql: ${TABLE}.Impressions_Override_1P ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_impressions_override_1_p {
    type: sum
    sql: ${impressions_override_1_p} ;;  }
  measure: average_impressions_override_1_p {
    type: average
    sql: ${impressions_override_1_p} ;;  }

  dimension: impressions_override_3_p {
    type: number
    sql: ${TABLE}.Impressions_Override_3P ;;
  }

  dimension: issue_id {
    type: number
    sql: ${TABLE}.Issue_ID ;;
  }

  dimension: jira_issue_key {
    type: string
    sql: ${TABLE}.Jira_Issue_Key ;;
  }

  dimension: reason {
    type: string
    sql: ${TABLE}.Reason ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
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

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: summary {
    type: string
    sql: ${TABLE}.Summary ;;
  }
  measure: count {
    type: count
    drill_fields: [account_manager_name]
  }
}
