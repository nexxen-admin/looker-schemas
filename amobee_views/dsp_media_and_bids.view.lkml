view: dsp_media_and_bids {
  sql_table_name: druid.dsp_media_and_bids ;;

  dimension_group: __time {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."__time" ;;
  }

  dimension: lag_date {
    type: date
    sql: lag(${__time_date},1) over(order by ${__time_date}) ;;

  }

  measure:  Previous_day_cost {
    label: "Inv Cost Previous Day "
    type: sum
    sql: ${TABLE}.inv_cost ;;
    description: "Cost from 2 days ago"
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [__time_date: "2 days ago"]
  }

  measure:  last_day_cost {
    label: "Inv Cost Yesterday "
    type: sum
    description: "Yesterday's cost"
    sql: ${TABLE}.inv_cost ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [__time_date :  "last 1 day ago for 1 day"]
  }

  measure:  Previous_day_impression {
    label: "Impression Previous Day "
    type: sum
    description: "Impressions from 2 days ago"
    sql: ${TABLE}.impression ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [__time_date: "2 days ago"]
  }

  measure:  last_day_impression {
    label: "Impression Current Day "
    type: sum
    description: "Yesterday's impressions"
    sql: ${TABLE}.impression ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [__time_date :  "last 1 day ago for 1 day"]
  }

  measure:  unruly_previous_day_cost {
    label: "Inv Cost Nexxen Previous Day "
    type: sum
    description: "Unruly's Cost from 2 days ago"
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.inv_cost ELSE NULL END ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [__time_date: "2 days ago"]
  }

  measure:  unruly_last_day_cost {
    label: "Inv Cost Nexxen - Yesterday "
    type: sum
    description: "Unruly's yesterday's cost"
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.inv_cost ELSE NULL END ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [__time_date :  "last 1 day ago for 1 day"]
  }

  measure: unruly_previous_day_impression {
    label: "Impression Nexxen Previous Day "
    type: sum
    description: "Unruly's impressions from 2 days ago"
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.impression ELSE NULL END ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [__time_date: "2 days ago"]
  }

  measure: unruly_last_day_impression {
    label: "Impression Nexxen Current Day "
    type: sum
    description: "Unruly's yesterday's impressions"
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}.impression ELSE NULL END ;;
    group_label: "Time Shifted Measures"
    value_format: "$#,##0.00"
    filters: [__time_date :  "last 1 day ago for 1 day"]
  }

  measure: Inv_Cost_Change {
    type: number
    #value_format: "0.0%"
    description: "The inventort cost change from 2 days ago to yesterday"
    sql: case when ${last_day_cost} = 0 then 0 else
         (${last_day_cost}-${Previous_day_cost})/${last_day_cost} end;;
    value_format_name: percent_2
  }

  parameter: domain_or_app {
    type: unquoted
    allowed_value: {
      label: "Domain"
      value: "tld"
    }
    allowed_value: {
      label: "App"
      value: "app_id"
    }
  }

  dimension: app_or_site {
    type: string
    label: "App or Site"
    sql: case when ${app_id} is not null then "App" else "Site" end ;;
  }

    dimension: dynamic_domain_app {
      type: string
      sql: {% parameter domain_or_app %} ;;
    }


  # dimension: is_1P_SSP {
  #   type: yesno
  #   sql: case when ${inventory_source_id} = 158 then yes else no end ;;
  # }

  measure: acc_100pct_vis_aud_sec {
    type: sum
    description: "Number of cumulative seconds when 100% of the video ad's viewable area was in-view and volume was greater than zero (i.e., not muted)"
    sql: ${TABLE}."acc_100pct_vis_aud_sec" ;;
  }

  measure: acc_100pct_vis_sec {
    type: sum
    description: "Number of cumulative seconds when 100% of the video ad's viewable area was in-view"
    sql: ${TABLE}."acc_100pct_vis_sec" ;;
  }

  measure: acc_50pct_vis_aud_sec {
    type: sum
    description: "Number of cumulative seconds when 50% of the video ad's viewable area was in-view and volume was greater than zero (i.e., not muted)"
    sql: ${TABLE}."acc_50pct_vis_aud_sec" ;;
  }

  measure: acc_50pct_vis_sec {
    type: sum
    description: "Number of cumulative seconds when 50% of the video ad's viewable area was in-view"
    sql: ${TABLE}."acc_50pct_vis_sec" ;;
  }

  measure: acc_aud_sec {
    type: sum
    description: "Number of cumulative seconds when the video ad's volume was greater than zero (i.e., not muted)"
    sql: ${TABLE}."acc_aud_sec" ;;
  }

  measure: action {
    type: sum
    description: "1 if this event was an action, 0 otherwise"
    sql: ${TABLE}."action" ;;
  }

  dimension: ad_code_id {
    type: number
    sql: ${TABLE}."ad_code_id" ;;
    value_format_name: id
  }

  dimension: ad_format_id {
    type: number
    description: "Ad format ID. Please see DataMine Analytics Reference Guide for the full list"
    sql: ${TABLE}."ad_format_id" ;;
    value_format_name: id
  }

  dimension: ad_group_id {
    type: number
    sql: ${TABLE}."ad_group_id" ;;
    value_format_name: id
  }

  dimension: ad_id {
    type: number
    description: "ID for an ad"
    sql: ${TABLE}."ad_id" ;;
    value_format_name: id
  }

  dimension: adstxt_seller_relationship {
    type: string
    description: "The seller and inventory's relationship for this impression opportunity according to the site's ads.txt"
    sql: ${TABLE}."adstxt_seller_relationship" ;;
  }

  dimension: adstxt_seller_status {
    type: string
    description: "The seller's authorization status for this impression opportunity according to the site's ads.txt"
    sql: ${TABLE}."adstxt_seller_status" ;;
  }

  dimension: advertiser_id {
    type: number
    description: "Audience Suite Advertiser ID"
    sql: ${TABLE}."advertiser_id" ;;
    value_format_name: id
  }

  dimension: app_id {
    type: string
    sql: ${TABLE}."app_id" ;;
    value_format_name: id
  }

  dimension: auction_type {
    type: number
    description: "Type of auction. '2' is default. 1 - 1st Price; 2 - 2nd Price; -2 - Unrecognized"
    sql: ${TABLE}."auction_type" ;;
  }

  measure: audio_mute_events {
    type: sum
    description: "1 for events that were muted"
    sql: ${TABLE}."audio_mute_events" ;;
  }

  dimension: audio_unmute_events {
    type: number
    description: "1 for events that were unmuted"
    sql: ${TABLE}."audio_unmute_events" ;;
  }

  measure: avoc_imp {
    type: sum
    description: "1 or 0, where 1 indicates the Video was Audible and Visible upon complete"
    sql: ${TABLE}."avoc_imp" ;;
  }

  dimension: beacon_id {
    type: number
    description: "Id of the beacon"
    sql: ${TABLE}."beacon_id" ;;
    value_format_name: id
  }

  measure: bid {
    type: sum
    sql: ${TABLE}."bid" ;;
  }

  measure: bid_price {
    type: sum
    description: "Internally determined worth of the impression"
    sql: ${TABLE}."bid_price" ;;
  }

  measure: bid_saving_calculated {
    type: sum
    description: "Difference between original bid price vs discounted bid price if bid shading is enabled"
    sql: ${TABLE}."bid_saving_calculated" ;;
  }

  measure: bid_saving_fee {
    type: sum
    description: "Charged fee for bid saving if bid shading is enabled"
    sql: ${TABLE}."bid_saving_fee" ;;
  }

  measure: brand_safety_data_cost {
    type: sum
    description: "Data cost for brand safety data"
    sql: ${TABLE}."brand_safety_data_cost" ;;
  }

  dimension: browser_type {
    type: number
    description: "0 - Unknown; 1 - IExplorer; 2 - Firefox; 3 - Chrome; 4 - Safari; 5 - Sleipnir; 6 - Opera; 7- Gecko; 8 - IAB Valid"
    sql: ${TABLE}."browser_type" ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}."campaign_id" ;;
    value_format_name: id
  }

  dimension: city_id {
    type: number
    sql: ${TABLE}."city_id" ;;
    value_format_name: id
  }

  measure: click {
    type: sum
    description: "1 if this event was a click, 0 otherwise"
    sql: ${TABLE}."click" ;;
  }

  measure: click_through_action {
    type: sum
    description: "1 for CTA, 0 for all other actions"
    sql: ${TABLE}."click_through_action" ;;
  }

  measure: cogs {
    type: sum
    description: "Inventory cost plus third-party cost"
    sql: ${TABLE}."cogs" ;;
  }

  measure: collapse_events {
    type: sum
    description: "1 for events that were collapsed"
    sql: ${TABLE}."collapse_events" ;;
  }

  measure: complete_events {
    type: sum
    description: "1 for events that were completed"
    sql: ${TABLE}."complete_events" ;;
  }

  measure: concatenated_brand_intelligence_data_cost {
    type: sum
    description: "Amount to charge for using this brand intelligence targeting"
    sql: ${TABLE}."concatenated_brand_intelligence_data_cost" ;;
  }

  measure: content_data_cost {
    type: sum
    description: "Aggregate data cost of contextual data cost, brand safety cost, and page quality data cost"
    sql: ${TABLE}."content_data_cost" ;;
  }

  measure: contextual_data_cost {
    type: sum
    description: "Data cost for contextual data"
    sql: ${TABLE}."contextual_data_cost" ;;
  }

  measure: cost {
    type: sum
    description: "Cost of impression"
    sql: ${TABLE}."cost" ;;
  }

  dimension: country_id {
    type: number
    sql: ${TABLE}."country_id" ;;
    value_format_name: id
  }

  dimension: cpa_goal {
    type: number
    sql: ${TABLE}."cpa_goal" ;;
  }

  dimension: cpc_goal {
    type: number
    sql: ${TABLE}."cpc_goal" ;;
  }

  dimension: creative_id {
    type: number
    sql: ${TABLE}."creative_id" ;;
    value_format_name: id
  }

  dimension: creative_size {
    type: string
    description: "Size of the creative"
    sql: ${TABLE}."creative_size" ;;
  }

  measure: cross_device_action {
    type: sum
    sql: ${TABLE}."cross_device_action" ;;
  }

  measure: cross_device_assigned_cpa_action {
    type: sum
    sql: ${TABLE}."cross_device_assigned_cpa_action" ;;
  }

  measure: cross_device_click_through_action {
    type: sum
    description: "1 for cross device click-through action (CTA), 0 for all other actions"
    sql: ${TABLE}."cross_device_click_through_action" ;;
  }

  measure: cross_device_cta_value {
    type: sum
    description: "Represents the value of a cross device click-through action If the action is associated to a shopping cart beacon type, then: cta_value = shopping cart value * maximum of (0, cta factor)"
    sql: ${TABLE}."cross_device_cta_value" ;;
  }

  measure: cross_device_view_through_action {
    type: sum
    description: "1 for view-through cross device action (VTA), 0 for all other functions"
    sql: ${TABLE}."cross_device_view_through_action" ;;
  }

  measure: cross_device_vta_value {
    type: sum
    description: "Represents the value of a cross device view-through action If the action is associated to a shopping cart beacon type, then: vta_value = shopping cart value * maximum of (0, vta factor) If it is another beacon type: vta_value = maximum of (0, vta value)"
    sql: ${TABLE}."cross_device_vta_value" ;;
  }

  measure: cta_value {
    type: sum
    description: "Shopping cart value for the click-through-rate"
    sql: ${TABLE}."cta_value" ;;
  }

  dimension: deal_id {
    type: string
    description: "String id for a deal id object"
    sql: ${TABLE}."deal_id" ;;
    value_format_name: id
  }

  dimension: dma_id {
    type: number
    description: "DMA ID for the audience segment."
    sql: ${TABLE}."dma_id" ;;
    value_format_name: id
  }

  dimension: environment {
    type: string
    description: "Media environment where ad is delivered - desktop web/ mobile web/ mobile app/ CTV app"
    sql: ${TABLE}."environment" ;;
  }

  dimension: environment_id {
    type: number
    description: "1 - Desktop Web; 3 - Mobile Web; 4 - Mobile App; 5 - CTV App; -1 - Unknown"
    sql: ${TABLE}."environment_id" ;;
    value_format_name: id
  }

  dimension: event_type {
    type: string
    description: "Campaign Impression Event type = Impression, Action, Click"
    sql: ${TABLE}."event_type" ;;
  }

  measure: exchange_fee {
    type: sum
    sql: ${TABLE}."exchange_fee" ;;
  }

  dimension: exchange_line_item_id {
    type: string
    sql: ${TABLE}."exchange_line_item_id" ;;
  }

  measure: expand_events {
    type: sum
    description: "1 for events expanded"
    sql: ${TABLE}."expand_events" ;;
  }

  dimension: ext_app {
    type: number
    description: "Ext_app = 0 implies web environment, Ext_app = 1 implies App Environment"
    sql: ${TABLE}."ext_app" ;;
  }

  measure: first_party_cost {
    type: sum
    description: "Total first party cost aggregate"
    sql: ${TABLE}."first_party_cost" ;;
  }

  dimension: format {
    type: string
    description: "Creative format on the campaign e.g. display or video"
    sql: ${TABLE}."format" ;;
  }

  measure: gross_video_ad_call {
    type: sum
    description: "1 for gross video flag"
    sql: ${TABLE}."gross_video_ad_call" ;;
  }

  measure: groupm_viewable_imp {
    type: sum
    sql: ${TABLE}."groupm_viewable_imp" ;;
  }

  measure: household_action {
    type: sum
    sql: ${TABLE}."household_action" ;;
  }

  measure: household_click_through_action {
    type: sum
    sql: ${TABLE}."household_click_through_action" ;;
  }

  measure: household_cta_value {
    type: sum
    sql: ${TABLE}."household_cta_value" ;;
  }

  measure: household_id_sketch {
    type: sum
    sql: ${TABLE}."household_id_sketch" ;;
  }

  measure: household_person_id_sketch {
    type: sum
    description: "Unique Identifier for a person in house hold"
    sql: ${TABLE}."household_person_id_sketch" ;;
  }

  measure: household_view_through_action {
    type: sum
    sql: ${TABLE}."household_view_through_action" ;;
  }

  measure: household_vta_value {
    type: sum
    sql: ${TABLE}."household_vta_value" ;;
  }

  dimension: iab_category_id {
    type: number
    description: "IAB publisher content category ID. The DataMine Analytics Reference Guide includes the detailed list of values"
    sql: ${TABLE}."iab_category_id" ;;
  }

  dimension: iab_category_name {
    type: string
    description: "Content category based on the IAB standard displayed as a string, for example, Arts & Entertainment, Automotive, etc"
    sql: ${TABLE}."iab_category_name" ;;
  }

  measure: impression {
    type: sum
    #value_format: "#,##0,,,\"B\""
    sql: ${TABLE}."impression" ;;
  }

  measure: inv_cost {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}."inv_cost" ;;
  }

  dimension: line_item_id {
    type: number
    sql: ${TABLE}."line_item_id" ;;
  }

  measure: margin_on_inventory {
    type: sum
    description: "Amount set aside for an Amobee platform customer which is a percentage of all costs associated in acquiring inventory"
    sql: ${TABLE}."margin_on_inventory" ;;
  }

  measure: market_audience_data_cost {
    type: sum
    sql: ${TABLE}."market_audience_data_cost" ;;
  }

  dimension: market_id {
    type: number
    description: "ID of the market to which the Advertiser belongs"
    sql: ${TABLE}."market_id" ;;
    value_format_name: id
  }

  measure: market_third_party_cost {
    type: sum
    sql: ${TABLE}."market_third_party_cost" ;;
  }

  measure: measurable_imp {
    type: sum
    description: "Flag that specifies if the video ad impression was measurable by the viewability partner"
    sql: ${TABLE}."measurable_imp" ;;
  }

  dimension: media_channel_id {
    type: number
    description: "1 - Display; 2 - Video; 3 - Social; 4 - Mobile"
    sql: ${TABLE}."media_channel_id" ;;
  }

  dimension: media_channel_name {
    type: string
    sql: ${TABLE}."media_channel_name" ;;
  }

  dimension: mobile_app_name {
    type: string
    description: "1 - Display; 2 - Video; 3 - Social; 4 - Mobile"
    sql: ${TABLE}."mobile_app_name" ;;
  }

  dimension: mobile_device_type_id {
    type: number
    description: "ID of Device type (that is, mobile phone, tablet, gaming console, e-reader, and other)"
    sql: ${TABLE}."mobile_device_type_id" ;;
    value_format_name: id
  }

  measure: non_ssl_ad_serving_fee {
    type: sum
    description: "This is the fee that is CPM based fee that is charged typically when Turn Fee, Turn Rev Share or Turn Variable Margin are not used"
    sql: ${TABLE}."non_ssl_ad_serving_fee" ;;
  }

  dimension: os_type {
    type: number
    description: "OS Type; 0 - Unknown; 1 - Windows; 2 - Linux; 3 - Mac; 4 - iPad; 5 - iPhone; 6 - Android"
    sql: ${TABLE}."os_type" ;;
  }

  dimension: package_client_status {
    type: string
    sql: ${TABLE}."package_client_status" ;;
  }

  measure: page_quality_data_cost {
    type: sum
    description: "Data cost for page quality contract"
    sql: ${TABLE}."page_quality_data_cost" ;;
  }

  measure: partner_fee {
    type: sum
    sql: ${TABLE}."partner_fee" ;;
  }

  measure: partner_markup {
    type: sum
    sql: ${TABLE}."partner_markup" ;;
  }

  measure: partner_reserve {
    type: sum
    sql: ${TABLE}."partner_reserve" ;;
  }

  measure: pause_events {
    type: sum
    description: "1 for paused events"
    sql: ${TABLE}."pause_events" ;;
  }

  measure: percent25_events {
    type: sum
    description: "1 for 25% of events"
    sql: ${TABLE}."percent25_events" ;;
  }

  measure: percent50_events {
    type: sum
    description: "1 for 50% of events"
    sql: ${TABLE}."percent50_events" ;;
  }

  measure: percent75_events {
    type: sum
    description: "1 for 75% of events"
    sql: ${TABLE}."percent75_events" ;;
  }

  measure: performance_reserve {
    type: sum
    sql: ${TABLE}."performance_reserve" ;;
  }

  measure: pmp_fee {
    type: sum
    sql: ${TABLE}."pmp_fee" ;;
  }

  dimension: postal_code {
    type: string
    description: "User-level postal code; zip_code in United States"
    sql: ${TABLE}."postal_code" ;;
  }

  dimension: publisher_deal_object_id {
    type: number
    description: "deal id object primary key"
    sql: ${TABLE}."publisher_deal_object_id" ;;
    value_format_name: id
  }

  dimension: publisher_id {
    type: number
    sql: ${TABLE}."publisher_id" ;;
    value_format_name: id
  }

  dimension: region_id {
    type: number
    sql: ${TABLE}."region_id" ;;
    value_format_name: id
  }

  measure: resume_events {
    type: sum
    description: "1 for events that were resumed"
    sql: ${TABLE}."resume_events" ;;
  }

  measure: rewind_events {
    type: sum
    description: "1 for events that were rewound"
    sql: ${TABLE}."rewind_events" ;;
  }

  measure: shopping_cart_value {
    type: sum
    description: "Dollar value of shopping cart passed via action pixel"
    sql: ${TABLE}."shopping_cart_value" ;;
  }

  measure: shopping_cart_value_cta {
    type: sum
    sql: ${TABLE}."shopping_cart_value_cta" ;;
  }

  dimension: shopping_cart_value_vta {
    type: number
    sql: ${TABLE}."shopping_cart_value_vta" ;;
  }

  measure: skip_events {
    type: sum
    description: "1 for events that were skipped"
    sql: ${TABLE}."skip_events" ;;
  }

  measure: ssl_ad_serving_fee {
    type: sum
    description: "This is the fee that is charged only when an SSL creative is served"
    sql: ${TABLE}."ssl_ad_serving_fee" ;;
  }

  measure: tac {
    type: sum
    description: "Traffic acquisition cost (TAC). The amount paid out to the publisher that covers the inventory cost"
    sql: ${TABLE}."tac" ;;
  }

  dimension: targeted_segment_id {
    type: number
    description: "Segment id targeted"
    sql: ${TABLE}."targeted_segment_id" ;;
    value_format_name: id
  }

  dimension: third_party_cost_type {
    type: string
    sql: ${TABLE}."third_party_cost_type" ;;
  }

  dimension: tier_id {
    type: number
    sql: ${TABLE}."tier_id" ;;
    value_format_name: id
  }

  dimension: tld {
    type: string
    description: "Top-level domain"
    sql: ${TABLE}."tld" ;;
  }

  measure: turn_ad_serving_charge {
    type: sum
    description: "This is the fee that is charged only when Turn is the ad server of record"
    sql: ${TABLE}."turn_ad_serving_charge" ;;
  }

  measure: turn_audience_data_cost {
    type: sum
    sql: ${TABLE}."turn_audience_data_cost" ;;
  }

  measure: turn_fee {
    type: sum
    sql: ${TABLE}."turn_fee" ;;
  }

  measure: turn_min_charge_adjustment {
    type: sum
    sql: ${TABLE}."turn_min_charge_adjustment" ;;
  }

  measure: turn_third_party_cost {
    type: sum
    sql: ${TABLE}."turn_third_party_cost" ;;
  }

  measure: user_id_sketch {
    type: sum
    sql: ${TABLE}."user_id_sketch" ;;
  }

  measure: video_max_duration {
    type: sum
    description: "Max duration of the video"
    sql: ${TABLE}."video_max_duration" ;;
  }

  measure: video_min_duration {
    type: sum
    description: "Min duration of the video"
    sql: ${TABLE}."video_min_duration" ;;
  }

  dimension: video_playback_method {
    type: string
    description: "Playback method used for the video ad"
    sql: ${TABLE}."video_playback_method" ;;
  }

  dimension: video_player_size {
    type: string
    description: "Player size used for the video ad"
    sql: ${TABLE}."video_player_size" ;;
  }

  measure: view_through_action {
    type: sum
    description: "1 for VTA, 0 for all other functions"
    sql: ${TABLE}."view_through_action" ;;
  }

  measure: viewability_video_duration {
    type: sum
    description: "Length, in seconds, of the video ad"
    sql: ${TABLE}."viewability_video_duration" ;;
  }

  measure: viewable_imp {
    type: sum
    sql: ${TABLE}."viewable_imp" ;;
  }

  measure: vta_value {
    type: sum
    description: "Shopping cart value for the view-through-action"
    sql: ${TABLE}."vta_value" ;;
  }

  measure: win {
    type: sum
    sql: ${TABLE}."win" ;;
  }

  measure: xd_shopping_cart_value_cta {
    type: sum
    sql: ${TABLE}."xd_shopping_cart_value_cta" ;;
  }

  measure: xd_shopping_cart_value_vta {
    type: sum
    sql: ${TABLE}."xd_shopping_cart_value_vta" ;;
  }

  dimension: zip_code {
    type: zipcode
    description: "Zip Code (United States only. For rest of the world see postal_code"
    sql: ${TABLE}."zip_code" ;;
  }

