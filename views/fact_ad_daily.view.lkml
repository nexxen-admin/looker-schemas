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
    hidden: yes
  }

  dimension: buying_channel {
    type: string
    sql: ${TABLE}.Buying_Channel ;;
  }

  dimension: buying_channel_key {
    type: number
    sql: ${TABLE}.Buying_Channel_Key ;;
    hidden: yes
  }

  measure: click_count {
    type: sum
    sql: ${TABLE}.click_count ;;
  }

  measure: cogs {
    type: sum
    sql: ${TABLE}.cogs ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # measure: total_cost {
  #   type: sum
  #   sql: ${cost} ;;
  # }

  # measure: average_cost {
  #   type: average
  #   sql: ${cost} ;;
  # }

  dimension: country_code {
    type: string
    sql: ${TABLE}.Country_Code ;;
  }

  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
    hidden: yes
  }

  dimension: data_center {
    type: string
    sql: ${TABLE}.DataCenter ;;
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
  }

  dimension: deal_bid_floor {
    type: number
    sql: ${TABLE}.deal_bid_floor ;;
  }

  measure: deal_count {
    type: sum
    sql: ${TABLE}.deal_count ;;
  }

  dimension: deal_id {
    type: string
    sql: ${TABLE}.Deal_ID ;;
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.Deal_Key ;;
    hidden: yes
  }

  dimension: device_type_id {
    type: string
    sql: ${TABLE}.Device_Type_ID ;;
  }

  dimension: device_type_key {
    type: number
    sql: ${TABLE}.Device_Type_Key ;;
    hidden: yes
  }

  dimension: dsp_bid_price {
    type: number
    sql: ${TABLE}.dsp_bid_price ;;
  }

  measure: dsp_count {
    type: sum
    sql: ${TABLE}.dsp_count ;;
  }

  dimension: dsp_deal_type {
    type: string
    sql: ${TABLE}.DSP_Deal_Type ;;
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

  dimension: dsp_id {
    type: string
    sql: ${TABLE}.DSP_ID ;;
  }

  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
    hidden: yes
  }

  dimension: dsp_name {
    type: string
    sql: ${TABLE}.DSP_Name ;;
  }

  dimension: dsp_seat_key {
    type: number
    sql: ${TABLE}.DSP_Seat_Key ;;
    hidden: yes
  }

  dimension: flight_id {
    type: string
    sql: ${TABLE}.Flight_ID ;;
  }

  measure: ias_ivt_impression {
    type: sum
    sql: ${TABLE}.ias_ivt_impression ;;
  }

  measure: ias_ivt_rate {
    type: sum
    sql: ${TABLE}.ias_ivt_rate ;;
  }

  measure: ias_measurable_impression {
    type: sum
    sql: ${TABLE}.ias_measurable_impression ;;
  }

  measure: ias_total_impression {
    type: sum
    sql: ${TABLE}.ias_total_impression ;;
  }

  measure: ias_viewability_score {
    type: sum
    sql: ${TABLE}.ias_viewability_score ;;
  }

  measure: ias_viewable_impression {
    type: sum
    sql: ${TABLE}.ias_viewable_impression ;;
  }

  dimension: imp_sub_type {
    type: string
    sql: ${TABLE}.Imp_SubType ;;
  }

  dimension: imp_sub_type_key {
    type: number
    sql: ${TABLE}.Imp_SubType_Key ;;
    hidden: yes
  }

  dimension: imp_type {
    type: string
    sql: ${TABLE}.Imp_Type ;;
  }

  dimension: imp_type_key {
    type: number
    sql: ${TABLE}.Imp_Type_Key ;;
    hidden: yes
  }

  measure: impression_pixel {
    type: sum
    label: "daily"
    sql: ${TABLE}.impression_pixel ;;
  }

  measure: impression_win {
    type: sum
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
    hidden: yes
  }

  measure: moat_impressions_ivt {
    type: sum
    sql: ${TABLE}.moat_impressions_ivt ;;
  }

  measure: moat_impressions_ivt_measurable {
    type: sum
    sql: ${TABLE}.moat_impressions_ivt_measurable ;;
  }

  measure: moat_impressions_viewable {
    type: sum
    sql: ${TABLE}.moat_impressions_viewable ;;
  }

  measure: moat_impressions_viewable_measurable {
    type: sum
    sql: ${TABLE}.moat_impressions_viewable_measurable ;;
  }

  dimension: o_domain {
    type: string
    sql: ${TABLE}.O_Domain ;;
  }

  dimension: o_domain_key {
    type: number
    sql: ${TABLE}.O_Domain_Key ;;
    hidden: yes
  }

  dimension: placement_id {
    type: string
    sql: ${TABLE}.Placement_ID ;;
  }

  dimension: placement_key {
    type: number
    sql: ${TABLE}.Placement_Key ;;
    hidden: yes
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.Placement_Name ;;
  }

  dimension: platformfee_type {
    type: string
    sql: ${TABLE}.platformfee_type ;;
  }

  measure: pub_cost {
    type: sum
    sql: ${TABLE}.pub_cost ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.PUB_ID ;;
  }

  dimension: pub_ssp_key {
    type: number
    sql: ${TABLE}.PUB_SSP_Key ;;
    hidden: yes
  }

  dimension: request_status {
    type: string
    sql: ${TABLE}.Request_Status ;;
  }

  dimension: request_status_key {
    type: number
    sql: ${TABLE}.Request_Status_Key ;;
    hidden: yes
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.requests ;;
  }

  dimension: response_status {
    type: string
    sql: ${TABLE}.Response_Status ;;
  }

  dimension: response_status_key {
    type: number
    sql: ${TABLE}.Response_Status_Key ;;
    hidden: yes
  }

  measure: responses {
    type: sum
    sql: ${TABLE}.responses ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  dimension: revenue_type {
    type: string
    sql: ${TABLE}.revenue_type ;;
  }

  measure: rmp_attempts {
    type: sum
    sql: ${TABLE}.rmp_attempts ;;
  }

  measure: rmp_requests {
    type: sum
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

  measure: slot_attempts {
    type: sum
    sql: ${TABLE}.slot_attempts ;;
  }

  measure: slot_requests {
    type: sum
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

  measure: ssp_win_price {
    type: number
    sql: ${TABLE}.ssp_win_price ;;
  }

  dimension: usermatched {
    type: number
    sql: ${TABLE}.usermatched ;;
  }

  measure: video_completes {
    type: sum
    sql: ${TABLE}.video_completes ;;
  }

  measure: video_creative_views {
    type: sum
    sql: ${TABLE}.video_creative_views ;;
  }

  measure: video_errors {
    type: sum
    sql: ${TABLE}.video_errors ;;
  }

  measure: video_first_quartiles {
    type: sum
    sql: ${TABLE}.video_first_quartiles ;;
  }

  measure: video_midpoints {
    type: sum
    sql: ${TABLE}.video_midpoints ;;
  }

  measure: video_starts {
    type: sum
    sql: ${TABLE}.video_starts ;;
  }

  measure: win_price {
    type: sum
    sql: ${TABLE}.win_price ;;
  }

  dimension: greatest_bid_floor {
    type: number
    sql: case when ${rx_bid_floor}>${ssp_bid_floor} then ${rx_bid_floor} else ${ssp_bid_floor} end;;
  }

  dimension: diff_floor_price {
    type: number
    sql: ${greatest_bid_floor}-${dsp_bid_price} ;;
  }

  dimension: range_from_bid_floor{
    type: string
    sql:
   CASE
            WHEN (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} <= 0.1 THEN '0-10%'
            WHEN (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} > 0.1 AND (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} <= 0.2 THEN '11-20%'
            WHEN (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} > 0.2 AND (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} <= 0.3 THEN '21-30%'
            WHEN (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} > 0.3 AND (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} <= 0.4 THEN '31-40%'
            WHEN (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} > 0.4 AND (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} <= 0.5 THEN '41-50%'
            WHEN (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} > 0.5 AND (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} <= 0.6 THEN '51-60%'
            WHEN (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} > 0.6 AND (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} <= 0.7 THEN '61-70%'
            WHEN (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} > 0.7 AND (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} <= 0.8 THEN '71-80%'
            WHEN (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} > 0.8 AND (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} <= 0.9 THEN '81-90%'
            WHEN (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} > 0.9 AND (${greatest_bid_floor} - ${dsp_bid_price}) / ${greatest_bid_floor} <= 1 THEN '91-100%'
            ELSE 'Other' end ;;
  }

  measure: num_of_bids {
    description: "A measure containing the total sales value over a dynamic window."
    type: number
    sql: count(${diff_floor_price}) OVER (PARTITION BY
      {% if pub_id._is_selected %} ${pub_id}, {% endif %}
      {% if device_type_id._is_selected %} ${device_type_id}, {% endif %}
      {% if imp_type._is_selected %} ${imp_type}, {% endif %}
      {% if country_code._is_selected %} ${country_code}, {% endif %}
      1 -- helper if none of the above dimensions is selected
    )
    ;;
  }

  measure: num_of_bids_per_range {
    description: "A measure containing the total sales value over a dynamic window."
    type: number
    sql: count(${diff_floor_price}) OVER (PARTITION BY
      {% if pub_id._is_selected %} ${pub_id}, {% endif %}
      {% if device_type_id._is_selected %} ${device_type_id}, {% endif %}
      {% if imp_type._is_selected %} ${imp_type}, {% endif %}
      {% if country_code._is_selected %} ${country_code}, {% endif %}
      {% if range_from_bid_floor._is_selected %} ${range_from_bid_floor}, {% endif %}
      1 -- helper if none of the above dimensions is selected
    )
    ;;
  }


  measure: count {
    type: count
    drill_fields: [pub_id, device_type_id, imp_type, country_code]
  }
}
