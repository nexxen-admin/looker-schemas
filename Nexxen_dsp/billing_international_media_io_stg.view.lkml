view: billing_international_media_io_stg {
  sql_table_name: BI_DSP.media_IO_billing_international ;;

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_manager_name {
    type: string
    sql: ${TABLE}.account_manager_name ;;
  }

  dimension: ad_ops_override_approving_manager {
    type: string
    sql: ${TABLE}.AdOps_OverrideApprovingManager ;;
  }

  dimension: ad_ops_override_reason {
    type: string
    sql: ${TABLE}.AdOps_OverrideReason ;;
  }

  measure: adj_3p_cost {
    type: sum
    sql: ${TABLE}.Adj_3P_Cost ;;
  }

  measure: adjustment_billable_actions {
    label: "Billable Actions after Finance Adj"
    type: sum
    sql: ${TABLE}.adjustment_billable_actions ;;
    value_format: "#,##0"
  }

  measure: adjustment_billable_clicks {
    label: "Billable Clicks after Finance Adj"
    type: sum
    sql: ${TABLE}.adjustment_billable_clicks ;;
    value_format: "#,##0"
  }

  measure: adjustment_billable_impressions {
    label: "Billable Impressions after Finance Adj"
    type: sum
    sql: ${TABLE}.adjustment_billable_impressions ;;
    value_format: "#,##0"
  }

  measure: adjustment_billable_revenue {
    label: "Finance revenue adj"
    type: sum
    sql: ${TABLE}.adjustment_billable_revenue ;;
    value_format: "$#,##0.00"
  }

  measure: adjustment_billable_video_completes {
    label: "Billable Complete events after Finance Adj"
    type: sum
    sql: ${TABLE}.adjustment_billable_video_completes ;;
    value_format: "#,##0"
  }

  measure: adv_invoice {
    type: sum
    sql: ${TABLE}.adv_invoice ;;
    value_format: "#,##0.00"
  }

  # dimension: adv_invoice_after_ad_ops_override {
  #   type: string
  #   sql: ${TABLE}.adv_invoice_after_ad_ops_override ;;
  # }

  # measure: billable_percent_25_complete_events_after_finance_adj {
  #   type: sum
  #   sql: 0 ;;
  # }

  # measure: billable_percent_50_complete_events_after_finance_adj {
  #   type: sum
  #   sql: 0 ;;
  # }

  # measure: billable_percent_75_complete_events_after_finance_adj {
  #   type: sum
  #   sql: 0 ;;
  # }

  dimension: billing_instructions {
    type: string
    sql: ${TABLE}.billing_instructions ;;
  }

  measure: booked_units {
    type: sum
    sql: ${TABLE}.booked_units ;;
    value_format: "#,##0"
  }

  measure: capped_revenue_before_adj_with_override {
    label: "Capped Revenue (Before finance Adj, after AdOps adj)"
    type: sum
    sql: ${TABLE}.capped_revenue_before_adj_with_override ;;
    value_format: "$#,##0.00"
  }

  dimension: case_safe_opp_line_item_id {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
    value_format: "#,##0"
  }

  measure: check_completeness_revenue_adj {
    type: sum
    sql: ${TABLE}.Check_completeness_Revenue_ADJ ;;
  }

  measure: complete_events {
    type: sum
    sql: ${TABLE}.complete_events ;;
    value_format: "#,##0"
  }

  dimension: corp_entity {
    type: string
    sql: ${TABLE}.corp_entity ;;
  }

  measure: discrepancy_between_1p_and_final_billable_revenue_after_adj {
    label: "Discrepancy Between 1P and Final Billable Revenue After Adj"
    type: average
    sql: ${TABLE}.Discrepancy_between_1P_and_final_Billable_revenue_after_adj ;;
  }

  measure: discrepancy_between_1p_and_final_billable_revenue_after_adj_percent {
    label: "Discrepancy In Between 1p USD and Final Billable Revenue After Adj Percent"
    type: average
    sql: ${TABLE}.Discrepancy_between_1P_and_final_Billable_revenue_after_adj_percent ;;
  }

  measure: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd {
    label: "Discrepancy In Between 1p USD and Final Billable Revenue After Adj USD"
    type: average
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd ;;
  }

  measure: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent {
    label: "Discrepancy In Between 1p USD and Final Billable Revenue After Adj USD Percent"
    type: average
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent ;;
  }

  dimension: exchange_rate {
    type: number
    sql: ${TABLE}.exchange_rate ;;
  }

  dimension:  exchange_rate_usd {
    label: "Exchange Rate USD"
    type: number
    sql: ${TABLE}.exchange_rate_usd ;;
  }

  measure: expected_revenue {
    type: sum
    sql: ${TABLE}.Expected_Revenue ;;
    value_format: "$#,##0.00"
  }

  measure: final_billable_revenue_after_adj {
    label: "Final Billable Revenue After Finance Adj"
    type: sum
    sql: ${TABLE}.final_billable_revenue_after_adj ;;
    value_format: "$#,##0.00"
  }

  measure: final_billable_revenue_after_adj_usd {
    label: "Final Billable Revenue After Finance Adj USD"
    type: sum
    sql: ${TABLE}.final_billable_revenue_after_adj_usd ;;
    value_format: "$#,##0.00"
  }

  dimension: final_billable_revenue_local_currency {
    type: string
    sql: ${TABLE}.final_billable_revenue_after_adj_local_currency ;;
  }

  measure: final_billable_units_after_adj {
    label: "Final Billable Units After Finance Adj"
    type: sum
    sql: ${TABLE}.final_billable_units_after_adj ;;
  }

  dimension: industry {
    type: string
    sql: ${TABLE}.industry ;;
  }

  measure: inventory_cost {
    type: sum
    sql: ${TABLE}.inv_cost ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
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

  measure: manual_discount {
    type: sum
    sql: ${TABLE}.manual_discount ;;
  }

  measure: margin_amount {
    type: sum
    sql: ${TABLE}.Margin_amount ;;
  }

  measure: margin_amount_usd {
    label: "Margin Amount USD"
    type: sum
    sql: ${TABLE}.margin_amount_usd ;;
  }

  measure: margin_amount_percent_USD {
    label: "Margin Amount Precent USD"
    type: average
    sql: ${TABLE}.Margin_amount_percent_USD ;;
  }

  measure: margin_percent {
    type: average
    sql: ${TABLE}.Margin_Parcent ;;
  }

  dimension: modified_case_safe {
    type: string
    sql: ${TABLE}.modified_case_safe ;;
  }
  measure: ns_remaining_amount {
    type: sum
    sql: ${TABLE}.ns_remaining_amount ;;
  }

  measure: ns_remaining_units {
    type: sum
    sql: ${TABLE}.ns_remaining_units ;;
  }

  dimension: opportunity_region {
    type: string
    sql: ${TABLE}.region ;;
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

  dimension: opportunity_trader {
    type: string
    sql: ${TABLE}.opportunity_trader ;;
  }

  measure: overall_discount {
    type: average
    sql: ${TABLE}.overall_discount ;;
  }

  measure: over_delivery_amount {
    type: sum
    sql: ${TABLE}.Over_delivery_Amount ;;
    value_format: "$#,##0.00"
  }

  measure: over_delivery_amount_USD {
    label: "Over Delivery Amount USD"
    type: sum
    sql: ${TABLE}.Over_Delivery_Amount_USD ;;
    value_format: "$#,##0.00"
  }

  measure: over_delivery_units {
    type: sum
    sql: ${TABLE}.Over_Delivery_Units ;;
  }

  measure: past_bill_amount {
    type: sum
    sql: ${TABLE}.past_bill_amount ;;
    value_format: "$#,##0.00"
  }

  measure: past_bill_units {
    type: sum
    sql: ${TABLE}.quantity ;;
  }

  measure: percent25_events {
    type: sum
    sql: ${TABLE}.percent25_events ;;
  }

  measure: percent50_events {
    type: sum
    sql: ${TABLE}.percent50_events ;;
  }

  measure: percent75_events {
    type: sum
    sql: ${TABLE}.percent75_events ;;
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

  measure: p_rev {
    label: "1st Party Revenue"
    type: sum
    sql: ${TABLE}.p_rev ;;
  }

  measure: p_rev_usd {
    label: "1st Party Revenue USD"
    type: sum
    sql: ${TABLE}.p_rev_usd ;;
  }

  dimension: rate {
    type: number
    sql: ${TABLE}.rate ;;
  }

  dimension: rate_card_discount {
    type: number
    sql: ${TABLE}.rate_card_discount ;;
  }

  dimension: related_brand_name {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }

  dimension: related_brand_id {
    type: string
    sql: ${TABLE}.related_brand_id ;;
  }

  # measure: remaining_diff_between_1P_to_billing_3P_vs_1P_discrepancy  {
  #   label: "Remaining Diff Between 1P  to Billing 3 P Vs 1 P Discrepancy"
  #   type: average
  #   sql: ${TABLE}.Remaining_diff_between_1P_to_Billing_3P_VS_1P_discrepancy ;;
  # }

  # measure: remaining_diff_between_1P_to_billing_3P_vs_1P_discrepancy_usd  {
  #   label: "Remaining Diff Between 1P  to Billing 3 P Vs 1 P Discrepancy USD"
  #   type: average
  #   sql: ${TABLE}.Remaining_diff_between_1P_to_Billing_3P_VS_1P_discrepancy_usd ;;
  # }

  measure: revenue_adj {
    label: "Revenue adj"
    type: sum
    sql: ${TABLE}.revenue_adj ;;
    description: "final_billable_revenue_after_adj - capped_revenue_before_adj_with_override"
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

  measure: tac {
    type: sum
    sql: ${TABLE}.tac ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.'type' ;;
  }

  measure: total_booked_budget {
    type: sum
    sql: ${TABLE}.total_booked_budget ;;
  }

  measure: total_billable_units_before_adj_adops_override {
    type: sum
    sql: ${TABLE}.total_billable_units_before_adj_adops_override ;;
  }

  measure: uncapped_revenue_adj_adops {
    type: sum
    sql: ${TABLE}.UncappeD_Revenue_adj_adops ;;
  }

  measure: uncapped_revenue_before_ad_ops_override {
    label: "Uncapped Revenue"
    type: sum
    sql: ${TABLE}.uncapped_revenue_bedore_AdOps_Override ;;
  }

  measure: uncapped_revenue_before_ad_ops_override_staging {
    label: "Uncapped Revenue (staging)"
    type: sum
    sql: ${TABLE}.uncapped_revenue_before_AdOps_Override ;;
  }

  measure: uncapped_revenue_after_ad_ops_override {
    type: sum
    sql: ${TABLE}.uncapped_revenue_after_AdOps_Override ;;
  }

  measure: under_delivery_budget {
    type: sum
    sql: ${TABLE}.under_delivery_budget ;;
  }

  measure: under_delivery_budget_usd {
    label: "Under Delivery Budget USD"
    type: sum
    sql: ${TABLE}.Under_Delivery_budget_USD ;;
  }

  measure: undiscounted_spend {
    type: sum
    sql: ${TABLE}.undiscounted_spend ;;
  }

  measure: unit_ad_ops_override_1p {
    label: "1P Unit after Ad Ops Override"
    type: sum
    sql: ${TABLE}.Unit_AdOps_Override_1P ;;
  }

  measure: under_delivery_units {
    type: sum
    sql: ${TABLE}.Under_Delivery_Units ;;
  }

  measure: units_adj {
    label: "Finance units adj"
    type: sum
    sql: ${TABLE}.Units_ADJ ;;
  }

  measure: units_adj_override {
    label: "Units adj AdOps"
    type: sum
    sql: ${TABLE}.units_adj_override ;;
  }

  measure: units_before_adj_ad_ops_override {
    type: sum
    sql: ${TABLE}.units_before_adj_AdOps_override ;;
  }

  dimension_group: date_key {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date_key ;;
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

  dimension_group: opportunity_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_start_date ;;
  }

  dimension_group: opportunity_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_end_date ;;
  }
}
