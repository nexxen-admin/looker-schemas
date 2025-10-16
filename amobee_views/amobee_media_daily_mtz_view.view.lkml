view: amobee_media_daily_mtz_view {
  sql_table_name: SunFlower.amobee_media_daily_mtz_view ;;

  dimension_group: _ {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.__time ;;
  }
  dimension: acc_100pct_vis_aud_sec {
    type: number
    sql: ${TABLE}.acc_100pct_vis_aud_sec ;;
  }
  dimension: acc_100pct_vis_sec {
    type: number
    sql: ${TABLE}.acc_100pct_vis_sec ;;
  }
  dimension: acc_50pct_vis_aud_sec {
    type: number
    sql: ${TABLE}.acc_50pct_vis_aud_sec ;;
  }
  dimension: acc_50pct_vis_sec {
    type: number
    sql: ${TABLE}.acc_50pct_vis_sec ;;
  }
  dimension: acc_aud_sec {
    type: number
    sql: ${TABLE}.acc_aud_sec ;;
  }
  dimension: action {
    type: number
    sql: ${TABLE}."action" ;;
  }
  dimension: ad_code_id {
    type: number
    sql: ${TABLE}.ad_code_id ;;
  }
  dimension: ad_format_id {
    type: number
    sql: ${TABLE}.ad_format_id ;;
  }
  dimension: ad_group_id {
    type: number
    sql: ${TABLE}.ad_group_id ;;
  }
  dimension: ad_id {
    type: number
    sql: ${TABLE}.ad_id ;;
  }
  dimension: adstxt_seller_relationship {
    type: string
    sql: ${TABLE}.adstxt_seller_relationship ;;
  }
  dimension: adstxt_seller_status {
    type: string
    sql: ${TABLE}.adstxt_seller_status ;;
  }
  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
  }
  dimension: advertiser_local_currency_exchange_rate {
    type: number
    sql: ${TABLE}.advertiser_local_currency_exchange_rate ;;
  }
  dimension: advertiser_local_currency_id {
    type: number
    sql: ${TABLE}.advertiser_local_currency_id ;;
  }
  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }
  dimension: app_id {
    type: string
    sql: ${TABLE}.app_id ;;
  }
  dimension: auction_discount_cost {
    type: number
    sql: ${TABLE}.auction_discount_cost ;;
  }
  dimension: auction_type {
    type: number
    sql: ${TABLE}.auction_type ;;
  }
  dimension: audio_mute_events {
    type: number
    sql: ${TABLE}.audio_mute_events ;;
  }
  dimension: audio_unmute_events {
    type: number
    sql: ${TABLE}.audio_unmute_events ;;
  }
  dimension: avoc_imp {
    type: number
    sql: ${TABLE}.avoc_imp ;;
  }
  dimension: beacon_id {
    type: number
    sql: ${TABLE}.beacon_id ;;
  }
  dimension: bid {
    type: number
    value_format_name: id
    sql: ${TABLE}.bid ;;
  }
  dimension: bid_price {
    type: number
    sql: ${TABLE}.bid_price ;;
  }
  dimension: bid_saving_calculated {
    type: number
    sql: ${TABLE}.bid_saving_calculated ;;
  }
  dimension: bid_saving_fee {
    type: number
    sql: ${TABLE}.bid_saving_fee ;;
  }
  dimension: brand_safety_data_cost {
    type: number
    sql: ${TABLE}.brand_safety_data_cost ;;
  }
  dimension: browser_type {
    type: string
    sql: ${TABLE}.browser_type ;;
  }
  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }
  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }
  dimension: city_id {
    type: number
    sql: ${TABLE}.city_id ;;
  }
  dimension: city_name {
    type: string
    sql: ${TABLE}.city_name ;;
  }
  dimension: click {
    type: number
    sql: ${TABLE}.click ;;
  }
  dimension: click_through_action {
    type: number
    sql: ${TABLE}.click_through_action ;;
  }
  dimension: cogs {
    type: number
    sql: ${TABLE}.cogs ;;
  }
  dimension: collapse_events {
    type: number
    sql: ${TABLE}.collapse_events ;;
  }
  dimension: complete_events {
    type: number
    sql: ${TABLE}.complete_events ;;
  }
  dimension: concatenated_brand_intelligence_data_cost {
    type: number
    sql: ${TABLE}.concatenated_brand_intelligence_data_cost ;;
  }
  dimension: content_data_cost {
    type: number
    sql: ${TABLE}.content_data_cost ;;
  }
  dimension: contextual_data_cost {
    type: number
    sql: ${TABLE}.contextual_data_cost ;;
  }
  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }
  dimension: country_id {
    type: number
    sql: ${TABLE}.country_id ;;
  }
  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
  }
  dimension: county_id {
    type: number
    sql: ${TABLE}.county_id ;;
  }
  dimension: cpa_goal {
    type: number
    sql: ${TABLE}.cpa_goal ;;
  }
  dimension: cpc_goal {
    type: number
    sql: ${TABLE}.cpc_goal ;;
  }
  dimension: creative_engagement_events {
    type: number
    sql: ${TABLE}.creative_engagement_events ;;
  }
  dimension: creative_id {
    type: number
    sql: ${TABLE}.creative_id ;;
  }
  dimension: creative_name {
    type: string
    sql: ${TABLE}.creative_name ;;
  }
  dimension: creative_size {
    type: string
    sql: ${TABLE}.creative_size ;;
  }
  dimension: cross_device_action {
    type: number
    sql: ${TABLE}.cross_device_action ;;
  }
  dimension: cross_device_assigned_cpa_action {
    type: number
    sql: ${TABLE}.cross_device_assigned_cpa_action ;;
  }
  dimension: cross_device_click_through_action {
    type: number
    sql: ${TABLE}.cross_device_click_through_action ;;
  }
  dimension: cross_device_cta_value {
    type: number
    sql: ${TABLE}.cross_device_cta_value ;;
  }
  dimension: cross_device_view_through_action {
    type: number
    sql: ${TABLE}.cross_device_view_through_action ;;
  }
  dimension: cross_device_vta_value {
    type: number
    sql: ${TABLE}.cross_device_vta_value ;;
  }
  dimension: cta_value {
    type: number
    sql: ${TABLE}.cta_value ;;
  }
  dimension: current_bid_price {
    type: number
    sql: ${TABLE}.current_bid_price ;;
  }
  dimension: deal_floor_price {
    type: number
    sql: ${TABLE}.deal_floor_price ;;
  }
  dimension: deal_id {
    type: string
    sql: ${TABLE}.deal_id ;;
  }
  dimension: deal_name {
    type: string
    sql: ${TABLE}.deal_name ;;
  }
  dimension: deal_type {
    type: number
    sql: ${TABLE}.deal_type ;;
  }
  dimension: deal_type_name {
    type: string
    sql: ${TABLE}.deal_type_name ;;
  }
  dimension: device_manufacturer {
    type: string
    sql: ${TABLE}.device_manufacturer ;;
  }
  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }
  dimension: dma_id {
    type: number
    sql: ${TABLE}.dma_id ;;
  }
  dimension: dma_name {
    type: string
    sql: ${TABLE}.dma_name ;;
  }
  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
  }
  dimension: environment_id {
    type: number
    sql: ${TABLE}.environment_id ;;
  }
  dimension_group: event {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.event_time ;;
  }
  dimension_group: event_time_mtz {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.event_time_mtz ;;
  }
  dimension: exchange_fee {
    type: number
    sql: ${TABLE}.exchange_fee ;;
  }
  dimension: exchange_line_item_id {
    type: string
    sql: ${TABLE}.exchange_line_item_id ;;
  }
  dimension: exchange_publisher_name {
    type: string
    sql: ${TABLE}.exchange_publisher_name ;;
  }
  dimension: expand_events {
    type: number
    sql: ${TABLE}.expand_events ;;
  }
  dimension: ext_app {
    type: number
    sql: ${TABLE}.ext_app ;;
  }
  dimension: external_package_id {
    type: string
    sql: ${TABLE}.external_package_id ;;
  }
  dimension: external_tpa_id {
    type: string
    sql: ${TABLE}.external_tpa_id ;;
  }
  dimension: first_party_cost {
    type: number
    sql: ${TABLE}.first_party_cost ;;
  }
  dimension: format {
    type: string
    sql: ${TABLE}."format" ;;
  }
  dimension: format_id {
    type: number
    sql: ${TABLE}.format_id ;;
  }
  dimension: gross_video_ad_call {
    type: number
    sql: ${TABLE}.gross_video_ad_call ;;
  }
  dimension: groupm_viewable_imp {
    type: number
    sql: ${TABLE}.groupm_viewable_imp ;;
  }
  dimension: home_market_name {
    type: string
    sql: ${TABLE}.home_market_name ;;
  }
  dimension: household_action {
    type: number
    sql: ${TABLE}.household_action ;;
  }
  dimension: household_click_through_action {
    type: number
    sql: ${TABLE}.household_click_through_action ;;
  }
  dimension: household_cta_value {
    type: number
    sql: ${TABLE}.household_cta_value ;;
  }
  dimension: household_id_sketch {
    type: string
    sql: ${TABLE}.household_id_sketch ;;
  }
  dimension: household_person_id_sketch {
    type: string
    sql: ${TABLE}.household_person_id_sketch ;;
  }
  dimension: household_view_through_action {
    type: number
    sql: ${TABLE}.household_view_through_action ;;
  }
  dimension: household_vta_value {
    type: number
    sql: ${TABLE}.household_vta_value ;;
  }
  dimension: iab_category_id {
    type: number
    sql: ${TABLE}.iab_category_id ;;
  }
  dimension: iab_category_name {
    type: string
    sql: ${TABLE}.iab_category_name ;;
  }
  dimension: impression {
    type: number
    sql: ${TABLE}.impression ;;
  }
  dimension: insertion_order_id {
    type: number
    sql: ${TABLE}.insertion_order_id ;;
  }
  dimension: insertion_order_name {
    type: string
    sql: ${TABLE}.insertion_order_name ;;
  }
  dimension: inv_cost {
    type: number
    sql: ${TABLE}.inv_cost ;;
  }
  dimension: inventory_cost {
    type: number
    sql: ${TABLE}.inventory_cost ;;
  }
  dimension: inventory_source_id {
    type: number
    sql: ${TABLE}.inventory_source_id ;;
  }
  dimension: inventory_source_name {
    type: string
    sql: ${TABLE}.inventory_source_name ;;
  }
  dimension: io_current_budget {
    type: number
    sql: ${TABLE}.io_current_budget ;;
  }
  dimension_group: io_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.io_end_date ;;
  }
  dimension_group: io_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.io_start_date ;;
  }
  dimension: is_budget_optimized {
    type: number
    sql: ${TABLE}.is_budget_optimized ;;
  }
  dimension: line_item_id {
    type: number
    sql: ${TABLE}.line_item_id ;;
  }
  dimension: line_item_name {
    type: string
    sql: ${TABLE}.line_item_name ;;
  }
  dimension: margin_on_inventory {
    type: number
    sql: ${TABLE}.margin_on_inventory ;;
  }
  dimension: market_audience_data_cost {
    type: number
    sql: ${TABLE}.market_audience_data_cost ;;
  }
  dimension: market_default_local_currency_exchange_rate {
    type: number
    sql: ${TABLE}.market_default_local_currency_exchange_rate ;;
  }
  dimension: market_default_local_currency_id {
    type: number
    sql: ${TABLE}.market_default_local_currency_id ;;
  }
  dimension: market_id {
    type: number
    sql: ${TABLE}.market_id ;;
  }
  dimension: market_third_party_cost {
    type: number
    sql: ${TABLE}.market_third_party_cost ;;
  }
  dimension: market_timezone {
    type: string
    sql: ${TABLE}.market_timezone ;;
  }
  dimension: measurable_imp {
    type: number
    sql: ${TABLE}.measurable_imp ;;
  }
  dimension: media_channel_id {
    type: number
    sql: ${TABLE}.media_channel_id ;;
  }
  dimension: media_channel_name {
    type: string
    sql: ${TABLE}.media_channel_name ;;
  }
  dimension: mobile_app_name {
    type: string
    sql: ${TABLE}.mobile_app_name ;;
  }
  dimension: mobile_device_os_version {
    type: number
    sql: ${TABLE}.mobile_device_os_version ;;
  }
  dimension: mobile_device_type_id {
    type: number
    sql: ${TABLE}.mobile_device_type_id ;;
  }
  dimension: non_ssl_ad_serving_fee {
    type: number
    sql: ${TABLE}.non_ssl_ad_serving_fee ;;
  }
  dimension: os_type {
    type: string
    sql: ${TABLE}.os_type ;;
  }
  dimension: os_version {
    type: number
    sql: ${TABLE}.os_version ;;
  }
  dimension: os_version_name {
    type: string
    sql: ${TABLE}.os_version_name ;;
  }
  dimension: package_client_status {
    type: string
    sql: ${TABLE}.package_client_status ;;
  }
  dimension: package_current_budget {
    type: number
    sql: ${TABLE}.package_current_budget ;;
  }
  dimension_group: package_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.package_end_date ;;
  }
  dimension: package_goal_amount {
    type: number
    sql: ${TABLE}.package_goal_amount ;;
  }
  dimension: package_goal_type_id {
    type: number
    sql: ${TABLE}.package_goal_type_id ;;
  }
  dimension: package_id {
    type: number
    sql: ${TABLE}.package_id ;;
  }
  dimension: package_rpm {
    type: number
    sql: ${TABLE}.package_rpm ;;
  }
  dimension_group: package_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.package_start_date ;;
  }
  dimension: page_quality_data_cost {
    type: number
    sql: ${TABLE}.page_quality_data_cost ;;
  }
  dimension: partner_fee {
    type: number
    sql: ${TABLE}.partner_fee ;;
  }
  dimension: partner_markup {
    type: number
    sql: ${TABLE}.partner_markup ;;
  }
  dimension: partner_reserve {
    type: number
    sql: ${TABLE}.partner_reserve ;;
  }
  dimension: pause_events {
    type: number
    sql: ${TABLE}.pause_events ;;
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
  dimension: performance_reserve {
    type: number
    sql: ${TABLE}.performance_reserve ;;
  }
  dimension: pmp_fee {
    type: number
    sql: ${TABLE}.pmp_fee ;;
  }
  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }
  dimension: publisher_deal_object_id {
    type: number
    sql: ${TABLE}.publisher_deal_object_id ;;
  }
  dimension: publisher_id {
    type: number
    sql: ${TABLE}.publisher_id ;;
  }
  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }
  dimension: region_id {
    type: number
    sql: ${TABLE}.region_id ;;
  }
  dimension: region_name {
    type: string
    sql: ${TABLE}.region_name ;;
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
  dimension: shopping_cart_value {
    type: number
    sql: ${TABLE}.shopping_cart_value ;;
  }
  dimension: shopping_cart_value_cta {
    type: number
    sql: ${TABLE}.shopping_cart_value_cta ;;
  }
  dimension: shopping_cart_value_vta {
    type: number
    sql: ${TABLE}.shopping_cart_value_vta ;;
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
  dimension: targeted_segment_id {
    type: number
    sql: ${TABLE}.targeted_segment_id ;;
  }
  dimension: third_party_cost_type {
    type: string
    sql: ${TABLE}.third_party_cost_type ;;
  }
  dimension: tier_id {
    type: string
    sql: ${TABLE}.tier_id ;;
  }
  dimension: tld {
    type: string
    sql: ${TABLE}.tld ;;
  }
  dimension: tpa_cta {
    type: number
    sql: ${TABLE}.tpa_cta ;;
  }
  dimension: tpa_mta_action {
    type: number
    sql: ${TABLE}.tpa_mta_action ;;
  }
  dimension: tpa_vta {
    type: number
    sql: ${TABLE}.tpa_vta ;;
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
  dimension: turn_min_charge_adjustment {
    type: number
    sql: ${TABLE}.turn_min_charge_adjustment ;;
  }
  dimension: turn_third_party_cost {
    type: number
    sql: ${TABLE}.turn_third_party_cost ;;
  }
  dimension: unique_devices_sketch {
    type: string
    sql: ${TABLE}.unique_devices_sketch ;;
  }
  dimension: unique_households_sketch {
    type: string
    sql: ${TABLE}.unique_households_sketch ;;
  }
  dimension: unique_persons_sketch {
    type: string
    sql: ${TABLE}.unique_persons_sketch ;;
  }
  dimension: user_id_sketch {
    type: string
    sql: ${TABLE}.user_id_sketch ;;
  }
  dimension: video_max_duration {
    type: number
    sql: ${TABLE}.video_max_duration ;;
  }
  dimension: video_min_duration {
    type: number
    sql: ${TABLE}.video_min_duration ;;
  }
  dimension: video_placement {
    type: string
    sql: ${TABLE}.video_placement ;;
  }
  dimension: video_playback_method {
    type: string
    sql: ${TABLE}.video_playback_method ;;
  }
  dimension: video_player_size {
    type: string
    sql: ${TABLE}.video_player_size ;;
  }
  dimension: video_skippable {
    type: number
    sql: ${TABLE}.video_skippable ;;
  }
  dimension: view_through_action {
    type: number
    sql: ${TABLE}.view_through_action ;;
  }
  dimension: viewability_video_duration {
    type: number
    sql: ${TABLE}.viewability_video_duration ;;
  }
  dimension: viewable_imp {
    type: number
    sql: ${TABLE}.viewable_imp ;;
  }
  dimension: vta_value {
    type: number
    sql: ${TABLE}.vta_value ;;
  }
  dimension: win {
    type: number
    sql: ${TABLE}.win ;;
  }
  dimension: workflow_status_id {
    type: number
    sql: ${TABLE}.workflow_status_id ;;
  }
  dimension: xd_shopping_cart_value_cta {
    type: number
    sql: ${TABLE}.xd_shopping_cart_value_cta ;;
  }
  dimension: xd_shopping_cart_value_vta {
    type: number
    sql: ${TABLE}.xd_shopping_cart_value_vta ;;
  }
  dimension: zip_code {
    type: zipcode
    sql: ${TABLE}.zip_code ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
	region_name,
	country_name,
	iab_category_name,
	deal_name,
	city_name,
	advertiser_name,
	deal_type_name,
	publisher_name,
	insertion_order_name,
	mobile_app_name,
	home_market_name,
	exchange_publisher_name,
	os_version_name,
	campaign_name,
	inventory_source_name,
	line_item_name,
	creative_name,
	media_channel_name,
	dma_name
	]
  }

}
