# The name of this view in Looker is "Fact Nexxen Dsp Temp"
view: fact_nexxen_dsp_temp {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_DSP.fact_nexxen_dsp_temp ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Account ID Key" in Explore.

  dimension: account_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.account_id_key ;;
  }

  dimension: advertiser_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.advertiser_id_key ;;
  }

  dimension: auction_discount_cost {
    type: number
    sql: ${TABLE}.auction_discount_cost ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_auction_discount_cost {
    type: sum
    sql: ${auction_discount_cost} ;;  }
  measure: average_auction_discount_cost {
    type: average
    sql: ${auction_discount_cost} ;;  }

  dimension: avoc_imp {
    type: number
    sql: ${TABLE}.avoc_imp ;;
  }

  dimension: bid {
    type: number
    value_format_name: id
    sql: ${TABLE}.bid ;;
  }

  dimension: bid_saving_fee {
    type: number
    sql: ${TABLE}.bid_saving_fee ;;
  }

  dimension: brand_safety_data_cost {
    type: number
    sql: ${TABLE}.brand_safety_data_cost ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: cogs {
    type: number
    sql: ${TABLE}.cogs ;;
  }

  dimension: complete_events {
    type: number
    sql: ${TABLE}.complete_events ;;
  }

  dimension: concatenated_brand_intelligence_data_cost {
    type: number
    sql: ${TABLE}.concatenated_brand_intelligence_data_cost ;;
  }

  dimension: contextual_data_cost {
    type: number
    sql: ${TABLE}.contextual_data_cost ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: creative_file_key {
    type: number
    sql: ${TABLE}.creative_file_key ;;
  }

  dimension: creative_file_tracking_url_key {
    type: number
    sql: ${TABLE}.creative_file_tracking_url_key ;;
  }

  dimension: creative_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.creative_id_key ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key ;;
  }

  dimension_group: date_key_in_timezone {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key_in_timezone ;;
  }

  dimension: exchange_fee {
    type: number
    sql: ${TABLE}.exchange_fee ;;
  }

  dimension: first_party_cost {
    type: number
    sql: ${TABLE}.first_party_cost ;;
  }

  dimension: first_party_imp {
    type: number
    sql: ${TABLE}.first_party_imp ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: inv_cost {
    type: number
    sql: ${TABLE}.inv_cost ;;
  }

  dimension: inventory_cost {
    type: number
    sql: ${TABLE}.inventory_cost ;;
  }

  dimension: manual_adjustment_key {
    type: number
    sql: ${TABLE}.manual_adjustment_key ;;
  }

  dimension: margin_on_inventory {
    type: number
    sql: ${TABLE}.margin_on_inventory ;;
  }

  dimension: market_audience_data_cost {
    type: number
    sql: ${TABLE}.market_audience_data_cost ;;
  }

  dimension: market_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.market_id_key ;;
  }

  dimension: market_third_party_cost {
    type: number
    sql: ${TABLE}.market_third_party_cost ;;
  }

  dimension: measurable_imp {
    type: number
    sql: ${TABLE}.measurable_imp ;;
  }

  dimension: netsuite_invoice_key {
    type: number
    sql: ${TABLE}.Netsuite_invoice_key ;;
  }

  dimension: non_ssl_ad_serving_fee {
    type: number
    sql: ${TABLE}.non_ssl_ad_serving_fee ;;
  }

  dimension: opportunity_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.opportunity_id_key ;;
  }

  dimension: opportunitylineitem_key {
    type: number
    sql: ${TABLE}.opportunitylineitem_key ;;
  }

  dimension: opportunitylineitemschedule_key {
    type: number
    sql: ${TABLE}.opportunitylineitemschedule_key ;;
  }

  dimension: package_budget_schedule_key {
    type: number
    sql: ${TABLE}.package_budget_schedule_key ;;
  }

  dimension: package_id {
    type: number
    sql: ${TABLE}.package_id ;;
  }

  dimension: page_quality_data_cost {
    type: number
    sql: ${TABLE}.page_quality_data_cost ;;
  }

  dimension: partner_fee {
    type: number
    sql: ${TABLE}.partner_fee ;;
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

  dimension: pmp_fee {
    type: number
    sql: ${TABLE}.pmp_fee ;;
  }

  dimension: praction {
    type: number
    sql: ${TABLE}.praction ;;
  }

  dimension: resume_events {
    type: number
    sql: ${TABLE}.resume_events ;;
  }

  dimension: rewind_events {
    type: number
    sql: ${TABLE}.rewind_events ;;
  }

  dimension: rtbexchange_bid {
    type: number
    value_format_name: id
    sql: ${TABLE}.rtbexchange_bid ;;
  }

  dimension: skip_events {
    type: number
    sql: ${TABLE}.skip_events ;;
  }

  dimension: ssl_ad_serving_fee {
    type: number
    sql: ${TABLE}.ssl_ad_serving_fee ;;
  }

  dimension: tac {
    type: number
    sql: ${TABLE}.tac ;;
  }

  dimension: third_fix {
    type: number
    sql: ${TABLE}.third_fix ;;
  }

  dimension: third_party {
    type: number
    sql: ${TABLE}.third_party ;;
  }

  dimension: third_party_key {
    type: number
    sql: ${TABLE}.third_party_key ;;
  }

  dimension: time_zone_code {
    type: string
    sql: ${TABLE}.time_zone_code ;;
  }

  dimension: total_first_party_imp {
    type: number
    sql: ${TABLE}.total_first_party_imp ;;
  }

  dimension: turn_ad_serving_charge {
    type: number
    sql: ${TABLE}.turn_ad_serving_charge ;;
  }

  dimension: turn_audience_data_cost {
    type: number
    sql: ${TABLE}.turn_audience_data_cost ;;
  }

  dimension: turn_fee {
    type: number
    sql: ${TABLE}.turn_fee ;;
  }

  dimension: turn_third_party_cost {
    type: number
    sql: ${TABLE}.turn_third_party_cost ;;
  }

  dimension: user_key_id {
    type: number
    sql: ${TABLE}.user_key_id ;;
  }

  dimension: win {
    type: number
    sql: ${TABLE}.win ;;
  }
  measure: count {
    type: count
  }
}
