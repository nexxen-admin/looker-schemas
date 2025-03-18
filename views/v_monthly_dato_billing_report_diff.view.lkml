view: v_monthly_dato_billing_report_diff {
  sql_table_name: BI_DSP.v_monthly_dato_billing_report_DIFF ;;

  dimension: account_id_diff {
    type: number
    value_format_name: id
    sql: ${TABLE}.account_id_diff ;;
  }

  dimension: Period {
    type: string
    sql: ${TABLE}.Period;;
  }
  dimension: Looker_DB_update_date {
    type: string
    sql: ${TABLE}.Looker_DB_update_date;;
  }
  dimension: Dato_DB_update_date {
    type: string
    sql: ${TABLE}.Dato_DB_update_date;;
  }
  dimension: account_manager_diff {
    type: number
    sql: ${TABLE}.account_manager_diff ;;
  }
  dimension: account_name_diff {
    type: number
    sql: ${TABLE}.account_name_diff ;;
  }
  dimension: billing_instructions_diff {
    type: number
    sql: ${TABLE}.billing_instructions_diff ;;
  }
  measure: booked_budget_diff {
    type: number
    sql: ${TABLE}.booked_budget_diff ;;
  }
  measure: capped_diff {
    type: number
    sql: ${TABLE}.capped_diff ;;
    value_format: "$0"
  }
  dimension: case_safe_opp_line_item_id {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id ;;
  }
  measure: check_completeness_revenue_adj {
    type: number
    sql: ${TABLE}.Check_completeness_Revenue_ADJ ;;
    value_format: "$0"
  }
  measure: column {
    type: number
    label: "Impressions diff"
    sql: ${TABLE}."?column?" ;;
  }
  dimension: dato_price_type {
    type: string
    sql: ${TABLE}.Dato_price_type ;;
  }
  dimension: looker_price_type {
    type: string
    sql: ${TABLE}.looker_price_type ;;
  }
  dimension: dato_account_id {
    type: string
    sql: ${TABLE}.dato_account_id ;;
  }
  dimension: dato_account_manager_name {
    type: string
    sql: ${TABLE}.dato_account_manager_name ;;
  }
  dimension: dato_account_name {
    type: string
    sql: ${TABLE}.dato_account_name ;;
  }
  dimension: dato_billing_instructions {
    type: string
    sql: ${TABLE}.dato_billing_instructions ;;
  }
  measure: dato_booked_budget {
    type: number
    sql: ${TABLE}.dato_booked_budget ;;
  }
  dimension: dato_booked_units {
    type: number
    sql: ${TABLE}.dato_booked_units ;;
  }
  measure: dato_capped_revenue {
    type: number
    sql: ${TABLE}.dato_capped_revenue ;;
    value_format: "$0"
  }
  measure: dato_click {
    type: number
    sql: ${TABLE}.dato_click ;;
  }
  dimension_group: dato_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dato_end_Date ;;
  }
  measure: dato_expected_revenue {
    type: number
    sql: ${TABLE}.dato_expected_revenue ;;
    value_format: "$0"
  }
  measure: dato_final_revenue {
    type: number
    sql: ${TABLE}.Dato_Final_Revenue ;;
  }
  measure: dato_first_complete_events {
    type: number
    sql: ${TABLE}.dato_first_complete_events ;;
  }
  measure: dato_first_party_rev {
    type: number
    sql: ${TABLE}.dato_first_party_rev ;;
    value_format: "$0"
  }
  measure: dato_imp {
    type: number
    sql: ${TABLE}.DATO_IMP ;;
  }
  dimension: dato_industry {
    type: string
    sql: ${TABLE}.dato_industry ;;
  }
  dimension: dato_io_currency {
    type: string
    sql: ${TABLE}.dato_IO_currency ;;
  }
  dimension: dato_legal_entity {
    type: string
    sql: ${TABLE}.dato_legal_entity ;;
  }
  dimension: dato_line_item {
    type: string
    sql: ${TABLE}.dato_line_item ;;
  }
  measure: dato_ns_remaining_amount {
    type: number
    sql: ${TABLE}.Dato_ns_remaining_amount ;;
    value_format: "$0"
  }
  dimension: dato_opp_name {
    type: string
    sql: ${TABLE}.dato_opp_name ;;
  }
  dimension: dato_opp_number {
    type: string
    sql: ${TABLE}.dato_opp_number ;;
  }
  dimension: dato_opportunity_owner {
    type: string
    sql: ${TABLE}.dato_opportunity_owner ;;
  }
  measure: dato_over_delivery {
    type: number
    sql: ${TABLE}.dato_over_delivery ;;
  }
  dimension: dato_passed_bill {
    type: number
    sql: ${TABLE}.dato_passed_bill ;;
  }
  dimension: dato_primary_kpi {
    type: string
    sql: ${TABLE}.dato_primary_kpi ;;
  }
  dimension: dato_product_level_1 {
    type: string
    sql: ${TABLE}.dato_product_level_1 ;;
  }
  dimension: dato_product_level_2 {
    type: string
    sql: ${TABLE}.dato_product_level_2 ;;
  }
  dimension: dato_rate {
    type: number
    sql: ${TABLE}.Dato_Rate ;;
  }
  dimension: dato_region {
    type: string
    sql: ${TABLE}.dato_region ;;
  }
  dimension: dato_related_brand_id {
    type: string
    sql: ${TABLE}.dato_related_brand_id ;;
  }
  dimension: dato_related_brand_name {
    type: string
    sql: ${TABLE}.dato_related_brand_name ;;
  }
  dimension: dato_reporting {
    type: string
    sql: ${TABLE}.dato_reporting ;;
  }
  dimension: dato_sales_team {
    type: string
    sql: ${TABLE}.dato_sales_team ;;
  }
  dimension_group: dato_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dato_start_date ;;
  }
  dimension: dato_status {
    type: string
    sql: ${TABLE}.dato_status ;;
  }
  measure: dato_third_complete_events {
    type: number
    sql: ${TABLE}.dato_third_complete_events ;;
  }
  measure: dato_third_party_click {
    type: number
    sql: ${TABLE}.dato_third_party_click ;;
  }
  measure: dato_uncapped_revenue {
    type: number
    sql: ${TABLE}.dato_Uncapped_revenue ;;
  }
  measure: dato_under_delivery {
    type: number
    sql: ${TABLE}.dato_under_delivery ;;
  }
  dimension: discrepancy_between_1p_and_final_billable_revenue_after_adj {
    type: number
    sql: ${TABLE}.Discrepancy_between_1p_and_final_billable_revenue_after_adj ;;
  }
  dimension: discrepancy_between_1p_and_final_billable_revenue_after_adj_precent {
    type: number
    sql: ${TABLE}.discrepancy_between_1p_and_final_billable_revenue_after_adj_precent ;;
  }
  dimension: end_date_diff {
    type: number
    sql: ${TABLE}.end_date_diff ;;
  }
  dimension: expected_revenue_diff {
    type: number
    sql: ${TABLE}.expected_revenue_diff ;;
  }
  measure: final_revenue_diff {
    type: number
    sql: ${TABLE}.Final_Revenue_Diff ;;
    value_format: "$0"
  }
  measure: first_comp_events_diff {
    type: number
    sql: ${TABLE}.first_comp_events_diff ;;
  }
  measure: first_party_click_diff {
    type: number
    sql: ${TABLE}.first_party_click_diff ;;
  }
  measure: first_party_rev_diff {
    type: number
    sql: ${TABLE}.first_party_rev_diff ;;
  }
  dimension: industry_diff {
    type: number
    sql: ${TABLE}.industry_diff ;;
  }
  measure: inv_cost {
    type: number
    sql: ${TABLE}.inv_cost ;;
    value_format: "$0.00"
  }
  dimension: io_currency_diff {
    type: number
    sql: ${TABLE}.IO_currency_diff ;;
  }
  dimension: io_key {
    type: string
    sql: ${TABLE}.IO_KEY ;;
  }
  dimension: legal_diff {
    type: number
    sql: ${TABLE}.legal_diff ;;
  }
  dimension: line_item_diff {
    type: number
    sql: ${TABLE}.line_item_diff ;;
  }
  dimension: looker_account_id {
    type: string
    sql: ${TABLE}.looker_account_id ;;
  }
  dimension: looker_account_manager {
    type: string
    sql: ${TABLE}.looker_account_manager ;;
  }
  dimension: looker_account_name {
    type: string
    sql: ${TABLE}.Looker_account_name ;;
  }
  dimension: looker_billing_instructions {
    type: string
    sql: ${TABLE}.looker_billing_instructions ;;
  }
  measure: looker_booked_budget {
    type: number
    sql: ${TABLE}.looker_booked_budget ;;
  }
  dimension: looker_booked_units {
    type: number
    sql: ${TABLE}.looker_booked_units ;;
  }
  measure: looker_capped_revenue {
    type: number
    sql: ${TABLE}.Looker_capped_revenue ;;
    value_format: "$0"
  }
  measure: looker_clicks {
    type: number
    sql: ${TABLE}.Looker_clicks ;;
  }
  dimension_group: looker_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.looker_end_Date ;;
  }
  measure: looker_expected_revenue {
    type: number
    sql: ${TABLE}.looker_expected_revenue ;;
  }
  measure: looker_final_revenue {
    type: number
    sql: ${TABLE}.Looker_Final_Revenue ;;
    value_format: "$0"
  }
  measure: looker_first_complete_events {
    type: number
    sql: ${TABLE}.looker_first_complete_events ;;
  }
  measure: looker_first_party_rev {
    type: number
    sql: ${TABLE}.looker_first_party_rev ;;
  }
  measure: looker_imp {
    type: number
    sql: ${TABLE}.looker_imp ;;
  }
  dimension: looker_industry {
    type: string
    sql: ${TABLE}.looker_industry ;;
  }
  dimension: looker_io_currency {
    type: string
    sql: ${TABLE}.looker_IO_currency ;;
  }
  dimension: looker_legal_entity {
    type: string
    sql: ${TABLE}.looker_legal_entity ;;
  }
  dimension: looker_line_item {
    type: string
    sql: ${TABLE}.looker_line_item ;;
  }
  measure: looker_ns_remaining_amount {
    type: number
    sql: ${TABLE}.Looker_ns_remaining_amount ;;
    value_format: "$0"
  }
  dimension: looker_opp_name {
    type: string
    sql: ${TABLE}.looker_opp_name ;;
  }
  dimension: looker_opp_number {
    type: string
    sql: ${TABLE}.Looker_opp_number ;;
  }
  dimension: looker_opportunity_owner {
    type: string
    sql: ${TABLE}.looker_opportunity_owner ;;
  }
  measure: looker_over_delivery {
    type: number
    sql: ${TABLE}.looker_over_delivery ;;
  }
  measure: looker_passed_bill {
    type: number
    sql: ${TABLE}.looker_passed_bill ;;
    value_format: "$0"
  }
  dimension: looker_primary_kpi {
    type: string
    sql: ${TABLE}.looker_primary_kpi ;;
  }
  dimension: looker_product_level_1 {
    type: string
    sql: ${TABLE}.looker_product_level_1 ;;
  }
  dimension: looker_product_level_2 {
    type: string
    sql: ${TABLE}.looker_product_level_2 ;;
  }
  dimension: looker_rate {
    type: number
    sql: ${TABLE}.looker_rate ;;
  }
  dimension: looker_region {
    type: string
    sql: ${TABLE}.Looker_Region ;;
  }
  dimension: looker_related_brand_id {
    type: string
    sql: ${TABLE}.looker_related_brand_id ;;
  }
  dimension: looker_related_brand_name {
    type: string
    sql: ${TABLE}.looker_related_brand_name ;;
  }
  dimension: looker_reporting {
    type: string
    sql: ${TABLE}.looker_reporting ;;
  }
  measure: looker_revenue_adj {
    type: number
    sql: ${TABLE}.Looker_Revenue_adj ;;
    value_format: "$0"
  }
  dimension: looker_sales_team {
    type: string
    sql: ${TABLE}.looker_sales_team ;;
  }
  dimension_group: looker_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.looker_start_date ;;
  }
  dimension: looker_status {
    type: string
    sql: ${TABLE}.looker_status ;;
  }
  measure: looker_third_complete_events {
    type: number
    sql: ${TABLE}.looker_third_complete_events ;;
  }
  measure: looker_third_party_click {
    type: number
    sql: ${TABLE}.looker_third_party_click ;;
  }
  measure: looker_uncapped_revenue {
    type: number
    sql: ${TABLE}.looker_Uncapped_revenue ;;
  }
  measure: looker_under_delivery {
    type: number
    sql: ${TABLE}.looker_under_delivery ;;
  }
  measure: margin_amount {
    type: number
    sql: ${TABLE}.margin_amount ;;
    value_format: "$0.00"
  }
  measure: margin_amount_percent {
    type: number
    sql: ${TABLE}.margin_amount_percent ;;
    value_format: "0.00%"
  }
  dimension: ns_remaining_amount_diff {
    type: number
    sql: ${TABLE}.ns_remaining_amount_diff ;;
  }
  dimension: opp_name_diff {
    type: number
    sql: ${TABLE}.opp_name_diff ;;
  }
  dimension: opp_number_diff {
    type: number
    sql: ${TABLE}.opp_number_diff ;;
  }
  dimension: opportunity_owner_diff {
    type: number
    sql: ${TABLE}.opportunity_owner_diff ;;
  }
  measure: over_delivery_diff {
    type: number
    sql: ${TABLE}.over_delivery_diff ;;
  }
  dimension: passed_bill_diff {
    type: number
    sql: ${TABLE}.passed_bill_diff ;;
  }
  dimension: price_type_diff {
    type: number
    sql: ${TABLE}.price_type_diff ;;
  }
  dimension: primary_kpi_diff {
    type: number
    sql: ${TABLE}.primary_kpi_diff ;;
  }
  dimension: product_level_1_diff {
    type: number
    sql: ${TABLE}.product_level_1_diff ;;
  }
  dimension: product_level_2_diff {
    type: number
    sql: ${TABLE}.product_level_2_diff ;;
  }
  dimension: rate_diff {
    type: number
    sql: ${TABLE}.rate_diff ;;
  }
  dimension: region_diff {
    type: number
    sql: ${TABLE}.region_diff ;;
  }
  dimension: related_brand_id_diff {
    type: number
    value_format_name: id
    sql: ${TABLE}.related_brand_id_diff ;;
  }
  dimension: related_brand_name_id_diff {
    type: number
    value_format_name: id
    sql: ${TABLE}.related_brand_name_id_diff ;;
  }
  dimension: reporting_diff {
    type: number
    sql: ${TABLE}.reporting_diff ;;
  }
  dimension: sales_team_diff {
    type: number
    sql: ${TABLE}.sales_team_diff ;;
  }
  dimension: start_date_diff {
    type: number
    sql: ${TABLE}.start_date_diff ;;
  }
  dimension: status_diff {
    type: number
    sql: ${TABLE}.status_diff ;;
  }
  measure: third_comp_events_diff {
    type: number
    sql: ${TABLE}.third_comp_events_diff ;;
  }
  measure: third_party_click_diff {
    type: number
    sql: ${TABLE}.third_party_click_diff ;;
  }
  measure: third_party_imp {
    type: number
    sql: ${TABLE}.third_party_imp ;;
  }
  measure: third_party_imp_dato {
    type: number
    sql: ${TABLE}.third_party_imp_dato ;;
  }
  measure: third_party_imp_diff {
    type: number
    sql: ${TABLE}.third_party_imp_diff ;;
  }
  measure: uncappe_d_revenue_adj_adops {
    type: number
    sql: ${TABLE}.UncappeD_Revenue_adj_adops ;;
  }
  measure: uncapped_after_ad_ops_diff {
    type: number
    sql: ${TABLE}.uncapped_after_ad_ops_diff ;;
  }
  measure: under_delivery_budget {
    type: number
    sql: ${TABLE}.under_delivery_budget ;;
    value_format: "$0"
  }
  measure: under_delivery_diff {
    type: number
    sql: ${TABLE}.under_delivery_diff ;;
  }
  measure: unit_ad_ops_override_1_p {
    type: number
    sql: ${TABLE}.Unit_AdOps_Override_1P ;;
  }
  measure: unit_ad_ops_override_3_p {
    type: number
    sql: ${TABLE}.Unit_AdOps_Override_3P ;;
  }
  measure: units_adj {
    type: number
    sql: ${TABLE}.Units_ADJ ;;
  }
  measure: units_adj_override {
    type: number
    sql: ${TABLE}.units_adj_override ;;
  }
  measure: units_before_adj_ad_ops_override {
    type: number
    sql: ${TABLE}.units_before_adj_AdOps_override ;;
  }
  dimension: units_diff {
    type: number
    sql: ${TABLE}.units_diff ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  looker_account_name,
  looker_opp_name,
  dato_opp_name,
  dato_related_brand_name,
  dato_account_manager_name,
  looker_related_brand_name,
  dato_account_name
  ]
  }

}
