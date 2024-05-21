# The name of this view in Looker is "Billing Us V1"
view: billing_us_v1 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.billing_us_v1 ;;

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

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension: adjustment_billable_revenue {
    type: number
    sql: ${TABLE}.adjustment_billable_revenue ;;
  }

  dimension: adjustment_billable_video_completes {
    type: number
    sql: ${TABLE}.adjustment_billable_video_completes ;;
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
  }

  dimension: case_safe_opp_line_item_id {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id ;;
  }

  measure: check_completeness_revenue_adj {
    type: sum
    sql: ${TABLE}.Check_completeness_Revenue_ADJ ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }

  measure: complete_events {
    type: sum
    sql: ${TABLE}.complete_events ;;
  }

  measure: cost {
    type: sum
    label: "Adv Invoice"
    sql: ${TABLE}.cost ;;
    value_format: "#,##0.00"
  }

  measure: discrepancy_between_1_p_and_final_billable_revenue_after_adj {
    type: sum
    sql: ${TABLE}.Discrepancy_between_1P_and_final_Billable_revenue_after_adj ;;
    value_format: "#,##0.00"
  }

  measure: discrepancy_between_1_p_and_final_billable_revenue_after_adj_percent {
    type: sum
    sql: ${TABLE}.Discrepancy_between_1P_and_final_Billable_revenue_after_adj_percent ;;
    value_format: "#,##0.00"
  }

  measure: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd {
    type: sum
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd ;;
    value_format: "#,##0.00"
  }

  measure: discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent {
    type: sum
    sql: ${TABLE}.discrepancy_in_between_1p_usd_and_final_billable_revenue_after_adj_usd_percent ;;
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

  dimension: expected_amount_c {
    type: number
    sql: ${TABLE}.expected_amount_c ;;
  }

  dimension: expected_revenue {
    type: number
    sql: ${TABLE}.expected_revenue ;;
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
    value_format: "#,##0.00"
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

  dimension: line_item_spend {
    type: number
    sql: ${TABLE}.line_item_spend ;;
  }

  dimension: line_item_status {
    type: string
    sql: ${TABLE}.line_item_status ;;
  }

  measure: margin_amount {
    type: sum
    sql: ${TABLE}.Margin_amount ;;
    value_format: "#,##0.00"
  }

  measure: margin_amount_percent {
    type: sum
    sql: ${TABLE}.Margin_amount_percent ;;
    value_format: "0.00%"
  }

  measure: margin_amount_percent_usd {
    type: sum
    sql: ${TABLE}.Margin_amount_percent_USD ;;
    value_format: "0.00%"
  }

  measure: margin_amount_usd {
    type: sum
    sql: ${TABLE}.margin_amount_usd ;;
    value_format: "#,##0.00"
  }

  dimension: modified_case_safe {
    type: string
    sql: ${TABLE}.modified_case_safe ;;
  }

  measure: ns_remaining_amount {
    type: sum
    sql: ${TABLE}.ns_remaining_amount ;;
    value_format: "#,##0.00"
  }

  measure: ns_remaining_units {
    type: sum
    sql: ${TABLE}.ns_remaining_units ;;
    value_format: "#,##0.00"
  }

  measure: od_delivery_units {
    type: sum
    sql: ${TABLE}.OD_Delivery_Units ;;
    value_format: "#,##0.00"
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: opp_line_item_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opp_line_item_end_date ;;
  }

  dimension_group: opp_line_item_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opp_line_item_start_date ;;
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

  measure: over_delivery_amount {
    type: sum
    sql: ${TABLE}.Over_delivery_Amount ;;
    value_format: "#,##0.00"
  }

  measure: over_delivery_amount_usd {
    type: sum
    sql: ${TABLE}.Over_Delivery_Amount_USD ;;
    value_format: "#,##0.00"
  }

  measure: p_rev {
    type: sum
    sql: ${TABLE}.p_rev ;;
    label: "1P Rev"
    value_format: "#,##0.00"
  }

  measure: p_rev_usd {
    type: sum
    label: "1P Rev USD"
    sql: ${TABLE}.p_rev_usd ;;
    value_format: "#,##0.00"
  }

  dimension: passed_bill_amount {
    type: number
    sql: ${TABLE}.passed_bill_amount ;;
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

  measure: remaining_diff_between_1_p_to_billing_3_p_vs_1_p_discrepancy_local_currency {
    type: sum
    sql: ${TABLE}.Remaining_diff_between_1P_to_Billing_3P_VS_1P_discrepancy_local_currency ;;
    value_format: "#,##0.00"
  }

  measure: remaining_diff_between_1_p_to_billing_3_p_vs_1_p_discrepancy_usd {
    type: sum
    sql: ${TABLE}.Remaining_diff_between_1P_to_Billing_3P_VS_1P_discrepancy_usd ;;
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
    sql: ${TABLE}.Spend ;;
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
    value_format: "#,##0.00"
  }

  measure: total_booked_budget {
    type: sum
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

  measure: under_delivery_budget_usd {
    type: sum
    sql: ${TABLE}.Under_Delivery_budget_USD ;;
    value_format: "#,##0.00"
  }

  measure: under_delivery_units {
    type: sum
    sql: ${TABLE}.Under_Delivery_Units ;;
    value_format: "#,##0.00"
  }

  measure: units_adj {
    type: sum
    sql: ${TABLE}.Units_ADJ ;;
    value_format: "#,##0.00"
  }

  measure: units_before_adj {
    type: sum
    sql: ${TABLE}.units_before_adj ;;
    value_format: "#,##0.00"
  }

  dimension_group: v_dim_dsp_date_date_key {
    type: time
    label: "Date Key"
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."v_dim_dsp_date.Date_Key" ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  account_manager_name,
  related_brand_name,
  line_item_name,
  opportunity_name,
  account_name,
  price_type_name,
  opportunity_owner_name
  ]
  }

}
