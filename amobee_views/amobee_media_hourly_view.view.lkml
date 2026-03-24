view: amobee_media_hourly_view {
  sql_table_name: SunFlower.amobee_media_hourly_view ;;



    # =================================================================
    # TIME DIMENSIONS (Forced to top)
    # =================================================================

  dimension_group: event_time {
    type: time
    timeframes: [raw, time, hour, date, week, month, quarter, year]
    sql: ${TABLE}.event_time ;;
    label: "  Event Time"
  }

  dimension_group: event_time_mtz {
    type: time
    timeframes: [raw, time, hour, date, week, month, quarter, year]
    sql: ${TABLE}.event_time_mtz ;;
    label: " Event Time MTZ"
  }

  dimension_group: event_time_et {
    type: time
    timeframes: [raw, time, hour, date, week, month, quarter, year]
    label: " Event Time ET"
    description: "Event timestamp converted to America/New_York (handles DST)."
    sql: (${TABLE}.event_time AT TIME ZONE 'UTC') AT TIME ZONE 'America/New_York' ;;
  }

    # =================================================================
    # DIMENSIONS
    # =================================================================

    dimension: ad_code_id {
      type: string
      sql: ${TABLE}.ad_code_id ;;
    }
    dimension: ad_format_id {
      type: string
      sql: ${TABLE}.ad_format_id ;;
    }
    dimension: ad_id {
      type: string
      sql: ${TABLE}.ad_id ;;
    }
    dimension: ad_layout {
      type: string
      sql: ${TABLE}.ad_layout ;;
    }
    dimension: ad_position {
      type: string
      sql: ${TABLE}.ad_position ;;
    }
    dimension: ad_server_id {
      type: string
      sql: ${TABLE}.ad_server_id ;;
    }
    dimension: adstxt_seller_relationship {
      type: string
      sql: ${TABLE}.adstxt_seller_relationship ;;
    }
    dimension: adstxt_seller_relationship_id {
      type: string
      sql: ${TABLE}.adstxt_seller_relationship_id ;;
    }
    dimension: adstxt_seller_status {
      type: string
      sql: ${TABLE}.adstxt_seller_status ;;
    }
    dimension: adstxt_seller_status_id {
      type: string
      sql: ${TABLE}.adstxt_seller_status_id ;;
    }
    dimension: advertiser_id {
      type: string
      sql: ${TABLE}.advertiser_id ;;
    }
    # dimension: advertiser_local_currency_exchange_rate {
    #   type: number
    #   sql: ${TABLE}.advertiser_local_currency_exchange_rate ;;
    # }
    dimension: advertiser_local_currency_id {
      type: string
      sql: ${TABLE}.advertiser_local_currency_id ;;
    }
    dimension: app_id {
      type: string
      sql: ${TABLE}.app_id ;;
    }
    dimension: auction_type {
      type: string
      sql: ${TABLE}.auction_type ;;
    }
    dimension: authorized_digital_seller_status_id {
      type: string
      sql: ${TABLE}.authorized_digital_seller_status_id ;;
    }
    dimension: beacon_id {
      type: string
      sql: ${TABLE}.beacon_id ;;
    }
    dimension: bid_request_app_name {
      type: string
      sql: ${TABLE}.bid_request_app_name ;;
    }
    dimension: brand_intelligence_category {
      type: string
      sql: ${TABLE}.brand_intelligence_category ;;
    }
    dimension: brand_safety_concept_id {
      type: string
      sql: ${TABLE}.brand_safety_concept_id ;;
    }
    dimension: brand_safety_contract_name {
      type: string
      sql: ${TABLE}.brand_safety_contract_name ;;
    }
    dimension: brand_safety_provider_id {
      type: string
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
      type: string
      sql: ${TABLE}.browser_type_id ;;
    }
    dimension: browser_type_name {
      type: string
      sql: ${TABLE}.browser_type_name ;;
    }
    dimension: browser_version {
      type: string
      sql: ${TABLE}.browser_version ;;
    }
    dimension: city_id {
      type: string
      sql: ${TABLE}.city_id ;;
    }
    dimension: city_name {
      type: string
      sql: ${TABLE}.city_name ;;
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
      type: string
      sql: ${TABLE}.content_context ;;
    }
    dimension: content_episode {
      type: string
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
    dimension: content_live_stream {
      type: string
      sql: ${TABLE}.content_live_stream ;;
    }
    dimension: content_production_quality {
      type: string
      sql: ${TABLE}.content_production_quality ;;
    }
    dimension: content_qag_media_rating {
      type: string
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
      type: string
      sql: ${TABLE}.contextual_category_id ;;
    }
    dimension: contextual_concept_id {
      type: string
      sql: ${TABLE}.contextual_concept_id ;;
    }
    dimension: country_id {
      type: string
      sql: ${TABLE}.country_id ;;
    }
    dimension: country_name {
      type: string
      sql: ${TABLE}.country_name ;;
    }
    dimension: county_id {
      type: string
      sql: ${TABLE}.county_id ;;
    }
    dimension: county_name {
      type: string
      sql: ${TABLE}.county_name ;;
    }
    dimension: creative_id {
      type: string
      sql: ${TABLE}.creative_id ;;
    }
    dimension: creative_size {
      type: string
      sql: ${TABLE}.creative_size ;;
    }
    dimension: creative_type_id {
      type: string
      sql: ${TABLE}.creative_type_id ;;
    }
    dimension: custom_channel_id {
      type: string
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
      type: string
      sql: ${TABLE}.data_center_id ;;
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
    dimension: deal_id {
      type: string
      sql: ${TABLE}.deal_id ;;
    }
    dimension: deal_labels {
      type: string
      sql: ${TABLE}.deal_labels ;;
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
      type: string
      sql: ${TABLE}.device_type_id ;;
    }
    dimension: device_type_name {
      type: string
      sql: ${TABLE}.device_type_name ;;
    }
    dimension: dma_id {
      type: string
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
      type: string
      sql: ${TABLE}.environment_id ;;
    }
    dimension: exchange_line_item_id {
      type: string
      sql: ${TABLE}.exchange_line_item_id ;;
    }
    dimension: exchange_publisher_name {
      type: string
      sql: ${TABLE}.exchange_publisher_name ;;
    }
    dimension: experiment_id {
      type: string
      sql: ${TABLE}.experiment_id ;;
    }
    dimension: external_advertiser_id {
      type: string
      sql: ${TABLE}.external_advertiser_id ;;
    }
    dimension: ext_app {
      type: number
      sql: ${TABLE}.ext_app ;;
    }
    dimension: format {
      type: string
      sql: ${TABLE}."format" ;;
    }
    dimension: format_id {
      type: string
      sql: ${TABLE}.format_id ;;
    }
      dimension: full_impression {
      type: number
       sql: ${TABLE}.full_impression ;;
    }
    dimension: goal_adjustment_model_id {
      type: string
      sql: ${TABLE}.goal_adjustment_model_id ;;
    }
    dimension: graph_provider_type {
      type: string
      sql: ${TABLE}.graph_provider_type ;;
    }
    dimension: home_market_name {
      type: string
      sql: ${TABLE}.home_market_name ;;
    }
    dimension: household_id_sketch {
      type: string
      sql: ${TABLE}.household_id_sketch ;;
      hidden: yes
    }
    dimension: household_person_id_sketch {
      type: string
      sql: ${TABLE}.household_person_id_sketch ;;
      hidden: yes
    }
    dimension: iab_category_id {
      type: string
      sql: ${TABLE}.iab_category_id ;;
    }
    dimension: iab_category_name {
      type: string
      sql: ${TABLE}.iab_category_name ;;
    }
    dimension: imp_server_id {
      type: string
      sql: ${TABLE}.imp_server_id ;;
    }
    dimension: insertion_order_id {
      type: string
      sql: ${TABLE}.insertion_order_id ;;
    }
    dimension: inventory_source_id {
      type: string
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
      type: yesno
      sql: ${TABLE}.is_advanced_creative = 1 ;;
    }
    dimension: is_mobile_optimized {
      type: yesno
      sql: ${TABLE}.is_mobile_optimized = 1 ;;
    }
    dimension: is_private_deal {
      type: yesno
      sql: ${TABLE}.is_private_deal = 1 ;;
    }
    dimension: line_item_id {
      type: string
      sql: ${TABLE}.line_item_id ;;
    }
    # dimension: market_default_local_currency_exchange_rate {
    #   type: number
    #   sql: ${TABLE}.market_default_local_currency_exchange_rate ;;
    # }
    dimension: market_default_local_currency_id {
      type: string
      sql: ${TABLE}.market_default_local_currency_id ;;
    }
    dimension: market_id {
      type: string
      sql: ${TABLE}.market_id ;;
    }
    dimension: market_inventory_source_id {
      type: string
      sql: ${TABLE}.market_inventory_source_id ;;
    }
    dimension: market_timezone {
      type: string
      sql: ${TABLE}.market_timezone ;;
    }
    dimension: media_channel_id {
      type: string
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
  dimension: multi_goal_types {
    type: number
    sql: ${TABLE}.multi_goal_types ;;
  }
    dimension: net_connection_speed {
      type: string
      sql: ${TABLE}.net_connection_speed ;;
    }
    dimension: opt_type {
      type: string
      sql: ${TABLE}.opt_type ;;
    }
    dimension: os_type {
      type: string
      sql: ${TABLE}.os_type ;;
    }
    dimension: os_type_id {
      type: string
      sql: ${TABLE}.os_type_id ;;
    }
    dimension: os_version {
      type: string
      sql: ${TABLE}.os_version ;;
    }
    dimension: os_version_id {
      type: string
      sql: ${TABLE}.os_version_id ;;
    }
  dimension: package_goal_amount {
    type: number
    sql: ${TABLE}.package_goal_amount ;;
  }
    dimension: package_goal_type_id {
      type: string
      sql: ${TABLE}.package_goal_type_id ;;
    }
    dimension: package_id {
      type: string
      sql: ${TABLE}.package_id ;;
    }
  dimension: page_quality_concept_id {
    type: number
    sql: ${TABLE}.page_quality_concept_id ;;
  }
    dimension: placement_id {
      type: string
      sql: ${TABLE}.placement_id ;;
    }
    dimension: postal_code {
      type: string
      sql: ${TABLE}.postal_code ;;
    }
    dimension: profile_type {
      type: string
      sql: ${TABLE}.profile_type ;;
    }
    dimension: publisher_deal_id {
      type: string
      sql: ${TABLE}.publisher_deal_id ;;
    }
    dimension: publisher_id {
      type: string
      sql: ${TABLE}.publisher_id ;;
    }
    dimension: publisher_name {
      type: string
      sql: ${TABLE}.publisher_name ;;
    }
    dimension: region_id {
      type: string
      sql: ${TABLE}.region_id ;;
    }
    dimension: region_name {
      type: string
      sql: ${TABLE}.region_name ;;
    }
  dimension: selected_deal_request_floor_price {
    type: number
    sql: ${TABLE}.selected_deal_request_floor_price ;;
  }
    dimension: state_district_id {
      type: string
      sql: ${TABLE}.state_district_id ;;
    }
  dimension: targeted_behavior_id {
    type: number
    sql: ${TABLE}.targeted_behavior_id ;;
  }
    dimension: time_zone_offset {
      type: number
      sql: ${TABLE}.time_zone_offset ;;
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
  dimension: total_bid_multiplier_factor {
    type: number
    sql: ${TABLE}.total_bid_multiplier_factor ;;
  }
    dimension: tld {
      type: string
      sql: ${TABLE}.tld ;;
    }
    dimension: unique_devices_sketch {
      type: string
      sql: ${TABLE}.unique_devices_sketch ;;

    }
    dimension: unique_households_sketch {
      type: string
      sql: CAST(${TABLE}.unique_households_sketch AS VARCHAR) ;;

    }
    dimension: unique_persons_sketch {
      type: string
      sql: ${TABLE}.unique_persons_sketch ;;
    }
    dimension: user_id_sketch {
      type: string
      sql: ${TABLE}.user_id_sketch ;;
      hidden: yes
    }
    dimension: video_duration_bucket {
      type: string
      sql: ${TABLE}.video_duration_bucket ;;
    }
    dimension: video_linear_type_id {
      type: string
      sql: ${TABLE}.video_linear_type_id ;;
    }
    dimension: video_placement {
      type: string
      sql: ${TABLE}.video_placement ;;
    }
    dimension: video_placement_id {
      type: string
      sql: ${TABLE}.video_placement_id ;;
    }
    dimension: video_playback_method {
      type: string
      sql: ${TABLE}.video_playback_method ;;
    }
    dimension: video_playback_method_id {
      type: string
      sql: ${TABLE}.video_playback_method_id ;;
    }
    dimension: video_player_size {
      type: string
      sql: ${TABLE}.video_player_size ;;
    }
  dimension: video_player_height {
    type: number
    sql: ${TABLE}.video_player_height ;;
  }
  dimension: video_player_width {
    type: number
    sql: ${TABLE}.video_player_width ;;
  }
    dimension: video_player_size_id {
      type: string
      sql: ${TABLE}.video_player_size_id ;;
    }
    dimension: video_skippability_id {
      type: string
      sql: ${TABLE}.video_skippability_id ;;
    }
    dimension: video_skippable {
      type: yesno
      sql: ${TABLE}.video_skippable = 1 ;;
    }
    dimension: view_event_measurement_id {
      type: string
      sql: ${TABLE}.view_event_measurement_id ;;
    }
    dimension: view_event_platform_id {
      type: string
      sql: ${TABLE}.view_event_platform_id ;;
    }
  dimension: viewability_video_height {
    type: number
    sql: ${TABLE}.viewability_video_height ;;
  }
  dimension: viewability_video_width {
    type: number
    sql: ${TABLE}.viewability_video_width ;;
  }
    dimension: zip_code {
      type: zipcode
      sql: ${TABLE}.zip_code ;;
    }

    # =================================================================
    # MEASURES (Sums and Aggregations)
    # =================================================================

    measure: acc_100pct_vis_aud_sec {
      type: sum
      sql: ${TABLE}.acc_100pct_vis_aud_sec ;;
    }
    measure: acc_100pct_vis_sec {
      type: sum
      sql: ${TABLE}.acc_100pct_vis_sec ;;
    }
    measure: acc_50pct_vis_aud_sec {
      type: sum
      sql: ${TABLE}.acc_50pct_vis_aud_sec ;;
    }
    measure: acc_50pct_vis_sec {
      type: sum
      sql: ${TABLE}.acc_50pct_vis_sec ;;
    }
    measure: acc_aud_sec {
      type: sum
      sql: ${TABLE}.acc_aud_sec ;;
    }
    measure: action_value {
      type: sum
      sql: ${TABLE}.action_value ;;
    }
    measure: actions {
      type: sum
      sql: ${TABLE}.actions ;;
    }
    measure: ad_calls {
      type: sum
      sql: ${TABLE}.ad_calls ;;
    }
    measure: adjustment_cost {
      type: sum
      sql: ${TABLE}.adjustment_cost ;;
    }
    measure: analyzed_imp {
      type: sum
      sql: ${TABLE}.analyzed_imp ;;
    }
    measure: auction_discount_cost {
      type: sum
      sql: ${TABLE}.auction_discount_cost ;;
    }
    measure: audible_fully_visible_for_half {
      type: sum
      sql: ${TABLE}.audible_fully_visible_for_half ;;
    }
    measure: audio_mute_events {
      type: sum
      sql: ${TABLE}.audio_mute_events ;;
    }
    measure: audio_unmute_events {
      type: sum
      sql: ${TABLE}.audio_unmute_events ;;
    }

  measure: advertiser_local_currency_exchange_rate {
    type: sum
    sql: ${TABLE}.advertiser_local_currency_exchange_rate ;;
  }
    measure: avoc_imp {
      type: sum
      sql: ${TABLE}.avoc_imp ;;
    }
    measure: bid_price {
      type: sum
      sql: ${TABLE}.bid_price ;;
    }
    measure: bid_requests {
      type: sum
      sql: ${TABLE}.bid_requests ;;
    }
    measure: bid_saving_calculated {
      type: sum
      sql: ${TABLE}.bid_saving_calculated ;;
    }
    measure: bid_saving_fee {
      type: sum
      sql: ${TABLE}.bid_saving_fee ;;
    }
    measure: bids {
      type: sum
      sql: ${TABLE}.bids ;;
    }
    measure: bids_unsampled {
      type: sum
      sql: ${TABLE}.bids_unsampled ;;
    }
    measure: billing_invoice {
      type: sum
      sql: ${TABLE}.billing_invoice ;;
    }
    measure: billing_margin {
      type: sum
      sql: ${TABLE}.billing_margin ;;
    }
    measure: brand_intelligence_data_cost {
      type: sum
      sql: ${TABLE}.brand_intelligence_data_cost ;;
    }
    measure: brand_safety_data_cost {
      type: sum
      sql: ${TABLE}.brand_safety_data_cost ;;
    }
    measure: click_events {
      type: sum
      sql: ${TABLE}.click_events ;;
    }
    measure: click_through_actions {
      type: sum
      sql: ${TABLE}.click_through_actions ;;
    }
    measure: clicks {
      type: sum
      sql: ${TABLE}.clicks ;;
    }
    measure: cogs {
      type: sum
      sql: ${TABLE}.cogs ;;
    }
    measure: collapse_events {
      type: sum
      sql: ${TABLE}.collapse_events ;;
    }
    measure: complete_events {
      type: sum
      sql: ${TABLE}.complete_events ;;
    }
    measure: content_data_cost {
      type: sum
      sql: ${TABLE}.content_data_cost ;;
    }
    measure: content_length {
      type: sum
      sql: ${TABLE}.content_length ;;
    }
    measure: contextual_data_cost {
      type: sum
      sql: ${TABLE}.contextual_data_cost ;;
    }
    measure: cost {
      type: sum
      sql: ${TABLE}.cost ;;
      value_format: "$#,##0.00"
    }
    measure: creative_engagement_events {
      type: sum
      sql: ${TABLE}.creative_engagement_events ;;
    }
    measure: cross_device_actions {
      type: sum
      sql: ${TABLE}.cross_device_actions ;;
    }
    measure: cross_device_click_through_actions {
      type: sum
      sql: ${TABLE}.cross_device_click_through_actions ;;
    }
    measure: cross_device_cta_value {
      type: sum
      sql: ${TABLE}.cross_device_cta_value ;;
    }
    measure: cross_device_first_party_cost {
      type: sum
      sql: ${TABLE}.cross_device_first_party_cost ;;
    }
    measure: cross_device_shopping_cart_value {
      type: sum
      sql: ${TABLE}.cross_device_shopping_cart_value ;;
    }
    measure: cross_device_shopping_cart_value_cta {
      type: sum
      sql: ${TABLE}.cross_device_shopping_cart_value_cta ;;
    }
    measure: cross_device_shopping_cart_value_vta {
      type: sum
      sql: ${TABLE}.cross_device_shopping_cart_value_vta ;;
    }
    measure: cross_device_view_through_actions {
      type: sum
      sql: ${TABLE}.cross_device_view_through_actions ;;
    }
    measure: cross_device_vta_value {
      type: sum
      sql: ${TABLE}.cross_device_vta_value ;;
    }
    measure: cta_value {
      type: sum
      sql: ${TABLE}.cta_value ;;
    }
    # measure: custom_events {
    #   type: sum
    #   sql: ${TABLE}.custom_events ;;
    # }
    measure: data_cost {
      type: sum
      sql: ${TABLE}.data_cost ;;
    }
    measure: dcpm_cost {
      type: sum
      sql: ${TABLE}.dcpm_cost ;;
    }
    measure: defined_bid_price {
      type: sum
      sql: ${TABLE}.defined_bid_price ;;
    }
    measure: display_nielsen_targeting_first_party_cost {
      type: sum
      sql: ${TABLE}.display_nielsen_targeting_first_party_cost ;;
    }
    measure: display_viewability_first_party_cost {
      type: sum
      sql: ${TABLE}.display_viewability_first_party_cost ;;
    }
    # measure: dynamic_pricing {
    #   type: sum
    #   sql: ${TABLE}.dynamic_pricing ;;
    # }
    measure: exchange_fee {
      type: sum
      sql: ${TABLE}.exchange_fee ;;
    }
    measure: expand_events {
      type: sum
      sql: ${TABLE}.expand_events ;;
    }
    # measure: ext_app {
    #   type: sum
    #   sql: ${TABLE}.ext_app ;;
    # }
    measure: first_party_cost {
      type: sum
      sql: ${TABLE}.first_party_cost ;;
    }
    # measure: full_impression {
    #   type: sum
    #   sql: ${TABLE}.full_impression ;;
    # }
    measure: fv_measurable_imps {
      type: sum
      sql: ${TABLE}.fv_measurable_imps ;;
    }
    measure: ghost_bid_first_party_cost {
      type: sum
      sql: ${TABLE}.ghost_bid_first_party_cost ;;
    }
    measure: gross_video_ad_call_events {
      type: sum
      sql: ${TABLE}.gross_video_ad_call_events ;;
    }
    measure: groupm_in_view_imp {
      type: sum
      sql: ${TABLE}.groupm_in_view_imp ;;
    }
    measure: groupm_viewable_imp {
      type: sum
      sql: ${TABLE}.groupm_viewable_imp ;;
    }
    measure: grp_adjustment_cost {
      type: sum
      sql: ${TABLE}.grp_adjustment_cost ;;
    }
    measure: grp_cost {
      type: sum
      sql: ${TABLE}.grp_cost ;;
    }
    measure: household_actions {
      type: sum
      sql: ${TABLE}.household_actions ;;
    }
    measure: household_click_through_actions {
      type: sum
      sql: ${TABLE}.household_click_through_actions ;;
    }
    measure: household_cta_value {
      type: sum
      sql: ${TABLE}.household_cta_value ;;
    }
  # measure: household_id_sketch {
  #   type: sum
  #   sql: ${TABLE}.household_id_sketch ;;
  # }

  # measure: unique_households {
  #   type: number
  #   label: "Household Id Sketch"
  #   sql: HLL_ESTIMATE(${TABLE}.household_id_sketch) ;;
  #   value_format_name: decimal_0
  # }
    measure: household_shopping_cart_value {
      type: sum
      sql: ${TABLE}.household_shopping_cart_value ;;
    }
    measure: household_shopping_cart_value_cta {
      type: sum
      sql: ${TABLE}.household_shopping_cart_value_cta ;;
    }
    measure: household_shopping_cart_value_vta {
      type: sum
      sql: ${TABLE}.household_shopping_cart_value_vta ;;
    }
    measure: household_view_through_actions {
      type: sum
      sql: ${TABLE}.household_view_through_actions ;;
    }
    measure: household_vta_value {
      type: sum
      sql: ${TABLE}.household_vta_value ;;
    }
    measure: iab_in_view_imp {
      type: sum
      sql: ${TABLE}.iab_in_view_imp ;;
    }
    measure: impression_events {
      type: sum
      sql: ${TABLE}.impression_events ;;
    }
    measure: impressions {
      type: sum
      sql: ${TABLE}.impressions ;;
    }
    measure: impressions_major_exch {
      type: sum
      sql: ${TABLE}.impressions_major_exch ;;
    }
    measure: inventory_carry_fee {
      type: sum
      sql: ${TABLE}.inventory_carry_fee ;;
    }
    measure: inventory_carrying_cost {
      type: sum
      sql: ${TABLE}.inventory_carrying_cost ;;
    }
    measure: inventory_cost {
      type: sum
      sql: ${TABLE}.inventory_cost ;;
      value_format: "#,##0.00"
    }
    # measure: ip_mismatch {
    #   type: sum
    #   sql: ${TABLE}.ip_mismatch ;;
    # }
    measure: margin_on_inventory {
      type: sum
      sql: ${TABLE}.margin_on_inventory ;;
    }
    measure: market_audience_data_cost {
      type: sum
      sql: ${TABLE}.market_audience_data_cost ;;
      value_format: "#,##0.00"
    }

  measure: market_default_local_currency_exchange_rate {
    type: sum
    sql: ${TABLE}.market_default_local_currency_exchange_rate ;;
  }
    measure: market_third_party_cost {
      type: sum
      sql: ${TABLE}.market_third_party_cost ;;
      value_format: "#,##0.00"
    }
    measure: measurable_imp {
      type: sum
      sql: ${TABLE}.measurable_imp ;;
    }
    measure: misc_cogs_charges {
      type: sum
      sql: ${TABLE}.misc_cogs_charges ;;
    }
    measure: misc_tac_charges {
      type: sum
      sql: ${TABLE}.misc_tac_charges ;;
    }
    measure: mta_actions {
      type: sum
      sql: ${TABLE}.mta_actions ;;
    }
    # measure: multi_goal_types {
    #   type: sum
    #   sql: ${TABLE}.multi_goal_types ;;
    # }
    measure: nexxen_health_first_party_cost {
      type: sum
      sql: ${TABLE}.nexxen_health_first_party_cost ;;
    }
    measure: non_ssl_ad_serving_fee {
      type: sum
      sql: ${TABLE}.non_ssl_ad_serving_fee ;;
    }
    measure: non_utilized_ad_call_fee {
      type: sum
      sql: ${TABLE}.non_utilized_ad_call_fee ;;
    }
    measure: on_target_imp {
      type: sum
      sql: ${TABLE}.on_target_imp ;;
    }
    # measure: package_goal_amount {
    #   type: sum
    #   sql: ${TABLE}.package_goal_amount ;;
    # }
    measure: page_quality_data_cost {
      type: sum
      sql: ${TABLE}.page_quality_data_cost ;;
      value_format: "#,##0.00"
    }
    measure: partner_fee {
      type: sum
      sql: ${TABLE}.partner_fee ;;
    }
    measure: partner_markup {
      type: sum
      sql: ${TABLE}.partner_markup ;;
    }
    measure: partner_reserve {
      type: sum
      sql: ${TABLE}.partner_reserve ;;
    }
    measure: pause_events {
      type: sum
      sql: ${TABLE}.pause_events ;;
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
    measure: performance_reserve {
      type: sum
      sql: ${TABLE}.performance_reserve ;;
    }
    measure: pmp_fee {
      type: sum
      sql: ${TABLE}.pmp_fee ;;
    }
    measure: pub_def_ad_calls {
      type: sum
      sql: ${TABLE}.pub_def_ad_calls ;;
    }
    measure: rank {
      type: sum
      sql: ${TABLE}.rank ;;
    }
    measure: reconciliation_factor {
      type: sum
      sql: ${TABLE}.reconciliation_factor ;;
    }
    measure: resume_events {
      type: sum
      sql: ${TABLE}.resume_events ;;
    }
    measure: rewind_events {
      type: sum
      sql: ${TABLE}.rewind_events ;;
    }
    measure: rtbexchange_bid {
      type: sum
      sql: ${TABLE}.rtbexchange_bid ;;
    }
    measure: rtbexchange_bid_price {
      type: sum
      sql: ${TABLE}.rtbexchange_bid_price ;;
    }
    measure: rtbexchange_bid_price_unsampled {
      type: sum
      sql: ${TABLE}.rtbexchange_bid_price_unsampled ;;
    }
    # measure: selected_deal_request_floor_price {
    #   type: sum
    #   sql: ${TABLE}.selected_deal_request_floor_price ;;
    # }
    measure: shopping_cart_value {
      type: sum
      sql: ${TABLE}.shopping_cart_value ;;
    }
    measure: shopping_cart_value_cta {
      type: sum
      sql: ${TABLE}.shopping_cart_value_cta ;;
    }
    measure: shopping_cart_value_vta {
      type: sum
      sql: ${TABLE}.shopping_cart_value_vta ;;
    }
    measure: skip_events {
      type: sum
      sql: ${TABLE}.skip_events ;;
    }
    measure: ssl_ad_serving_fee {
      type: sum
      sql: ${TABLE}.ssl_ad_serving_fee ;;
    }
    measure: tac {
      type: sum
      sql: ${TABLE}.tac ;;
    }
    measure: third_party_mta_actions {
      type: sum
      sql: ${TABLE}.third_party_mta_actions ;;
    }
    # measure: throttle_by_model_based_early_exit {
    #   type: sum
    #   sql: ${TABLE}.throttle_by_model_based_early_exit ;;
    # }
    # measure: throttle_by_rule_based_early_exit {
    #   type: sum
    #   sql: ${TABLE}.throttle_by_rule_based_early_exit ;;
    # }
    # measure: total_bid_multiplier_factor {
    #   type: sum
    #   sql: ${TABLE}.total_bid_multiplier_factor ;;
    # }
    measure: tpa_click_based_actions {
      type: sum
      sql: ${TABLE}.tpa_click_based_actions ;;
    }
    measure: tpa_clicks {
      type: sum
      sql: ${TABLE}.tpa_clicks ;;
    }
    measure: tpa_impressions {
      type: sum
      sql: ${TABLE}.tpa_impressions ;;
    }
    measure: tpa_view_based_actions {
      type: sum
      sql: ${TABLE}.tpa_view_based_actions ;;
    }
    measure: turn_ad_serving_charge {
      type: sum
      sql: ${TABLE}.turn_ad_serving_charge ;;
    }
    measure: turn_audience_data_cost {
      type: sum
      sql: ${TABLE}.turn_audience_data_cost ;;
    }
    measure: turn_cogs_fee {
      type: sum
      sql: ${TABLE}.turn_cogs_fee ;;
    }
    measure: turn_def_pub_trigger_ad_calls {
      type: sum
      sql: ${TABLE}.turn_def_pub_trigger_ad_calls ;;
    }
    measure: turn_derived_mis_margin {
      type: sum
      sql: ${TABLE}.turn_derived_mis_margin ;;
    }
    measure: turn_exchange_fee {
      type: sum
      sql: ${TABLE}.turn_exchange_fee ;;
    }
    measure: turn_fee {
      type: sum
      sql: ${TABLE}.turn_fee ;;
    }
    measure: turn_inventory_cost {
      type: sum
      sql: ${TABLE}.turn_inventory_cost ;;
    }
    measure: turn_markup {
      type: sum
      sql: ${TABLE}.turn_markup ;;
    }
    measure: turn_min_charge_adjustment {
      type: sum
      sql: ${TABLE}.turn_min_charge_adjustment ;;
    }
    measure: turn_reconciliation_factor {
      type: sum
      sql: ${TABLE}.turn_reconciliation_factor ;;
    }
    measure: turn_reserve {
      type: sum
      sql: ${TABLE}.turn_reserve ;;
    }
    measure: turn_service_fee {
      type: sum
      sql: ${TABLE}.turn_service_fee ;;
    }
    measure: turn_spend_share {
      type: sum
      sql: ${TABLE}.turn_spend_share ;;
    }
    measure: turn_third_party_cost {
      type: sum
      sql: ${TABLE}.turn_third_party_cost ;;
    }
    measure: two_sec_viewable_imp {
      type: sum
      sql: ${TABLE}.two_sec_viewable_imp ;;
    }
    measure: utilized_ad_call_fee {
      type: sum
      sql: ${TABLE}.utilized_ad_call_fee ;;
    }
    measure: video_completed {
      type: sum
      sql: ${TABLE}.video_completed ;;
    }
    measure: video_duration_two_sec {
      type: sum
      sql: ${TABLE}.video_duration_two_sec ;;
    }
    measure: video_max_duration {
      type: sum
      sql: ${TABLE}.video_max_duration ;;
    }
    measure: video_min_duration {
      type: sum
      sql: ${TABLE}.video_min_duration ;;
    }
    # measure: video_player_height {
    #   type: sum
    #   sql: ${TABLE}.video_player_height ;;
    # }
    # measure: video_player_width {
    #   type: sum
    #   sql: ${TABLE}.video_player_width ;;
    # }
    measure: video_viewability_first_party_cost {
      type: sum
      sql: ${TABLE}.video_viewability_first_party_cost ;;
    }
    measure: view_events {
      type: sum
      sql: ${TABLE}.view_events ;;
    }
    measure: view_through_actions {
      type: sum
      sql: ${TABLE}.view_through_actions ;;
    }
    measure: viewability_video_duration {
      type: sum
      sql: ${TABLE}.viewability_video_duration ;;
    }
    # measure: viewability_video_height {
    #   type: sum
    #   sql: ${TABLE}.viewability_video_height ;;
    # }
    # measure: viewability_video_width {
    #   type: sum
    #   sql: ${TABLE}.viewability_video_width ;;
    # }
    measure: viewable_imp {
      type: sum
      sql: ${TABLE}.viewable_imp ;;
    }
    measure: viewable_time_two_sec {
      type: sum
      sql: ${TABLE}.viewable_time_two_sec ;;
    }
    measure: vta_value {
      type: sum
      sql: ${TABLE}.vta_value ;;
    }
    measure: win_notifications {
      type: sum
      sql: ${TABLE}.win_notifications ;;
    }
    measure: win_notifications_major_exch {
      type: sum
      sql: ${TABLE}.win_notifications_major_exch ;;
    }
    measure: win_price {
      type: sum
      sql: ${TABLE}.win_price ;;
    }
    measure: wins {
      type: sum
      sql: ${TABLE}.wins ;;
    }
    measure: wins_unsampled {
      type: sum
      sql: ${TABLE}.wins_unsampled ;;
    }

    # measure: count {
    #   type: count
    #   drill_fields: [detail*]
    # }

    # # ----- Sets of fields for drilling ------
    # set: detail {
    #   fields: [
    #     iab_category_name,
    #     device_type_name,
    #     city_name,
    #     home_market_name,
    #     media_channel_name,
    #     exchange_publisher_name,
    #     brand_safety_contract_name,
    #     custom_event_name,
    #     county_name,
    #     dma_name,
    #     country_name,
    #     inventory_source_name,
    #     mobile_app_name,
    #     browser_type_name,
    #     brand_safety_provider_name,
    #     region_name,
    #     bid_request_app_name,
    #     publisher_name
    #   ]
    # }

  }
