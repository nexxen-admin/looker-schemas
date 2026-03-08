view: amobee_media_hourly_view {
  sql_table_name: SunFlower.amobee_media_hourly_view ;;

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
  dimension: action_value {
    type: number
    sql: ${TABLE}.action_value ;;
  }
  dimension: actions {
    type: number
    sql: ${TABLE}.actions ;;
  }
  dimension: ad_calls {
    type: number
    sql: ${TABLE}.ad_calls ;;
  }
  dimension: ad_code_id {
    type: number
    sql: ${TABLE}.ad_code_id ;;
  }
  dimension: ad_format_id {
    type: number
    sql: ${TABLE}.ad_format_id ;;
  }
  dimension: ad_id {
    type: number
    sql: ${TABLE}.ad_id ;;
  }
  dimension: ad_layout {
    type: number
    sql: ${TABLE}.ad_layout ;;
  }
  dimension: ad_position {
    type: number
    sql: ${TABLE}.ad_position ;;
  }
  dimension: ad_server_id {
    type: number
    sql: ${TABLE}.ad_server_id ;;
  }
  dimension: adjustment_cost {
    type: number
    sql: ${TABLE}.adjustment_cost ;;
  }
  dimension: adstxt_seller_relationship {
    type: string
    sql: ${TABLE}.adstxt_seller_relationship ;;
  }
  dimension: adstxt_seller_relationship_id {
    type: number
    sql: ${TABLE}.adstxt_seller_relationship_id ;;
  }
  dimension: adstxt_seller_status {
    type: string
    sql: ${TABLE}.adstxt_seller_status ;;
  }
  dimension: adstxt_seller_status_id {
    type: number
    sql: ${TABLE}.adstxt_seller_status_id ;;
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
  dimension: analyzed_imp {
    type: number
    sql: ${TABLE}.analyzed_imp ;;
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
  dimension: audible_fully_visible_for_half {
    type: number
    sql: ${TABLE}.audible_fully_visible_for_half ;;
  }
  dimension: audio_mute_events {
    type: number
    sql: ${TABLE}.audio_mute_events ;;
  }
  dimension: audio_unmute_events {
    type: number
    sql: ${TABLE}.audio_unmute_events ;;
  }
  dimension: authorized_digital_seller_status_id {
    type: number
    sql: ${TABLE}.authorized_digital_seller_status_id ;;
  }
  dimension: avoc_imp {
    type: number
    sql: ${TABLE}.avoc_imp ;;
  }
  dimension: beacon_id {
    type: number
    sql: ${TABLE}.beacon_id ;;
  }
  dimension: bid_price {
    type: number
    sql: ${TABLE}.bid_price ;;
  }
  dimension: bid_request_app_name {
    type: string
    sql: ${TABLE}.bid_request_app_name ;;
  }
  dimension: bid_requests {
    type: number
    sql: ${TABLE}.bid_requests ;;
  }
  dimension: bid_saving_calculated {
    type: number
    sql: ${TABLE}.bid_saving_calculated ;;
  }
  dimension: bid_saving_fee {
    type: number
    sql: ${TABLE}.bid_saving_fee ;;
  }
  dimension: bids {
    type: number
    sql: ${TABLE}.bids ;;
  }
  dimension: bids_unsampled {
    type: number
    sql: ${TABLE}.bids_unsampled ;;
  }
  dimension: billing_invoice {
    type: number
    sql: ${TABLE}.billing_invoice ;;
  }
  dimension: billing_margin {
    type: number
    sql: ${TABLE}.billing_margin ;;
  }
  dimension: brand_intelligence_category {
    type: number
    sql: ${TABLE}.brand_intelligence_category ;;
  }
  dimension: brand_intelligence_data_cost {
    type: number
    sql: ${TABLE}.brand_intelligence_data_cost ;;
  }
  dimension: brand_safety_concept_id {
    type: number
    sql: ${TABLE}.brand_safety_concept_id ;;
  }
  dimension: brand_safety_contract_name {
    type: string
    sql: ${TABLE}.brand_safety_contract_name ;;
  }
  dimension: brand_safety_data_cost {
    type: number
    sql: ${TABLE}.brand_safety_data_cost ;;
  }
  dimension: brand_safety_provider_id {
    type: number
    sql: ${TABLE}.brand_safety_provider_id ;;
  }
  dimension: brand_safety_provider_name {
    type: string
    sql: ${TABLE}.brand_safety_provider_name ;;
  }
  dimension: browser_type {
    type: string
    sql: ${TABLE}.browser_type ;;
  }
  dimension: browser_type_id {
    type: number
    sql: ${TABLE}.browser_type_id ;;
  }
  dimension: browser_type_name {
    type: string
    sql: ${TABLE}.browser_type_name ;;
  }
  dimension: browser_version {
    type: number
    sql: ${TABLE}.browser_version ;;
  }
  dimension: city_id {
    type: number
    sql: ${TABLE}.city_id ;;
  }
  dimension: city_name {
    type: string
    sql: ${TABLE}.city_name ;;
  }
  dimension: click_events {
    type: number
    sql: ${TABLE}.click_events ;;
  }
  dimension: click_through_actions {
    type: number
    sql: ${TABLE}.click_through_actions ;;
  }
  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
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
  dimension: congress_district_id {
    type: string
    sql: ${TABLE}.congress_district_id ;;
  }
  dimension: content_album {
    type: string
    sql: ${TABLE}.content_album ;;
  }
  dimension: content_artist {
    type: string
    sql: ${TABLE}.content_artist ;;
  }
  dimension: content_context {
    type: number
    sql: ${TABLE}.content_context ;;
  }
  dimension: content_data_cost {
    type: number
    sql: ${TABLE}.content_data_cost ;;
  }
  dimension: content_episode {
    type: number
    sql: ${TABLE}.content_episode ;;
  }
  dimension: content_genre {
    type: string
    sql: ${TABLE}.content_genre ;;
  }
  dimension: content_id {
    type: string
    sql: ${TABLE}.content_id ;;
  }
  dimension: content_isrc {
    type: string
    sql: ${TABLE}.content_isrc ;;
  }
  dimension: content_language {
    type: string
    sql: ${TABLE}.content_language ;;
  }
  dimension: content_length {
    type: number
    sql: ${TABLE}.content_length ;;
  }
  dimension: content_live_stream {
    type: number
    sql: ${TABLE}.content_live_stream ;;
  }
  dimension: content_production_quality {
    type: number
    sql: ${TABLE}.content_production_quality ;;
  }
  dimension: content_qag_media_rating {
    type: number
    sql: ${TABLE}.content_qag_media_rating ;;
  }
  dimension: content_rating {
    type: string
    sql: ${TABLE}.content_rating ;;
  }
  dimension: content_season {
    type: string
    sql: ${TABLE}.content_season ;;
  }
  dimension: content_series {
    type: string
    sql: ${TABLE}.content_series ;;
  }
  dimension: content_title {
    type: string
    sql: ${TABLE}.content_title ;;
  }
  dimension: content_url {
    type: string
    sql: ${TABLE}.content_url ;;
  }
  dimension: contextual_category_id {
    type: number
    sql: ${TABLE}.contextual_category_id ;;
  }
  dimension: contextual_concept_id {
    type: number
    sql: ${TABLE}.contextual_concept_id ;;
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
  dimension: county_name {
    type: string
    sql: ${TABLE}.county_name ;;
  }
  dimension: creative_engagement_events {
    type: number
    sql: ${TABLE}.creative_engagement_events ;;
  }
  dimension: creative_id {
    type: number
    sql: ${TABLE}.creative_id ;;
  }
  dimension: creative_size {
    type: string
    sql: ${TABLE}.creative_size ;;
  }
  dimension: creative_type_id {
    type: number
    sql: ${TABLE}.creative_type_id ;;
  }
  dimension: cross_device_actions {
    type: number
    sql: ${TABLE}.cross_device_actions ;;
  }
  dimension: cross_device_click_through_actions {
    type: number
    sql: ${TABLE}.cross_device_click_through_actions ;;
  }
  dimension: cross_device_cta_value {
    type: number
    sql: ${TABLE}.cross_device_cta_value ;;
  }
  dimension: cross_device_first_party_cost {
    type: number
    sql: ${TABLE}.cross_device_first_party_cost ;;
  }
  dimension: cross_device_shopping_cart_value {
    type: number
    sql: ${TABLE}.cross_device_shopping_cart_value ;;
  }
  dimension: cross_device_shopping_cart_value_cta {
    type: number
    sql: ${TABLE}.cross_device_shopping_cart_value_cta ;;
  }
  dimension: cross_device_shopping_cart_value_vta {
    type: number
    sql: ${TABLE}.cross_device_shopping_cart_value_vta ;;
  }
  dimension: cross_device_view_through_actions {
    type: number
    sql: ${TABLE}.cross_device_view_through_actions ;;
  }
  dimension: cross_device_vta_value {
    type: number
    sql: ${TABLE}.cross_device_vta_value ;;
  }
  dimension: cta_value {
    type: number
    sql: ${TABLE}.cta_value ;;
  }
  dimension: custom_channel_id {
    type: number
    sql: ${TABLE}.custom_channel_id ;;
  }
  dimension: custom_event_name {
    type: string
    sql: ${TABLE}.custom_event_name ;;
  }
  dimension: custom_events {
    type: number
    sql: ${TABLE}.custom_events ;;
  }
  dimension: data_center_id {
    type: number
    sql: ${TABLE}.data_center_id ;;
  }
  dimension: data_cost {
    type: number
    sql: ${TABLE}.data_cost ;;
  }
  dimension: data_date {
    type: number
    sql: ${TABLE}.data_date ;;
  }
  dimension: data_hour {
    type: number
    sql: ${TABLE}.data_hour ;;
  }
  dimension: data_month {
    type: number
    sql: ${TABLE}.data_month ;;
  }
  dimension: data_week {
    type: number
    sql: ${TABLE}.data_week ;;
  }
  dimension: day_of_week {
    type: number
    sql: ${TABLE}.day_of_week ;;
  }
  dimension: dcpm_cost {
    type: number
    sql: ${TABLE}.dcpm_cost ;;
  }
  dimension: deal_id {
    type: string
    sql: ${TABLE}.deal_id ;;
  }
  dimension: deal_labels {
    type: string
    sql: ${TABLE}.deal_labels ;;
  }
  dimension: defined_bid_price {
    type: number
    sql: ${TABLE}.defined_bid_price ;;
  }
  dimension: device_manufacturer {
    type: string
    sql: ${TABLE}.device_manufacturer ;;
  }
  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }
  dimension: device_type_id {
    type: number
    sql: ${TABLE}.device_type_id ;;
  }
  dimension: device_type_name {
    type: string
    sql: ${TABLE}.device_type_name ;;
  }
  dimension: display_nielsen_targeting_first_party_cost {
    type: number
    sql: ${TABLE}.display_nielsen_targeting_first_party_cost ;;
  }
  dimension: display_viewability_first_party_cost {
    type: number
    sql: ${TABLE}.display_viewability_first_party_cost ;;
  }
  dimension: dma_id {
    type: number
    sql: ${TABLE}.dma_id ;;
  }
  dimension: dma_name {
    type: string
    sql: ${TABLE}.dma_name ;;
  }
  dimension: dynamic_pricing {
    type: number
    sql: ${TABLE}.dynamic_pricing ;;
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
  dimension: experiment_id {
    type: number
    sql: ${TABLE}.experiment_id ;;
  }
  dimension: ext_app {
    type: number
    sql: ${TABLE}.ext_app ;;
  }
  dimension: external_advertiser_id {
    type: string
    sql: ${TABLE}.external_advertiser_id ;;
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
  dimension: full_impression {
    type: number
    sql: ${TABLE}.full_impression ;;
  }
  dimension: fv_measurable_imps {
    type: number
    sql: ${TABLE}.fv_measurable_imps ;;
  }
  dimension: ghost_bid_first_party_cost {
    type: number
    sql: ${TABLE}.ghost_bid_first_party_cost ;;
  }
  dimension: goal_adjustment_model_id {
    type: number
    sql: ${TABLE}.goal_adjustment_model_id ;;
  }
  dimension: graph_provider_type {
    type: number
    sql: ${TABLE}.graph_provider_type ;;
  }
  dimension: gross_video_ad_call_events {
    type: number
    sql: ${TABLE}.gross_video_ad_call_events ;;
  }
  dimension: groupm_in_view_imp {
    type: number
    sql: ${TABLE}.groupm_in_view_imp ;;
  }
  dimension: groupm_viewable_imp {
    type: number
    sql: ${TABLE}.groupm_viewable_imp ;;
  }
  dimension: grp_adjustment_cost {
    type: number
    sql: ${TABLE}.grp_adjustment_cost ;;
  }
  dimension: grp_cost {
    type: number
    sql: ${TABLE}.grp_cost ;;
  }
  dimension: home_market_name {
    type: string
    sql: ${TABLE}.home_market_name ;;
  }
  dimension: household_actions {
    type: number
    sql: ${TABLE}.household_actions ;;
  }
  dimension: household_click_through_actions {
    type: number
    sql: ${TABLE}.household_click_through_actions ;;
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
  dimension: household_shopping_cart_value {
    type: number
    sql: ${TABLE}.household_shopping_cart_value ;;
  }
  dimension: household_shopping_cart_value_cta {
    type: number
    sql: ${TABLE}.household_shopping_cart_value_cta ;;
  }
  dimension: household_shopping_cart_value_vta {
    type: number
    sql: ${TABLE}.household_shopping_cart_value_vta ;;
  }
  dimension: household_view_through_actions {
    type: number
    sql: ${TABLE}.household_view_through_actions ;;
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
  dimension: iab_in_view_imp {
    type: number
    sql: ${TABLE}.iab_in_view_imp ;;
  }
  dimension: imp_server_id {
    type: number
    sql: ${TABLE}.imp_server_id ;;
  }
  dimension: impression_events {
    type: number
    sql: ${TABLE}.impression_events ;;
  }
  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }
  dimension: impressions_major_exch {
    type: number
    sql: ${TABLE}.impressions_major_exch ;;
  }
  dimension: insertion_order_id {
    type: number
    sql: ${TABLE}.insertion_order_id ;;
  }
  dimension: inventory_carry_fee {
    type: number
    sql: ${TABLE}.inventory_carry_fee ;;
  }
  dimension: inventory_carrying_cost {
    type: number
    sql: ${TABLE}.inventory_carrying_cost ;;
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
  dimension: ip_mismatch {
    type: number
    sql: ${TABLE}.ip_mismatch ;;
  }
  dimension: is_advanced_creative {
    type: number
    sql: ${TABLE}.is_advanced_creative ;;
  }
  dimension: is_mobile_optimized {
    type: number
    sql: ${TABLE}.is_mobile_optimized ;;
  }
  dimension: is_private_deal {
    type: number
    sql: ${TABLE}.is_private_deal ;;
  }
  dimension: line_item_id {
    type: number
    sql: ${TABLE}.line_item_id ;;
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
  dimension: market_inventory_source_id {
    type: number
    sql: ${TABLE}.market_inventory_source_id ;;
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
  dimension: misc_cogs_charges {
    type: number
    sql: ${TABLE}.misc_cogs_charges ;;
  }
  dimension: misc_tac_charges {
    type: number
    sql: ${TABLE}.misc_tac_charges ;;
  }
  dimension: mobile_app_name {
    type: string
    sql: ${TABLE}.mobile_app_name ;;
  }
  dimension: mta_actions {
    type: number
    sql: ${TABLE}.mta_actions ;;
  }
  dimension: multi_goal_types {
    type: number
    sql: ${TABLE}.multi_goal_types ;;
  }
  dimension: net_connection_speed {
    type: number
    sql: ${TABLE}.net_connection_speed ;;
  }
  dimension: nexxen_health_first_party_cost {
    type: number
    sql: ${TABLE}.nexxen_health_first_party_cost ;;
  }
  dimension: non_ssl_ad_serving_fee {
    type: number
    sql: ${TABLE}.non_ssl_ad_serving_fee ;;
  }
  dimension: non_utilized_ad_call_fee {
    type: number
    sql: ${TABLE}.non_utilized_ad_call_fee ;;
  }
  dimension: on_target_imp {
    type: number
    sql: ${TABLE}.on_target_imp ;;
  }
  dimension: opt_type {
    type: number
    sql: ${TABLE}.opt_type ;;
  }
  dimension: os_type {
    type: string
    sql: ${TABLE}.os_type ;;
  }
  dimension: os_type_id {
    type: number
    sql: ${TABLE}.os_type_id ;;
  }
  dimension: os_version {
    type: number
    sql: ${TABLE}.os_version ;;
  }
  dimension: os_version_id {
    type: number
    sql: ${TABLE}.os_version_id ;;
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
  dimension: page_quality_concept_id {
    type: number
    sql: ${TABLE}.page_quality_concept_id ;;
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
  dimension: placement_id {
    type: string
    sql: ${TABLE}.placement_id ;;
  }
  dimension: pmp_fee {
    type: number
    sql: ${TABLE}.pmp_fee ;;
  }
  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }
  dimension: profile_type {
    type: string
    sql: ${TABLE}.profile_type ;;
  }
  dimension: pub_def_ad_calls {
    type: number
    sql: ${TABLE}.pub_def_ad_calls ;;
  }
  dimension: publisher_deal_id {
    type: number
    sql: ${TABLE}.publisher_deal_id ;;
  }
  dimension: publisher_id {
    type: number
    sql: ${TABLE}.publisher_id ;;
  }
  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }
  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }
  dimension: reconciliation_factor {
    type: number
    sql: ${TABLE}.reconciliation_factor ;;
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
  dimension: rtbexchange_bid_price {
    type: number
    sql: ${TABLE}.rtbexchange_bid_price ;;
  }
  dimension: rtbexchange_bid_price_unsampled {
    type: number
    sql: ${TABLE}.rtbexchange_bid_price_unsampled ;;
  }
  dimension: selected_deal_request_floor_price {
    type: number
    sql: ${TABLE}.selected_deal_request_floor_price ;;
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
  dimension: state_district_id {
    type: string
    sql: ${TABLE}.state_district_id ;;
  }
  dimension: tac {
    type: number
    sql: ${TABLE}.tac ;;
  }
  dimension: targeted_behavior_id {
    type: number
    sql: ${TABLE}.targeted_behavior_id ;;
  }
  dimension: third_party_mta_actions {
    type: number
    sql: ${TABLE}.third_party_mta_actions ;;
  }
  dimension: throttle_by_model_based_early_exit {
    type: number
    sql: ${TABLE}.throttle_by_model_based_early_exit ;;
  }
  dimension: throttle_by_rule_based_early_exit {
    type: number
    sql: ${TABLE}.throttle_by_rule_based_early_exit ;;
  }
  dimension: throttle_reason_id {
    type: number
    sql: ${TABLE}.throttle_reason_id ;;
  }
  dimension: time_zone_offset {
    type: number
    sql: ${TABLE}.time_zone_offset ;;
  }
  dimension: tld {
    type: string
    sql: ${TABLE}.tld ;;
  }
  dimension: total_bid_multiplier_factor {
    type: number
    sql: ${TABLE}.total_bid_multiplier_factor ;;
  }
  dimension: tpa_click_based_actions {
    type: number
    sql: ${TABLE}.tpa_click_based_actions ;;
  }
  dimension: tpa_clicks {
    type: number
    sql: ${TABLE}.tpa_clicks ;;
  }
  dimension: tpa_impressions {
    type: number
    sql: ${TABLE}.tpa_impressions ;;
  }
  dimension: tpa_view_based_actions {
    type: number
    sql: ${TABLE}.tpa_view_based_actions ;;
  }
  dimension: turn_ad_serving_charge {
    type: number
    sql: ${TABLE}.turn_ad_serving_charge ;;
  }
  dimension: turn_audience_data_cost {
    type: number
    sql: ${TABLE}.turn_audience_data_cost ;;
  }
  dimension: turn_cogs_fee {
    type: number
    sql: ${TABLE}.turn_cogs_fee ;;
  }
  dimension: turn_def_pub_trigger_ad_calls {
    type: number
    sql: ${TABLE}.turn_def_pub_trigger_ad_calls ;;
  }
  dimension: turn_derived_mis_margin {
    type: number
    sql: ${TABLE}.turn_derived_mis_margin ;;
  }
  dimension: turn_exchange_fee {
    type: number
    sql: ${TABLE}.turn_exchange_fee ;;
  }
  dimension: turn_fee {
    type: number
    sql: ${TABLE}.turn_fee ;;
  }
  dimension: turn_inventory_cost {
    type: number
    sql: ${TABLE}.turn_inventory_cost ;;
  }
  dimension: turn_markup {
    type: number
    sql: ${TABLE}.turn_markup ;;
  }
  dimension: turn_min_charge_adjustment {
    type: number
    sql: ${TABLE}.turn_min_charge_adjustment ;;
  }
  dimension: turn_reconciliation_factor {
    type: number
    sql: ${TABLE}.turn_reconciliation_factor ;;
  }
  dimension: turn_reserve {
    type: number
    sql: ${TABLE}.turn_reserve ;;
  }
  dimension: turn_service_fee {
    type: number
    sql: ${TABLE}.turn_service_fee ;;
  }
  dimension: turn_spend_share {
    type: number
    sql: ${TABLE}.turn_spend_share ;;
  }
  dimension: turn_third_party_cost {
    type: number
    sql: ${TABLE}.turn_third_party_cost ;;
  }
  dimension: two_sec_viewable_imp {
    type: number
    sql: ${TABLE}.two_sec_viewable_imp ;;
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
  dimension: utilized_ad_call_fee {
    type: number
    sql: ${TABLE}.utilized_ad_call_fee ;;
  }
  dimension: video_completed {
    type: number
    sql: ${TABLE}.video_completed ;;
  }
  dimension: video_duration_bucket {
    type: number
    sql: ${TABLE}.video_duration_bucket ;;
  }
  dimension: video_duration_two_sec {
    type: number
    sql: ${TABLE}.video_duration_two_sec ;;
  }
  dimension: video_linear_type_id {
    type: number
    sql: ${TABLE}.video_linear_type_id ;;
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
  dimension: video_placement_id {
    type: number
    sql: ${TABLE}.video_placement_id ;;
  }
  dimension: video_playback_method {
    type: string
    sql: ${TABLE}.video_playback_method ;;
  }
  dimension: video_playback_method_id {
    type: number
    sql: ${TABLE}.video_playback_method_id ;;
  }
  dimension: video_player_height {
    type: number
    sql: ${TABLE}.video_player_height ;;
  }
  dimension: video_player_size {
    type: string
    sql: ${TABLE}.video_player_size ;;
  }
  dimension: video_player_size_id {
    type: number
    sql: ${TABLE}.video_player_size_id ;;
  }
  dimension: video_player_width {
    type: number
    sql: ${TABLE}.video_player_width ;;
  }
  dimension: video_skippability_id {
    type: number
    sql: ${TABLE}.video_skippability_id ;;
  }
  dimension: video_skippable {
    type: number
    sql: ${TABLE}.video_skippable ;;
  }
  dimension: video_viewability_first_party_cost {
    type: number
    sql: ${TABLE}.video_viewability_first_party_cost ;;
  }
  dimension: view_event_measurement_id {
    type: number
    sql: ${TABLE}.view_event_measurement_id ;;
  }
  dimension: view_event_platform_id {
    type: number
    sql: ${TABLE}.view_event_platform_id ;;
  }
  dimension: view_events {
    type: number
    sql: ${TABLE}.view_events ;;
  }
  dimension: view_through_actions {
    type: number
    sql: ${TABLE}.view_through_actions ;;
  }
  dimension: viewability_video_duration {
    type: number
    sql: ${TABLE}.viewability_video_duration ;;
  }
  dimension: viewability_video_height {
    type: number
    sql: ${TABLE}.viewability_video_height ;;
  }
  dimension: viewability_video_width {
    type: number
    sql: ${TABLE}.viewability_video_width ;;
  }
  dimension: viewable_imp {
    type: number
    sql: ${TABLE}.viewable_imp ;;
  }
  dimension: viewable_time_two_sec {
    type: number
    sql: ${TABLE}.viewable_time_two_sec ;;
  }
  dimension: vta_value {
    type: number
    sql: ${TABLE}.vta_value ;;
  }
  dimension: win_notifications {
    type: number
    sql: ${TABLE}.win_notifications ;;
  }
  dimension: win_notifications_major_exch {
    type: number
    sql: ${TABLE}.win_notifications_major_exch ;;
  }
  dimension: win_price {
    type: number
    sql: ${TABLE}.win_price ;;
  }
  dimension: wins {
    type: number
    sql: ${TABLE}.wins ;;
  }
  dimension: wins_unsampled {
    type: number
    sql: ${TABLE}.wins_unsampled ;;
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
	iab_category_name,
	device_type_name,
	city_name,
	home_market_name,
	media_channel_name,
	exchange_publisher_name,
	brand_safety_contract_name,
	custom_event_name,
	county_name,
	dma_name,
	country_name,
	inventory_source_name,
	mobile_app_name,
	browser_type_name,
	brand_safety_provider_name,
	region_name,
	bid_request_app_name,
	publisher_name
	]
  }

}
