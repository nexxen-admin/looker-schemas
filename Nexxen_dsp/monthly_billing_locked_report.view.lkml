# The name of this view in Looker is "Monthly Billing Locked Report"
view: monthly_billing_locked_report {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.

  sql_table_name: BI_DSP.monthly_billing_locked_report ;;

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    # using _month ensures it's a string, avoiding type errors in Vertica
    sql: ${case_safe_opp_line_item_id} || '-' || ${date_key_month} ;;
  }

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
    description: "Manually adjusted action count, From Finance manual adjustment upload"
    sql: ${TABLE}.adjustment_billable_actions ;;
  }

  dimension: adjustment_billable_clicks {
    type: number
    description: "Manually adjusted clicks count, From Finance manual adjustment upload"
    sql: ${TABLE}.adjustment_billable_clicks ;;
  }

  dimension: adjustment_billable_impressions {
    type: number
    description: "Manually adjusted impressions count, From Finance manual adjustment upload"
    sql: ${TABLE}.adjustment_billable_impressions ;;
  }

  dimension: adjustment_billable_revenue {
    type: number
    description: "Manually adjusted revenue amount, From Finance manual adjustment upload"
    sql: ${TABLE}.adjustment_billable_revenue ;;
  }

  dimension: adjustment_billable_video_completes {
    type: number
    description: "Manually adjusted Complete Events amount, From Finance manual adjustment upload"
    sql: ${TABLE}.adjustment_billable_video_completes ;;
  }

  dimension: adv_invoice {
    type: number
    description: "Advertisrr invoice amount (cost) from DSP"
    sql: ${TABLE}.adv_invoice ;;
    value_format: "#,##0.00"
  }

  dimension: billing_instructions {
    type: string
    sql: ${TABLE}.billing_instructions ;;
  }

  dimension: booked_units {
    type: number
    description: "Total units contracted to deliver, From SF"
    sql: ${TABLE}.booked_units ;;
  }

  dimension: capped_revenue_before_adj {
    type: number
    description: "We take the smaller of: (1) Remaining budget (Total Booked Budget - Past Bill Amount), OR (2) Uncapped Revenue After AdOps Override."
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
    description: "Validation check. Revenue Adj - (Units Adj x Rate)"
    sql: ${TABLE}.check_completeness_revenue_adj ;;
    value_format: "#,##0.00"
  }

  dimension: clicks {
    type: number
    description: "1P Clicks from DSP platform"
    sql: ${TABLE}.clicks ;;
  }

  dimension: complete_events {
    type: number
    description: "1P Complete Events from DSP platform"
    sql: ${TABLE}.complete_events ;;
  }

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key ;;
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }

  dimension: disc_between_1p_and_final_billable_revenue_after_adj_usd {
    type: number
    label: "Discrepancy In Between 1p USD and Final Billable Revenue After Adj USD"
    description: "Final Billable Revenue After Adj USD - 1st Party Revenue USD"
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd ;;
    value_format: "#,##0.00"
  }

  dimension: disc_between_1p_and_final_billable_revenue_after_adj_usd_precent {
    type: number
    label: "Discrepancy In Between 1p USD and Final Billable Revenue After Adj USD Percent"
    description: "Difference between system revenue and billing in %. If Final Billable Revenue is 0, then 0%. Otherwise: (Final Billable Revenue - 1P Revenue) ÷ Final Billable Revenue"
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent ;;
    value_format: "0.00%"
  }

  dimension: discrepancy_between_1p_and_final_billable_revenue_after_adj {
    type: number
    description: "Final Billable Revenue After Adj - 1st Party Revenue. (Positive = billing more than calculated; Negative = billing less)"
    sql: ${TABLE}.discrepancy_between_1p_and_final_billable_revenue_after_adj ;;
    value_format: "#,##0.00"
  }

  dimension: discrepancy_between_1p_and_final_billable_revenue_after_adj_precent {
    type: number
    label: "Discrepancy In Between 1p USD and Final Billable Revenue After Adj Percent"
    description: "Difference between system revenue and billing in %. If Final Billable Revenue is 0, then 0%. Otherwise: (Final Billable Revenue - 1P Revenue) ÷ Final Billable Revenue"
    sql: ${TABLE}.discrepancy_between_1p_and_final_billable_revenue_after_adj_percent ;;
    value_format: "0.00%"
  }

  dimension: exchange_rate {
    type: number
    description: "Conversion rate to local billing currency, Monthly exchange rate from NetSuite"
    sql: ${TABLE}.exchange_rate ;;
  }

  dimension: exchange_rate_usd {
    type: number
    description: "Conversion rate to USD, Monthly exchange rate from NetSuite"
    sql: ${TABLE}.exchange_rate_usd ;;
  }

  dimension: expected_revenue {
    type: number
    description: "Revenue expected for this month based on schedule (from Opportunity line Schedule in SF)"
    sql: ${TABLE}.Expected_Revenue ;;
  }

  dimension: units_before_adj_ad_ops_override {
    type: number
    description: "Billable units before Finance Adjustment, If there's an Ad Ops override, use that value. Otherwise, use the sum of delivered units"
    sql: ${TABLE}.units_before_adj_AdOps_override ;;
  }

  dimension: ad_ops_override_approving_manager {
    type: string
    description: "AdOps Override Approval manager"
    sql: ${TABLE}.AdOps_OverrideApprovingManager ;;
  }

  dimension: ad_ops_override_reason {
    type: string
    description: "Reason for Ad Ops Override"
    sql: ${TABLE}.AdOps_OverrideReason ;;
  }

  dimension: units_adj_override {
    type: number
    description: "Difference between override and original units: Units Before Adj AdOps Override minus the raw delivered units (before override)"
    sql: ${TABLE}.units_adj_override ;;
  }

  dimension: unit_ad_ops_override_1_p {
    type: number
    description: "Manually corrected 1st party delivery units, entry from Ad Ops override table"
    sql: ${TABLE}.Unit_AdOps_Override_1P ;;
  }

  dimension: unit_ad_ops_override_3_p {
    type: number
    description: "Manually corrected 3rd party delivery units, entry from Ad Ops override table"
    sql: ${TABLE}.Unit_AdOps_Override_3P ;;
  }

  dimension: adv_invoice_ad_ops_override {
    type: number
    description: "Manually corrected Adv Invoice, entry from Ad Ops override table"
    sql: ${TABLE}.Adv_Invoice_AdOps_Override ;;
  }

  dimension: final_billable_revenue_after_adj {
    type: number
    description: "The Final Billable Revenue. If Finance uploaded a manual adjustment > 0, we use that. Otherwise, we use Capped Revenue."
    sql: ${TABLE}.final_billable_revenue_after_adj ;;
    value_format: "#,##0.00"
  }

  dimension: final_billable_revenue_after_adj_usd {
    type: number
    description: "Final Billable Revenue After Adj multiplied by Exchange Rate USD"
    sql: ${TABLE}.final_billable_revenue_after_adj_usd ;;
    value_format: "#,##0.00"
  }

  measure: final_billable_revenue_after_adj_measure {
    type: sum
    label: "Final Billable Revenue (Locked)"
    description: "Billable Revenue after Adjustments in Opp Currency (Locked by Finance)"
    sql: ${TABLE}.final_billable_revenue_after_adj ;;
  }

  measure: final_billable_revenue_after_adj_usd_measure {
    type: sum
    label: "Final Billable Revenue USD (Locked)"
    description: "Billable Revenue after Adjustments in USD  (Locked by Finance)"
    sql: ${TABLE}.final_billable_revenue_after_adj_usd ;;
  }

  dimension: final_billable_units_after_adj {
    type: number
    description: "The Final Billable Units. If Finance uploaded a manual adjustment, we use that number. Otherwise, for dCPM we use impressions; for all other price types we use Total Billable Units Before Adj"
    sql: ${TABLE}.final_billable_units_after_adj ;;
    value_format: "#,##0"
  }

  dimension: impressions {
    type: number
    description: "1P impressions from DSP platform"
    sql: ${TABLE}.impressions ;;
  }

  dimension: industry {
    type: string
    sql: ${TABLE}.industry ;;
  }

  dimension: inv_cost {
    type: number
    description: "inventory cost from DSP platform"
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
    description: "Final Billable Revenue After Adj - Inventory Cost"
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
    description: "Final Billable Revenue After Adj USD minus (Inventory Cost x Exchange Rate USD)"
    sql: ${TABLE}.margin_amount_usd ;;
    value_format: "#,##0.00"
  }

  dimension: ns_remaining_amount {
    type: number
    description: "Budget remaining after previous invoices. Total Booked Budget - Past Bill Amount"
    sql: ${TABLE}.ns_remaining_amount ;;
    value_format: "#,##0.00"
  }

  dimension: ns_remaining_units {
    type: number
    description: "Units remaining after previous invoices. Booked Units - Past Bill Units"
    sql: ${TABLE}.ns_remaining_units ;;
    value_format: "#,##0"
  }

  dimension: over_delivery_units {
    type: number
    description: "Units delivered beyond the cap"
    sql: ${TABLE}.over_delivery_units ;;
    value_format: "#,##0"
  }

  dimension: one_p_rev {
    type: number
    description: "1st Party Revenue calculated from 1P delivery data, considering line item status and price type"
    sql: ${TABLE}.p_rev ;;
    value_format: "#,##0.00"
  }

  dimension: one_p_rev_usd {
    type: number
    description: "1st Party Revenue multiplied by Exchange Rate USD"
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
    description: "Capped Revenue - Uncapped Revenue After AdOps Override. (This is negative when we over-delivered but had to cap.)"
    sql: ${TABLE}.over_delivery_amount ;;
    value_format: "#,##0.00"
  }

  dimension: over_delivery_amount_in_usd {
    type: number
    label: "Over Delivery Amount USD"
    description: "Over Delivery Amount multiplied by Exchange Rate USD"
    sql: ${TABLE}.over_delivery_amount_usd ;;
    value_format: "#,##0.00"
  }

  dimension: passed_bill_amount {
    label: "Past Bill Amount"
    description: "Amount already billed in previous months, From NetSuite invoice data"
    type: number
    sql: ${TABLE}.passed_bill_amount ;;
  }

  dimension: percent25events {
    type: number
    description: "25% Complete Events from DSP platform"
    sql: ${TABLE}.percent25_events ;;
  }

  dimension: percent50events {
    type: number
    description: "50% Complete Events from DSP platform"
    sql: ${TABLE}.percent50_events ;;
  }

  dimension: percent75events {
    type: number
    description: "75% Complete Events from DSP platform"
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
    label: "Past Bill Units"
    description: "Units already billed in previous months, From NetSuite invoice data"
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
    label: "Remaining Diff Between 1 P to Billing 3 P Vs 1 P Discrepancy"
    description: "Discrepancy - Over Delivery Amount - Revenue Adj - Uncapped Revenue Adj AdOps. (This is what's left after we account for all known adjustments - should ideally be close to 0)"
    sql: ${TABLE}.remaining_diff_between_1p_to_billing_3p_vs_1p_discrepancy_local_currency ;;
    value_format: "#,##0.00"
  }

  dimension: remaining_diff_between_1p_to_billing_3p_1p_discrepancy_usd {
    type: number
    description: "same as Remaining Diff Between 1 P to Billing 3 P Vs 1 P Discrepancy in USD"
    sql: ${TABLE}.remaining_diff_between_1p_to_billing_3p_VS_1p_discrepancy_usd ;;
    value_format: "#,##0.00"
  }

  dimension: revenue_adj {
    type: number
    description: "Finance Revenue Adj, This shows how much Finance changed the revenue. Final Billable Revenue After Adj - Capped Revenue"
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
    description: "TAC from DSP platform"
    sql: ${TABLE}.tac ;;
    value_format: "#,##0.00"
  }

  dimension: third_party_clicks {
    type: number
    description: "3rd Party clicks from 3P reporting sources"
    sql: ${TABLE}.third_party_clicks ;;
  }

  dimension: third_party_complete_events {
    type: number
    description: "3rd Party Complete Events from 3P reporting sources"
    sql: ${TABLE}.third_party_complete_events ;;
  }

  dimension: third_party_impressions {
    type: number
    description: "3rd Party impressions from 3P reporting sources"
    sql: ${TABLE}.third_party_impressions ;;
  }

  dimension: total_billable_units_before_adj {
    type: number
    label: "Total Billable Units Before Adj Adops Override"
    description: "Capped billable units"
    sql: ${TABLE}.total_billable_units_before_adj_adops_override ;;
    value_format: "#,##0"
  }

  dimension: total_booked_budget {
    type: number
    description: "Total campaign budget in IO currency (Gross Billable amount)"
    sql: ${TABLE}.total_booked_budget ;;
  }

  dimension: uncapped_revenue_adj_adops {
    type: number
    description: "Ad Ops Override Revenue - Raw Uncapped Revenue. If no override, this is 0."
    sql: ${TABLE}.uncapped_revenue_adj_adops ;;
    value_format: "#,##0.00"
  }

  dimension: uncapped_revenue{
    type: number
    description: "Sum of Uncapped Revenue"
    sql: ${TABLE}.uncapped_revenue ;;
    value_format: "#,##0.00"
  }

  dimension: uncapped_revenue_after_adops_override {
    type: number
    description: "Revenue after Ad Ops Override. If there's an Ad Ops revenue override, use that value. Otherwise, use the sum of uncapped revenue"
    sql: ${TABLE}.uncapped_revenue_after_adops_override ;;
    value_format: "#,##0.00"
  }

  dimension: under_delivery_budget {
    type: number
    description: "Total Booked Budget - (Past Bill Amount + Final Billable Revenue After Adj)"
    sql: ${TABLE}.under_delivery_budget ;;
    value_format: "#,##0.00"
  }

  dimension: under_delivery_budget_in_usd {
    type: number
    description: "Under Delivery Budget multiplied by Exchange Rate USD"
    sql: ${TABLE}.under_delivery_budget_usd ;;
    value_format: "#,##0.00"
  }

  dimension: under_delivery_units {
    type: number
    description: "Booked Units - (Past Bill Units + Final Billable Units After Adj)"
    sql: ${TABLE}.under_delivery_units ;;
    value_format: "#,##0"
  }

  dimension: units_adj {
    type: number
    description: "Finance adjustment to units. Final Billable Units After Adj minus Total Billable Units Before Adj AdOps Override"
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
  }
}
