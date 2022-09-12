# The name of this view in Looker is "V Fact Ad Events Hourly Agg"
view: v_fact_ad_events_hourly_agg {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Fact_Ad_Events_Hourly_Agg ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ad Orientation Key" in Explore.

  dimension: ad_orientation_key {
    type: number
    sql: ${TABLE}.Ad_Orientation_Key ;;
    hidden: yes
  }

  dimension: ad_position_key {
    type: number
    sql: ${TABLE}.Ad_Position_Key ;;
    hidden: yes
  }

  dimension: app_bundle_key {
    type: number
    sql: ${TABLE}.App_Bundle_Key ;;
    hidden: yes
  }

  dimension: app_name_key {
    type: number
    sql: ${TABLE}.App_Name_Key ;;
    hidden: yes
  }

  dimension: app_or_web {
    type: string
    sql: ${TABLE}.App_Or_Web ;;
  }

  dimension: browser_type_key {
    type: number
    sql: ${TABLE}.Browser_Type_Key ;;
    hidden: yes
  }

  dimension: content_category_key {
    type: number
    sql: ${TABLE}.Content_Category_Key ;;
    hidden: yes
  }

  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
    hidden: yes
  }

  dimension: cpa_custom_value_key {
    type: number
    sql: ${TABLE}.CPA_Custom_Value_Key ;;
    hidden: yes
  }

  dimension: creative_key {
    type: number
    sql: ${TABLE}.Creative_Key ;;
    hidden: yes
  }

  dimension: creative_type_key {
    type: number
    sql: ${TABLE}.Creative_Type_Key ;;
    hidden: yes
  }

  dimension: custom_action_key {
    type: number
    sql: ${TABLE}.Custom_Action_Key ;;
    hidden: yes
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension: date_time_key {
    type: date
    sql: ${TABLE}.DateTime_Key ;;
    hidden: yes
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.Deal_Key ;;
    hidden: yes
  }

  dimension: dma_key {
    type: number
    sql: ${TABLE}.DMA_Key ;;
    hidden: yes
  }

  dimension: domain_key {
    type: number
    sql: ${TABLE}.Domain_Key ;;
    hidden: yes
  }

  dimension: flight_key {
    type: number
    sql: ${TABLE}.Flight_Key ;;
    hidden: yes
  }

  dimension: genre_key {
    type: number
    sql: ${TABLE}.Genre_Key ;;
    hidden: yes
  }

  dimension: is_bid_switch {
    type: yesno
    sql: ${TABLE}.Is_BidSwitch ;;
  }

  dimension: network_key {
    type: number
    sql: ${TABLE}.Network_Key ;;
    hidden: yes
  }

  dimension: os_key {
    type: number
    sql: ${TABLE}.OS_Key ;;
    hidden: yes
  }

  dimension: product_type_key {
    type: number
    sql: ${TABLE}.Product_Type_Key ;;
    hidden: yes
  }

  dimension: rtb_app_key {
    type: number
    sql: ${TABLE}.RTB_App_Key ;;
    hidden: yes
  }

  dimension: rtb_media_key {
    type: number
    sql: ${TABLE}.RTB_Media_Key ;;
    hidden: yes
  }

  dimension: rtb_publisher_key {
    type: number
    sql: ${TABLE}.RTB_Publisher_Key ;;
    hidden: yes
  }

  dimension: rtb_site_name_key {
    type: number
    sql: ${TABLE}.RTB_Site_Name_Key ;;
    hidden: yes
  }

  dimension: screen_type_key {
    type: number
    sql: ${TABLE}.Screen_Type_Key ;;
    hidden: yes
  }

  dimension: ssp_key {
    type: number
    sql: ${TABLE}.SSP_Key ;;
    hidden: yes
  }

  measure: sum_of_bids_lost {
    type: sum
    label: "Bids Lost"
    sql: ${TABLE}.sum_of_Bids_Lost ;;
  }

  measure: sum_of_bids_made {
    type: sum
    label: "Bids Made"
    sql: ${TABLE}.sum_of_Bids_Made ;;
  }

  measure: sum_of_bids_made_amount {
    type: sum
    label: "Bids Made Amount"
    sql: ${TABLE}.sum_of_Bids_Made_Amount ;;
  }

  measure: sum_of_bids_won {
    type: sum
    label: "Bids Won"
    sql: ${TABLE}.sum_of_Bids_Won ;;
  }

  measure: sum_of_campaign_reach {
    type: sum
    label: "Campaign Reach"
    sql: ${TABLE}.sum_of_Campaign_Reach ;;
  }

  measure: sum_of_clicks {
    type: sum
    label: "Clicks"
    sql: ${TABLE}.sum_of_Clicks ;;
  }

  measure: sum_of_completions {
    type: sum
    label: "Completions"
    sql: ${TABLE}.sum_of_Completions ;;
  }

  measure: sum_of_completions_viewable {
    type: sum
    label: "Completions Viewable"
    sql: ${TABLE}.sum_of_Completions_Viewable ;;
  }

  measure: sum_of_conversions {
    type: sum
    label: "Conversions"
    sql: ${TABLE}.sum_of_Conversions ;;
  }

  measure: sum_of_cost_agency {
    type: sum
    label: "Cost Agency"
    sql: ${TABLE}.sum_of_Cost_Agency ;;
  }

  measure: sum_of_cost_data {
    type: sum
    label: "Cost Data"
    sql: ${TABLE}.sum_of_Cost_Data ;;
  }

  measure: sum_of_cost_inventory {
    type: sum
    label: "Cost Inventory"
    sql: ${TABLE}.sum_of_Cost_Inventory ;;
  }

  measure: sum_of_cost_partner {
    type: sum
    label: "Cost Partner"
    sql: ${TABLE}.sum_of_Cost_Partner ;;
  }

  measure: sum_of_cost_platform {
    type: sum
    label: "Cost Platform"
    sql: ${TABLE}.sum_of_Cost_Platform ;;
  }

  measure: sum_of_cost_third_party {
    type: sum
    label: "Cost third Party"
    sql: ${TABLE}.sum_of_Cost_ThirdParty ;;
  }

  measure: sum_of_creative_reach {
    type: sum
    label: "Creative Reach"
    sql: ${TABLE}.sum_of_Creative_Reach ;;
  }

  measure: sum_of_custom_overlay_impression {
    type: sum
    label: "Custom Overlay Impression"
    sql: ${TABLE}.sum_of_Custom_Overlay_Impression ;;
  }

  measure: sum_of_demo_impressions {
    type: sum
    label: "Demo Impressions"
    sql: ${TABLE}.sum_of_Demo_Impressions ;;
  }

  measure: sum_of_engagements {
    type: sum
    label: "Engagement"
    sql: ${TABLE}.sum_of_Engagements ;;
  }

  measure: sum_of_engagements_rollover {
    type: sum
    label: "Engagement Rollover"
    sql: ${TABLE}.sum_of_Engagements_Rollover ;;
  }

  measure: sum_of_fill_attempts {
    type: sum
    label: "Fill Attempts"
    sql: ${TABLE}.sum_of_Fill_Attempts ;;
  }

  measure: sum_of_focus {
    type: sum
    label: "Focus"
    sql: ${TABLE}.sum_of_Focus ;;
  }

  measure: sum_of_gross_revenue {
    type: sum
    label: "Gross Revenue"
    sql: ${TABLE}.sum_of_Gross_Revenue ;;
  }

  measure: sum_of_impressions {
    type: sum
    label: "Impressions"
    sql: ${TABLE}.sum_of_Impressions ;;
  }

  measure: sum_of_impressions_clickable {
    type: sum
    label: "Impressions Clickable"
    sql: ${TABLE}.sum_of_Impressions_Clickable ;;
  }

  measure: sum_of_impressions_companion {
    type: sum
    label: "Impressions Companion"
    sql: ${TABLE}.sum_of_Impressions_Companion ;;
  }

  measure: sum_of_impressions_companion_available {
    type: sum
    label: "Impressions Companion Available"
    sql: ${TABLE}.sum_of_Impressions_Companion_Available ;;
  }

  measure: sum_of_impressions_viewability_known {
    type: sum
    label: "Impressions Viewability Known"
    sql: ${TABLE}.sum_of_Impressions_Viewability_Known ;;
  }

  measure: sum_of_impressions_viewable {
    type: sum
    label: "Impressions Viewable"
    sql: ${TABLE}.sum_of_Impressions_Viewable ;;
  }

  measure: sum_of_max_duration {
    type: sum
    label: "Max Duration"
    sql: ${TABLE}.sum_of_Max_Duration ;;
  }

  measure: sum_of_min_duration {
    type: sum
    label: "Min Duration"
    sql: ${TABLE}.sum_of_Min_Duration ;;
  }

  measure: sum_of_placement_reach {
    type: sum
    label: "Placement Reach"
    sql: ${TABLE}.sum_of_Placement_Reach ;;
  }

  measure: sum_of_player_size_detected {
    type: sum
    label: "Player Size Detected"
    sql: ${TABLE}.sum_of_Player_Size_Detected ;;
  }

  measure: sum_of_player_size_passed {
    type: sum
    label: "Player Size Passed"
    sql: ${TABLE}.sum_of_Player_Size_Passed ;;
  }

  measure: sum_of_progress0 {
    type: sum
    label: "Progress 0"
    sql: ${TABLE}.sum_of_Progress0 ;;
  }

  measure: sum_of_progress100 {
    type: sum
    label: "Progress 100"
    sql: ${TABLE}.sum_of_Progress100 ;;
  }

  measure: sum_of_progress25 {
    type: sum
    label: "Progress 25"
    sql: ${TABLE}.sum_of_Progress25 ;;
  }

  measure: sum_of_progress50 {
    type: sum
    label: "Progress 50"
    sql: ${TABLE}.sum_of_Progress50 ;;
  }

  measure: sum_of_progress75 {
    type: sum
    label: "Progress 75"
    sql: ${TABLE}.sum_of_Progress75 ;;
  }

  measure: sum_of_requests {
    type: sum
    label: "Requests"
    sql: ${TABLE}.sum_of_Requests ;;
  }

  measure: sum_of_revenue {
    type: sum
    label: "Revenue"
    sql: ${TABLE}.sum_of_Revenue ;;
  }

  measure: sum_of_site_fraud_ias_fee {
    type: number
    sql: ${TABLE}.sum_of_Site_Fraud_IAS_Fee ;;
    hidden: yes
  }

  measure: sum_of_third_party_fees {
    type: sum
    label: "Third Party fee"
    sql: ${TABLE}.sum_of_Third_Party_Fees ;;
  }

  measure: sum_of_third_party_viewable_impression_fee {
    type: sum
    label: "Third party viewable impression fee"
    sql: ${TABLE}.sum_of_Third_Party_Viewable_Impression_Fee ;;
  }

  measure: sum_of_time_spent {
    type: sum
    label: "Time Spent"
    sql: ${TABLE}.sum_of_Time_Spent ;;
  }

  measure: sum_of_time_spent_active {
    type: sum
    label: "Time Spent Active"
    sql: ${TABLE}.sum_of_Time_Spent_Active ;;
  }

  measure: sum_of_time_spent_passive {
    type: sum
    label: "Time Spent Passive"
    sql: ${TABLE}.sum_of_Time_Spent_Passive ;;
  }

  measure: sum_of_total_dmp_fees {
    type: sum
    label: "Total DMP Fees"
    sql: ${TABLE}.sum_of_Total_DMP_Fees ;;
  }

  measure: sum_of_total_partner_fees {
    type: sum
    label: "Total Partner Fee"
    sql: ${TABLE}.sum_of_Total_Partner_Fees ;;
  }

  measure: sum_of_viewability {
    type: sum
    label: "Viewability"
    sql: ${TABLE}.sum_of_Viewability ;;
  }

  measure: sum_of_win_price {
    type: sum
    label: "Win Price"
    sql: ${TABLE}.sum_of_Win_Price ;;
  }

  dimension: video_type_key {
    type: number
    sql: ${TABLE}.Video_Type_Key ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []

  }
}
