# The name of this view in Looker is "V Fact Ad Events Daily Agg"
view: v_fact_ad_events_daily_agg {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Fact_Ad_Events_Daily_Agg ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ad Orientation Key" in Explore.

  dimension: ad_orientation_key {
    type: number
    sql: ${TABLE}.Ad_Orientation_Key ;;
  }

  dimension: ad_position_key {
    type: number
    sql: ${TABLE}.Ad_Position_Key ;;
  }

  dimension: app_bundle_key {
    type: number
    sql: ${TABLE}.App_Bundle_Key ;;
  }

  dimension: app_name_key {
    type: number
    sql: ${TABLE}.App_Name_Key ;;
  }

  dimension: app_or_web {
    type: string
    sql: ${TABLE}.App_Or_Web ;;
  }

  dimension: browser_type_key {
    type: number
    sql: ${TABLE}.Browser_Type_Key ;;
  }

  dimension: content_category_key {
    type: number
    sql: ${TABLE}.Content_Category_Key ;;
  }

  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
  }

  dimension: cpa_custom_value_key {
    type: number
    sql: ${TABLE}.CPA_Custom_Value_Key ;;
  }

  dimension: creative_key {
    type: number
    sql: ${TABLE}.Creative_Key ;;
  }

  dimension: creative_type_key {
    type: number
    sql: ${TABLE}.Creative_Type_Key ;;
  }

  dimension: custom_action_key {
    type: number
    sql: ${TABLE}.Custom_Action_Key ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_time_key {
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
    sql: ${TABLE}.DateTime_Key ;;
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.Deal_Key ;;
  }

  dimension: dma_key {
    type: number
    sql: ${TABLE}.DMA_Key ;;
  }

  dimension: domain_key {
    type: number
    sql: ${TABLE}.Domain_Key ;;
  }

  dimension: flight_key {
    type: number
    sql: ${TABLE}.Flight_Key ;;
  }

  dimension: genre_key {
    type: number
    sql: ${TABLE}.Genre_Key ;;
  }

  dimension: is_bid_switch {
    type: yesno
    sql: ${TABLE}.Is_BidSwitch ;;
  }

  dimension: network_key {
    type: number
    sql: ${TABLE}.Network_Key ;;
  }

  dimension: os_key {
    type: number
    sql: ${TABLE}.OS_Key ;;
  }

  dimension: product_type_key {
    type: number
    sql: ${TABLE}.Product_Type_Key ;;
  }

  dimension: rtb_app_key {
    type: number
    sql: ${TABLE}.RTB_App_Key ;;
  }

  dimension: rtb_media_key {
    type: number
    sql: ${TABLE}.RTB_Media_Key ;;
  }

  dimension: rtb_publisher_key {
    type: number
    sql: ${TABLE}.RTB_Publisher_Key ;;
  }

  dimension: rtb_site_name_key {
    type: number
    sql: ${TABLE}.RTB_Site_Name_Key ;;
  }

  dimension: screen_type_key {
    type: number
    sql: ${TABLE}.Screen_Type_Key ;;
  }

  dimension: ssp_key {
    type: number
    sql: ${TABLE}.SSP_Key ;;
  }

  dimension: sum_of_bids_lost {
    type: number
    sql: ${TABLE}.sum_of_Bids_Lost ;;
  }

  dimension: sum_of_bids_made {
    type: number
    sql: ${TABLE}.sum_of_Bids_Made ;;
  }

  dimension: sum_of_bids_made_amount {
    type: number
    sql: ${TABLE}.sum_of_Bids_Made_Amount ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sum_of_bids_made_amount {
    type: sum
    sql: ${sum_of_bids_made_amount} ;;
  }

  measure: average_sum_of_bids_made_amount {
    type: average
    sql: ${sum_of_bids_made_amount} ;;
  }

  dimension: sum_of_bids_won {
    type: number
    sql: ${TABLE}.sum_of_Bids_Won ;;
  }

  dimension: sum_of_campaign_reach {
    type: number
    sql: ${TABLE}.sum_of_Campaign_Reach ;;
  }

  dimension: sum_of_clicks {
    type: number
    sql: ${TABLE}.sum_of_Clicks ;;
  }

  dimension: sum_of_completions {
    type: number
    sql: ${TABLE}.sum_of_Completions ;;
  }

  dimension: sum_of_completions_viewable {
    type: number
    sql: ${TABLE}.sum_of_Completions_Viewable ;;
  }

  dimension: sum_of_conversions {
    type: number
    sql: ${TABLE}.sum_of_Conversions ;;
  }

  dimension: sum_of_cost_agency {
    type: number
    sql: ${TABLE}.sum_of_Cost_Agency ;;
  }

  dimension: sum_of_cost_data {
    type: number
    sql: ${TABLE}.sum_of_Cost_Data ;;
  }

  dimension: sum_of_cost_inventory {
    type: number
    sql: ${TABLE}.sum_of_Cost_Inventory ;;
  }

  dimension: sum_of_cost_partner {
    type: number
    sql: ${TABLE}.sum_of_Cost_Partner ;;
  }

  dimension: sum_of_cost_platform {
    type: number
    sql: ${TABLE}.sum_of_Cost_Platform ;;
  }

  dimension: sum_of_cost_third_party {
    type: number
    sql: ${TABLE}.sum_of_Cost_ThirdParty ;;
  }

  dimension: sum_of_custom_overlay_impression {
    type: number
    sql: ${TABLE}.sum_of_Custom_Overlay_Impression ;;
  }

  dimension: sum_of_demo_impressions {
    type: number
    sql: ${TABLE}.sum_of_Demo_Impressions ;;
  }

  dimension: sum_of_engagements {
    type: number
    sql: ${TABLE}.sum_of_Engagements ;;
  }

  dimension: sum_of_engagements_rollover {
    type: number
    sql: ${TABLE}.sum_of_Engagements_Rollover ;;
  }

  dimension: sum_of_fill_attempts {
    type: number
    sql: ${TABLE}.sum_of_Fill_Attempts ;;
  }

  dimension: sum_of_focus {
    type: number
    sql: ${TABLE}.sum_of_Focus ;;
  }

  dimension: sum_of_gross_revenue {
    type: number
    sql: ${TABLE}.sum_of_Gross_Revenue ;;
  }

  dimension: sum_of_impressions {
    type: number
    sql: ${TABLE}.sum_of_Impressions ;;
  }

  dimension: sum_of_impressions_clickable {
    type: number
    sql: ${TABLE}.sum_of_Impressions_Clickable ;;
  }

  dimension: sum_of_impressions_companion {
    type: number
    sql: ${TABLE}.sum_of_Impressions_Companion ;;
  }

  dimension: sum_of_impressions_companion_available {
    type: number
    sql: ${TABLE}.sum_of_Impressions_Companion_Available ;;
  }

  dimension: sum_of_impressions_viewability_known {
    type: number
    sql: ${TABLE}.sum_of_Impressions_Viewability_Known ;;
  }

  dimension: sum_of_impressions_viewable {
    type: number
    sql: ${TABLE}.sum_of_Impressions_Viewable ;;
  }

  dimension: sum_of_max_duration {
    type: number
    sql: ${TABLE}.sum_of_Max_Duration ;;
  }

  dimension: sum_of_min_duration {
    type: number
    sql: ${TABLE}.sum_of_Min_Duration ;;
  }

  dimension: sum_of_placement_reach {
    type: number
    sql: ${TABLE}.sum_of_Placement_Reach ;;
  }

  dimension: sum_of_player_size_detected {
    type: number
    sql: ${TABLE}.sum_of_Player_Size_Detected ;;
  }

  dimension: sum_of_player_size_passed {
    type: number
    sql: ${TABLE}.sum_of_Player_Size_Passed ;;
  }

  dimension: sum_of_progress0 {
    type: number
    sql: ${TABLE}.sum_of_Progress0 ;;
  }

  dimension: sum_of_progress100 {
    type: number
    sql: ${TABLE}.sum_of_Progress100 ;;
  }

  dimension: sum_of_progress25 {
    type: number
    sql: ${TABLE}.sum_of_Progress25 ;;
  }

  dimension: sum_of_progress50 {
    type: number
    sql: ${TABLE}.sum_of_Progress50 ;;
  }

  dimension: sum_of_progress75 {
    type: number
    sql: ${TABLE}.sum_of_Progress75 ;;
  }

  dimension: sum_of_requests {
    type: number
    sql: ${TABLE}.sum_of_Requests ;;
  }

  dimension: sum_of_revenue {
    type: number
    sql: ${TABLE}.sum_of_Revenue ;;
  }

  dimension: sum_of_site_fraud_ias_fee {
    type: number
    sql: ${TABLE}.sum_of_Site_Fraud_IAS_Fee ;;
  }

  dimension: sum_of_third_party_fees {
    type: number
    sql: ${TABLE}.sum_of_Third_Party_Fees ;;
  }

  dimension: sum_of_third_party_viewable_impression_fee {
    type: number
    sql: ${TABLE}.sum_of_Third_Party_Viewable_Impression_Fee ;;
  }

  dimension: sum_of_time_spent {
    type: number
    sql: ${TABLE}.sum_of_Time_Spent ;;
  }

  dimension: sum_of_time_spent_active {
    type: number
    sql: ${TABLE}.sum_of_Time_Spent_Active ;;
  }

  dimension: sum_of_time_spent_passive {
    type: number
    sql: ${TABLE}.sum_of_Time_Spent_Passive ;;
  }

  dimension: sum_of_total_dmp_fees {
    type: number
    sql: ${TABLE}.sum_of_Total_DMP_Fees ;;
  }

  dimension: sum_of_total_partner_fees {
    type: number
    sql: ${TABLE}.sum_of_Total_Partner_Fees ;;
  }

  dimension: sum_of_viewability {
    type: number
    sql: ${TABLE}.sum_of_Viewability ;;
  }

  dimension: sum_of_win_price {
    type: number
    sql: ${TABLE}.sum_of_Win_Price ;;
  }

  dimension: video_type_key {
    type: number
    sql: ${TABLE}.Video_Type_Key ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
