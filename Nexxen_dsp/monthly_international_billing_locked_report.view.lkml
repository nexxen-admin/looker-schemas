view: monthly_international_billing_locked_report {
  sql_table_name: BI_DSP.monthly_International_billing_locked_report ;;

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
  dimension: ad_ops_override_approving_manager {
    type: string
    description: "AdOps Override Approval manager"
    sql: ${TABLE}.ad_ops_override_approving_manager ;;
  }
  dimension: ad_ops_override_reason {
    type: string
    description: "Reason for Ad Ops Override"
    sql: ${TABLE}.ad_ops_override_reason ;;
  }
  dimension: billing_instructions {
    type: string
    sql: ${TABLE}.billing_instructions ;;
  }
  dimension: case_safe_opp_line_item_id {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id ;;
  }
  dimension: corp_entity {
    type: string
    sql: ${TABLE}.corp_entity ;;
  }
  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key ;;
  }
  dimension: month_date_key_ {
    type: string
    sql: ${TABLE}.date_key_month ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }
  dimension_group: dsp_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dsp_end_date ;;
  }
  dimension_group: dsp_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dsp_start_date ;;
  }
  dimension: industry {
    type: string
    sql: ${TABLE}.industry ;;
  }
  dimension: io_currency {
    label: "IO Currency"
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
  dimension: modified_case_safe {
    type: string
    sql: ${TABLE}.modified_case_safe ;;
  }
  dimension_group: opportunity_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
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
  dimension: opportunity_owner_name {
    type: string
    sql: ${TABLE}.opportunity_owner_name ;;
  }
  dimension: opportunity_region {
    type: string
    sql: ${TABLE}.opportunity_region ;;
  }
  dimension_group: opportunity_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_start_date ;;
  }
  dimension: opportunity_trader {
    type: string
    sql: ${TABLE}.opportunity_trader ;;
  }
  dimension: price_type_name {
    type: string
    sql: ${TABLE}.price_type_name ;;
  }
  dimension: product_level_1 {
    type: string
    sql: ${TABLE}.product_level_1 ;;
  }
  dimension: product_level_2 {
    type: string
    sql: ${TABLE}.product_level_2 ;;
  }
  dimension: related_brand_id {
    type: string
    sql: ${TABLE}.related_brand_id ;;
  }
  dimension: related_brand_name {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }
  dimension: sales_team {
    type: string
    sql: ${TABLE}.sales_team ;;
  }
  dimension: server_reporting {
    type: string
    sql: ${TABLE}.server_reporting ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }
  dimension: type {
    type: string
    sql: ${TABLE}."type" ;;
  }

  dimension: adj_3p_cost {
    type: number
    label: "3P Cost Override"
    sql: ${TABLE}.adj_3p_cost ;;
  }
  dimension: adjustment_billable_actions {
    label: "Billable Actions after Finance Adj"
    description: "Manually adjusted action count, From Finance manual adjustment upload"
    type: number
    sql: ${TABLE}.adjustment_billable_actions ;;
  }
  dimension: adjustment_billable_clicks {
    label: "Billable Clicks after Finance Adj"
    description: "Manually adjusted clicks count, From Finance manual adjustment upload"
    type: number
    sql: ${TABLE}.adjustment_billable_clicks ;;
  }
  dimension: adjustment_billable_impressions {
    label: "Billable Impressions after Finance Adj"
    description: "Manually adjusted impressions count, From Finance manual adjustment upload"
    type: number
    sql: ${TABLE}.adjustment_billable_impressions ;;
  }
  dimension: adjustment_billable_revenue {
    label: "Finance revenue adj"
    description: "Manually adjusted revenue amount, From Finance manual adjustment upload"
    type: number
    sql: ${TABLE}.adjustment_billable_revenue ;;
  }
  dimension: adjustment_billable_video_completes {
    label: "Billable Complete events after Finance Adj"
    description: "Manually adjusted Complete Events amount, From Finance manual adjustment upload"
    type: number
    sql: ${TABLE}.adjustment_billable_video_completes ;;
  }
  dimension: adv_invoice {
    type: number
    description: "Advertisrr invoice amount (cost) from DSP"
    sql: ${TABLE}.adv_invoice ;;
  }
  dimension: adv_invoice_after_ad_ops_override {
    type: number
    description: "Manually corrected Adv Invoice, entry from Ad Ops override table"
    sql: ${TABLE}.adv_invoice_after_ad_ops_override ;;
  }
  dimension: billable_percent_25_complete_events_after_finance_adj {
    type: number
    sql: ${TABLE}.billable_percent_25_complete_events_after_finance_adj ;;
  }
  dimension: billable_percent_50_complete_events_after_finance_adj {
    type: number
    sql: ${TABLE}.billable_percent_50_complete_events_after_finance_adj ;;
  }
  dimension: billable_percent_75_complete_events_after_finance_adj {
    type: number
    sql: ${TABLE}.billable_percent_75_complete_events_after_finance_adj ;;
  }
  dimension: booked_units {
    type: number
    description: "Total units contracted to deliver, From SF"
    sql: ${TABLE}.booked_units ;;
  }
  dimension: capped_revenue_before_adj_with_override {
    label: "Capped Revenue (Before finance Adj, after AdOps adj)"
    description: "We take the smaller of: (1) Remaining budget (Total Booked Budget - Past Bill Amount), OR (2) Uncapped Revenue After AdOps Override."
    type: number
    sql: ${TABLE}.capped_revenue_before_adj_with_override ;;
  }
  dimension: check_completeness_revenue_adj {
    type: number
    description: "Validation check. Revenue Adj - (Units Adj x Rate)"
    sql: ${TABLE}.check_completeness_revenue_adj ;;
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
  dimension: discrepancy_between_1p_and_final_billable_revenue_after_adj {
    label: "Discrepancy Between 1P and Final Billable Revenue After Adj"
    description: "Final Billable Revenue After Adj - 1st Party Revenue. (Positive = billing more than calculated; Negative = billing less)"
    type: number
    sql: ${TABLE}.discrepancy_between_1p_and_final_billable_revenue_after_adj ;;
  }
  dimension: discrepancy_between_1p_and_final_billable_revenue_after_adj_percent {
    label: "Discrepancy In Between 1p USD and Final Billable Revenue After Adj Percent"
    description: "Difference between system revenue and billing in %. If Final Billable Revenue is 0, then 0%. Otherwise: (Final Billable Revenue - 1P Revenue) ÷ Final Billable Revenue"
    type: number
    sql: ${TABLE}.discrepancy_between_1p_and_final_billable_revenue_after_adj_percent ;;
  }
  dimension: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd {
    label: "Discrepancy In Between 1p USD and Final Billable Revenue After Adj USD"
    description: "Final Billable Revenue After Adj USD - 1st Party Revenue USD"
    type: number
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd ;;
  }
  dimension: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent {
    label: "Discrepancy In Between 1p USD and Final Billable Revenue After Adj USD Percent"
    description: "Difference between system revenue and billing in %. If Final Billable Revenue is 0, then 0%. Otherwise: (Final Billable Revenue - 1P Revenue) ÷ Final Billable Revenue"
    type: number
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent ;;
  }
  dimension: exchange_rate {
    type: number
    description: "Conversion rate to local billing currency, Monthly exchange rate from NetSuite"
    sql: ${TABLE}.exchange_rate ;;
  }
  dimension: exchange_rate_usd {
    label: "Exchange Rate USD"
    description: "Conversion rate to USD, Monthly exchange rate from NetSuite"
    type: number
    sql: ${TABLE}.exchange_rate_usd ;;
  }
  dimension: expected_revenue {
    type: number
    description: "Revenue expected for this month based on schedule (from Opportunity line Schedule in SF)"
    sql: ${TABLE}.expected_revenue ;;
  }
  dimension: final_billable_revenue_after_adj {
    label: "Final Billable Revenue After Finance Adj"
    description: "The Final Billable Revenue. If Finance uploaded a manual adjustment with a value greater than 0, we use that. Otherwise, we use the Capped Revenue."
    type: number
    sql: ${TABLE}.final_billable_revenue_after_adj ;;
  }
  dimension: final_billable_revenue_after_adj_usd {
    label: "Final Billable Revenue After Finance Adj USD"
    description: "Final Billable Revenue After Adj multiplied by Exchange Rate USD"
    type: number
    sql: ${TABLE}.final_billable_revenue_after_adj_usd ;;
  }
  dimension: final_billable_revenue_local_currency {
    type: number
    sql: ${TABLE}.final_billable_revenue_local_currency ;;
  }
  dimension: final_billable_units_after_adj {
    label: "Final Billable Units After Finance Adj"
    description: "The Final Billable Units. If Finance uploaded a manual adjustment, we use that number. Otherwise, for dCPM we use impressions; for all other price types we use the Total Billable Units Before Ad"
    type: number
    sql: ${TABLE}.final_billable_units_after_adj ;;
  }
  dimension: inventory_cost {
    type: number
    description: "inventory cost from DSP platform"
    sql: ${TABLE}.inventory_cost ;;
  }
  dimension: manual_discount {
    type: number
    sql: ${TABLE}.manual_discount ;;
  }
  dimension: margin_amount {
    type: number
    description: "Final Billable Revenue After Adj - Inventory Cost"
    sql: ${TABLE}.margin_amount ;;
  }
  dimension: margin_amount_percent_usd {
    label: "Margin Amount Precent USD"
    type: number
    sql: ${TABLE}.margin_amount_percent_usd ;;
  }
  dimension: margin_amount_usd {
    label: "Margin Amount USD"
    description: "Final Billable Revenue After Adj USD minus (Inventory Cost x Exchange Rate USD)"
    type: number
    sql: ${TABLE}.margin_amount_usd ;;
  }
  dimension: margin_percent {
    type: number
    sql: ${TABLE}.margin_percent ;;
  }
  dimension: ns_remaining_amount {
    type: number
    description: "Budget remaining after previous invoices. Total Booked Budget - Past Bill Amount"
    sql: ${TABLE}.ns_remaining_amount ;;
  }
  dimension: ns_remaining_units {
    type: number
    description: "Units remaining after previous invoices. Booked Units - Past Bill Units"
    sql: ${TABLE}.ns_remaining_units ;;
  }
  dimension: over_delivery_amount {
    type: number
    description: "Capped Revenue - Uncapped Revenue After AdOps Override. (This is negative when we over-delivered but had to cap.)"
    sql: ${TABLE}.over_delivery_amount ;;
  }
  dimension: over_delivery_amount_usd {
    label: "Over Delivery Amount USD"
    description: "Over Delivery Amount multiplied by Exchange Rate USD"
    type: number
    sql: ${TABLE}.over_delivery_amount_usd ;;
  }
  dimension: over_delivery_units {
    type: number
    description: "Units delivered beyond the cap"
    sql: ${TABLE}.over_delivery_units ;;
  }
  dimension: overall_discount {
    type: number
    sql: ${TABLE}.overall_discount ;;
  }
  dimension: p_rev {
    label: "1st Party Revenue"
    description: "1st Party Revenue calculated from 1P delivery data, considering line item status and price type"
    type: number
    sql: ${TABLE}.p_rev ;;
  }
  dimension: p_rev_usd {
    label: "1st Party Revenue USD"
    description: "1st Party Revenue multiplied by Exchange Rate USD"
    type: number
    sql: ${TABLE}.p_rev_usd ;;
  }
  dimension: past_bill_amount {
    type: number
    description: "Amount already billed in previous months, From NetSuite invoice data"
    sql: ${TABLE}.past_bill_amount ;;
  }
  dimension: past_bill_units {
    type: number
    description: "Units already billed in previous months, From NetSuite invoice data"
    sql: ${TABLE}.past_bill_units ;;
  }
  dimension: percent25_events {
    type: number
    description: "25% Complete Events from DSP platform"
    sql: ${TABLE}.percent25_events ;;
  }
  dimension: percent50_events {
    type: number
    description: "50% Complete Events from DSP platform"
    sql: ${TABLE}.percent50_events ;;
  }
  dimension: percent75_events {
    type: number
    description: "75% Complete Events from DSP platform"
    sql: ${TABLE}.percent75_events ;;
  }
  dimension: rate {
    type: number
    sql: ${TABLE}.rate ;;
  }
  dimension: rate_card_discount {
    type: number
    sql: ${TABLE}.rate_card_discount ;;
  }
  dimension: remaining_diff_between_1p_to_billing_3p_vs_1p_discrepancy {
    label: "Remaining Diff Between 1P  to Billing 3 P Vs 1 P Discrepancy"
    description: "Discrepancy - Over Delivery Amount - Revenue Adj - Uncapped Revenue Adj AdOps. (This is what's left after we account for all known adjustments - should ideally be close to 0)"
    type: number
    sql: ${TABLE}.remaining_diff_between_1p_to_billing_3p_vs_1p_discrepancy ;;
  }
  dimension: remaining_diff_between_1p_to_billing_3p_vs_1p_discrepancy_usd {
    label: "Remaining Diff Between 1P  to Billing 3 P Vs 1 P Discrepancy USD"
    description: "same as Remaining Diff Between 1 P to Billing 3 P Vs 1 P Discrepancy in USD"
    type: number
    sql: ${TABLE}.remaining_diff_between_1p_to_billing_3p_vs_1p_discrepancy_usd ;;
  }
  dimension: revenue_adj {
    label: "Revenue adj"
    description: "Finance Revenue Adj, This shows how much Finance changed the revenue. Final Billable Revenue After Adj - Capped Revenue"
    type: number
    sql: ${TABLE}.revenue_adj ;;
  }
  dimension: tac {
    type: number
    description: "TAC from DSP platform"
    sql: ${TABLE}.tac ;;
  }
  dimension: total_billable_units_before_adj_adops_override {
    type: number
    description: "Capped billable units"
    sql: ${TABLE}.total_billable_units_before_adj_adops_override ;;
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
  }
  dimension: uncapped_revenue_after_ad_ops_override {
    type: number
    description: "Revenue after Ad Ops Override . If there's an Ad Ops revenue override, use that value. Otherwise, use the sum of uncapped revenue"
    sql: ${TABLE}.uncapped_revenue_after_ad_ops_override ;;
  }
  dimension: uncapped_revenue_before_ad_ops_override {
    label: "Uncapped Revenue"
    type: number
    sql: ${TABLE}.uncapped_revenue_before_ad_ops_override ;;
  }
  dimension: under_delivery_budget {
    type: number
    description: "Total Booked Budget - (Past Bill Amount + Final Billable Revenue After Adj)"
    sql: ${TABLE}.under_delivery_budget ;;
  }
  dimension: under_delivery_budget_usd {
    label: "Under Delivery Budget USD"
    description: "Under Delivery Budget multiplied by Exchange Rate USD"
    type: number
    sql: ${TABLE}.under_delivery_budget_usd ;;
  }
  dimension: under_delivery_units {
    type: number
    description: "Booked Units - (Past Bill Units + Final Billable Units After Adj)"
    sql: ${TABLE}.under_delivery_units ;;
  }
  dimension: undiscounted_spend {
    type: number
    sql: ${TABLE}.undiscounted_spend ;;
  }
  dimension: unit_ad_ops_override_1p {
    label: "1P Unit after Ad Ops Override"
    description: "Manually corrected 1st party delivery units, entry from Ad Ops override table"
    type: number
    sql: ${TABLE}.unit_ad_ops_override_1p ;;
  }
  dimension: units_adj {
    label: "Finance units adj"
    description: "Finance adjustment to units. Final Billable Units After Adj minus Total Billable Units Before Adj AdOps Override"
    type: number
    sql: ${TABLE}.units_adj ;;
  }
  dimension: units_adj_override {
    label: "Units adj AdOps"
    description: "Difference between override and original units: Units Before Adj AdOps Override minus the raw delivered units (before override)"
    type: number
    sql: ${TABLE}.units_adj_override ;;
  }
  dimension: units_before_adj_ad_ops_override {
    type: number
    description: "Billable units before Finance Adjustment, If there's an Ad Ops override, use that value. Otherwise, use the sum of delivered units (consider price types)"
    sql: ${TABLE}.units_before_adj_ad_ops_override ;;
  }

  measure: impressions {
    type: sum
    description: "Sum of 1P impressions from DSP platform"
    sql: ${TABLE}.impressions ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      price_type_name,
      related_brand_name,
      account_name,
      opportunity_name,
      account_manager_name,
      line_item_name,
      opportunity_owner_name
    ]
  }

}
