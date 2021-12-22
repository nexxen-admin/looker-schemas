# The name of this view in Looker is "V Fact Ad Daily"
view: v_fact_ad_daily {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Fact_Ad_Daily ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "A Domain" in Explore.

  dimension: a_domain {
    type: string
    sql: ${TABLE}.A_Domain ;;
  }

  dimension: a_domain_key {
    type: number
    sql: ${TABLE}.A_Domain_Key ;;
  }

  dimension: buying_channel {
    type: string
    sql: ${TABLE}.Buying_Channel ;;
  }

  dimension: buying_channel_key {
    type: number
    sql: ${TABLE}.Buying_Channel_Key ;;
  }

  dimension: click_count {
    type: number
    sql: ${TABLE}.click_count ;;
  }

  dimension: cogs {
    type: number
    sql: ${TABLE}.cogs ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_cost {
    type: sum
    sql: ${cost} ;;
  }

  measure: average_cost {
    type: average
    sql: ${cost} ;;
  }

  dimension: country_code {
    type: string
    sql: ${TABLE}.Country_Code ;;
  }

  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
  }

  dimension: data_center {
    type: string
    sql: ${TABLE}.DataCenter ;;
  }

  dimension: data_center_key {
    type: number
    sql: ${TABLE}.DataCenter_Key ;;
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
  }

  dimension: deal_bid_floor {
    type: number
    sql: ${TABLE}.deal_bid_floor ;;
  }

  dimension: deal_count {
    type: number
    sql: ${TABLE}.deal_count ;;
  }

  dimension: deal_id {
    type: string
    sql: ${TABLE}.Deal_ID ;;
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.Deal_Key ;;
  }

  dimension: device_type_id {
    type: string
    sql: ${TABLE}.Device_Type_ID ;;
  }

  dimension: device_type_key {
    type: number
    sql: ${TABLE}.Device_Type_Key ;;
  }

  dimension: dsp_bid_price {
    type: number
    sql: ${TABLE}.dsp_bid_price ;;
  }

  dimension: dsp_count {
    type: number
    sql: ${TABLE}.dsp_count ;;
  }

  dimension: dsp_deal_type {
    type: string
    sql: ${TABLE}.DSP_Deal_Type ;;
  }

  dimension: dsp_deal_type_key {
    type: number
    sql: ${TABLE}.DSP_Deal_Type_Key ;;
  }

  dimension: dsp_flight_key {
    type: number
    sql: ${TABLE}.DSP_Flight_Key ;;
  }

  dimension: dsp_id {
    type: string
    sql: ${TABLE}.DSP_ID ;;
  }

  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
  }

  dimension: dsp_name {
    type: string
    sql: ${TABLE}.DSP_Name ;;
  }

  dimension: dsp_seat_key {
    type: number
    sql: ${TABLE}.DSP_Seat_Key ;;
  }

  dimension: flight_id {
    type: string
    sql: ${TABLE}.Flight_ID ;;
  }

  dimension: ias_ivt_impression {
    type: number
    sql: ${TABLE}.ias_ivt_impression ;;
  }

  dimension: ias_ivt_rate {
    type: number
    sql: ${TABLE}.ias_ivt_rate ;;
  }

  dimension: ias_measurable_impression {
    type: number
    sql: ${TABLE}.ias_measurable_impression ;;
  }

  dimension: ias_total_impression {
    type: number
    sql: ${TABLE}.ias_total_impression ;;
  }

  dimension: ias_viewability_score {
    type: number
    sql: ${TABLE}.ias_viewability_score ;;
  }

  dimension: ias_viewable_impression {
    type: number
    sql: ${TABLE}.ias_viewable_impression ;;
  }

  dimension: imp_sub_type {
    type: string
    sql: ${TABLE}.Imp_SubType ;;
  }

  dimension: imp_sub_type_key {
    type: number
    sql: ${TABLE}.Imp_SubType_Key ;;
  }

  dimension: imp_type {
    type: string
    sql: ${TABLE}.Imp_Type ;;
  }

  dimension: imp_type_key {
    type: number
    sql: ${TABLE}.Imp_Type_Key ;;
  }

  measure: impression_pixel {
    type: sum
    label: "daily"
    sql: ${TABLE}.impression_pixel ;;
  }

  dimension: impression_win {
    type: number
    sql: ${TABLE}.impression_win ;;
  }

  dimension: is_1st_party {
    type: yesno
    sql: ${TABLE}.Is_1st_Party ;;
  }

  dimension: lda {
    type: number
    sql: ${TABLE}.lda ;;
  }

  dimension: media_type {
    type: string
    sql: ${TABLE}.Media_Type ;;
  }

  dimension: media_type_key {
    type: number
    sql: ${TABLE}.Media_Type_Key ;;
  }

  dimension: moat_impressions_ivt {
    type: number
    sql: ${TABLE}.moat_impressions_ivt ;;
  }

  dimension: moat_impressions_ivt_measurable {
    type: number
    sql: ${TABLE}.moat_impressions_ivt_measurable ;;
  }

  dimension: moat_impressions_viewable {
    type: number
    sql: ${TABLE}.moat_impressions_viewable ;;
  }

  dimension: moat_impressions_viewable_measurable {
    type: number
    sql: ${TABLE}.moat_impressions_viewable_measurable ;;
  }

  dimension: o_domain {
    type: string
    sql: ${TABLE}.O_Domain ;;
  }

  dimension: o_domain_key {
    type: number
    sql: ${TABLE}.O_Domain_Key ;;
  }

  dimension: placement_id {
    type: string
    sql: ${TABLE}.Placement_ID ;;
  }

  dimension: placement_key {
    type: number
    sql: ${TABLE}.Placement_Key ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.Placement_Name ;;
  }

  dimension: platformfee_type {
    type: string
    sql: ${TABLE}.platformfee_type ;;
  }

  dimension: pub_cost {
    type: number
    sql: ${TABLE}.pub_cost ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.PUB_ID ;;
  }

  dimension: pub_ssp_key {
    type: number
    sql: ${TABLE}.PUB_SSP_Key ;;
  }

  dimension: request_status {
    type: string
    sql: ${TABLE}.Request_Status ;;
  }

  dimension: request_status_key {
    type: number
    sql: ${TABLE}.Request_Status_Key ;;
  }

  dimension: requests {
    type: number
    sql: ${TABLE}.requests ;;
  }

  dimension: response_status {
    type: string
    sql: ${TABLE}.Response_Status ;;
  }

  dimension: response_status_key {
    type: number
    sql: ${TABLE}.Response_Status_Key ;;
  }

  dimension: responses {
    type: number
    sql: ${TABLE}.responses ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: revenue_type {
    type: string
    sql: ${TABLE}.revenue_type ;;
  }

  dimension: rmp_attempts {
    type: number
    sql: ${TABLE}.rmp_attempts ;;
  }

  dimension: rmp_requests {
    type: number
    sql: ${TABLE}.rmp_requests ;;
  }

  dimension: rx_bid_floor {
    type: number
    sql: ${TABLE}.rx_bid_floor ;;
  }

  dimension: seat_id {
    type: string
    sql: ${TABLE}.Seat_ID ;;
  }

  dimension: slot_attempts {
    type: number
    sql: ${TABLE}.slot_attempts ;;
  }

  dimension: slot_requests {
    type: number
    sql: ${TABLE}.slot_requests ;;
  }

  dimension: ssp_bid_floor {
    type: number
    sql: ${TABLE}.ssp_bid_floor ;;
  }

  dimension: ssp_name {
    type: string
    sql: ${TABLE}.SSP_Name ;;
  }

  dimension: ssp_win_price {
    type: number
    sql: ${TABLE}.ssp_win_price ;;
  }

  dimension: usermatched {
    type: number
    sql: ${TABLE}.usermatched ;;
  }

  dimension: video_completes {
    type: number
    sql: ${TABLE}.video_completes ;;
  }

  dimension: video_creative_views {
    type: number
    sql: ${TABLE}.video_creative_views ;;
  }

  dimension: video_errors {
    type: number
    sql: ${TABLE}.video_errors ;;
  }

  dimension: video_first_quartiles {
    type: number
    sql: ${TABLE}.video_first_quartiles ;;
  }

  dimension: video_midpoints {
    type: number
    sql: ${TABLE}.video_midpoints ;;
  }

  dimension: video_starts {
    type: number
    sql: ${TABLE}.video_starts ;;
  }

  dimension: win_price {
    type: number
    sql: ${TABLE}.win_price ;;
  }

  measure: count {
    type: count
    drill_fields: [placement_name, dsp_name, ssp_name]
  }
}
