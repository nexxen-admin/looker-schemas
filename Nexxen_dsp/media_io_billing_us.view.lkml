view: media_io_billing_us {
  sql_table_name: BI_DSP.media_IO_billing_US ;;

  # --- PRIMARY KEY (Critical for accurate sums) ---
  # We combine ID and Date to ensure every row is unique.
  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${case_safe_opp_line_item_id}, '-', ${date_key_month}) ;;
  }
  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
    hidden: yes
  }
  dimension: account_manager_name {
    type: string
    sql: ${TABLE}.account_manager_name ;;
    hidden: yes
  }
  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
    hidden: yes
  }
  dimension: ad_ops_override_approving_manager {
    type: string
    sql: ${TABLE}.AdOps_OverrideApprovingManager ;;
    hidden: yes
  }
  dimension: ad_ops_override_reason {
    type: string
    sql: ${TABLE}.AdOps_OverrideReason ;;
    hidden: yes
  }
  dimension: adjustment_billable_actions {
    type: number
    sql: ${TABLE}.adjustment_billable_actions ;;
    hidden: yes
  }
  dimension: adjustment_billable_clicks {
    type: number
    sql: ${TABLE}.adjustment_billable_clicks ;;
    hidden: yes
  }
  dimension: adjustment_billable_impressions {
    type: number
    sql: ${TABLE}.adjustment_billable_impressions ;;
    hidden: yes
  }
  dimension: adjustment_billable_revenue {
    type: number
    sql: ${TABLE}.adjustment_billable_revenue ;;
    hidden: yes
  }
  dimension: adjustment_billable_video_completes {
    type: number
    sql: ${TABLE}.adjustment_billable_video_completes ;;
    hidden: yes
  }
  dimension: adv_invoice {
    type: number
    sql: ${TABLE}.adv_invoice ;;
    hidden: yes
  }
  dimension: adv_invoice_ad_ops_override {
    type: number
    sql: ${TABLE}.Adv_Invoice_AdOps_Override ;;
    hidden: yes
  }
  dimension: billing_instructions {
    type: string
    sql: ${TABLE}.billing_instructions ;;
    hidden: yes
  }
  dimension: booked_units {
    type: number
    sql: ${TABLE}.booked_units ;;
    hidden: yes
  }
  dimension: capped_revenue_before_adj_with_override {
    type: number
    sql: ${TABLE}.capped_revenue_before_adj_with_override ;;
    hidden: yes
  }
  dimension: case_safe_opp_line_item_id {
    #primary_key: yes
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id ;;
    hidden: yes
  }
  dimension: check_completeness_revenue_adj {
    type: number
    sql: ${TABLE}.Check_completeness_Revenue_ADJ ;;
    hidden: yes
  }
  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
    hidden: yes
  }
  dimension: complete_events {
    type: number
    sql: ${TABLE}.complete_events ;;
    hidden: yes
  }
  dimension_group: date_key {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Date_Key ;;
    hidden: yes
  }
  dimension_group: db_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_update_date ;;
    hidden: yes
  }
  dimension: discrepancy_between_1_p_and_final_billable_revenue_after_adj {
    type: number
    sql: ${TABLE}.Discrepancy_between_1P_and_final_Billable_revenue_after_adj ;;
    hidden: yes
  }
  dimension: discrepancy_between_1_p_and_final_billable_revenue_after_adj_percent {
    type: number
    sql: ${TABLE}.Discrepancy_between_1P_and_final_Billable_revenue_after_adj_percent ;;
    hidden: yes
  }
  dimension: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd {
    type: number
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd ;;
    hidden: yes
  }
  dimension: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent {
    type: number
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent ;;
    hidden: yes
  }
  dimension_group: dsp_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dsp_end_date ;;
    hidden: yes
  }
  dimension_group: dsp_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dsp_start_date ;;
    hidden: yes
  }
  dimension: exchange_rate {
    type: number
    sql: ${TABLE}.exchange_rate ;;
    hidden: yes
  }
  dimension: exchange_rate_usd {
    type: number
    sql: ${TABLE}.exchange_rate_usd ;;
    hidden: yes
  }
  dimension: expected_revenue {
    type: number
    sql: ${TABLE}.Expected_Revenue ;;
    hidden: yes
  }


  dimension: final_billable_revenue_after_adj {
    type: number
    sql: ${TABLE}.final_billable_revenue_after_adj ;;
    hidden: yes
  }

  dimension: final_billable_revenue_after_adj_usd {
    type: number
    sql: ${TABLE}.final_billable_revenue_after_adj_usd ;;
    hidden: yes
  }

  measure: final_billable_revenue_after_adj_measure {
    type: sum
    label: "Final Billable Revenue"
    description: "Billable Revenue after Adjustments in Opp Currency"
    sql: ${TABLE}.final_billable_revenue_after_adj ;;
  }

  measure: final_billable_revenue_after_adj_usd_measure {
    type: sum
    label: "Final Billable Revenue USD"
    description: "Billable Revenue after Adjustments in USD"
    sql: ${TABLE}.final_billable_revenue_after_adj_usd ;;
  }

  dimension: final_billable_units_after_adj {
    type: number
    sql: ${TABLE}.final_billable_units_after_adj ;;
    hidden: yes
  }
  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
    hidden: yes
  }
  dimension: industry {
    type: string
    sql: ${TABLE}.industry ;;
    hidden: yes
  }
  dimension: inv_cost {
    type: number
    sql: ${TABLE}.inv_cost ;;
    hidden: yes
  }
  dimension: io_currency {
    type: string
    sql: ${TABLE}.IO_currency ;;
    hidden: yes
  }
  dimension: legal_entity {
    type: string
    sql: ${TABLE}.legal_entity ;;
    hidden: yes
  }
  dimension: line_item_name {
    type: string
    sql: ${TABLE}.line_item_name ;;
    hidden: yes
  }
  dimension: line_item_status {
    type: string
    sql: ${TABLE}.line_item_status ;;
    hidden: yes
  }
  dimension: margin_amount {
    type: number
    sql: ${TABLE}.Margin_amount ;;
    hidden: yes
  }
  dimension: margin_amount_percent_usd {
    type: number
    sql: ${TABLE}.Margin_amount_percent_USD ;;
    hidden: yes
  }
  dimension: margin_amount_usd {
    type: number
    sql: ${TABLE}.margin_amount_usd ;;
    hidden: yes
  }
  dimension: margin_parcent {
    type: number
    sql: ${TABLE}.Margin_Parcent ;;
    hidden: yes
  }
  dimension: modified_case_safe {
    type: string
    sql: ${TABLE}.modified_case_safe ;;
    hidden: yes
  }
  dimension: ns_remaining_amount {
    type: number
    sql: ${TABLE}.ns_remaining_amount ;;
    hidden: yes
  }
  dimension: ns_remaining_units {
    type: number
    sql: ${TABLE}.ns_remaining_units ;;
    hidden: yes
  }
  dimension_group: opportunity_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_end_date ;;
    hidden: yes
  }
  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
    hidden: yes
  }
  dimension: opportunity_number {
    type: string
    sql: ${TABLE}.opportunity_number ;;
    hidden: yes
  }
  dimension: opportunity_owner_name {
    type: string
    sql: ${TABLE}.opportunity_owner_name ;;
    hidden: yes
  }
  dimension: opportunity_region {
    type: string
    sql: ${TABLE}.opportunity_region ;;
    hidden: yes
  }
  dimension_group: opportunity_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_start_date ;;
    hidden: yes
  }
  dimension: opportunity_trader {
    type: string
    sql: ${TABLE}.opportunity_trader ;;
    hidden: yes
  }
  dimension: over_delivery_amount {
    type: number
    sql: ${TABLE}.Over_delivery_Amount ;;
    hidden: yes
  }
  dimension: over_delivery_amount_usd {
    type: number
    sql: ${TABLE}.Over_Delivery_Amount_USD ;;
    hidden: yes
  }
  dimension: over_delivery_units {
    type: number
    sql: ${TABLE}.Over_Delivery_Units ;;
    hidden: yes
  }
  dimension: p_rev {
    type: number
    sql: ${TABLE}.p_rev ;;
    hidden: yes
  }
  dimension: p_rev_usd {
    type: number
    sql: ${TABLE}.p_rev_usd ;;
    hidden: yes
  }
  dimension: passed_bill_amount {
    type: number
    sql: ${TABLE}.passed_bill_amount ;;
    hidden: yes
  }
  dimension: percent25_events {
    type: number
    sql: ${TABLE}.percent25_events ;;
    hidden: yes
  }
  dimension: percent50_events {
    type: number
    sql: ${TABLE}.percent50_events ;;
    hidden: yes
  }
  dimension: percent75_events {
    type: number
    sql: ${TABLE}.percent75_events ;;
    hidden: yes
  }
  dimension: price_type_name {
    type: string
    sql: ${TABLE}.price_type_name ;;
    hidden: yes
  }
  dimension: primary_kpi {
    type: string
    sql: ${TABLE}.primary_kpi ;;
    hidden: yes
  }
  dimension: product_level_1 {
    type: string
    sql: ${TABLE}.product_level_1 ;;
    hidden: yes
  }
  dimension: product_level_2 {
    type: string
    sql: ${TABLE}.product_level_2 ;;
    hidden: yes
  }
  dimension: product_sold {
    type: string
    sql: ${TABLE}.product_sold ;;
    hidden: yes
  }
  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
    hidden: yes
  }
  dimension: rate {
    type: number
    sql: ${TABLE}.rate ;;
    hidden: yes
  }
  dimension: related_brand_id {
    type: string
    sql: ${TABLE}.related_brand_id ;;
    hidden: yes
  }
  dimension: related_brand_name {
    type: string
    sql: ${TABLE}.related_brand_name ;;
    hidden: yes
  }
  dimension: remaining_diff_between_1_p_to_billing_3_p_vs_1_p_discrepancy {
    type: number
    sql: ${TABLE}.Remaining_diff_between_1P_to_Billing_3P_VS_1P_discrepancy ;;
    hidden: yes
  }
  dimension: remaining_diff_between_1_p_to_billing_3_p_vs_1_p_discrepancy_usd {
    type: number
    sql: ${TABLE}.Remaining_diff_between_1P_to_Billing_3P_VS_1P_discrepancy_usd ;;
    hidden: yes
  }
  dimension: revenue_adj {
    type: number
    sql: ${TABLE}.revenue_adj ;;
    hidden: yes
  }
  dimension: sales_team {
    type: string
    sql: ${TABLE}.sales_team ;;
    hidden: yes
  }
  dimension: server_reporting {
    type: string
    sql: ${TABLE}.server_reporting ;;
    hidden: yes
  }
  dimension: tac {
    type: number
    sql: ${TABLE}.tac ;;
    hidden: yes
  }
  dimension: third_party_clicks {
    type: number
    sql: ${TABLE}.third_party_clicks ;;
    hidden: yes
  }
  dimension: third_party_complete_events {
    type: number
    sql: ${TABLE}.third_party_complete_events ;;
    hidden: yes
  }
  dimension: third_party_impressions {
    type: number
    sql: ${TABLE}.third_party_impressions ;;
    hidden: yes
  }
  dimension: total_billable_units_before_adj_adops_override {
    type: number
    sql: ${TABLE}.total_billable_units_before_adj_adops_override ;;
    hidden: yes
  }
  dimension: total_booked_budget {
    type: number
    sql: ${TABLE}.total_booked_budget ;;
    hidden: yes
  }
  dimension: uncappe_d_revenue_adj_adops {
    type: number
    sql: ${TABLE}.UncappeD_Revenue_adj_adops ;;
    hidden: yes
  }
  dimension: uncapped_revenue_after_ad_ops_override {
    type: number
    sql: ${TABLE}.uncapped_revenue_after_AdOps_Override ;;
    hidden: yes
  }
  dimension: uncapped_revenue_before_adops_override {
    type: number
    sql: ${TABLE}.Uncapped_Revenue_Before_adops_Override ;;
    hidden: yes
  }
  dimension: under_delivery_budget {
    type: number
    sql: ${TABLE}.under_delivery_budget ;;
    hidden: yes
  }
  dimension: under_delivery_budget_usd {
    type: number
    sql: ${TABLE}.Under_Delivery_budget_USD ;;
    hidden: yes
  }
  dimension: under_delivery_units {
    type: number
    sql: ${TABLE}.Under_Delivery_Units ;;
    hidden: yes
  }
  dimension: unit_ad_ops_override_1_p {
    type: number
    sql: ${TABLE}.Unit_AdOps_Override_1P ;;
    hidden: yes
  }
  dimension: unit_ad_ops_override_3_p {
    type: number
    sql: ${TABLE}.Unit_AdOps_Override_3P ;;
    hidden: yes
  }
  dimension: units_adj {
    type: number
    sql: ${TABLE}.Units_ADJ ;;
    hidden: yes
  }
  dimension: units_adj_override {
    type: number
    sql: ${TABLE}.units_adj_override ;;
    hidden: yes
  }
  dimension: units_before_adj_ad_ops_override {
    type: number
    sql: ${TABLE}.units_before_adj_AdOps_override ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  opportunity_owner_name,
  account_manager_name,
  line_item_name,
  account_name,
  price_type_name,
  opportunity_name,
  related_brand_name
  ]
  }

}
