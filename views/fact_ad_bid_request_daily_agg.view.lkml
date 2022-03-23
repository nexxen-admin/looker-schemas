# The name of this view in Looker is "V Fact Ad Bid Request Daily Agg"
view: fact_ad_bid_request_daily_agg {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Fact_Ad_BidRequest_Daily_Agg ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ad Size Height Key" in Explore.

  dimension: ad_size_height_key {
    type: number
    sql: ${TABLE}.Ad_Size_Height_Key ;;
    hidden: yes
  }

  dimension: ad_size_width_key {
    type: number
    sql: ${TABLE}.Ad_Size_Width_Key ;;
    hidden: yes
  }

  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
    hidden: yes
  }

  dimension: data_center_key {
    type: number
    sql: ${TABLE}.DataCenter_Key ;;
    hidden: yes
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: date_key {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date_Key ;;
    hidden: yes
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.Deal_Key ;;
    hidden: yes
  }

  dimension: device_type_key {
    type: number
    sql: ${TABLE}.Device_Type_Key ;;
    hidden: yes
  }

  dimension: dsp_deal_type_key {
    type: number
    sql: ${TABLE}.DSP_Deal_Type_Key ;;
    hidden: yes
  }

  dimension: dsp_filter_reason_key {
    type: number
    sql: ${TABLE}.DSP_Filter_Reason_Key ;;
    hidden: yes
  }

  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
    hidden: yes
  }

  dimension: imp_sub_type_key {
    type: number
    sql: ${TABLE}.Imp_SubType_Key ;;
    hidden: yes
  }

  dimension: imp_type_key {
    type: number
    sql: ${TABLE}.Imp_Type_Key ;;
    hidden: yes
  }

  dimension: media_name_key {
    type: number
    sql: ${TABLE}.Media_Name_Key ;;
    hidden: yes
  }

  dimension: media_type_key {
    type: number
    sql: ${TABLE}.Media_Type_Key ;;
    hidden: yes
  }

  dimension: o_domain_key {
    type: number
    sql: ${TABLE}.O_Domain_Key ;;
    hidden: yes
  }

  dimension: os_key {
    type: number
    sql: ${TABLE}.OS_Key ;;
    hidden: yes
  }

  dimension: placement_key {
    type: number
    sql: ${TABLE}.Placement_Key ;;
    hidden: yes
  }

  dimension: pub_ssp_key {
    type: number
    sql: ${TABLE}.PUB_SSP_Key ;;
    hidden: yes
  }

  dimension: request_status_key {
    type: number
    sql: ${TABLE}.Request_Status_Key ;;
    hidden: yes
  }

  measure: click_count {
    type: sum
    label: "Clicks"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_click_count_from_ad_data ;;
    #hidden: yes
  }

  measure:: cogs {
    label: "Cogs"
    description: "Media Cost  (3rd Party SSP or Publisher Cost)"
    type: sum
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_cogs_from_ad_data ;;
  }


  measure:: cost {
    label: "Cost"
    type: sum
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_cost ;;
  }

  measure: deal_count {
    type: sum
    label: "Deal Count"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_deal_count_from_ad_data ;;
    #hidden: yes
  }

  measure: sum_of_deal_requests_from_bidrequest {
    type: sum
    label: "Deal Requests"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_deal_requests_from_bidrequest ;;
  }

  dimension: sum_of_dsp_count_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_dsp_count_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_dsp_deals_count_from_bidrequest {
    type: number
    sql: ${TABLE}.sum_of_dsp_deals_count_from_bidrequest ;;
    hidden: yes
  }

  measure: sum_of_dsp_requests_from_bidrequest {
    type: sum
    label: "Outbound Requests"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_dsp_requests_from_bidrequest ;;
  }

  dimension: sum_of_ias_ivt_impression_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_ias_ivt_impression_from_ad_data ;;
  }

  measure: ias_measurable_impression {
    type: sum
    label: "IAS Measurable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_ias_measurable_impression_from_ad_data  ;;
  }

  measure:: ias_viewable_impression {
    type: sum
    label: "IAS Viewable Impressions"
    group_label: "Daily Measures"
    sql:  ${TABLE}.sum_of_ias_viewable_impression_from_ad_data ;;
  }

  measure: impression_pixel {
    type: sum
    label: "Impressions"
    description: "Successfully delivered ad impression.   Billable event. ."
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_impression_pixel_from_ad_data ;;
  }

  measure: impression_win {
    type: sum
    label: "Wins"
    description: "The win event is post our bid response back to the publisher/ssp, indicating that we have won the bid in their auction.   "
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_impression_win_from_ad_data ;;
  }

  dimension: sum_of_media_requests_from_bidrequest {
    type: number
    sql: ${TABLE}.sum_of_media_requests_from_bidrequest ;;

  }

  dimension: sum_of_moat_impressions_ivt_measurable_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_moat_impressions_ivt_measurable_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_moat_impressions_viewable_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_moat_impressions_viewable_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_pub_cost_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_pub_cost_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_pub_platform_fee_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_pub_platform_fee_from_ad_data ;;
  }

  dimension: sum_of_requests_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_requests_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_requests_from_bidrequest {
    type: number
    sql: ${TABLE}.sum_of_requests_from_bidrequest ;;
    hidden: yes
  }

  measure: responses {
    type: sum
    label: "Bids"
    description: "Bid responses returned from dsps.   There may be more than one bid response per bid request.   "
    value_format: "#,##0"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_responses_from_ad_data ;;
  }

  measure: revenue
  {
    type: sum
    label: "Revenue"
    #sql_distinct_key: ${deal_key} ;;
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_revenue_from_ad_data;;
  }


  dimension: sum_of_rmp_attempts_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_rmp_attempts_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_rmp_requests_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_rmp_requests_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_slot_attempts_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_slot_attempts_from_ad_data ;;
    hidden: yes
  }

  dimension: sum_of_slot_requests_from_ad_data {
    type: number
    sql: ${TABLE}.sum_of_slot_requests_from_ad_data ;;
    hidden: yes
  }


  measure:: video_completes {
    type: sum
    label: "Video Completes"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_video_completes_from_ad_data ;;
    #hidden: yes
  }

  measure:: video_starts {
    type: sum
    label: "Video Starts"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_video_starts_from_ad_data ;;
    #hidden: yes
  }

  measure: video_creative_views {
    type: sum
    label: "Video Creative Views"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_video_creative_views_from_ad_data ;;
    #hidden: yes
  }

  measure: video_errors {
    type: sum
    label: "Video Errors"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_video_errors_from_ad_data ;;
    #hidden: yes
  }



  dimension: user_matched_key {
    type: number
    sql: ${TABLE}.User_Matched_Key ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