dimension: ad_name {
  type: string
  sql: LOOKUP(CONCAT(ad_id, ''), 'dsp_media_and_bids_ad_name') ;;
}
dimension: advertiser_name {
  type: string
  sql: LOOKUP(CONCAT(advertiser_id, ''), 'dsp_media_and_bids_advertiser_name') ;;
}
dimension: external_advertiser_id {
  type: string
  description: "The name of external advertiser_id"
  sql: LOOKUP(CONCAT(advertiser_id, ''), 'dsp_media_and_bids_external_advertiser_id') ;;
}
dimension: beacon_name {
  type: string
  description: "Name of the beacon that tracks user's action. Usually named according to the desired action"
  sql: LOOKUP(CONCAT(beacon_id, ''), 'dsp_media_and_bids_beacon_name') ;;
}
dimension: content_contract_id {
  type: string
  sql: LOOKUP(CONCAT(concept_id, ''), 'dsp_media_and_bids_content_contract_id') ;;
}
dimension: content_provider_id {
  type: string
  sql: LOOKUP(CONCAT(concept_id, ''), 'dsp_media_and_bids_content_provider_id') ;;
}
dimension: provider_name {
  type: string
  sql: LOOKUP(CONCAT(concept_id, ''), 'dsp_media_and_bids_provider_name') ;;
}
dimension: brand_safety_category_name {
  type: string
  description: "Safety Cateogry Name"
  sql: LOOKUP(CONCAT(contextual_category_id, ''), 'dsp_media_and_bids_brand_safety_category_name') ;;
}
dimension: contextual_category_name {
  type: string
  description: "Contextual Category Name"
  sql: LOOKUP(CONCAT(contextual_category_id, ''), 'dsp_media_and_bids_contextual_category_name') ;;
}
dimension: page_quality_category_name {
  type: string
  sql: LOOKUP(CONCAT(contextual_category_id, ''), 'dsp_media_and_bids_page_quality_category_name') ;;
}
dimension: creative_name {
  type: string
  sql: LOOKUP(CONCAT(creative_id, ''), 'dsp_media_and_bids_creative_name') ;;
}
dimension: tpa_external_id {
  type: string
  sql: LOOKUP(CONCAT(creative_id, ''), 'dsp_media_and_bids_tpa_external_id') ;;
}
dimension: contract_name {
  type: string
  description: "Name of the data contract"
  sql: LOOKUP(CONCAT(data_contract_id, ''), 'dsp_media_and_bids_contract_name') ;;
}
dimension: deal_name {
  type: string
  description: "The name of a deal id object"
  sql: LOOKUP(CONCAT(publisher_deal_object_id, ''), 'dsp_media_and_bids_deal_name') ;;
}
dimension: deal_type_name {
  type: string
  description: "The type of a deal id object"
  sql: LOOKUP(CONCAT(publisher_deal_object_id, ''), 'dsp_media_and_bids_deal_type_name') ;;
}
dimension: deal_floor_price {
  type: string
  description: "The floor price of a deal id project"
  sql: LOOKUP(CONCAT(publisher_deal_object_id, ''), 'dsp_media_and_bids_deal_floor_price') ;;
}
dimension: segment_id {
  type: string
  description: "Targeted segments"
  sql: LOOKUP(CONCAT(targeted_segment_id, ''), 'dsp_media_and_bids_segment_id') ;;
}
dimension: targeted_segment_name {
  type: string
  description: "Segment name targeted"
  sql: LOOKUP(CONCAT(targeted_segment_id, ''), 'dsp_media_and_bids_targeted_segment_name') ;;
}
dimension: insertion_order_id {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_insertion_order_id') ;;
}
dimension: insertion_order_name {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_insertion_order_name') ;;
}
dimension: external_io_id {
  type: string
  description: "external Insertion order ID"
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_external_io_id') ;;
}
dimension: io_current_budget {
  type: string
  description: "Budget for the IO"
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_io_current_budget') ;;
}
dimension: io_cpa_goal {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_io_cpa_goal') ;;
}
dimension: io_cpc_goal {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_io_cpc_goal') ;;
}
dimension: io_start_date {
  type: string
  description: "Date the IO begins at 12:01 am"
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_io_start_date') ;;
}
dimension: io_end_date {
  type: string
  description: "Date the IO ends"
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_io_end_date') ;;
}
dimension: io_impression_cap_day {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_io_impression_cap_day') ;;
}
dimension: io_impression_cap_week {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_io_impression_cap_week') ;;
}
dimension: io_client_status {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_io_client_status') ;;
}
dimension: line_item_name {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_line_item_name') ;;
}
dimension: external_line_item_id {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_external_line_item_id') ;;
}
dimension: li_bid_price {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_li_bid_price') ;;
}
dimension: li_budget_optimized {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_li_budget_optimized') ;;
}
dimension: li_client_status {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_li_client_status') ;;
}
dimension: li_cpa_goal {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_li_cpa_goal') ;;
}
dimension: li_cpc_goal {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_li_cpc_goal') ;;
}
dimension: li_impression_cap {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_li_impression_cap') ;;
}
dimension: li_start_date {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_li_start_date') ;;
}
dimension: li_end_date {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_li_end_date') ;;
}
dimension: is_budget_optimized {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_is_budget_optimized') ;;
}
dimension: deal_label {
  type: string
  sql: LOOKUP(CONCAT(publisher_deal_object_id, ''), 'dsp_media_and_bids_deal_label') ;;
}
dimension: deal_label_string {
  type: string
  sql: LOOKUP(CONCAT(publisher_deal_object_id, ''), 'dsp_media_and_bids_deal_label_string') ;;
}
dimension: packag_name {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_packag_name') ;;
}
dimension: package_name {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_package_name') ;;
}
dimension: external_packag_id {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_external_packag_id') ;;
}
dimension: external_package_id {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_external_package_id') ;;
}
dimension: packag_current_budget {
  type: string
  description: "Overall budget for the package"
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_packag_current_budget') ;;
}
dimension: packag_client_status {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_packag_client_status') ;;
}
dimension: packag_cpa_goal {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_packag_cpa_goal') ;;
}
dimension: packag_cpc_goal {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_packag_cpc_goal') ;;
}
dimension: packag_start_date {
  type: string
  description: "The date on which the package begins at 12:01 am"
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_packag_start_date') ;;
}
dimension: packag_end_date {
  type: string
  description: "The date on which the package ends at 11:59 pm"
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_packag_end_date') ;;
}
dimension: impression_cap_value {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_impression_cap_value') ;;
}
dimension: inventory_source_id {
  type: string
  sql: LOOKUP(CONCAT(publisher_id, ''), 'dsp_media_and_bids_inventory_source_id') ;;
}
dimension: inventory_source_name {
  type: string
  sql: LOOKUP(CONCAT(publisher_id, ''), 'dsp_media_and_bids_inventory_source_name') ;;
}

