# The name of this view in Looker is "Monthly Billing Locked Report"
view: monthly_billing_locked_report {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.monthly_billing_locked_report ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account ID" in Explore.

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_manager_name {
    type: string
    sql: ${TABLE}.account_manager_name ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: adjustment_billable_actions {
    type: number
    sql: ${TABLE}.adjustment_billable_actions ;;
  }

  dimension: adjustment_billable_clicks {
    type: number
    sql: ${TABLE}.adjustment_billable_clicks ;;
  }

  dimension: adjustment_billable_impressions {
    type: number
    sql: ${TABLE}.adjustment_billable_impressions ;;
  }

  dimension: adjustment_billable_revenue {
    type: number
    sql: ${TABLE}.adjustment_billable_revenue ;;
  }

  dimension: adjustment_billable_video_completes {
    type: number
    sql: ${TABLE}.adjustment_billable_video_completes ;;
  }

  measure: adv_invoice {
    type: sum
    sql: ${TABLE}.adv_invoice ;;
    value_format: "#,##0.00"
  }

  dimension: billing_instructions {
    type: string
    sql: ${TABLE}.billing_instructions ;;
  }

  dimension: booked_units {
    type: number
    sql: ${TABLE}.booked_units ;;
  }

  measure: capped_revenue_before_adj {
    type: sum
    sql: ${TABLE}.capped_revenue_before_adj ;;
    value_format: "#,##0.00"
  }

  dimension: case_safe_opp_line_item_id {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id ;;
  }

  measure: check_completeness_revenue_adj {
    type: sum
    sql: ${TABLE}.check_completeness_revenue_adj ;;
    value_format: "#,##0.00"
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }

  measure: complete_events {
    type: sum
    sql: ${TABLE}.complete_events ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  # dimension_group: date_key {
  #   type: time
  #   timeframes: [raw, date, week, month, quarter, year]
  #   convert_tz: no
  #   datatype: date
  #   sql: ${TABLE}.date_key ;;
  # }

  dimension: date_key_month {
    type: string
    sql: ${TABLE}.date_key_month ;;
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }

  measure: disc_between_1p_and_final_billable_revenue_after_adj_usd {
    type: sum
    sql: ${TABLE}.disc_between_1p_and_final_billable_revenue_after_adj_usd ;;
    value_format: "#,##0.00"
  }

  measure: disc_between_1p_and_final_billable_revenue_after_adj_usd_precent {
    type: sum
    sql: ${TABLE}.disc_between_1p_and_final_billable_revenue_after_adj_usd_precent ;;
    value_format: "0.00%"
  }

  measure: discrepancy_between_1p_and_final_billable_revenue_after_adj {
    type: sum
    sql: ${TABLE}.discrepancy_between_1p_and_final_billable_revenue_after_adj ;;
    value_format: "#,##0.00"
  }

  measure: discrepancy_between_1p_and_final_billable_revenue_after_adj_precent {
    type: sum
    sql: ${TABLE}.discrepancy_between_1p_and_final_billable_revenue_after_adj_precent ;;
    value_format: "0.00%"
  }

  measure: final_billable_revenue_after_adj {
    type: sum
    sql: ${TABLE}.final_billable_revenue_after_adj ;;
    value_format: "#,##0.00"
  }

  measure: final_billable_revenue_after_adj_usd {
    type: sum
    sql: ${TABLE}.final_billable_revenue_after_adj_usd ;;
    value_format: "#,##0.00"
  }

  measure: final_billable_units_after_adj {
    type: sum
    sql: ${TABLE}.final_billable_units_after_adj ;;
    value_format: "#,##0"
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  dimension: industry {
    type: string
    sql: ${TABLE}.industry ;;
  }

  measure: inv_cost {
    type: sum
    sql: ${TABLE}.inv_cost ;;
    value_format: "#,##0.00"
  }

  dimension: io_currency {
    type: string
    sql: ${TABLE}.io_currency ;;
  }

  dimension: legal_entity {
    type: string
    sql: ${TABLE}.legal_entity ;;
  }

  dimension: line_item_name {
    type: string
    sql: ${TABLE}.line_item_name ;;
  }

  dimension: line_item_status {
    type: string
    sql: ${TABLE}.line_item_status ;;
  }

  measure: margin_amount {
    type: sum
    sql: ${TABLE}.margin_amount ;;
    value_format: "#,##0.00"
  }

  measure: margin_amount_in_usd_precent {
    type: sum
    sql: ${TABLE}.margin_amount_in_usd_precent ;;
    value_format: "0.00%"
  }

  measure: margin_amount_percent {
    type: sum
    sql: ${TABLE}.margin_amount_percent ;;
    value_format: "0.00%"
  }

  measure: mergin_amount_usd {
    type: sum
    sql: ${TABLE}.mergin_amount_usd ;;
    value_format: "#,##0.00"
  }

  measure: ns_remaining_amount {
    type: sum
    sql: ${TABLE}.ns_remaining_amount ;;
    value_format: "#,##0.00"
  }

  measure: ns_remaining_units {
    type: sum
    sql: ${TABLE}.ns_remaining_units ;;
    value_format: "#,##0"
  }

  measure: od_delivery_units {
    type: sum
    sql: ${TABLE}.od_delivery_units ;;
    value_format: "#,##0"
  }

  measure: one_p_rev {
    type: sum
    sql: ${TABLE}.one_p_rev ;;
    value_format: "#,##0.00"
  }

  measure: one_p_rev_usd {
    type: sum
    sql: ${TABLE}.one_p_rev_usd ;;
    value_format: "#,##0.00"
  }

  dimension: opportunity_end_date {
    type: string
    sql: ${TABLE}.opportunity_end_date ;;
  }

  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }

  dimension: opportunity_number {
    type: string
    sql: ${TABLE}.opportunity_number ;;
  }

  dimension: opportunity_owner {
    type: string
    sql: ${TABLE}.opportunity_owner ;;
    label: "Opportunity Owner Name"
  }

  dimension: opportunity_region {
    type: string
    sql: ${TABLE}.opportunity_region ;;
  }

  dimension: opportunity_start_date {
    type: string
    sql: ${TABLE}.opportunity_start_date ;;
  }

  measure: over_delivery_amount {
    type: sum
    sql: ${TABLE}.over_delivery_amount ;;
    value_format: "#,##0.00"
  }

  measure: over_delivery_amount_in_usd {
    type: sum
    sql: ${TABLE}.over_delivery_amount_in_usd ;;
    value_format: "#,##0.00"
  }

  dimension: passed_bill_amount {
    type: number
    sql: ${TABLE}.passed_bill_amount ;;
  }

  measure: percent25events {
    type: sum
    sql: ${TABLE}.percent25events ;;
  }

  measure: percent50events {
    type: sum
    sql: ${TABLE}.percent50events ;;
  }

  measure: percent75events {
    type: sum
    sql: ${TABLE}.percent75events ;;
  }

  dimension: price_type_name {
    type: string
    sql: ${TABLE}.price_type_name ;;
  }

  dimension: primary_kpi {
    type: string
    sql: ${TABLE}.primary_kpi ;;
  }

  dimension: product_level_1 {
    type: string
    sql: ${TABLE}.product_level_1 ;;
  }

  dimension: product_level_2 {
    type: string
    sql: ${TABLE}.product_level_2 ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
  }

  dimension: rate {
    type: number
    sql: ${TABLE}.rate ;;
  }

  dimension: related_brand_id {
    type: string
    sql: ${TABLE}.related_brand_id ;;
  }

  dimension: related_brand_name {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }

  measure: remaining_diff_between_1p_to_billing_3p_1p_discrepancy_local_currency {
    type: sum
    sql: ${TABLE}.remaining_diff_between_1p_to_billing_3p_1p_discrepancy_local_currency ;;
    value_format: "#,##0.00"
  }

  measure: remaining_diff_between_1p_to_billing_3p_1p_discrepancy_usd {
    type: sum
    sql: ${TABLE}.remaining_diff_between_1p_to_billing_3p_1p_discrepancy_usd ;;
    value_format: "#,##0.00"
  }

  measure: revenue_adj {
    type: sum
    sql: ${TABLE}.revenue_adj ;;
    value_format: "#,##0.00"
  }

  dimension: sales_team {
    type: string
    sql: ${TABLE}.sales_team ;;
  }

  dimension: server_reporting {
    type: string
    sql: ${TABLE}.server_reporting ;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
  }

  measure: tac {
    type: sum
    sql: ${TABLE}.tac ;;
    value_format: "#,##0.00"
  }

  measure: third_party_clicks {
    type: sum
    sql: ${TABLE}.third_party_clicks ;;
  }

  measure: third_party_complete_events {
    type: sum
    sql: ${TABLE}.third_party_complete_events ;;
  }

  measure: third_party_impressions {
    type: sum
    sql: ${TABLE}.third_party_impressions ;;
  }

  measure: total_billable_units_before_adj {
    type: sum
    sql: ${TABLE}.total_billable_units_before_adj ;;
    value_format: "#,##0"
  }

  dimension: total_booked_budget {
    type: number
    sql: ${TABLE}.total_booked_budget ;;
  }

  measure: uncapped_revenue {
    type: sum
    sql: ${TABLE}.uncapped_revenue ;;
    value_format: "#,##0.00"
  }

  measure: under_delivery_budget {
    type: sum
    sql: ${TABLE}.under_delivery_budget ;;
    value_format: "#,##0.00"
  }

  measure: under_delivery_budget_in_usd {
    type: sum
    sql: ${TABLE}.under_delivery_budget_in_usd ;;
    value_format: "#,##0.00"
  }

  measure: under_delivery_units {
    type: sum
    sql: ${TABLE}.under_delivery_units ;;
    value_format: "#,##0"
  }

  measure: units_adj {
    type: sum
    sql: ${TABLE}.units_adj ;;
    value_format: "#,##0"
  }

  measure: units_before_adj {
    type: sum
    sql: ${TABLE}.units_before_adj ;;
    value_format: "#,##0"
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  account_manager_name,
  line_item_name,
  price_type_name,
  opportunity_name,
  account_name,
  related_brand_name
  ]
  }

}
