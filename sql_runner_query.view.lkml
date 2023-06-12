view: sql_runner_query {
  derived_table: {
    sql: select * from bi_new.fact_ad_daily_agg limit 10
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date_key {
    type: date
    sql: ${TABLE}.Date_Key ;;
  }

  dimension: a_domain_key {
    type: number
    sql: ${TABLE}.A_Domain_Key ;;
  }

  dimension: ad_size_height_key {
    type: number
    sql: ${TABLE}.Ad_Size_Height_Key ;;
  }

  dimension: ad_size_width_key {
    type: number
    sql: ${TABLE}.Ad_Size_Width_Key ;;
  }

  dimension: buying_channel_key {
    type: number
    sql: ${TABLE}.Buying_Channel_Key ;;
  }

  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
  }

  dimension: data_center_key {
    type: number
    sql: ${TABLE}.DataCenter_Key ;;
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.Deal_Key ;;
  }

  dimension: device_type_key {
    type: number
    sql: ${TABLE}.Device_Type_Key ;;
  }

  dimension: dsp_deal_type_key {
    type: number
    sql: ${TABLE}.DSP_Deal_Type_Key ;;
  }

  dimension: dsp_flight_key {
    type: number
    sql: ${TABLE}.DSP_Flight_Key ;;
  }

  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
  }

  dimension: dsp_seat_key {
    type: number
    sql: ${TABLE}.DSP_Seat_Key ;;
  }

  dimension: imp_sub_type_key {
    type: number
    sql: ${TABLE}.Imp_SubType_Key ;;
  }

  dimension: imp_type_key {
    type: number
    sql: ${TABLE}.Imp_Type_Key ;;
  }

  dimension: media_name_key {
    type: number
    sql: ${TABLE}.Media_Name_Key ;;
  }

  dimension: media_type_key {
    type: number
    sql: ${TABLE}.Media_Type_Key ;;
  }

  dimension: o_domain_key {
    type: number
    sql: ${TABLE}.O_Domain_Key ;;
  }

  dimension: os_key {
    type: number
    sql: ${TABLE}.OS_Key ;;
  }

  dimension: placement_key {
    type: number
    sql: ${TABLE}.Placement_Key ;;
  }

  dimension: platformfee_type_key {
    type: number
    sql: ${TABLE}.Platformfee_Type_Key ;;
  }

  dimension: pub_ssp_key {
    type: number
    sql: ${TABLE}.PUB_SSP_Key ;;
  }

  dimension: request_status_key {
    type: number
    sql: ${TABLE}.Request_Status_Key ;;
  }

  dimension: response_status_key {
    type: number
    sql: ${TABLE}.Response_Status_Key ;;
  }

  dimension: rg_blocked_key {
    type: number
    sql: ${TABLE}.RG_Blocked_Key ;;
  }

  dimension: rg_blocked_reason_key {
    type: number
    sql: ${TABLE}.RG_Blocked_Reason_Key ;;
  }

  dimension: user_matched_key {
    type: number
    sql: ${TABLE}.User_Matched_Key ;;
  }

  dimension: video_linearity_key {
    type: number
    sql: ${TABLE}.Video_Linearity_Key ;;
  }

  dimension: video_simple_size_key {
    type: number
    sql: ${TABLE}.Video_Simple_Size_Key ;;
  }

  dimension: sum_of_click_count {
    type: number
    sql: ${TABLE}.sum_of_click_count ;;
  }

  dimension: sum_of_cogs {
    type: number
    sql: ${TABLE}.sum_of_cogs ;;
  }

  dimension: sum_of_cost {
    type: number
    sql: ${TABLE}.sum_of_cost ;;
  }

  dimension: avg_of_deal_bid_floor {
    type: number
    sql: ${TABLE}.avg_of_deal_bid_floor ;;
  }

  dimension: sum_of_deal_count {
    type: number
    sql: ${TABLE}.sum_of_deal_count ;;
  }

  dimension: avg_of_dsp_bid_price {
    type: number
    sql: ${TABLE}.avg_of_dsp_bid_price ;;
  }

  dimension: sum_of_dsp_count {
    type: number
    sql: ${TABLE}.sum_of_dsp_count ;;
  }

  dimension: sum_of_ias_ivt_impression {
    type: number
    sql: ${TABLE}.sum_of_ias_ivt_impression ;;
  }

  dimension: avg_of_ias_ivt_rate {
    type: number
    sql: ${TABLE}.avg_of_ias_ivt_rate ;;
  }

  dimension: sum_of_ias_measurable_impression {
    type: number
    sql: ${TABLE}.sum_of_ias_measurable_impression ;;
  }

  dimension: sum_of_ias_total_impression {
    type: number
    sql: ${TABLE}.sum_of_ias_total_impression ;;
  }

  dimension: sum_of_ias_viewability_score {
    type: number
    sql: ${TABLE}.sum_of_ias_viewability_score ;;
  }

  dimension: sum_of_ias_viewable_impression {
    type: number
    sql: ${TABLE}.sum_of_ias_viewable_impression ;;
  }

  dimension: sum_of_impression_pixel {
    type: number
    sql: ${TABLE}.sum_of_impression_pixel ;;
  }

  dimension: sum_of_impression_win {
    type: number
    sql: ${TABLE}.sum_of_impression_win ;;
  }

  dimension: sum_of_lda {
    type: number
    sql: ${TABLE}.sum_of_lda ;;
  }

  dimension: sum_of_moat_impressions_ivt {
    type: number
    sql: ${TABLE}.sum_of_moat_impressions_ivt ;;
  }

  dimension: sum_of_moat_impressions_ivt_measurable {
    type: number
    sql: ${TABLE}.sum_of_moat_impressions_ivt_measurable ;;
  }

  dimension: sum_of_moat_impressions_viewable {
    type: number
    sql: ${TABLE}.sum_of_moat_impressions_viewable ;;
  }

  dimension: sum_of_moat_impressions_viewable_measurable {
    type: number
    sql: ${TABLE}.sum_of_moat_impressions_viewable_measurable ;;
  }

  dimension: sum_of_pub_cost {
    type: number
    sql: ${TABLE}.sum_of_pub_cost ;;
  }

  dimension: sum_of_pub_platform_fee {
    type: number
    sql: ${TABLE}.sum_of_pub_platform_fee ;;
  }

  dimension: sum_of_requests {
    type: number
    sql: ${TABLE}.sum_of_requests ;;
  }

  dimension: sum_of_responses {
    type: number
    sql: ${TABLE}.sum_of_responses ;;
  }

  dimension: sum_of_revenue {
    type: number
    sql: ${TABLE}.sum_of_revenue ;;
  }

  dimension: sum_of_rmp_attempts {
    type: number
    sql: ${TABLE}.sum_of_rmp_attempts ;;
  }

  dimension: sum_of_rmp_requests {
    type: number
    sql: ${TABLE}.sum_of_rmp_requests ;;
  }

  dimension: avg_of_rx_bid_floor {
    type: number
    sql: ${TABLE}.avg_of_rx_bid_floor ;;
  }

  dimension: sum_of_slot_attempts {
    type: number
    sql: ${TABLE}.sum_of_slot_attempts ;;
  }

  dimension: sum_of_slot_requests {
    type: number
    sql: ${TABLE}.sum_of_slot_requests ;;
  }

  dimension: avg_of_ssp_bid_floor {
    type: number
    sql: ${TABLE}.avg_of_ssp_bid_floor ;;
  }

  dimension: avg_of_ssp_win_price {
    type: number
    sql: ${TABLE}.avg_of_ssp_win_price ;;
  }

  dimension: sum_of_video_completes {
    type: number
    sql: ${TABLE}.sum_of_video_completes ;;
  }

  dimension: sum_of_video_creative_views {
    type: number
    sql: ${TABLE}.sum_of_video_creative_views ;;
  }

  dimension: sum_of_video_errors {
    type: number
    sql: ${TABLE}.sum_of_video_errors ;;
  }

  dimension: sum_of_video_first_quartiles {
    type: number
    sql: ${TABLE}.sum_of_video_first_quartiles ;;
  }

  dimension: sum_of_video_midpoints {
    type: number
    sql: ${TABLE}.sum_of_video_midpoints ;;
  }

  dimension: sum_of_video_starts {
    type: number
    sql: ${TABLE}.sum_of_video_starts ;;
  }

  dimension: avg_of_win_price {
    type: number
    sql: ${TABLE}.avg_of_win_price ;;
  }

  dimension: sum_of_plug_measure_int_1 {
    type: number
    sql: ${TABLE}.sum_of_Plug_Measure_INT_1 ;;
  }

  dimension: sum_of_plug_measure_int_2 {
    type: number
    sql: ${TABLE}.sum_of_Plug_Measure_INT_2 ;;
  }

  dimension: sum_of_plug_measure_float_1 {
    type: number
    sql: ${TABLE}.sum_of_Plug_Measure_FLOAT_1 ;;
  }

  dimension: sum_of_plug_measure_float_2 {
    type: number
    sql: ${TABLE}.sum_of_Plug_Measure_FLOAT_2 ;;
  }

  dimension: avg_of_plug_measure_float_1 {
    type: number
    sql: ${TABLE}.avg_of_Plug_Measure_FLOAT_1 ;;
  }

  dimension: avg_of_plug_measure_float_2 {
    type: number
    sql: ${TABLE}.avg_of_Plug_Measure_FLOAT_2 ;;
  }

  dimension: operations_owner_key {
    type: number
    sql: ${TABLE}.Operations_Owner_Key ;;
  }

  dimension: bizdev_owner_key {
    type: number
    sql: ${TABLE}.Bizdev_Owner_Key ;;
  }

  dimension: content_language_norm_key {
    type: number
    sql: ${TABLE}.Content_Language_Norm_Key ;;
  }

  dimension: content_network_key {
    type: number
    sql: ${TABLE}.Content_Network_Key ;;
  }

  dimension: content_rating_norm_key {
    type: number
    sql: ${TABLE}.Content_Rating_Norm_Key ;;
  }

  dimension: genre_norm_key {
    type: number
    sql: ${TABLE}.Genre_Norm_Key ;;
  }

  dimension: deal_auction_type_key {
    type: number
    sql: ${TABLE}.Deal_Auction_Type_Key ;;
  }

  dimension: ssp_deal_type_key {
    type: number
    sql: ${TABLE}.SSP_Deal_Type_Key ;;
  }

  dimension: sum_of_impression_video_events {
    type: number
    sql: ${TABLE}.sum_of_impression_video_events ;;
  }

  dimension: sum_of_pad_amount {
    type: number
    sql: ${TABLE}.sum_of_pad_amount ;;
  }

  dimension: avg_of_ssp_bid_price {
    type: number
    sql: ${TABLE}.avg_of_ssp_bid_price ;;
  }

  dimension: sum_of_video_third_quartiles {
    type: number
    sql: ${TABLE}.sum_of_video_third_quartiles ;;
  }

  set: detail {
    fields: [
      date_key,
      a_domain_key,
      ad_size_height_key,
      ad_size_width_key,
      buying_channel_key,
      country_key,
      data_center_key,
      deal_key,
      device_type_key,
      dsp_deal_type_key,
      dsp_flight_key,
      dsp_key,
      dsp_seat_key,
      imp_sub_type_key,
      imp_type_key,
      media_name_key,
      media_type_key,
      o_domain_key,
      os_key,
      placement_key,
      platformfee_type_key,
      pub_ssp_key,
      request_status_key,
      response_status_key,
      rg_blocked_key,
      rg_blocked_reason_key,
      user_matched_key,
      video_linearity_key,
      video_simple_size_key,
      sum_of_click_count,
      sum_of_cogs,
      sum_of_cost,
      avg_of_deal_bid_floor,
      sum_of_deal_count,
      avg_of_dsp_bid_price,
      sum_of_dsp_count,
      sum_of_ias_ivt_impression,
      avg_of_ias_ivt_rate,
      sum_of_ias_measurable_impression,
      sum_of_ias_total_impression,
      sum_of_ias_viewability_score,
      sum_of_ias_viewable_impression,
      sum_of_impression_pixel,
      sum_of_impression_win,
      sum_of_lda,
      sum_of_moat_impressions_ivt,
      sum_of_moat_impressions_ivt_measurable,
      sum_of_moat_impressions_viewable,
      sum_of_moat_impressions_viewable_measurable,
      sum_of_pub_cost,
      sum_of_pub_platform_fee,
      sum_of_requests,
      sum_of_responses,
      sum_of_revenue,
      sum_of_rmp_attempts,
      sum_of_rmp_requests,
      avg_of_rx_bid_floor,
      sum_of_slot_attempts,
      sum_of_slot_requests,
      avg_of_ssp_bid_floor,
      avg_of_ssp_win_price,
      sum_of_video_completes,
      sum_of_video_creative_views,
      sum_of_video_errors,
      sum_of_video_first_quartiles,
      sum_of_video_midpoints,
      sum_of_video_starts,
      avg_of_win_price,
      sum_of_plug_measure_int_1,
      sum_of_plug_measure_int_2,
      sum_of_plug_measure_float_1,
      sum_of_plug_measure_float_2,
      avg_of_plug_measure_float_1,
      avg_of_plug_measure_float_2,
      operations_owner_key,
      bizdev_owner_key,
      content_language_norm_key,
      content_network_key,
      content_rating_norm_key,
      genre_norm_key,
      deal_auction_type_key,
      ssp_deal_type_key,
      sum_of_impression_video_events,
      sum_of_pad_amount,
      avg_of_ssp_bid_price,
      sum_of_video_third_quartiles
    ]
  }
}