measure: ssp {

    sql: ${inv_cost} ;;

    html:

    {% if inventory_source_name._value == 'Unruly' %}

      <p style="color: black; color: yellow; font-size:100%; text-align:center">{{ inv_cost._rendered_value }}</p>

    {% else %}

      <p style="color: black; color: gray; font-size:100%; text-align:center">{{ inv_cost._rendered_value }}</p>

    {% endif %}

;;

    }



dimension: publisher_name {
  type: string
  description: "Name of a publisher"
  sql: LOOKUP(CONCAT(publisher_id, ''), 'dsp_media_and_bids_publisher_name') ;;
}
dimension: domain_name {
  type: string
  sql: LOOKUP(CONCAT(site_section_id, ''), 'dsp_media_and_bids_domain_name') ;;
}
dimension: device_type_name {
  type: string
  sql: LOOKUP(CONCAT(mobile_device_type_id, ''), 'dsp_media_and_bids_device_type_name') ;;
}
dimension: country_name {
  type: string
  description: "Country name for the audience segments"
  sql: LOOKUP(CONCAT(country_id, ''), 'dsp_media_and_bids_country_name') ;;
}
dimension: dma_name {
  type: string
  description: "DMA name for the audience segment"
  sql: LOOKUP(CONCAT(dma_id, ''), 'dsp_media_and_bids_dma_name') ;;
}
dimension: city_name {
  type: string
  description: "City name for the audience segment"
  sql: LOOKUP(CONCAT(city_id, ''), 'dsp_media_and_bids_city_name') ;;
}
dimension: region_name {
  type: string
  description: "Region name for the audience segment"
  sql: LOOKUP(CONCAT(region_id, ''), 'dsp_media_and_bids_region_name') ;;
}
dimension: exchange_rate {
  type: string
  sql: LOOKUP(CONCAT(date_code, ''), 'dsp_media_and_bids_exchange_rate') ;;
}
dimension: li_cpa_goal_mkt_ccy {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_li_cpa_goal_mkt_ccy') ;;
}
dimension: li_cpc_goal_mkt_ccy {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_li_cpc_goal_mkt_ccy') ;;
}
dimension: li_current_budget_mkt_ccy {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_li_current_budget_mkt_ccy') ;;
}
dimension: li_current_budget {
  type: string
  sql: LOOKUP(CONCAT(line_item_id, ''), 'dsp_media_and_bids_li_current_budget') ;;
}
dimension: package_cpa_goal_mkt_ccy {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_package_cpa_goal_mkt_ccy') ;;
}
dimension: package_cpc_goal_mkt_ccy {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_package_cpc_goal_mkt_ccy') ;;
}
dimension: package_current_budget_mkt_ccy {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_package_current_budget_mkt_ccy') ;;
}
dimension: io_cpa_goal_mkt_ccy {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_io_cpa_goal_mkt_ccy') ;;
}
dimension: io_cpc_goal_mkt_ccy {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_io_cpc_goal_mkt_ccy') ;;
}
dimension: io_current_budget_mkt_ccy {
  type: string
  sql: LOOKUP(CONCAT(campaign_id, ''), 'dsp_media_and_bids_io_current_budget_mkt_ccy') ;;
}
dimension: os_type_name {
  type: string
  description: "Name of OS Type"
  sql: LOOKUP(CONCAT(os_type, ''), 'dsp_media_and_bids_os_type_name') ;;
}
dimension: browser_type_name {
  type: string
  description: "Name of Browser Type"
  sql: LOOKUP(CONCAT(browser_type, ''), 'dsp_media_and_bids_browser_type_name') ;;
}

  dimension: supply_source_name {
    type: string
    label: "Supply Source"
    sql: CASE WHEN ${inventory_source_id} = 158 THEN 'Unruly' ELSE 'Other SSP' END ;;
  }

  dimension: service_type_name {
    type: string
    label: "Service Type"
    sql: CASE WHEN ${market_id} in (884, 1792, 2067, 2050, 58, 1637, 577, 1398, 1489, 1677, 2017,
     1781, 1805, 1008, 1051, 1810, 1604, 996, 1090, 961, 923, 1487, 1379, 685, 1431, 2035, 2091,
     1045, 1121, 1477, 1383, 2120, 1636, 2099, 2088, 2111, 1188, 1734) THEN 'Managed'
      WHEN ${market_id} in (2045, 305, 1678, 1183, 2018, 1577, 933, 2058, 1310, 2012, 301,
        658, 1376, 1407, 272, 1576, 1776, 2064, 2087, 927, 3, 141, 999, 1480, 1356, 95, 1393, 2107,
        861, 1472, 1532, 1405, 2101, 2048, 1058, 2014, 2069, 1084, 1120, 1192, 681, 2032, 1079, 1516,
        1608, 175, 2063, 1371, 2117, 1566, 2086, 1069, 2011, 898, 1204, 1380, 1441, 1533, 2034, 2103 ) THEN 'Self-Service'
      WHEN ${market_id} in (1, -1, 59) THEN 'DSP Internal / Defaults'
      WHEN ${market_id} in (1602) THEN 'Managed/self service'
      WHEN ${market_id} in (1144, 1307, 1368, 1606, 1789, 2013, 2039, 2056, 1662, 2125, 2127, 2121,
        2092, 1997, 671, 2129, 1076, 1206, 1416, 1425, 1538, 1570, 1657, 1659, 1676, 1731, 1819, 1972,
        2010, 2057, 2084, 9999) THEN 'Other'
      ELSE 'Unknown' END ;;
  }

  dimension: inventory_src_name {
    type: string
    label: "Inventory Src Name"
    description: "Daily Tracker Unruly dimension"
    sql: CASE WHEN ${inventory_source_id} in (12, 115, 50, 8, 158, 9, 179, 16, 202, 6, 11, 40, 97, 191, 37, 200, 195)
    THEN ${inventory_source_name} ELSE 'Misc Small Volume Exchanges' END ;;
  }

  dimension: inventory_src_id {
    type: number
    label: "Inventory Src ID"
    description: "Daily Tracker Unruly dimension"
    sql: CASE WHEN ${inventory_source_id} in (12, 115, 50, 8, 158, 9, 179, 16, 202, 6, 11, 40, 97, 191, 37, 200, 195) THEN ${inventory_source_id} ELSE 999 END ;;
  }

  dimension: home_market_name1 {
    type: string
    label: "Home Market Name"
    sql: LOOKUP(CONCAT(market_id, ''), 'dsp_media_and_bids_market_name') ;;

  }

  dimension: home_market_name {
    type: string
    label: "Home Market Name_old"
    sql: CASE ${market_id} WHEN 884 THEN 'Amobee, Inc.'
  WHEN 1792 THEN 'Amobee Inc - Western Governors University'
  WHEN 2067 THEN 'Amobee Inc - Crossmedia'
  WHEN 2050 THEN 'Amobee Inc - TheMany'
  WHEN 58 THEN 'The Richards Group'
  WHEN 1602 THEN 'Nebo Agency'
  WHEN 1637 THEN 'Amobee Inc - MVNP'
  WHEN 577 THEN '22squared'
  WHEN 1398 THEN 'VML - Kansas City'
  WHEN 1489 THEN 'Remitly Inc'
  WHEN 1677 THEN 'Marketsmith - Managed'
  WHEN 2017 THEN 'LRXD'
  WHEN 1781 THEN 'Everlywell'
  WHEN 1805 THEN 'BB3 Atlanta'
  WHEN 2045 THEN 'Coegi'
  WHEN 1008 THEN 'Amobee ANZ'
  WHEN 1051 THEN 'Amobee - Singtel'
  WHEN 1810 THEN 'Matterkind - Optus'
  WHEN 1604 THEN 'OMD Apple ISEA'
  WHEN 996 THEN 'Amobee APAC'
  WHEN 1090 THEN 'Amobee PH'
  WHEN 305 THEN 'Matterkind - AU'
  WHEN 1678 THEN 'OMG AU - CHEP - Samsung'
  WHEN 1183 THEN 'OMG - AU'
  WHEN 2018 THEN 'Matterkind - HBF'
  WHEN 1577 THEN 'R1 - Unruly APAC'
  WHEN 933 THEN 'Ikon AU - Advisory'
  WHEN 2058 THEN 'Solv Technology'
  WHEN 1310 THEN 'OMG Singapore'
  WHEN 2012 THEN 'White Labs AU'
  WHEN 301 THEN 'AMNET - ANZ'
  WHEN 658 THEN 'AdGiz Limited Taiwan Branch'
  WHEN 1144 THEN 'Publicis Media APAC_Samsung'
  WHEN 1307 THEN 'OMG Malaysia'
  WHEN 1368 THEN 'Matterkind AU- Nestle'
  WHEN 1606 THEN 'Publicis Media SG Gov_CATA'
  WHEN 1789 THEN 'Amobee APAC - Platform'
  WHEN 2013 THEN 'Audience 360 AU'
  WHEN 2039 THEN 'Publicis Media APAC_WRS'
  WHEN 2056 THEN 'Carat JP'
  WHEN 1 THEN 'Turn'
  WHEN -1 THEN 'Unknown'
  WHEN 59 THEN 'Amobee Demo'
  WHEN 1376 THEN 'Mastercard EMEA'
  WHEN 1407 THEN 'Tesco'
  WHEN 272 THEN 'Cadreon BE'
  WHEN 1576 THEN 'R1 - Unruly EMEA'
  WHEN 1776 THEN 'Tesco Ireland'
  WHEN 961 THEN 'Amobee EMEA'
  WHEN 2064 THEN 'Smartclip ES'
  WHEN 2087 THEN 'Smartclip EU'
  WHEN 923 THEN 'Molson Coors'
  WHEN 1487 THEN 'Amobee Inc - ATV - Managed Service IO'
  WHEN 1379 THEN 'NCC Media'
  WHEN 685 THEN 'Canvas Worldwide'
  WHEN 1431 THEN 'Bath & Body Works'
  WHEN 2035 THEN 'Persuasion Perfected - Managed'
  WHEN 2091 THEN 'IVC Media - Managed'
  WHEN 927 THEN 'Constellation Brands'
  WHEN 3 THEN 'Matterkind'
  WHEN 141 THEN 'TCAA USA'
  WHEN 999 THEN 'Publicis Media Spark Foundry US'
  WHEN 1480 THEN 'Media Assembly'
  WHEN 1356 THEN '22Squared- SS'
  WHEN 95 THEN 'Ebay'
  WHEN 1393 THEN 'Place Exchange'
  WHEN 2107 THEN 'CBI - Brand Team'
  WHEN 861 THEN 'Williams-Sonoma'
  WHEN 1472 THEN 'H&L Partners'
  WHEN 1532 THEN 'Vizio'
  WHEN 1405 THEN 'NCC Media - Self-Serve'
  WHEN 2101 THEN 'Smile Direct Club'
  WHEN 2048 THEN 'Molson Coors - MediaMonks'
  WHEN 1058 THEN 'RhythmOne'
  WHEN 2014 THEN 'Persuasion Perfected'
  WHEN 1045 THEN 'Indeed.Com'
  WHEN 1121 THEN 'Epiphany'
  WHEN 1477 THEN 'Frank Media'
  WHEN 1383 THEN 'Globe - Managed (AdSpark)'
  WHEN 2120 THEN 'Informa'
  WHEN 1636 THEN 'True Agency'
  WHEN 2099 THEN 'AdSpark Non Globe - Managed'
  WHEN 2088 THEN 'Zero Co'
  WHEN 2069 THEN 'Hatched Media'
  WHEN 1084 THEN 'Interplay Media'
  WHEN 1120 THEN 'Jaywing'
  WHEN 1192 THEN 'Publicis Health Media US'
  WHEN 681 THEN 'Dream Nexus Co. Ltd.'
  WHEN 2032 THEN 'Nunn Media - Self-Serve'
  WHEN 1079 THEN 'Pierce Media'
  WHEN 1516 THEN 'Semcasting'
  WHEN 1608 THEN 'ACCSS Digital'
  WHEN 175 THEN 'iBelieve'
  WHEN 2063 THEN 'AdSomeNoise'
  WHEN 1371 THEN 'ACCSS'
  WHEN 2117 THEN 'True Agency - Self-Serve'
  WHEN 1566 THEN 'TMT - Stellar Media'
  WHEN 2086 THEN 'GoWithMedia'
  WHEN 1069 THEN 'Zeta'
  WHEN 1662 THEN 'Digital Tags - Adbreez'
  WHEN 2111 THEN 'Starcom - Managed'
  WHEN 2125 THEN 'Heartbeat - Publicis Managed'
  WHEN 2127 THEN 'Leap Frogger'
  WHEN 2121 THEN 'Heartbeat - Publicis Managed'
  WHEN 2092 THEN 'Neptune Ops - Managed'
  WHEN 2011 THEN 'YouTrumpet'
  WHEN 1997 THEN 'Next Level Online Marketing'
  WHEN 671 THEN 'Online Media Group - India'
  WHEN 2129 THEN 'Leap Frogger'
  WHEN 898 THEN 'Q1 Media Inc'
  WHEN 1076 THEN 'Murmur Group'
  WHEN 1188 THEN 'Walton Isaacson'
  WHEN 1204 THEN 'Publicis Media Starcom US'
  WHEN 1206 THEN 'Hiebing'
  WHEN 1380 THEN 'Mastercard US'
  WHEN 1416 THEN 'Astro Entertainment'
  WHEN 1425 THEN 'Performics - Chicago'
  WHEN 1441 THEN 'Life Time Fitness'
  WHEN 1533 THEN 'Broadbeam (Involved Media)'
  WHEN 1538 THEN 'TMT - IAM Digital'
  WHEN 1570 THEN 'TMT - D-imPULSE'
  WHEN 1657 THEN 'Publicis Media APAC_Adhoc'
  WHEN 1659 THEN 'Publicis Media APAC_Citibank'
  WHEN 1676 THEN 'GroupM - Xaxis SG'
  WHEN 1731 THEN 'Underscore'
  WHEN 1734 THEN 'Molson Coors CA'
  WHEN 1819 THEN 'Totally Awesome'
  WHEN 1972 THEN 'Dream Nexus (Global) - Terminated'
  WHEN 2010 THEN 'Streamlyn - Terminated'
  WHEN 2034 THEN 'IVC Media'
  WHEN 2057 THEN 'Neo US - GroupM'
  WHEN 2084 THEN 'Streamkey'
  WHEN 2103 THEN 'Digital Impact -Self-Serve'
  WHEN 9999 THEN 'Misc Small Volume Markets'
  ELSE 'Misc Small Spend Customers' END ;;
  hidden: yes

  }

  dimension: home_market_id {
    type: number
    label: "Home Market ID"
    sql: CASE WHEN ${market_id} in (861, 884, 927, 1472, 1677, 2067, 1792, 305, 3, 141, 1532, 999,
    923, 1678, 2050, 1487, 1379, 1480, 1405, 58, 1008, 685, 1045, 1602, 2101, 1183, 1356, 2048,
    2069, 2018, 1431, 2017, 1121, 1079, 1058, 1781, 95, 1637, 1577, 2111, 1516, 2014, 1805,
    2045, 577, 1398, 1489, 1051, 301, 1810, 1376, 1407, 272, 1576, 1776) THEN ${market_id} ELSE 9999 END ;;
  }

  dimension: deal_vs_pmp {
    type: string
    label: "Deal vs. PMP"
    sql: CASE WHEN ${deal_type_name} = '' THEN 'Open Auction' ELSE 'PMP' END ;;
  }

  dimension: amobee_business_unit {
    type: string
    label: "Amobee Business Unit"
    sql: CASE WHEN ${market_id} in (884, 1792, 2067, 2050, 58, 1602, 1637, 577, 1398, 1489, 1677, 2017, 1781,
      1805, 2045) THEN 'ACCESS'
      WHEN ${market_id} in (1008, 1051, 1810, 1604, 996, 1090, 305, 1678, 1183, 2018, 1577, 933,
        2058, 1310, 2012, 301, 658, 1144, 1307, 1368, 1606, 1789, 2013, 2039, 2056) THEN 'ANZ & APAC'
      WHEN ${market_id} in (1, -1, 59) THEN 'DSP Internal / Defaults'
      WHEN ${market_id} in (1376, 1407, 272, 1576, 1776, 961, 2064, 2087, 1121, 1636, 1120) THEN 'EMEA'
      WHEN ${market_id} in (923, 1487, 1379, 685, 1431, 2035, 2091, 927, 3, 141, 999, 1480, 1356,
        95, 1393, 2107, 861, 1472, 1532, 1405, 2101, 2048, 1058, 2014, 1045, 2120, 1192, 1516, 1069,
        2111, 2011, 898, 1188, 1204, 1380, 1441, 1533, 1734, 2034, 2103) THEN 'Enterprise'
      WHEN ${market_id} in (1477, 1383, 2099, 2088, 2069, 1084, 681, 2032, 1079, 1608, 175, 2063, 1371,
        2117, 1566, 2086, 1662, 2125, 2127, 2121, 2092, 1997, 671, 2129, 1076, 1206, 1416, 1425, 1538, 1570,
        1657, 1659, 1676, 1731, 1819, 1972, 2010, 2057, 2084, 9999) THEN 'Other' ELSE 'Unknown' END ;;
  }

  measure: unruly_inv_cost {
    type: sum
    label: "Nexxen Inv Cost"
    value_format: "$#,##0"
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}."inv_cost"  ELSE NULL END ;;
  }

  measure: unruly_impression {
    type: sum
    label: "Nexxen Impressions"
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}."impression"  ELSE NULL END ;;
  }

  measure: unruly_adv_spend {
    type: sum
    label: "Nexxen Adv Spend"
    sql: CASE WHEN ${inventory_source_id} = 158 THEN ${TABLE}."cost"  ELSE NULL END ;;
  }

  measure: count {
    type: count
    drill_fields: [iab_category_name, media_channel_name, mobile_app_name]
  }

  parameter: date_granularity {

    label: "Date Granularity Filter (D/W/M/Q/Y)"
    description: "For dynamic Delivery period Granularity. Use with dynamic Dimension Date Granularity"
    type: string
    allowed_value: {value:"Day"}
    allowed_value: {value:"Week"}
    allowed_value: {value:"Month"}
    allowed_value: {value:"Quarter"}
    allowed_value: {value:"Year"}
  }

  dimension: date {
    group_label: "Deliverydate Granularity"
    label: "Deliverydate Granularity"
    description: "For dynamic Delivery period Granularity. Use with Filter Date Granularity"
    #value_format: "%m/%d"
    sql:  CASE
      WHEN {% parameter date_granularity %} = 'Day'
        THEN ${__time_date}
      When {% parameter date_granularity %} ='Week'
        THEN ${__time_week}
      WHEN {% parameter date_granularity %} = 'Month'
        THEN ${__time_month}
      WHEN {% parameter date_granularity %} = 'Quarter'
        THEN ${__time_quarter}
      ELSE NULL
    END ;;

    hidden:  no
  }

  filter: current_date_range {
    type: date
    view_label: "PoP"
    label: "Current Date Range"
    description: "Select the current date range you are interested in. Make sure any other filter on Time covers this period, or is removed."
    sql: ${period} IS NOT NULL ;;
  }

  parameter: compare_to {
    view_label: "PoP"
    description: "Select the templated previous period you would like to compare to. Must be used with Current Date Range filter"
    label: "Compare To:"
    type: unquoted
    allowed_value: {
      label: "Previous Period"
      value: "Period"
    }
    allowed_value: {
      label: "Previous Week"
      value: "Week"
    }
    allowed_value: {
      label: "Previous Month"
      value: "Month"
    }
    allowed_value: {
      label: "Previous Quarter"
      value: "Quarter"
    }
    allowed_value: {
      label: "Previous Year"
      value: "Year"
    }
    default_value: "Period"
  }

