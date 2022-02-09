# The name of this view in Looker is "V Fact Ad Hourly Agg"
view: fact_ad_hourly_agg {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Fact_Ad_Hourly_Agg ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "A Domain Key" in Explore.

  dimension: a_domain_key {
    type: number
    sql: ${TABLE}.A_Domain_Key ;;
    hidden: yes
  }

  dimension: avg_of_deal_bid_floor {
    type: number
    sql: ${TABLE}.avg_of_deal_bid_floor ;;
    hidden: yes
  }

  dimension: avg_of_dsp_bid_price {
    type: number
    sql: ${TABLE}.avg_of_dsp_bid_price ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_avg_of_dsp_bid_price {
    type: sum
    sql: ${avg_of_dsp_bid_price} ;;
    hidden: yes
  }

  measure: average_avg_of_dsp_bid_price {
    type: average
    sql: ${avg_of_dsp_bid_price} ;;
    hidden: yes
  }

  dimension: avg_of_ias_ivt_rate {
    type: number
    sql: ${TABLE}.avg_of_ias_ivt_rate ;;
    hidden: yes
  }

  dimension: avg_of_rx_bid_floor {
    type: number
    sql: ${TABLE}.avg_of_rx_bid_floor ;;
    hidden: yes
  }

  dimension: avg_of_ssp_bid_floor {
    type: number
    sql: ${TABLE}.avg_of_ssp_bid_floor ;;
    hidden: yes
  }

  dimension: avg_of_ssp_win_price {
    type: number
    sql: ${TABLE}.avg_of_ssp_win_price ;;
    hidden: yes
  }

  dimension: avg_of_win_price {
    type: number
    sql: ${TABLE}.avg_of_win_price ;;
    hidden: yes
  }

  dimension: buying_channel_key {
    type: number
    sql: ${TABLE}.Buying_Channel_Key ;;
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

  dimension_group: datetime_key {
    type: time
    timeframes:
    [ date,
      month,
      raw
    ]
    sql: ${TABLE}.DateTime_Key ;;
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

  dimension: os_key {
    type: number
    sql: ${TABLE}.OS_Key ;;
    hidden: yes
  }

  dimension: rg_blocked_key {
    type: number
    sql: ${TABLE}.RG_Blocked_Key ;;
    hidden: yes
  }
  dimension: rg_blocked_reason_key {
    type: number
    sql: ${TABLE}.RG_Blocked_Reason_key ;;
    hidden: yes
  }
  dimension: user_matched_key {
    type: number
    sql: ${TABLE}.user_Matched_Key ;;
    hidden: yes
  }
  dimension: video_Linearity_key {
    type: number
    sql: ${TABLE}.video_Linearity_key ;;
    hidden: yes
  }
  dimension: video_simple_size_key {
    type: number
    sql: ${TABLE}.video_simple_size_key ;;
    hidden: yes
  }
  dimension: ad_size_height_key {
    type: number
    sql: ${TABLE}.Ad_Size_Height_Key ;;
    hidden: yes
  }
  dimension: ad_size_width_key {
    type: number
    sql: ${TABLE}.Ad_Size_Width_Key;;
    hidden: yes
  }

  dimension: dsp_deal_type_key {
    type: number
    sql: ${TABLE}.DSP_Deal_Type_Key ;;
    hidden: yes
  }

  dimension: dsp_flight_key {
    type: number
    sql: ${TABLE}.DSP_Flight_Key ;;
    hidden: yes
  }

  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
    hidden: yes
  }

  dimension: dsp_seat_key {
    type: number
    sql: ${TABLE}.DSP_Seat_Key ;;
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

  dimension: response_status_key {
    type: number
    sql: ${TABLE}.Response_Status_Key ;;
    hidden: yes
  }

  measure: click_count {
    type: sum
    label: "Clicks"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_click_count ;;
    #hidden: yes
  }

  measure:: cogs {
    label: "Cogs"
    type: sum
    value_format: "$#,##0.00"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_cogs ;;
  }

  measure:: cost {
    label: "Cost"
    type: sum
    value_format: "$#,##0.00"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_cost ;;
  }

  measure: deal_count {
    type: sum
    label: "Deal Count"
    value_format: "$#,##0.00"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_deal_count ;;
    #hidden: yes
  }

  dimension: sum_of_dsp_count {
    type: number
    sql: ${TABLE}.sum_of_dsp_count ;;
    hidden: yes
  }


  measure:: ias_ivt_impression {
    type: sum
    label: "IAS IVT Viewable Impressions"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_ias_ivt_impression ;;
    hidden: yes
  }

  measure:: ias_measurable_impression {
    type: sum
    label: "IAS Measurable Impressions"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_ias_measurable_impression ;;
  }

  measure:: ias_viewability {
    type: number
    value_format: "0.00\%"
    label: "IAS Viewability"
    group_label: "Hourly Measures"
    sql: ${ias_viewable_impression}/NULLIF(${ias_measurable_impression},0);;
  }

  measure:: ias_total_impression {
    type: sum
    label: "Total IAS Count"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_ias_total_impression ;;
    hidden: yes
  }

  measure: ias_viewability_score {
    type: sum
    label: "IAS Predicted Viewability Score"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_ias_viewability_score ;;
    hidden: yes
  }

  measure:: ias_viewable_impression {
    type: sum
    label: "IAS Viewable Impressions"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_ias_viewable_impression ;;
  }

  measure: impression_pixel {
    type: sum
    label: "Impressions"
    #value_format: "#,##0.0,,\"\""
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_impression_pixel ;;
  }

  measure: impression_win {
    type: sum
    label: "Wins"
    #value_format: "#,##0.0,,\"\""
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_impression_win ;;
  }

  measure: sum_of_lda {
    type: sum
    label: "LDA"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_lda ;;
    #hidden: yes
  }

  measure: moat_impressions_ivt {
    type: sum
    label: "Moat Impressions IVT"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_moat_impressions_ivt ;;
    #hidden: yes
  }

  measure: moat_impressions_ivt_measurable {
    type: sum
    label: "Moat Measurable Impressions IVT"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_moat_impressions_ivt_measurable ;;
    #hidden: yes
  }

  measure: moat_impressions_viewable {
    type: sum
    label: "Moat Impressions Viewable"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_moat_impressions_viewable ;;
    hidden: yes
  }

  measure: moat_impressions_viewable_measurable {
    type: sum
    label: "Moat Impressions Viewable Measurable"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_moat_impressions_viewable_measurable ;;
    #hidden: yes
  }

  measure:: Moat_viewability {
    type: number
    value_format: "0.00\%"
    label: "Moat Viewability"
    group_label: "Hourly Measures"
    sql: ${moat_impressions_viewable}/NULLIF(${moat_impressions_viewable_measurable},0);;
    hidden: yes
  }

  dimension: sum_of_pub_cost {
    type: number
    sql: ${TABLE}.sum_of_pub_cost ;;
    hidden: yes
  }

  measure: requests {
    type: sum
    label: "Inbound Requests"
    #value_format: "#,##0.0,,\"\""
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_requests ;;
  }

  measure: responses {
    type: sum
    label: "Bids"
    value_format: "#,##0"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_responses ;;
  }

  measure: revenue
  {
    type: sum
    label: "Revenue"
    value_format: "$#,##0.00"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_revenue ;;
  }

  measure: rmp_attempts {
    type: sum
    label: "RMP Attempts"
    value_format: "$#,##0.00"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_rmp_attempts ;;
    # hidden: yes
  }
  measure: pub_platform_fee {
    type: sum
    label: "pub_platform_fee"
    value_format: "$#,##0.00"
    group_label: "Daily Measures"
    sql: ${TABLE}.sum_of_pub_platform_fee ;;
  }
  measure: rmp_requests {
    type: sum
    label: "Pub Requests"
    #value_format: "#,##0.0,,\"\""
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_rmp_requests ;;
  }

  measure: slot_attempts {
    type: sum
    label: "Slot Attempts"
    #value_format: "#,##0.0,,\"\""
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_slot_attempts ;;
    # hidden: yes
  }

  measure: slot_requests {
    type: sum
    label: "Slot Requests"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_slot_requests ;;
    hidden: yes
  }

  dimension: sum_of_usermatched {
    type: number
    sql: ${TABLE}.sum_of_usermatched ;;
    hidden: yes
  }

  measure:: video_completes {
    type: sum
    label: "Video Completes"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_video_completes ;;
    #hidden: yes
  }

  measure: video_creative_views {
    type: sum
    label: "Video Creative Views"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_video_creative_views ;;
    #hidden: yes
  }

  measure: video_errors {
    type: sum
    label: "Video Errors"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_video_errors ;;
    #hidden: yes
  }

  dimension: sum_of_video_first_quartiles {
    type: number
    sql: ${TABLE}.sum_of_video_first_quartiles ;;
    hidden: yes
  }

  dimension: sum_of_video_midpoints {
    type: number
    sql: ${TABLE}.sum_of_video_midpoints ;;
    hidden: yes
  }

  measure:: video_starts {
    type: sum
    label: "Video Starts"
    group_label: "Hourly Measures"
    sql: ${TABLE}.sum_of_video_starts ;;
    #hidden: yes
  }

  measure: Bid_Rate {
    type: number
    label: "Bid Rate"
    value_format: "0.00\%"
    group_label: "Hourly Measures"
    sql: ${responses}/NULLIF(${requests},0) ;;
  }

  measure: Fill_Rate {
    type: number
    label: "Fill Rate"
    value_format: "0.00%"
    group_label: "Hourly Measures"
    sql: ${impression_pixel}/NULLIF(${requests},0) ;;
  }

  measure: Net_Revenue {
    type: number
    label: "Net Revenue"
    value_format: "$#,##0.00"
    group_label: "Hourly Measures"
    sql: ${revenue} - ${cogs} ;;
  }

  measure: Margin {
    type: number
    label: "Margin%"
    value_format: "0.00"
    group_label: "Hourly Measures"
    sql: ((${revenue} - ${cogs})/NULLIF(${revenue},0))*100 ;;
  }

  measure: Pub_eCPM {
    type: number
    label: "Pub eCPM"
    value_format: "$#,##0.00"
    group_label: "Hourly Measures"
    sql: (${cogs}/NULLIF(${impression_pixel},0))*1000 ;;
  }

  measure: Render_Rate {
    type: number
    label: "Render Rate"
    value_format: "0.00\%"
    group_label: "Hourly Measures"
    sql: ${impression_pixel}/NULLIF(${impression_win},0) ;;
  }

  measure: Response_Rate {
    type: number
    label: "Response Rate"
    value_format: "0.00\%"
    group_label: "Hourly Measures"
    sql: ${responses}/NULLIF(${requests},0) ;;
  }

  measure: RPM {
    type: number
    label: "RPM"
    value_format: "$#,##0.00"
    group_label: "Hourly Measures"
    sql: ${revenue}/NULLIF((${requests}/1000000),0) ;;
  }

  measure: VTR {
    type: number
    label: "VTR"
    value_format: "0.00\%"
    group_label: "Hourly Measures"
    sql: ${video_completes}/NULLIF(${impression_pixel},0);;
  }

  measure: VCR {
    type: number
    label: "VCR"
    value_format: "0.00\%"
    group_label: "Hourly Measures"
    sql: (${video_completes}/NULLIF(${video_starts},0))*100;;

  }

  measure: count {
    type: count
    drill_fields: []
  }
}
