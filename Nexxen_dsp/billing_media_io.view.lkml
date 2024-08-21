
view: billing_media_io {
  derived_table: {
    sql: select * from bi_dsp.Billing_Media_IO_INTL ;;
  }

 dimension_group: date_key {
  type: time
  timeframes: [raw, time, date, week, month, quarter, year]
  label: "Month"
  sql: ${TABLE}.Date_Key ;;
}

dimension: opportunity_region {
  type: string
  sql: ${TABLE}.opportunity_region ;;
}

dimension: related_brand_id {
  type: string
  sql: ${TABLE}.related_brand_id ;;
}

dimension: related_brand_name {
  type: string
  sql: ${TABLE}.related_brand_name ;;
}

dimension: opportunity_owner_name {
  type: string
  sql: ${TABLE}.opportunity_owner_name ;;
}

dimension: account_manager_name {
  type: string
  sql: ${TABLE}.account_manager_name ;;
}

  dimension: rate_card_discount__c {
    type: number
    sql: ${TABLE}.rate_card_discount__c ;;
  }

  dimension: rate_card_discount_applies_to__c {
    type: string
    sql: ${TABLE}.rate_card_discount_applies_to__c ;;
  }

  dimension: overall_discount__c {
    type: number
    sql: ${TABLE}.overall_discount__c ;;
  }

dimension: opportunity_trader {
  type: string
  sql: ${TABLE}.opportunity_trader ;;
}

dimension: sales_team {
  type: string
  sql: ${TABLE}.sales_team ;;
}

dimension: account_id {
  type: string
  sql: ${TABLE}.account_id ;;
}

dimension: account_name {
  type: string
  sql: ${TABLE}.account_name ;;
}

dimension: line_item_name {
  type: string
  sql: ${TABLE}.line_item_name ;;
}

dimension: price_type_name {
  type: string
  sql: ${TABLE}.price_type_name ;;
}

dimension: product_level_2 {
  type: string
  sql: ${TABLE}.product_level_2 ;;
}

dimension: product_level_1 {
  type: string
  sql: ${TABLE}.product_level_1 ;;
}

dimension: primary_kpi {
  type: string
  sql: ${TABLE}.primary_kpi ;;
}

dimension: io_currency {
  type: string
  sql: ${TABLE}.IO_currency ;;
}

dimension: opportunity_name {
  type: string
  sql: ${TABLE}.opportunity_name ;;
}

dimension: opportunity_number {
  type: string
  sql: ${TABLE}.opportunity_number ;;
}

dimension: industry {
  type: string
  sql: ${TABLE}.industry ;;
}

dimension: case_safe_opp_line_item_id {
  type: string
  sql: ${TABLE}.case_safe_opp_line_item_id ;;
}

dimension: modified_case_safe {
  type: string
  sql: ${TABLE}.modified_case_safe ;;
}

dimension: line_item_status {
  type: string
  sql: ${TABLE}.line_item_status ;;
}

dimension: opp_line_item_start_date {
  type: date
  sql: ${TABLE}.opp_line_item_start_date ;;
}

dimension: opp_line_item_end_date {
  type: date
  sql: ${TABLE}.opp_line_item_end_date ;;
}

dimension: dsp_start_date {
  type: date
  sql: ${TABLE}.dsp_start_date ;;
}

dimension: dsp_end_date {
  type: date
  sql: ${TABLE}.dsp_end_date ;;
}

dimension: product_sold {
  type: string
  sql: ${TABLE}.product_sold ;;
}

dimension: server_reporting {
  type: string
  sql: ${TABLE}.server_reporting ;;
}

dimension: booked_units {
  type: number
  value_format: "0.####"
  sql: ${TABLE}.booked_units ;;
}

dimension: total_booked_budget {
  type: number
  value_format: "0.####"
  sql: ${TABLE}.total_booked_budget ;;
}

dimension: rate {
  type: number
  #value_format: "0.####"
  sql: ${TABLE}.rate ;;
}

dimension: passed_bill_amount {
  type: number
  value_format: "0.####"
  sql: ${TABLE}.passed_bill_amount ;;
}

dimension: quantity {
  type: number
  sql: ${TABLE}.quantity ;;
}

dimension: billing_instructions {
  type: string
  sql: ${TABLE}.billing_instructions ;;
}

dimension: expected_amount {
  type: number
  label: "Expected Revenue"
  value_format: "0.####"
  sql: ${TABLE}.Expected_amount ;;
}

dimension: monthly_adjustable_billable_revenue {
  type: number
  value_format: "#,##0.00"
  sql: ${TABLE}.monthly_adjustable_billable_revenue ;;
}

dimension: monthly_adjustable_billable_impressions {
  type: number
  value_format: "#,##0.00"
  sql: ${TABLE}.monthly_adjustable_billable_impressions ;;
}

dimension: monthly_adjustable_billable_clicks {
  type: number
  value_format: "#,##0.00"
  sql: ${TABLE}.monthly_adjustable_billable_clicks ;;
}

dimension: monthly_adjustable_billable_actions {
  type: number
  value_format: "#,##0.00"
  sql: ${TABLE}.monthly_adjustable_billable_actions ;;
}

dimension: monthly_adjustable_billable_video_completes {
  type: number
  value_format: "#,##0.00"
  sql: ${TABLE}.monthly_adjustable_billable_video_completes ;;
}

dimension: legal_entity {
  type: string
  sql: ${TABLE}.legal_entity ;;
}

measure: impressions {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.impressions ;;
}

measure: clicks {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.clicks ;;
}

measure: third_party_clicks {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.third_party_clicks ;;
}

measure: third_party_complete_events {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.third_party_complete_events ;;
}

measure: third_party_impressions {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.third_party_impressions ;;
}

measure: complete_events {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.complete_events ;;
}

measure: inv_cost {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.inv_cost ;;
}

measure: tac {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.tac ;;
}

measure: percent25_events {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.percent25_events ;;
}

measure: percent50_events {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.percent50_events ;;
}

measure: percent75_events {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.percent75_events ;;
}

measure: cost {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.cost ;;
}

measure: units_before_adj {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.units_before_adj ;;
}

measure: ns_remaining_units {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.ns_remaining_units ;;
}

measure: ns_remaining_amount {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.ns_remaining_amount ;;
}

measure: uncapped_revenue {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.uncapped_revenue ;;
}

measure: capped_revenue_before_adj {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.capped_revenue_before_adj ;;
}

measure: final_billable_revenue_after_adj {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.final_billable_revenue_after_adj ;;
}

measure: total_billable_units_before_adj {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.total_billable_units_before_adj ;;
}

measure: od_delivery_units {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.OD_Delivery_Units ;;
}

measure: final_billable_units_after_adj {
  type: sum
  sql: ${TABLE}.final_billable_units_after_adj ;;
}

measure: units_adj {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.Units_ADJ ;;
}

measure: under_delivery_units {
  type: sum
  sql: ${TABLE}.Under_Delivery_Units ;;
}

measure: p_rev {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.p_rev ;;
}

measure: over_delivery_amount {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.Over_delivery_Amount ;;
}

measure: revenue_adj {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.revenue_adj ;;
}

measure: check_completeness_revenue_adj {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.Check_completeness_Revenue_ADJ ;;
}

measure: under_delivery_budget {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.under_delivery_budget ;;
}

measure: discrepancy_between_1_p_and_final_billable_revenue_after_adj {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.Discrepancy_between_1P_and_final_Billable_revenue_after_adj ;;
}

measure: discrepancy_between_1_p_and_final_billable_revenue_after_adj_percent {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.Discrepancy_between_1P_and_final_Billable_revenue_after_adj_percent ;;
}

measure: margin_amount {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.Margin_amount ;;
}

measure: margin_amount_percent {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.Margin_amount_percent ;;
}

measure: remaining_diff_between_1_p_to_billing_3_p_vs_1_p_discrepancy_local_currency {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.Remaining_diff_between_1P_to_Billing_3P_VS_1P_discrepancy_local_currency ;;
}

measure: under_delivery_budget_usd {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.Under_Delivery_budget_USD ;;
}

measure: margin_amount_usd {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.margin_amount_usd ;;
}

measure: final_billable_revenue_after_adj_usd {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.final_billable_revenue_after_adj_usd ;;
}

measure: margin_amount_percent_usd {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.Margin_amount_percent_USD ;;
}

measure: over_delivery_amount_usd {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.Over_Delivery_Amount_USD ;;
}

measure: p_rev_usd {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.p_rev_usd ;;
}

measure: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd ;;
}

measure: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent ;;
}

measure: remaining_diff_between_1_p_to_billing_3_p_vs_1_p_discrepancy_usd {
  type: sum
  value_format: "#,##0.00"
  sql: ${TABLE}.Remaining_diff_between_1P_to_Billing_3P_VS_1P_discrepancy_usd ;;
}

}