## ------------------ HIDDEN HELPER DIMENSIONS  ------------------ ##


  dimension: days_in_period {
    hidden:  yes
    view_label: "PoP"
    description: "Gives the number of days in the current period date range"
    type: number
    sql: TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), CAST({% date_end current_date_range %} AS TIMESTAMP)) ;;
  }

  dimension: period_2_start {
    hidden:  yes
    view_label: "PoP"
    description: "Calculates the start of the previous period"
    type: date
    sql:
            {% if compare_to._parameter_value == "Period" %}
            TIMESTAMPADD(DAY, -${days_in_period}, CAST({% date_start current_date_range %} AS TIMESTAMP))
            {% else %}
            TIMESTAMPADD({% parameter compare_to %}, -1, CAST({% date_start current_date_range %} AS TIMESTAMP))
            {% endif %};;
  }

  dimension: period_2_end {
    hidden:  yes
    view_label: "PoP"
    description: "Calculates the end of the previous period"
    type: date
    sql:
            {% if compare_to._parameter_value == "Period" %}
            TIMESTAMPADD(DAY, -1, CAST({% date_start current_date_range %} AS TIMESTAMP))
            {% else %}
            TIMESTAMPADD({% parameter compare_to %}, -1, TIMESTAMPADD(DAY, -1, CAST({% date_end current_date_range %} AS TIMESTAMP)))
            {% endif %};;
  }

  dimension: day_in_period {
    hidden: yes
    description: "Gives the number of days since the start of each period. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:
        {% if current_date_range._is_filtered %}
            CASE
            WHEN {% condition current_date_range %} ${__time_raw} {% endcondition %}
            THEN TIMESTAMPDIFF(DAY, CAST({% date_start current_date_range %} AS TIMESTAMP), ${__time_date}) + 1
            WHEN ${__time_date} between ${period_2_start} and ${period_2_end}
            THEN TIMESTAMPDIFF(DAY, ${period_2_start}, ${__time_date}) + 1
            END
        {% else %} NULL
        {% endif %}
        ;;
  }

  dimension: order_for_period {
    hidden: yes
    type: number
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${__time_raw} {% endcondition %}
                THEN 1
                WHEN ${__time_date} between ${period_2_start} and ${period_2_end}
                THEN 2
                END
            {% else %}
                NULL
            {% endif %}
            ;;
  }

  ## ------- HIDING FIELDS  FROM ORIGINAL VIEW FILE  -------- ##

  dimension_group: created {hidden: yes}
  dimension: ytd_only {hidden:yes}
  dimension: mtd_only {hidden:yes}
  dimension: wtd_only {hidden:yes}


  ## ------------------ DIMENSIONS TO PLOT ------------------ ##

  dimension_group: date_in_period {
    description: "Use this as your grouping dimension when comparing periods. Aligns the previous periods onto the current period"
    label: "Current Period"
    type: time
    sql: TIMESTAMPADD(DAY, ${day_in_period} - 1, CAST({% date_start current_date_range %} AS TIMESTAMP)) ;;
    view_label: "PoP"
    timeframes: [
      date,
      hour_of_day,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week_of_year,
      month,
      month_name,
      month_num,
      year]
  }


  dimension: period {
    view_label: "PoP"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period' or 'Previous Period'"
    type: string
    hidden: yes
    order_by_field: order_for_period
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${__time_raw} {% endcondition %}
                THEN 'This {% parameter compare_to %}'
                WHEN ${__time_date} between ${period_2_start} and ${period_2_end}
                THEN 'Last {% parameter compare_to %}'
                END
            {% else %}
                NULL
            {% endif %}
            ;;
  }


  ## ---------------------- TO CREATE FILTERED MEASURES ---------------------------- ##

  dimension: period_filtered_measures {
    hidden: yes
    description: "We just use this for the filtered measures"
    type: string
    sql:
            {% if current_date_range._is_filtered %}
                CASE
                WHEN {% condition current_date_range %} ${__time_raw} {% endcondition %} THEN 'this'
                WHEN ${__time_date} between ${period_2_start} and ${period_2_end} THEN 'last' END
            {% else %} NULL {% endif %} ;;
  }

  # Filtered measures

  measure: current_period_inv_cost {
    view_label: "PoP"
    type: sum
    sql: ${TABLE}.inv_cost ;;
    value_format: "$#,##0,\" K\""
    filters: [period_filtered_measures: "this"]
  }

  measure: previous_period_inv_cost {
    view_label: "PoP"
    type: sum
    sql: ${TABLE}.inv_cost ;;
    value_format: "$#,##0,\" K\""
    filters: [period_filtered_measures: "last"]
  }

  measure: inv_cost_pop_change {
    view_label: "PoP"
    label: "Total Inv Cost period-over-period % change"
    type: number
    sql: CASE WHEN ${current_period_inv_cost} = 0
                THEN NULL
                ELSE (1.0 * ${current_period_inv_cost} / NULLIF(${previous_period_inv_cost} ,0)) - 1 END ;;
    value_format_name: percent_2
  }

}
