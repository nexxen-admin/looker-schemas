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

  dimension: opportunity_trader {
    type: string
    sql: ${TABLE}.opportunity_trader ;;
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

  dimension: adv_invoice {
    type: number
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

  dimension: capped_revenue_before_adj {
    type: number
    sql: ${TABLE}.capped_revenue_before_adj_with_override ;;
    value_format: "#,##0.00"
  }

  dimension: case_safe_opp_line_item_id {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id ;;
  }

  dimension: modified_case_safe {
    type: string
    sql: ${TABLE}.modified_case_safe ;;
  }

  dimension: check_completeness_revenue_adj {
    type: number
    sql: ${TABLE}.check_completeness_revenue_adj ;;
    value_format: "#,##0.00"
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: complete_events {
    type: number
    sql: ${TABLE}.complete_events ;;
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

  # dimension: date_key_month {
  #   type: date
  #   sql: ${TABLE}.date_key_month ;;
  # }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }

  dimension: disc_between_1p_and_final_billable_revenue_after_adj_usd {
    type: number
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd ;;
    value_format: "#,##0.00"
  }

  dimension: disc_between_1p_and_final_billable_revenue_after_adj_usd_precent {
    type: number
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent ;;
    value_format: "0.00%"
  }

  dimension: discrepancy_between_1p_and_final_billable_revenue_after_adj {
    type: number
    sql: ${TABLE}.discrepancy_between_1p_and_final_billable_revenue_after_adj ;;
    value_format: "#,##0.00"
  }

  dimension: discrepancy_between_1p_and_final_billable_revenue_after_adj_precent {
    type: number
    sql: ${TABLE}.discrepancy_between_1p_and_final_billable_revenue_after_adj_percent ;;
    value_format: "0.00%"
  }

  dimension: exchange_rate {
    type: number
    sql: ${TABLE}.exchange_rate ;;
  }
  dimension: exchange_rate_usd {
    type: number
    sql: ${TABLE}.exchange_rate_usd ;;
  }
  dimension: expected_revenue {
    type: number
    sql: ${TABLE}.Expected_Revenue ;;
  }
  dimension: units_before_adj_ad_ops_override {
    type: number
    sql: ${TABLE}.units_before_adj_AdOps_override ;;
  }

  dimension: ad_ops_override_approving_manager {
    type: string
    sql: ${TABLE}.AdOps_OverrideApprovingManager ;;
  }
  dimension: ad_ops_override_reason {
    type: string
    sql: ${TABLE}.AdOps_OverrideReason ;;
  }

  dimension: units_adj_override {
    type: number
    sql: ${TABLE}.units_adj_override ;;
  }

  dimension: unit_ad_ops_override_1_p {
    type: number
    sql: ${TABLE}.Unit_AdOps_Override_1P ;;
  }
  dimension: unit_ad_ops_override_3_p {
    type: number
    sql: ${TABLE}.Unit_AdOps_Override_3P ;;
  }
  dimension: adv_invoice_ad_ops_override {
    type: number
    sql: ${TABLE}.Adv_Invoice_AdOps_Override ;;
  }

  dimension: final_billable_revenue_after_adj {
    type: number
    sql: ${TABLE}.final_billable_revenue_after_adj ;;
    value_format: "#,##0.00"
  }

  dimension: final_billable_revenue_after_adj_usd {
    type: number
    sql: ${TABLE}.final_billable_revenue_after_adj_usd ;;
    value_format: "#,##0.00"
  }

  dimension: final_billable_units_after_adj {
    type: number
    sql: ${TABLE}.final_billable_units_after_adj ;;
    value_format: "#,##0"
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: industry {
    type: string
    sql: ${TABLE}.industry ;;
  }

  dimension: inv_cost {
    type: number
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

  dimension: margin_amount {
    type: number
    sql: ${TABLE}.margin_amount ;;
    value_format: "#,##0.00"
  }

  dimension: margin_amount_in_usd_precent {
    type: number
    sql: ${TABLE}.margin_amount_percent_usd ;;
    value_format: "0.00%"
  }

  dimension: margin_amount_percent {
    type: number
    sql: ${TABLE}.margin_parcent ;;
    value_format: "0.00%"
  }

  dimension: margin_amount_usd {
    type: number
    sql: ${TABLE}.margin_amount_usd ;;
    value_format: "#,##0.00"
  }

  dimension: ns_remaining_amount {
    type: number
    sql: ${TABLE}.ns_remaining_amount ;;
    value_format: "#,##0.00"
  }

  dimension: ns_remaining_units {
    type: number
    sql: ${TABLE}.ns_remaining_units ;;
    value_format: "#,##0"
  }

  dimension: od_delivery_units {
    type: number
    sql: ${TABLE}.od_delivery_units ;;
    value_format: "#,##0"
  }

  dimension: one_p_rev {
    type: number
    sql: ${TABLE}.p_rev ;;
    value_format: "#,##0.00"
  }

  dimension: one_p_rev_usd {
    type: number
    sql: ${TABLE}.p_rev_usd ;;
    value_format: "#,##0.00"
  }

  dimension: opportunity_end_date {
    type: string
    sql: ${TABLE}.opportunity_end_date ;;
  }

  dimension: dsp_end_date {
    type: string
    sql: ${TABLE}.dsp_end_date ;;
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
    sql: ${TABLE}.opportunity_owner_name ;;
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

  dimension: dsp_start_date {
    type: string
    sql: ${TABLE}.dsp_start_date ;;
  }

  dimension: over_delivery_amount {
    type: number
    sql: ${TABLE}.over_delivery_amount ;;
    value_format: "#,##0.00"
  }

  dimension: over_delivery_amount_in_usd {
    type: number
    sql: ${TABLE}.over_delivery_amount_usd ;;
    value_format: "#,##0.00"
  }

  dimension: passed_bill_amount {
    type: number
    sql: ${TABLE}.passed_bill_amount ;;
  }

  dimension: percent25events {
    type: number
    sql: ${TABLE}.percent25_events ;;
  }

  dimension: percent50events {
    type: number
    sql: ${TABLE}.percent50_events ;;
  }

  dimension: percent75events {
    type: number
    sql: ${TABLE}.percent75_events ;;
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

  dimension: remaining_diff_between_1p_to_billing_3p_1p_discrepancy_local_currency {
    type: number
    sql: ${TABLE}.remaining_diff_between_1p_to_billing_3p_vs_1p_discrepancy_local_currency ;;
    value_format: "#,##0.00"
  }

  dimension: remaining_diff_between_1p_to_billing_3p_1p_discrepancy_usd {
    type: number
    sql: ${TABLE}.remaining_diff_between_1p_to_billing_3p_VS_1p_discrepancy_usd ;;
    value_format: "#,##0.00"
  }

  dimension: revenue_adj {
    type: number
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

  dimension: tac {
    type: number
    sql: ${TABLE}.tac ;;
    value_format: "#,##0.00"
  }

  dimension: third_party_clicks {
    type: number
    sql: ${TABLE}.third_party_clicks ;;
  }

  dimension: third_party_complete_events {
    type: number
    sql: ${TABLE}.third_party_complete_events ;;
  }

  dimension: third_party_impressions {
    type: number
    sql: ${TABLE}.third_party_impressions ;;
  }

  dimension: total_billable_units_before_adj {
    type: number
    sql: ${TABLE}.total_billable_units_before_adj_adops_override ;;
    value_format: "#,##0"
  }

  dimension: total_booked_budget {
    type: number
    sql: ${TABLE}.total_booked_budget ;;
  }

  dimension: uncapped_revenue_adj_adops {
    type: number
    sql: ${TABLE}.uncapped_revenue_adj_adops ;;
    value_format: "#,##0.00"
  }

  dimension: uncapped_revenue_after_adops_override {
    type: number
    sql: ${TABLE}.uncapped_revenue_after_adops_override ;;
    value_format: "#,##0.00"
  }

  dimension: under_delivery_budget {
    type: number
    sql: ${TABLE}.under_delivery_budget ;;
    value_format: "#,##0.00"
  }

  dimension: under_delivery_budget_in_usd {
    type: number
    sql: ${TABLE}.under_delivery_budget_usd ;;
    value_format: "#,##0.00"
  }

  dimension: under_delivery_units {
    type: number
    sql: ${TABLE}.under_delivery_units ;;
    value_format: "#,##0"
  }

  dimension: units_adj {
    type: number
    sql: ${TABLE}.units_ADJ ;;
    value_format: "#,##0"
  }

  dimension: units_before_adj {
    type: number
    sql: ${TABLE}.units_before_adj_adops_override ;;
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
  }}
