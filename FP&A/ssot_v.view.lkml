view: ssot_v {
  sql_table_name: BI_DSP.ssot_v ;;

  measure: adv_invoice {
    type: sum
    label: "Advertiser Invoice"
    sql: ${TABLE}.adv_invoice ;;
    value_format: "$#,##0.00"
  }
  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
  }
  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }
  measure: bid_saving_fee {
    type: sum
    sql: ${TABLE}.bid_saving_fee ;;
    value_format: "$#,##0.00"
  }
  measure: bid_saving_fee_calculated {
    type: sum
    sql: ${TABLE}.bid_saving_fee_calculated ;;
    value_format: "$#,##0.00"
  }
  measure: billing_margin {
    type: sum
    sql: ${TABLE}.billing_margin ;;
    value_format: "$#,##0.00"
  }
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
  dimension: category_id {
    type: number
    sql: ${TABLE}.category_id ;;
  }
  measure: content_data_cost {
    type: sum
    sql: ${TABLE}.content_data_cost ;;
    value_format: "$#,##0.00"
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
  measure: first_party_cost {
    type: sum
    label: "Client Total First Party Cost"
    sql: ${TABLE}.first_party_cost ;;
    value_format: "$#,##0.00"
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
  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0.00"
  }
  dimension: insertion_order_id {
    type: number
    sql: ${TABLE}.insertion_order_id ;;
  }
  dimension: insertion_order_name {
    type: string
    sql: ${TABLE}.insertion_order_name ;;
  }
  measure: inventory_carry_fee {
    type: sum
    sql: ${TABLE}.inventory_carry_fee ;;
    value_format: "$#,##0.00"
  }
  measure: inventory_carrying_cost {
    type: sum
    sql: ${TABLE}.inventory_carrying_cost ;;
    value_format: "$#,##0.00"
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
  measure: managed_service_fee_cost {
    type: sum
    label: "Managed Service Fee"
    sql: ${TABLE}.managed_service_fee_cost ;;
    value_format: "$#,##0.00"
  }
  dimension: managed_service_fee_id {
    type: number
    sql: ${TABLE}.managed_service_fee_id ;;
  }
  measure: margin_on_inventory {
    type: sum
    sql: ${TABLE}.margin_on_inventory ;;
    value_format: "#,##0.00"
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

  measure: nexxen_fee {
    type: sum
    sql: ${TABLE}.nexxen_fee ;;
    value_format: "$#,##0.00"
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
  measure: pmp_fee {
    type: sum
    label: "PMP Fee"
    sql: ${TABLE}.pmp_fee ;;
    value_format: "$#,##0.00"
  }
  measure: publisher_cost {
    type: sum
    sql: ${TABLE}.publisher_cost ;;
    value_format: "$#,##0.00"
  }
  dimension: publisher_id {
    type: string
    sql: ${TABLE}.publisher_id ;;
  }
  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }
  measure: reconciliation_factor {
    type: sum
    label: "Recon Factor"
    sql: ${TABLE}.reconciliation_factor ;;
    value_format: "$#,##0.00"
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
  measure: total_billable {
    type: sum
    sql: ${TABLE}.total_billable ;;
    value_format: "#,##0.00"
  }
  measure: turn_audience_contra {
    type: sum
    label: "Audience Contra"
    sql: ${TABLE}.turn_audience_contra ;;
    value_format: "#,##0.00"
  }
  measure: turn_audience_data_cost {
    type: sum
    label: "Client Turn Pay Data Cost"
    sql: ${TABLE}.turn_audience_data_cost ;;
    value_format: "$#,##0.00"
  }
  measure: turn_audience_dc {
    type: sum
    label: "Audience Data Cost"
    sql: ${TABLE}.turn_audience_dc ;;
    value_format: "$#,##0.00"
  }
  measure: turn_audience_fee {
    type: sum
    label: "Audience Fee"
    sql: ${TABLE}.turn_audience_fee ;;
    value_format: "$#,##0.00"
  }
  measure: turn_audience_net {
    type: sum
    label: "Audience Data Cost Adjusted"
    sql: ${TABLE}.turn_audience_net ;;
    value_format: "$#,##0.00"
  }
  measure: turn_bi_contra {
    type: sum
    label: "Brand Intelligence Contra"
    sql: ${TABLE}.turn_bi_contra ;;
    value_format: "#,##0.00"
  }
  measure: turn_bi_dc {
    type: sum
     # label: "Client Content Data Cost"
    sql: ${TABLE}.turn_bi_dc ;;
    value_format: "#,##0.00"
  }
  measure: turn_bi_fee {
    type: sum
    label: "Brand Intelligence Fee"
    sql: ${TABLE}.turn_bi_fee ;;
    value_format: "$#,##0.00"
  }
  measure: turn_bi_net {
    type: sum
    label: "Brand Intelligence Data Cost Adjusted"
    sql: ${TABLE}.turn_bi_net ;;
    value_format: "$#,##0.00"
  }
  measure: turn_brand_safety_contra {
    type: sum
    label: "Brand Safety Contra"
    sql: ${TABLE}.turn_brand_safety_contra ;;
    value_format: "#,##0.00"
  }
  measure: turn_brand_safety_dc {
    type: sum
    # label: "Client Content Data Cost"
    sql: ${TABLE}.turn_brand_safety_dc ;;
    value_format: "#,##0.00"
  }
  measure: turn_brand_safety_fee {
    type: sum
    label: "Brand Safety Fee"
    sql: ${TABLE}.turn_brand_safety_fee ;;
    value_format: "$#,##0.00"
  }
  measure: turn_brand_safety_net {
    type: sum
    label: "Brand Safety Data Cost Adjusted"
    sql: ${TABLE}.turn_brand_safety_net ;;
    value_format: "$#,##0.00"
  }
  measure: turn_contextual_contra {
    type: sum
    label: "Contextual Contra"
    sql: ${TABLE}.turn_contextual_contra ;;
    value_format: "$#,##0.00"
  }
  measure: turn_contextual_dc {
    type: sum
    # label: "Client Content Data Cost"
    sql: ${TABLE}.turn_contextual_dc ;;
    value_format: "#,##0.00"
  }
  measure: turn_contextual_fee {
    type: sum
    label: "Contextual Fee"
    sql: ${TABLE}.turn_contextual_fee ;;
    value_format: "$#,##0.00"
  }
  measure: turn_contextual_net {
    type: sum
    label: "Contextual Data Cost Adjusted"
    sql: ${TABLE}.turn_contextual_net ;;
    value_format: "$#,##0.00"
  }
  measure: turn_cross_device_contra {
    type: sum
    label: "Cross Device Contra"
    sql: ${TABLE}.turn_cross_device_contra ;;
    value_format: "$#,##0.00"
  }
  measure: turn_cross_device_dc {
    type: sum
    label: "Cross Device First Party Cost"
    sql: ${TABLE}.turn_cross_device_dc ;;
    value_format: "$#,##0.00"
  }
  measure: turn_cross_device_fee {
    type: sum
    label: "Cross Device Fee"
    sql: ${TABLE}.turn_cross_device_fee ;;
    value_format: "$#,##0.00"
  }

  measure: turn_cross_device_net {
    type: sum
    label: "Cross Device First Party Cost Adjusted"
    sql: ${TABLE}.turn_cross_device_net ;;
    value_format: "$#,##0.00"
  }
  measure: turn_ghost_bid_contra {
    type: sum
    label: "Ghost Bid Contra"
    sql: ${TABLE}.turn_ghost_bid_contra ;;
    value_format: "$#,##0.00"
  }
  measure: turn_ghost_bid_dc {
    type: sum
    label: "Ghost Bid First Party Cost"
    sql: ${TABLE}.turn_ghost_bid_dc ;;
    value_format: "$#,##0.00"
  }
  measure: turn_ghost_bid_fee {
    type: sum
    label: "Ghost Bid Fee"
    sql: ${TABLE}.turn_ghost_bid_fee ;;
    value_format: "$#,##0.00"
  }
  measure: turn_ghost_bid_net {
    type: sum
    label: "Ghost Bid First Party Cost Adjusted"
    sql: ${TABLE}.turn_ghost_bid_net ;;
    value_format: "$#,##0.00"
  }
  measure: turn_markup {
    type: sum
    sql: ${TABLE}.turn_markup ;;
    value_format: "#,##0.00"
  }
  measure: turn_min_charge_adjustment {
    type: sum
    label: "Min Charge Adjustment"
    sql: ${TABLE}.turn_min_charge_adjustment ;;
    value_format: "$#,##0.00"
  }
  measure: turn_nielsen_targeting_contra {
    type: sum
    label: "Nielsen Targeting Contra"
    sql: ${TABLE}.turn_nielsen_targeting_contra ;;
    value_format: "$#,##0.00"
  }
  measure: turn_nielsen_targeting_dc {
    type: sum
    label: "Nielsen Targeting First Party Cost"
    sql: ${TABLE}.turn_nielsen_targeting_dc ;;
    value_format: "$#,##0.00"
  }
  measure: turn_nielsen_targeting_fee {
    type: sum
    label: "Nielsen Targeting Fee"
    sql: ${TABLE}.turn_nielsen_targeting_fee ;;
    value_format: "$#,##0.00"
  }
  measure: turn_nielsen_targeting_net {
    type: sum
    label: "Display Nielsen Targeting Frist Party Cost Adjusted"
    sql: ${TABLE}.turn_nielsen_targeting_net ;;
    value_format: "$#,##0.00"
  }
  measure: turn_page_quality_contra {
    type: sum
    label: "Page Quality Contra"
    sql: ${TABLE}.turn_page_quality_contra ;;
    value_format: "#,##0.00"
  }
  measure: turn_page_quality_dc {
    type: sum
     # label: "Client Content Data Cost"
    sql: ${TABLE}.turn_page_quality_dc ;;
    value_format: "#,##0.00"
  }
  measure: turn_page_quality_fee {
    type: sum
    label: "Page Quality Fee"
    sql: ${TABLE}.turn_page_quality_fee ;;
    value_format: "$#,##0.00"
  }
  measure: turn_page_quality_net {
    type: sum
    label: "Page Quality Data Cost Adjusted"
    sql: ${TABLE}.turn_page_quality_net ;;
    value_format: "$#,##0.00"
  }
  measure: turn_third_party_cost {
    type: sum
    label: "Client Turn Third Party Cost"
    sql: ${TABLE}.turn_third_party_cost ;;
    value_format: "$#,##0.00"
  }
  measure: turn_tpca_contra {
    type: sum
    label: "Turn Third Party cost Contra"
    sql: ${TABLE}.turn_tpca_contra ;;
    value_format: "$#,##0.00"
  }
  measure: turn_tpca_dc {
    type: sum
    label: "Turn Third Party Cost"
    sql: ${TABLE}.turn_tpca_dc ;;
    value_format: "$#,##0.00"
  }
  dimension: turn_tpca_fee {
    type: number
    sql: ${TABLE}.turn_tpca_fee ;;
  }
  measure: turn_tpca_net {
    type: sum
    label: "Turn Third Party Cost Adjusted"
    sql: ${TABLE}.turn_tpca_net ;;
    value_format: "$#,##0.00"
  }
  measure: turn_viewability_contra {
    type: sum
    label: "Viewability Contra"
    sql: ${TABLE}.turn_viewability_contra ;;
    value_format: "$#,##0.00"
  }
  measure: turn_viewability_dc {
    type: sum
    label: "Viewability First Party cost"
    sql: ${TABLE}.turn_viewability_dc ;;
    value_format: "$#,##0.00"
  }
  measure: turn_viewability_fee {
    type: sum
    label: "Viewability Fee"
    sql: ${TABLE}.turn_viewability_fee ;;
    value_format: "$#,##0.00"
  }
  measure: turn_viewability_net {
    type: sum
    label: "Viewability First Party Cost Adjusted"
    sql: ${TABLE}.turn_viewability_net ;;
    value_format: "$#,##0.00"
  }
  measure: vendor_cost {
    type: sum
    sql: ${TABLE}.vendor_cost ;;
    value_format: "$#,##0.00"
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
