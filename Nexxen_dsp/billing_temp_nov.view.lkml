view: billing_temp_nov {
  sql_table_name: BI_DSP.media_IO_billing_US ;;

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
  dimension: Over_Delivery_Units {
    type: number
    sql: ${TABLE}.Over_Delivery_Units ;;
  }
  dimension: Uncapped_Revenue {
    type: number
    sql: ${TABLE}.Uncapped_Revenue_Before_adops_Override ;;
  }
  dimension: ad_ops_override_approving_manager {
    type: string
    sql: ${TABLE}.AdOps_OverrideApprovingManager ;;
  }
  dimension: ad_ops_override_reason {
    type: string
    sql: ${TABLE}.AdOps_OverrideReason ;;
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
  }
  dimension: adv_invoice_ad_ops_override {
    type: number
    sql: ${TABLE}.Adv_Invoice_AdOps_Override ;;
  }
  dimension: billing_instructions {
    type: string
    sql: ${TABLE}.billing_instructions ;;
  }
  dimension: booked_units {
    type: number
    sql: ${TABLE}.booked_units ;;
  }
  dimension: capped_revenue_before_adj_with_override {
    type: number
    sql: ${TABLE}.capped_revenue_before_adj_with_override ;;
  }
  dimension: case_safe_opp_line_item_id {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id ;;
  }
  dimension: check_completeness_revenue_adj {
    type: number
    sql: ${TABLE}.Check_completeness_Revenue_ADJ ;;
  }
  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }
  dimension: complete_events {
    type: number
    sql: ${TABLE}.complete_events ;;
  }
  dimension_group: date_key {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Date_Key ;;
  }
  dimension: discrepancy_between_1_p_and_final_billable_revenue_after_adj {
    type: number
    sql: ${TABLE}.Discrepancy_between_1P_and_final_Billable_revenue_after_adj ;;
  }
  dimension: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd {
    type: number
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd ;;
  }
  dimension: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent {
    type: number
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent ;;
  }
  dimension: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_percent {
    type: number
    sql: ${TABLE}.Discrepancy_between_1P_and_final_Billable_revenue_after_adj_percent ;;
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
  dimension: final_billable_revenue_after_adj {
    type: number
    sql: ${TABLE}.final_billable_revenue_after_adj ;;
  }
  dimension: final_billable_revenue_after_adj_usd {
    type: number
    sql: ${TABLE}.final_billable_revenue_after_adj_usd ;;
  }
  dimension: final_billable_units_after_adj {
    type: number
    sql: ${TABLE}.final_billable_units_after_adj ;;
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
  }
  dimension: io_currency {
    type: string
    sql: ${TABLE}.IO_currency ;;
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
    sql: ${TABLE}.Margin_amount ;;
  }
  dimension: margin_amount_usd {
    type: number
    sql: ${TABLE}.margin_amount_usd ;;
  }
  dimension: modified_case_safe {
    type: string
    sql: ${TABLE}.modified_case_safe ;;
  }
  dimension: ns_remaining_amount {
    type: number
    sql: ${TABLE}.ns_remaining_amount ;;
  }
  dimension: ns_remaining_units {
    type: number
    sql: ${TABLE}.ns_remaining_units ;;
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
  dimension: over_delivery_amount {
    type: number
    sql: ${TABLE}.Over_delivery_Amount ;;
  }
  dimension: over_delivery_amount_usd {
    type: number
    sql: ${TABLE}.Over_Delivery_Amount_USD ;;
  }
  dimension: p_rev {
    type: number
    sql: ${TABLE}.p_rev ;;
  }
  dimension: p_rev_usd {
    type: number
    sql: ${TABLE}.p_rev_usd ;;
  }
  dimension: passed_bill_amount {
    label: "Past Bill Amount"
    type: number
    sql: ${TABLE}.passed_bill_amount ;;
  }
  dimension: percent25_events {
    type: number
    sql: ${TABLE}.percent25_events ;;
  }
  dimension: percent50_events {
    type: number
    sql: ${TABLE}.percent50_events ;;
  }
  dimension: percent75_events {
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
  dimension: product_sold {
    type: string
    sql: ${TABLE}.product_sold ;;
  }
  dimension: quantity {
    label: "Past Bill Units"
    type: number
    sql: ${TABLE}.quantity;;
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
  dimension: remaining_diff_between_1_p_to_billing_3_p_vs_1_p_discrepancy {
    type: number
    sql: ${TABLE}.Remaining_diff_between_1P_to_Billing_3P_VS_1P_discrepancy;;
  }
  dimension: remaining_diff_between_1_p_to_billing_3_p_vs_1_p_discrepancy_usd {
    type: number
    sql: ${TABLE}.Remaining_diff_between_1P_to_Billing_3P_VS_1P_discrepancy_usd ;;
  }

  dimension: revenue_adj {
    type: number
    sql: ${TABLE}.revenue_adj ;;
  }
  dimension: sales_team {
    type: string
    sql: ${TABLE}.sales_team ;;
  }
  dimension: server_reporting {
    type: string
    sql: ${TABLE}.server_reporting ;;
  }
  dimension: tac {
    type: number
    sql: ${TABLE}.tac ;;
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
  dimension: total_billable_units_before_adj_adops_override {
    type: number
    sql: ${TABLE}.total_billable_units_before_adj_adops_override ;;
  }
  dimension: total_booked_budget {
    type: number
    sql: ${TABLE}.total_booked_budget ;;
  }
  dimension: uncappe_d_revenue_adj_adops {
    type: number
    sql: ${TABLE}.UncappeD_Revenue_adj_adops ;;
  }
  dimension: uncapped_revenue_after_ad_ops_override {
    type: number
    sql: ${TABLE}.uncapped_revenue_after_AdOps_Override ;;
  }
  dimension: under_delivery_budget {
    type: number
    sql: ${TABLE}.under_delivery_budget ;;
  }
  dimension: under_delivery_budget_usd {
    type: number
    sql: ${TABLE}.Under_Delivery_budget_USD ;;
  }
  dimension: under_delivery_units {
    type: number
    sql: ${TABLE}.Under_Delivery_Units ;;
  }
  dimension: unit_ad_ops_override_1_p {
    type: number
    sql: ${TABLE}.Unit_AdOps_Override_1P ;;
  }
  dimension: unit_ad_ops_override_3_p {
    type: number
    sql: ${TABLE}.Unit_AdOps_Override_3P ;;
  }
  dimension: units_adj {
    type: number
    sql: ${TABLE}.Units_ADJ ;;
  }
  dimension: units_adj_override {
    type: number
    sql: ${TABLE}.units_adj_override ;;
  }
  dimension: units_before_adj_ad_ops_override {
    type: number
    sql: ${TABLE}.units_before_adj_AdOps_override ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  account_name,
  price_type_name,
  related_brand_name,
  opportunity_name,
  line_item_name,
  opportunity_owner_name,
  account_manager_name
  ]
  }

}
