view: ssot_v {
  sql_table_name: BI_DSP.ssot_v ;;

  dimension: adv_invoice {
    type: number
    sql: ${TABLE}.adv_invoice ;;
  }
  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
  }
  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }
  dimension: bid_saving_fee {
    type: number
    sql: ${TABLE}.bid_saving_fee ;;
  }
  dimension: bid_saving_fee_calculated {
    type: number
    sql: ${TABLE}.bid_saving_fee_calculated ;;
  }
  dimension: billing_margin {
    type: number
    sql: ${TABLE}.billing_margin ;;
  }
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
  dimension: category_id {
    type: number
    sql: ${TABLE}.category_id ;;
  }
  dimension: content_data_cost {
    type: number
    sql: ${TABLE}.content_data_cost ;;
  }
  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }
  dimension: country_id {
    type: number
    sql: ${TABLE}.country_id ;;
  }
  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
  }
  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
  }
  dimension: data_costs {
    type: number
    sql: ${TABLE}.data_costs ;;
  }
  dimension_group: date_period {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_period ;;
  }
  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
  }
  dimension: environment_id {
    type: number
    sql: ${TABLE}.environment_id ;;
  }
  measure: exchange_fee {
    type: sum
    sql: ${TABLE}.exchange_fee ;;
    value_format: "$#,##0.00"
  }
  dimension: exchange_line_item_id {
    type: string
    sql: ${TABLE}.exchange_line_item_id ;;
  }
  dimension: first_party_cost {
    type: number
    sql: ${TABLE}.first_party_cost ;;
  }
  dimension: home_market_id {
    type: number
    sql: ${TABLE}.home_market_id ;;
  }
  dimension: home_market_name {
    type: string
    sql: ${TABLE}.home_market_name ;;
  }
  dimension_group: impression {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.impression_date ;;
  }
  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }
  dimension: insertion_order_id {
    type: number
    sql: ${TABLE}.insertion_order_id ;;
  }
  dimension: insertion_order_name {
    type: string
    sql: ${TABLE}.insertion_order_name ;;
  }
  dimension: inventory_carry_fee {
    type: number
    sql: ${TABLE}.inventory_carry_fee ;;
  }
  dimension: inventory_carrying_cost {
    type: number
    sql: ${TABLE}.inventory_carrying_cost ;;
  }
  measure: inventory_cost {
    type: sum
    sql: ${TABLE}.inventory_cost ;;
    value_format: "$#,##0.00"
  }
  dimension: inventory_source_id {
    type: number
    sql: ${TABLE}.inventory_source_id ;;
  }
  dimension: inventory_source_name {
    type: string
    sql: ${TABLE}.inventory_source_name ;;
  }
  dimension: is_billable {
    type: number
    sql: ${TABLE}.is_billable ;;
  }
  dimension: managed_service_fee_cost {
    type: number
    sql: ${TABLE}.managed_service_fee_cost ;;
  }
  dimension: managed_service_fee_id {
    type: number
    sql: ${TABLE}.managed_service_fee_id ;;
  }
  dimension: margin_on_inventory {
    type: number
    sql: ${TABLE}.margin_on_inventory ;;
  }
  dimension: market_inventory_source_id {
    type: number
    sql: ${TABLE}.market_inventory_source_id ;;
  }
  dimension: media_channel_id {
    type: number
    sql: ${TABLE}.media_channel_id ;;
  }
  dimension: media_channel_name {
    type: string
    sql: ${TABLE}.media_channel_name ;;
  }
  dimension: media_type {
    type: string
    sql: ${TABLE}.media_type ;;
  }
  dimension: nexxen_fee {
    type: number
    sql: ${TABLE}.nexxen_fee ;;
  }
  dimension: ns_customer_id {
    type: number
    sql: ${TABLE}.ns_customer_id ;;
  }
  dimension: override_deal_fee_id {
    type: number
    sql: ${TABLE}.override_deal_fee_id ;;
  }
  dimension: package_id {
    type: number
    sql: ${TABLE}.package_id ;;
  }
  dimension: package_name {
    type: string
    sql: ${TABLE}.package_name ;;
  }
  dimension: parent_category {
    type: string
    sql: ${TABLE}.parent_category ;;
  }
  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }
  dimension: pmp_fee {
    type: number
    sql: ${TABLE}.pmp_fee ;;
  }
  dimension: publisher_cost {
    type: number
    sql: ${TABLE}.publisher_cost ;;
  }
  dimension: publisher_id {
    type: string
    sql: ${TABLE}.publisher_id ;;
  }
  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }
  dimension: reconciliation_factor {
    type: number
    sql: ${TABLE}.reconciliation_factor ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }
  dimension: region_id {
    type: number
    sql: ${TABLE}.region_id ;;
  }
  dimension: revenue_category {
    type: string
    sql: ${TABLE}.revenue_category ;;
  }
  dimension: service_level {
    type: string
    sql: ${TABLE}.service_level ;;
  }
  dimension: service_level_contract {
    type: string
    sql: ${TABLE}.service_level_contract ;;
  }
  dimension: sf_account_id {
    type: string
    sql: ${TABLE}.sf_account_id ;;
  }
  dimension: sf_account_name {
    type: string
    sql: ${TABLE}.sf_account_name ;;
  }
  dimension: sf_billing_account_id {
    type: string
    sql: ${TABLE}.sf_billing_account_id ;;
  }
  dimension: sf_billing_account_name {
    type: string
    sql: ${TABLE}.sf_billing_account_name ;;
  }
  dimension: sf_opportunity_id {
    type: string
    sql: ${TABLE}.sf_opportunity_id ;;
  }
  dimension: sf_opportunity_line_item_id {
    type: string
    sql: ${TABLE}.sf_opportunity_line_item_id ;;
  }
  dimension: sf_opportunity_line_item_name {
    type: string
    sql: ${TABLE}.sf_opportunity_line_item_name ;;
  }
  dimension: sf_opportunity_name {
    type: string
    sql: ${TABLE}.sf_opportunity_name ;;
  }
  dimension: sf_related_brand_id {
    type: string
    sql: ${TABLE}.sf_related_brand_id ;;
  }
  dimension: sf_related_brand_name {
    type: string
    sql: ${TABLE}.sf_related_brand_name ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  measure: tac {
    type: sum
    label: "TAC"
    sql: ${TABLE}.tac ;;
  }
  dimension: total_billable {
    type: number
    sql: ${TABLE}.total_billable ;;
  }
  dimension: turn_audience_contra {
    type: number
    sql: ${TABLE}.turn_audience_contra ;;
  }
  dimension: turn_audience_data_cost {
    type: number
    sql: ${TABLE}.turn_audience_data_cost ;;
  }
  dimension: turn_audience_dc {
    type: number
    sql: ${TABLE}.turn_audience_dc ;;
  }
  dimension: turn_audience_fee {
    type: number
    sql: ${TABLE}.turn_audience_fee ;;
  }
  dimension: turn_audience_net {
    type: number
    sql: ${TABLE}.turn_audience_net ;;
  }
  dimension: turn_bi_contra {
    type: number
    sql: ${TABLE}.turn_bi_contra ;;
  }
  dimension: turn_bi_dc {
    type: number
    sql: ${TABLE}.turn_bi_dc ;;
  }
  dimension: turn_bi_fee {
    type: number
    sql: ${TABLE}.turn_bi_fee ;;
  }
  dimension: turn_bi_net {
    type: number
    sql: ${TABLE}.turn_bi_net ;;
  }
  dimension: turn_brand_safety_contra {
    type: number
    sql: ${TABLE}.turn_brand_safety_contra ;;
  }
  dimension: turn_brand_safety_dc {
    type: number
    sql: ${TABLE}.turn_brand_safety_dc ;;
  }
  dimension: turn_brand_safety_fee {
    type: number
    sql: ${TABLE}.turn_brand_safety_fee ;;
  }
  dimension: turn_brand_safety_net {
    type: number
    sql: ${TABLE}.turn_brand_safety_net ;;
  }
  dimension: turn_contextual_contra {
    type: number
    sql: ${TABLE}.turn_contextual_contra ;;
  }
  dimension: turn_contextual_dc {
    type: number
    sql: ${TABLE}.turn_contextual_dc ;;
  }
  dimension: turn_contextual_fee {
    type: number
    sql: ${TABLE}.turn_contextual_fee ;;
  }
  dimension: turn_contextual_net {
    type: number
    sql: ${TABLE}.turn_contextual_net ;;
  }
  dimension: turn_cross_device_contra {
    type: number
    sql: ${TABLE}.turn_cross_device_contra ;;
  }
  dimension: turn_cross_device_dc {
    type: number
    sql: ${TABLE}.turn_cross_device_dc ;;
  }
  dimension: turn_cross_device_fee {
    type: number
    sql: ${TABLE}.turn_cross_device_fee ;;
  }
  dimension: turn_cross_device_net {
    type: number
    sql: ${TABLE}.turn_cross_device_net ;;
  }
  dimension: turn_ghost_bid_contra {
    type: number
    sql: ${TABLE}.turn_ghost_bid_contra ;;
  }
  dimension: turn_ghost_bid_dc {
    type: number
    sql: ${TABLE}.turn_ghost_bid_dc ;;
  }
  dimension: turn_ghost_bid_fee {
    type: number
    sql: ${TABLE}.turn_ghost_bid_fee ;;
  }
  dimension: turn_ghost_bid_net {
    type: number
    sql: ${TABLE}.turn_ghost_bid_net ;;
  }
  dimension: turn_markup {
    type: number
    sql: ${TABLE}.turn_markup ;;
  }
  dimension: turn_min_charge_adjustment {
    type: number
    sql: ${TABLE}.turn_min_charge_adjustment ;;
  }
  dimension: turn_nielsen_targeting_contra {
    type: number
    sql: ${TABLE}.turn_nielsen_targeting_contra ;;
  }
  dimension: turn_nielsen_targeting_dc {
    type: number
    sql: ${TABLE}.turn_nielsen_targeting_dc ;;
  }
  dimension: turn_nielsen_targeting_fee {
    type: number
    sql: ${TABLE}.turn_nielsen_targeting_fee ;;
  }
  dimension: turn_nielsen_targeting_net {
    type: number
    sql: ${TABLE}.turn_nielsen_targeting_net ;;
  }
  dimension: turn_page_quality_contra {
    type: number
    sql: ${TABLE}.turn_page_quality_contra ;;
  }
  dimension: turn_page_quality_dc {
    type: number
    sql: ${TABLE}.turn_page_quality_dc ;;
  }
  dimension: turn_page_quality_fee {
    type: number
    sql: ${TABLE}.turn_page_quality_fee ;;
  }
  dimension: turn_page_quality_net {
    type: number
    sql: ${TABLE}.turn_page_quality_net ;;
  }
  dimension: turn_third_party_cost {
    type: number
    sql: ${TABLE}.turn_third_party_cost ;;
  }
  dimension: turn_tpca_contra {
    type: number
    sql: ${TABLE}.turn_tpca_contra ;;
  }
  dimension: turn_tpca_dc {
    type: number
    sql: ${TABLE}.turn_tpca_dc ;;
  }
  dimension: turn_tpca_fee {
    type: number
    sql: ${TABLE}.turn_tpca_fee ;;
  }
  dimension: turn_tpca_net {
    type: number
    sql: ${TABLE}.turn_tpca_net ;;
  }
  dimension: turn_viewability_contra {
    type: number
    sql: ${TABLE}.turn_viewability_contra ;;
  }
  dimension: turn_viewability_dc {
    type: number
    sql: ${TABLE}.turn_viewability_dc ;;
  }
  dimension: turn_viewability_fee {
    type: number
    sql: ${TABLE}.turn_viewability_fee ;;
  }
  dimension: turn_viewability_net {
    type: number
    sql: ${TABLE}.turn_viewability_net ;;
  }
  dimension: vendor_cost {
    type: number
    sql: ${TABLE}.vendor_cost ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  package_name,
  customer_name,
  sf_billing_account_name,
  insertion_order_name,
  sf_opportunity_line_item_name,
  media_channel_name,
  home_market_name,
  country_name,
  inventory_source_name,
  sf_account_name,
  sf_related_brand_name,
  sf_opportunity_name,
  publisher_name,
  advertiser_name
  ]
  }

}
