view: social_media {
  sql_table_name: druid.social_media ;;

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

  dimension: account_id {
    type: string
    sql: ${TABLE}."account_id" ;;
  }

  dimension: ad_id {
    type: string
    sql: ${TABLE}."ad_id" ;;
  }

  measure: add_payment_info {
    type: sum
    sql: ${TABLE}."add_payment_info" ;;
  }

  measure: add_to_cart {
    type: sum
    sql: ${TABLE}."add_to_cart" ;;
  }

  measure: add_to_wishlist {
    type: sum
    sql: ${TABLE}."add_to_wishlist" ;;
  }

  dimension: adset_id {
    type: string
    sql: ${TABLE}."adset_id" ;;
  }

  dimension: advertiser_id {
    type: string
    sql: ${TABLE}."advertiser_id" ;;
  }

  measure: android_installs {
    type: sum
    sql: ${TABLE}."android_installs" ;;
  }

  measure: app_clicks {
    type: sum
    sql: ${TABLE}."app_clicks" ;;
  }

  measure: app_installs {
    type: sum
    sql: ${TABLE}."app_installs" ;;
  }

  measure: attachment_total_view_time_millis {
    type: sum
    sql: ${TABLE}."attachment_total_view_time_millis" ;;
  }

  measure: attachment_view_completions {
    type: sum
    sql: ${TABLE}."attachment_view_completions" ;;
  }

  measure: attachments_quartile_25 {
    type: sum
    sql: ${TABLE}."attachments_quartile_25" ;;
  }

  measure: attachments_quartile_50 {
    type: sum
    sql: ${TABLE}."attachments_quartile_50" ;;
  }

  measure: attachments_quartile_75 {
    type: sum
    sql: ${TABLE}."attachments_quartile_75" ;;
  }

  measure: billed_engagements {
    type: sum
    sql: ${TABLE}."billed_engagements" ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}."campaign_id" ;;
  }

  measure: card_engagements {
    type: sum
    sql: ${TABLE}."card_engagements" ;;
  }

  measure: checkins {
    type: sum
    sql: ${TABLE}."checkins" ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}."clicks" ;;
  }

  measure: clicks_to_website {
    type: sum
    sql: ${TABLE}."clicks_to_website" ;;
  }

  measure: complete_registrations {
    type: sum
    sql: ${TABLE}."complete_registrations" ;;
  }

  measure: earned_clicks {
    type: sum
    sql: ${TABLE}."earned_clicks" ;;
  }

  measure: earned_closeups {
    type: sum
    sql: ${TABLE}."earned_closeups" ;;
  }

  measure: earned_impressions {
    type: sum
    sql: ${TABLE}."earned_impressions" ;;
  }

  measure: earned_link_clicks {
    type: sum
    sql: ${TABLE}."earned_link_clicks" ;;
  }

  measure: earned_saves {
    type: sum
    sql: ${TABLE}."earned_saves" ;;
  }

  measure: earned_video_mrc_views {
    type: sum
    sql: ${TABLE}."earned_video_mrc_views" ;;
  }

  measure: engagements {
    type: sum
    sql: ${TABLE}."engagements" ;;
  }

  measure: event_responses {
    type: sum
    sql: ${TABLE}."event_responses" ;;
  }

  measure: follows {
    type: sum
    sql: ${TABLE}."follows" ;;
  }

  measure: game_plays {
    type: sum
    sql: ${TABLE}."game_plays" ;;
  }

  measure: gift_sales {
    type: sum
    sql: ${TABLE}."gift_sales" ;;
  }

  measure: impression1 {
    type: sum
    sql: ${TABLE}."impression1" ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}."impressions" ;;
  }

  measure: initiate_checkouts {
    type: sum
    sql: ${TABLE}."initiate_checkouts" ;;
  }

  measure: inline_link_click_ctr {
    type: sum
    sql: ${TABLE}."inline_link_click_ctr" ;;
  }

  measure: inline_link_clicks {
    type: sum
    sql: ${TABLE}."inline_link_clicks" ;;
  }

  measure: ios_installs {
    type: sum
    sql: ${TABLE}."ios_installs" ;;
  }

  measure: landing_page_views {
    type: sum
    sql: ${TABLE}."landing_page_views" ;;
  }

  measure: leads {
    type: sum
    sql: ${TABLE}."leads" ;;
  }

  measure: likes {
    type: sum
    sql: ${TABLE}."likes" ;;
  }

  measure: link_clicks {
    type: sum
    sql: ${TABLE}."link_clicks" ;;
  }

  dimension: market_id {
    type: string
    sql: ${TABLE}."market_id" ;;
  }

  measure: media_engagements {
    type: sum
    sql: ${TABLE}."media_engagements" ;;
  }

  measure: media_views {
    type: sum
    sql: ${TABLE}."media_views" ;;
  }

  measure: mobile_app_installs {
    type: sum
    sql: ${TABLE}."mobile_app_installs" ;;
  }

  measure: onsite_checkouts {
    type: sum
    sql: ${TABLE}."onsite_checkouts" ;;
  }

  measure: onsite_checkouts_cpa_billable {
    type: sum
    sql: ${TABLE}."onsite_checkouts_cpa_billable" ;;
  }

  measure: onsite_checkouts_value {
    type: sum
    sql: ${TABLE}."onsite_checkouts_value" ;;
  }

  measure: onsite_leads {
    type: sum
    sql: ${TABLE}."onsite_leads" ;;
  }

  measure: outbound_clicks {
    type: sum
    sql: ${TABLE}."outbound_clicks" ;;
  }

  measure: page_engagements {
    type: sum
    sql: ${TABLE}."page_engagements" ;;
  }

  measure: page_likes {
    type: sum
    sql: ${TABLE}."page_likes" ;;
  }

  measure: paid_closeups {
    type: sum
    sql: ${TABLE}."paid_closeups" ;;
  }

  measure: paid_impressions {
    type: sum
    sql: ${TABLE}."paid_impressions" ;;
  }

  measure: paid_saves {
    type: sum
    sql: ${TABLE}."paid_saves" ;;
  }

  measure: photo_views {
    type: sum
    sql: ${TABLE}."photo_views" ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}."platform" ;;
  }

  measure: post_comments {
    type: sum
    sql: ${TABLE}."post_comments" ;;
  }

  measure: post_engagements {
    type: sum
    sql: ${TABLE}."post_engagements" ;;
  }

  measure: post_reactions {
    type: sum
    sql: ${TABLE}."post_reactions" ;;
  }

  measure: post_shares {
    type: sum
    sql: ${TABLE}."post_shares" ;;
  }

  measure: purchase_value {
    type: sum
    sql: ${TABLE}."purchase_value" ;;
  }

  measure: purchases {
    type: sum
    sql: ${TABLE}."purchases" ;;
  }

  measure: qualified_impressions {
    type: sum
    sql: ${TABLE}."qualified_impressions" ;;
  }

  measure: replies {
    type: sum
    sql: ${TABLE}."replies" ;;
  }

  measure: retweets {
    type: sum
    sql: ${TABLE}."retweets" ;;
  }

  measure: saves {
    type: sum
    sql: ${TABLE}."saves" ;;
  }

  measure: screen_time_millis {
    type: sum
    sql: ${TABLE}."screen_time_millis" ;;
  }

  measure: searches {
    type: sum
    sql: ${TABLE}."searches" ;;
  }

  measure: shares {
    type: sum
    sql: ${TABLE}."shares" ;;
  }

  measure: social_clicks {
    type: sum
    sql: ${TABLE}."social_clicks" ;;
  }

  measure: social_impressions {
    type: sum
    sql: ${TABLE}."social_impressions" ;;
  }

  measure: spend {
    type: sum
    sql: ${TABLE}."spend" ;;
  }

  measure: store_visit_actions {
    type: sum
    sql: ${TABLE}."store_visit_actions" ;;
  }

  measure: story_completes {
    type: sum
    sql: ${TABLE}."story_completes" ;;
  }

  measure: story_opens {
    type: sum
    sql: ${TABLE}."story_opens" ;;
  }

  measure: swipes {
    type: sum
    sql: ${TABLE}."swipes" ;;
  }

  measure: thruplays {
    type: sum
    sql: ${TABLE}."thruplays" ;;
  }

  measure: total_action_value {
    type: sum
    sql: ${TABLE}."total_action_value" ;;
  }

  measure: total_actions {
    type: sum
    sql: ${TABLE}."total_actions" ;;
  }

  measure: total_click_add_to_cart {
    type: sum
    sql: ${TABLE}."total_click_add_to_cart" ;;
  }

  measure: total_click_add_to_cart_quantity {
    type: sum
    sql: ${TABLE}."total_click_add_to_cart_quantity" ;;
  }

  measure: total_click_add_to_cart_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_click_add_to_cart_value_in_micro_dollar" ;;
  }

  measure: total_click_checkout {
    type: sum
    sql: ${TABLE}."total_click_checkout" ;;
  }

  measure: total_click_checkout_quantity {
    type: sum
    sql: ${TABLE}."total_click_checkout_quantity" ;;
  }

  dimension: total_click_checkout_value_in_micro_dollar {
    type: number
    sql: ${TABLE}."total_click_checkout_value_in_micro_dollar" ;;
  }

  measure: total_click_custom {
    type: sum
    sql: ${TABLE}."total_click_custom" ;;
  }

  measure: total_click_custom_quantity {
    type: sum
    sql: ${TABLE}."total_click_custom_quantity" ;;
  }

  measure: total_click_custom_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_click_custom_value_in_micro_dollar" ;;
  }

  measure: total_click_lead {
    type: sum
    sql: ${TABLE}."total_click_lead" ;;
  }

  measure: total_click_lead_quantity {
    type: sum
    sql: ${TABLE}."total_click_lead_quantity" ;;
  }

  measure: total_click_lead_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_click_lead_value_in_micro_dollar" ;;
  }

  measure: total_click_page_visit {
    type: sum
    sql: ${TABLE}."total_click_page_visit" ;;
  }

  measure: total_click_page_visit_quantity {
    type: sum
    sql: ${TABLE}."total_click_page_visit_quantity" ;;
  }

  measure: total_click_page_visit_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_click_page_visit_value_in_micro_dollar" ;;
  }

  measure: total_click_search {
    type: sum
    sql: ${TABLE}."total_click_search" ;;
  }

  measure: total_click_search_quantity {
    type: sum
    sql: ${TABLE}."total_click_search_quantity" ;;
  }

  measure: total_click_search_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_click_search_value_in_micro_dollar" ;;
  }

  measure: total_click_signup {
    type: sum
    sql: ${TABLE}."total_click_signup" ;;
  }

  measure: total_click_signup_quantity {
    type: sum
    sql: ${TABLE}."total_click_signup_quantity" ;;
  }

  measure: total_click_signup_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_click_signup_value_in_micro_dollar" ;;
  }

  measure: total_click_view_category {
    type: sum
    sql: ${TABLE}."total_click_view_category" ;;
  }

  measure: total_click_view_category_quantity {
    type: sum
    sql: ${TABLE}."total_click_view_category_quantity" ;;
  }

  measure: total_click_view_category_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_click_view_category_value_in_micro_dollar" ;;
  }

  measure: total_click_watch_video {
    type: sum
    sql: ${TABLE}."total_click_watch_video" ;;
  }

  measure: total_click_watch_video_quantity {
    type: sum
    sql: ${TABLE}."total_click_watch_video_quantity" ;;
  }

  measure: total_click_watch_video_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_click_watch_video_value_in_micro_dollar" ;;
  }

  measure: total_conversions {
    type: sum
    sql: ${TABLE}."total_conversions" ;;
  }

  measure: total_conversions_quantity {
    type: sum
    sql: ${TABLE}."total_conversions_quantity" ;;
  }

  measure: total_conversions_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_conversions_value_in_micro_dollar" ;;
  }

  measure: total_engagement_add_to_cart {
    type: sum
    sql: ${TABLE}."total_engagement_add_to_cart" ;;
  }

  measure: total_engagement_add_to_cart_quantity {
    type: sum
    sql: ${TABLE}."total_engagement_add_to_cart_quantity" ;;
  }

  measure: total_engagement_add_to_cart_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_engagement_add_to_cart_value_in_micro_dollar" ;;
  }

  measure: total_engagement_checkout {
    type: sum
    sql: ${TABLE}."total_engagement_checkout" ;;
  }

  measure: total_engagement_checkout_quantity {
    type: sum
    sql: ${TABLE}."total_engagement_checkout_quantity" ;;
  }

  measure: total_engagement_checkout_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_engagement_checkout_value_in_micro_dollar" ;;
  }

  measure: total_engagement_custom {
    type: sum
    sql: ${TABLE}."total_engagement_custom" ;;
  }

  measure: total_engagement_custom_quantity {
    type: sum
    sql: ${TABLE}."total_engagement_custom_quantity" ;;
  }

  measure: total_engagement_custom_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_engagement_custom_value_in_micro_dollar" ;;
  }

  measure: total_engagement_lead {
    type: sum
    sql: ${TABLE}."total_engagement_lead" ;;
  }

  measure: total_engagement_lead_quantity {
    type: sum
    sql: ${TABLE}."total_engagement_lead_quantity" ;;
  }

  measure: total_engagement_lead_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_engagement_lead_value_in_micro_dollar" ;;
  }

  measure: total_engagement_page_visit {
    type: sum
    sql: ${TABLE}."total_engagement_page_visit" ;;
  }

  measure: total_engagement_page_visit_quantity {
    type: sum
    sql: ${TABLE}."total_engagement_page_visit_quantity" ;;
  }

  measure: total_engagement_page_visit_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_engagement_page_visit_value_in_micro_dollar" ;;
  }

  measure: total_engagement_search {
    type: sum
    sql: ${TABLE}."total_engagement_search" ;;
  }

  measure: total_engagement_search_quantity {
    type: sum
    sql: ${TABLE}."total_engagement_search_quantity" ;;
  }

  measure: total_engagement_search_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_engagement_search_value_in_micro_dollar" ;;
  }

  measure: total_engagement_signup {
    type: sum
    sql: ${TABLE}."total_engagement_signup" ;;
  }

  measure: total_engagement_signup_quantity {
    type: sum
    sql: ${TABLE}."total_engagement_signup_quantity" ;;
  }

  measure: total_engagement_signup_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_engagement_signup_value_in_micro_dollar" ;;
  }

  measure: total_engagement_view_category {
    type: sum
    sql: ${TABLE}."total_engagement_view_category" ;;
  }

  measure: total_engagement_view_category_quantity {
    type: sum
    sql: ${TABLE}."total_engagement_view_category_quantity" ;;
  }

  measure: total_engagement_view_category_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_engagement_view_category_value_in_micro_dollar" ;;
  }

  measure: total_engagement_watch_video {
    type: sum
    sql: ${TABLE}."total_engagement_watch_video" ;;
  }

  measure: total_engagement_watch_video_quantity {
    type: sum
    sql: ${TABLE}."total_engagement_watch_video_quantity" ;;
  }

  measure: total_engagement_watch_video_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_engagement_watch_video_value_in_micro_dollar" ;;
  }

  measure: total_view_add_to_cart {
    type: sum
    sql: ${TABLE}."total_view_add_to_cart" ;;
  }

  measure: total_view_add_to_cart_quantity {
    type: sum
    sql: ${TABLE}."total_view_add_to_cart_quantity" ;;
  }

  measure: total_view_add_to_cart_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_view_add_to_cart_value_in_micro_dollar" ;;
  }

  measure: total_view_checkout {
    type: sum
    sql: ${TABLE}."total_view_checkout" ;;
  }

  measure: total_view_checkout_quantity {
    type: sum
    sql: ${TABLE}."total_view_checkout_quantity" ;;
  }

  measure: total_view_checkout_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_view_checkout_value_in_micro_dollar" ;;
  }

  measure: total_view_custom {
    type: sum
    sql: ${TABLE}."total_view_custom" ;;
  }

  measure: total_view_custom_quantity {
    type: sum
    sql: ${TABLE}."total_view_custom_quantity" ;;
  }

  measure: total_view_custom_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_view_custom_value_in_micro_dollar" ;;
  }

  measure: total_view_lead {
    type: sum
    sql: ${TABLE}."total_view_lead" ;;
  }

  measure: total_view_lead_quantity {
    type: sum
    sql: ${TABLE}."total_view_lead_quantity" ;;
  }

  measure: total_view_lead_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_view_lead_value_in_micro_dollar" ;;
  }

  measure: total_view_page_visit {
    type: sum
    sql: ${TABLE}."total_view_page_visit" ;;
  }

  measure: total_view_page_visit_quantity {
    type: sum
    sql: ${TABLE}."total_view_page_visit_quantity" ;;
  }

  measure: total_view_page_visit_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_view_page_visit_value_in_micro_dollar" ;;
  }

  measure: total_view_search {
    type: sum
    sql: ${TABLE}."total_view_search" ;;
  }

  measure: total_view_search_quantity {
    type: sum
    sql: ${TABLE}."total_view_search_quantity" ;;
  }

  measure: total_view_search_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_view_search_value_in_micro_dollar" ;;
  }

  measure: total_view_signup {
    type: sum
    sql: ${TABLE}."total_view_signup" ;;
  }

  measure: total_view_signup_quantity {
    type: sum
    sql: ${TABLE}."total_view_signup_quantity" ;;
  }

  measure: total_view_signup_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_view_signup_value_in_micro_dollar" ;;
  }

  measure: total_view_view_category {
    type: sum
    sql: ${TABLE}."total_view_view_category" ;;
  }

  measure: total_view_view_category_quantity {
    type: sum
    sql: ${TABLE}."total_view_view_category_quantity" ;;
  }

  measure: total_view_view_category_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_view_view_category_value_in_micro_dollar" ;;
  }

  measure: total_view_watch_video {
    type: sum
    sql: ${TABLE}."total_view_watch_video" ;;
  }

  measure: total_view_watch_video_quantity {
    type: sum
    sql: ${TABLE}."total_view_watch_video_quantity" ;;
  }

  measure: total_view_watch_video_value_in_micro_dollar {
    type: sum
    sql: ${TABLE}."total_view_watch_video_value_in_micro_dollar" ;;
  }

  measure: video_content_starts {
    type: sum
    sql: ${TABLE}."video_content_starts" ;;
  }

  measure: video_cta_clicks {
    type: sum
    sql: ${TABLE}."video_cta_clicks" ;;
  }

  measure: video_p100_complete2 {
    type: sum
    sql: ${TABLE}."video_p100_complete2" ;;
  }

  measure: video_p100_watched {
    type: sum
    sql: ${TABLE}."video_p100_watched" ;;
  }

  measure: video_p25_combined2 {
    type: sum
    sql: ${TABLE}."video_p25_combined2" ;;
  }

  measure: video_p25_watched_actions {
    type: sum
    sql: ${TABLE}."video_p25_watched_actions" ;;
  }

  measure: video_p50_combined2 {
    type: sum
    sql: ${TABLE}."video_p50_combined2" ;;
  }

  measure: video_p50_watched_actions {
    type: sum
    sql: ${TABLE}."video_p50_watched_actions" ;;
  }

  measure: video_p75_combined2 {
    type: sum
    sql: ${TABLE}."video_p75_combined2" ;;
  }

  measure: video_p75_watched_actions {
    type: sum
    sql: ${TABLE}."video_p75_watched_actions" ;;
  }

  measure: video_p95_combined2 {
    type: sum
    sql: ${TABLE}."video_p95_combined2" ;;
  }

  measure: video_p95_watched_actions {
    type: sum
    sql: ${TABLE}."video_p95_watched_actions" ;;
  }

  measure: video_thruplay_watched_actions {
    type: sum
    sql: ${TABLE}."video_thruplay_watched_actions" ;;
  }

  measure: video_views_2_sec {
    type: sum
    sql: ${TABLE}."video_views_2_sec" ;;
  }

  measure: video_views_3_sec {
    type: sum
    sql: ${TABLE}."video_views_3_sec" ;;
  }

  measure: view_content {
    type: sum
    sql: ${TABLE}."view_content" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  dimension: market_name {
    type: string
    sql: LOOKUP(CONCAT(market_id, ''), 'social_media_market_name') ;;
  }
  dimension: advertiser_name {
    type: string
    sql: LOOKUP(CONCAT(advertiser_id, ''), 'social_media_advertiser_name') ;;
  }
  dimension: account_name {
    type: string
    sql: LOOKUP(CONCAT(account_id, ''), 'social_media_account_name') ;;
  }
  dimension: currency {
    type: string
    sql: LOOKUP(CONCAT(account_id, ''), 'social_media_currency') ;;
  }
  dimension: timezone_name {
    type: string
    sql: LOOKUP(CONCAT(account_id, ''), 'social_media_timezone_name') ;;
  }
  dimension: campaign_name {
    type: string
    sql: LOOKUP(CONCAT(campaign_id, ''), 'social_media_campaign_name') ;;
  }
  dimension: adset_name {
    type: string
    sql: LOOKUP(CONCAT(adset_id, ''), 'social_media_adset_name') ;;
  }
  dimension: ad_name {
    type: string
    sql: LOOKUP(CONCAT(ad_id, ''), 'social_media_ad_name') ;;
  }
  dimension: creative_name {
    type: string
    sql: LOOKUP(CONCAT(creative_id, ''), 'social_media_creative_name') ;;
  }
  dimension: creative_image_url {
    type: string
    sql: LOOKUP(CONCAT(creative_id, ''), 'social_media_creative_image_url') ;;
  }
  dimension: creative_title {
    type: string
    sql: LOOKUP(CONCAT(creative_id, ''), 'social_media_creative_title') ;;
  }
  dimension: creative_body {
    type: string
    sql: LOOKUP(CONCAT(creative_id, ''), 'social_media_creative_body') ;;
  }
  dimension: call_to_action_type {
    type: string
    sql: LOOKUP(CONCAT(creative_id, ''), 'social_media_call_to_action_type') ;;
  }
  dimension: funding_instrument_name {
    type: string
    sql: LOOKUP(CONCAT(funding_instrument_id, ''), 'social_media_funding_instrument_name') ;;
  }
}
