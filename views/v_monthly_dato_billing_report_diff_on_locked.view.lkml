view: v_monthly_dato_billing_report_diff_on_locked {
  sql_table_name: BI_DSP.v_monthly_dato_billing_report_DIFF_on_Locked ;;

  dimension: account_id_diff {
    type: number
    value_format_name: id
    sql: ${TABLE}.account_id_diff ;;
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
  dimension: booked_budget_diff {
    type: number
    sql: ${TABLE}.booked_budget_diff ;;
  }
  dimension: capped_diff {
    type: number
    sql: ${TABLE}.capped_diff ;;
  }
  dimension: case_safe_opp_line_item_id {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id ;;
  }
  dimension: check_completeness_revenue_adj {
    type: number
    sql: ${TABLE}.Check_completeness_Revenue_ADJ ;;
  }
  dimension: column {
    type: number
    label: "Impressions diff"
    sql: ${TABLE}."?column?" ;;
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
  dimension: dato_booked_budget {
    type: number
    sql: ${TABLE}.dato_booked_budget ;;
  }
  dimension: dato_booked_units {
    type: number
    sql: ${TABLE}.dato_booked_units ;;
  }
  dimension: dato_capped_revenue {
    type: number
    sql: ${TABLE}.dato_capped_revenue ;;
  }
  dimension: dato_click {
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
  dimension: dato_expected_revenue {
    type: number
    sql: ${TABLE}.dato_expected_revenue ;;
  }
  dimension: dato_final_revenue {
    type: number
    sql: ${TABLE}.Dato_Final_Revenue ;;
  }
  dimension: dato_first_complete_events {
    type: number
    sql: ${TABLE}.dato_first_complete_events ;;
  }
  dimension: dato_first_party_rev {
    type: number
    sql: ${TABLE}.dato_first_party_rev ;;
  }
  dimension: dato_imp {
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
  dimension: dato_ns_remaining_amount {
    type: number
    sql: ${TABLE}.Dato_ns_remaining_amount ;;
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
  dimension: dato_over_delivery {
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
  dimension: dato_third_complete_events {
    type: number
    sql: ${TABLE}.dato_third_complete_events ;;
  }
  dimension: dato_third_party_click {
    type: number
    sql: ${TABLE}.dato_third_party_click ;;
  }
  dimension: dato_uncapped_revenue {
    type: number
    sql: ${TABLE}.dato_Uncapped_revenue ;;
  }
  dimension: dato_under_delivery {
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
  dimension: expected_revenue_diff {
    type: number
    sql: ${TABLE}.expected_revenue_diff ;;
  }
  dimension: final_revenue_diff {
    type: number
    sql: ${TABLE}.Final_Revenue_Diff ;;
  }
  dimension: first_comp_events_diff {
    type: number
    sql: ${TABLE}.first_comp_events_diff ;;
  }
  dimension: first_party_click_diff {
    type: number
    sql: ${TABLE}.first_party_click_diff ;;
  }
  dimension: first_party_rev_diff {
    type: number
    sql: ${TABLE}.first_party_rev_diff ;;
  }
  dimension: industry_diff {
    type: number
    sql: ${TABLE}.industry_diff ;;
  }
  dimension: inv_cost {
    type: number
    sql: ${TABLE}.inv_cost ;;
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
  dimension: looker_booked_budget {
    type: number
    sql: ${TABLE}.looker_booked_budget ;;
  }
  dimension: looker_booked_units {
    type: number
    sql: ${TABLE}.looker_booked_units ;;
  }
  dimension: looker_capped_revenue {
    type: number
    sql: ${TABLE}.Looker_capped_revenue ;;
  }
  dimension: looker_clicks {
    type: number
    sql: ${TABLE}.Looker_clicks ;;
  }
  dimension_group: looker_end_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.looker_end_Date ;;
  }
  dimension: looker_expected_revenue {
    type: number
    sql: ${TABLE}.looker_expected_revenue ;;
  }
  dimension: looker_final_revenue {
    type: number
    sql: ${TABLE}.Looker_Final_Revenue ;;
  }
  dimension: looker_first_complete_events {
    type: number
    sql: ${TABLE}.looker_first_complete_events ;;
  }
  dimension: looker_first_party_rev {
    type: number
    sql: ${TABLE}.looker_first_party_rev ;;
  }
  dimension: looker_imp {
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
  dimension: looker_ns_remaining_amount {
    type: number
    sql: ${TABLE}.Looker_ns_remaining_amount ;;
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
  dimension: looker_over_delivery {
    type: number
    sql: ${TABLE}.looker_over_delivery ;;
  }
  dimension: looker_passed_bill {
    type: number
    sql: ${TABLE}.looker_passed_bill ;;
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
  dimension: looker_revenue_adj {
    type: number
    sql: ${TABLE}.Looker_Revenue_adj ;;
  }
  dimension: looker_sales_team {
    type: string
    sql: ${TABLE}.looker_sales_team ;;
  }
  dimension_group: looker_start_date {
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
  dimension: looker_third_complete_events {
    type: number
    sql: ${TABLE}.looker_third_complete_events ;;
  }
  dimension: looker_third_party_click {
    type: number
    sql: ${TABLE}.looker_third_party_click ;;
  }
  dimension: looker_uncapped_revenue {
    type: number
    sql: ${TABLE}.looker_Uncapped_revenue ;;
  }
  dimension: looker_under_delivery {
    type: number
    sql: ${TABLE}.looker_under_delivery ;;
  }
  dimension: margin_amount {
    type: number
    sql: ${TABLE}.margin_amount ;;
  }
  dimension: margin_amount_percent {
    type: number
    sql: ${TABLE}.margin_amount_percent ;;
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
  dimension: over_delivery_diff {
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
  dimension: start_date_diff {
    type: number
    sql: ${TABLE}.start_date_diff ;;
  }
  dimension: end_date_diff {
    type: number
    sql: ${TABLE}.end_date_diff ;;
  }
  dimension: Dato_price_type {
    type: string
    sql: ${TABLE}.Dato_price_type ;;
  }


  dimension: looker_price_type {
    type: string
    sql: ${TABLE}.looker_price_type ;;
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
  dimension: status_diff {
    type: number
    sql: ${TABLE}.status_diff ;;
  }
  dimension: third_comp_events_diff {
    type: number
    sql: ${TABLE}.third_comp_events_diff ;;
  }
  dimension: third_party_click_diff {
    type: number
    sql: ${TABLE}.third_party_click_diff ;;
  }
  dimension: third_party_imp {
    type: number
    sql: ${TABLE}.third_party_imp ;;
  }
  dimension: third_party_imp_dato {
    type: number
    sql: ${TABLE}.third_party_imp_dato ;;
  }
  dimension: third_party_imp_diff {
    type: number
    sql: ${TABLE}.third_party_imp_diff ;;
  }
  dimension: uncappe_d_revenue_adj_adops {
    type: number
    sql: ${TABLE}.UncappeD_Revenue_adj_adops ;;
  }
  dimension: uncapped_after_ad_ops_diff {
    type: number
    sql: ${TABLE}.uncapped_after_ad_ops_diff ;;
  }
  dimension: under_delivery_budget {
    type: number
    sql: ${TABLE}.under_delivery_budget ;;
  }
  dimension: under_delivery_diff {
    type: number
    sql: ${TABLE}.under_delivery_diff ;;
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
  dimension: Dato_first_p_dis {
    type: number
    sql: ${TABLE}.Dato_first_p_dis ;;
  }
  dimension: looker_first_p_disc {
    type: number
    sql: ${TABLE}.looker_first_p_disc ;;
  }
  dimension: dato_first_p_perc_disc {
    type: number
    sql: ${TABLE}.dato_first_p_perc_disc ;;
  }
  dimension: looker_first_p_perc_disc {
    type: number
    sql: ${TABLE}.looker_first_p_perc_disc ;;
  }
  dimension: first_p_perc_diff {
    type: number
    sql: ${TABLE}.first_p_perc_diff ;;
  }
  dimension: first_p_disc_diff {
    type: number
    sql: ${TABLE}.first_p_disc_diff ;;
  }
  dimension: units_adj_override {
    type: number
    sql: ${TABLE}.units_adj_override ;;
  }
  dimension: units_before_adj_ad_ops_override {
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
  looker_opp_name,
  looker_account_name,
  dato_opp_name,
  dato_related_brand_name,
  dato_account_manager_name,
  looker_related_brand_name,
  dato_account_name
  ]
  }

}
