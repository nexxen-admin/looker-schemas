view: fact_ad_daily_agg {
  sql_table_name: BI_New.V_Fact_Ad_Daily_Agg ;;

  parameter: max_rank {
    type: number
  }

  dimension: rank_limit {
    type: number
    sql: {% parameter max_rank %} ;;
  }

  dimension: a_domain_key {
    type: number
    sql: ${TABLE}.A_Domain_Key ;;
  hidden: yes
  }

  measure:: cogs {
    label: "Cogs"
    type: sum
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.cogs ;;
  }

  measure:: cost {
    label: "Cost"
    type: sum
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.cost ;;
  }

  measure:: ias_ivt_impression {
    type: sum
    label: "IAS IVT Viewable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.ias_ivt_impression ;;
  }

  measure:: ias_measurable_impression {
    type: sum
    label: "IAS Measurable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.ias_measurable_impression ;;
  }

  measure:: ias_viewability {
    type: number
    value_format: "0.0%"
    label: "IAS Viewability"
    group_label: "Daily Measures"
    sql: NULLIF(${ias_viewable_impression}/${ias_measurable_impression},0);;
  }

  measure:: ias_total_impression {
    type: sum
    label: "Total IAS Count"
    group_label: "Daily Measures"
    sql: ${TABLE}.ias_total_impression ;;
  }

  measure:: ias_viewable_impression {
    type: sum
    label: "IAS Viewable Impressions"
    group_label: "Daily Measures"
    sql: ${TABLE}.ias_viewable_impression ;;
  }

  measure:: video_completes {
    type: sum
    label: "Video Completes"
    group_label: "Daily Measures"
    sql: ${TABLE}.video_completes ;;
  }

  measure:: video_starts {
    type: sum
    label: "Video Starts"
    group_label: "Daily Measures"
    sql: ${TABLE}.video_starts ;;
  }


  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
    hidden: yes
  }

  dimension_group: date_key {
    type: time
    timeframes:
    [ date,
      month,
      raw
    ]
    label: "Date"
    group_label: "Time Frame"
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

  dimension: flight_key {
    type: number
    sql: ${TABLE}.Flight_Key ;;
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

  measure: impression_pixel {
    type: sum
    label: "Impressions"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.impression_pixel ;;
  }

  measure: impression_win {
    type: sum
    label: "Wins"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.impression_win ;;
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

  measure: requests {
    type: sum
    label: "Inbound Requests"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.requests ;;
  }

  dimension: response_status_key {
    type: number
    sql: ${TABLE}.Response_Status_Key ;;
    hidden: yes
  }

  measure: responses {
    type: sum
    label: "Bids"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.responses ;;
  }

  measure: revenue {
    type: sum
    label: "Revenue"
    #value_format: "#,##0"
    group_label: "Daily Measures"
    sql: ${TABLE}.revenue ;;
  }

  measure: rmp_requests {
    type: sum
    label: "Pub Requests"
    #value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.rmp_requests ;;
  }

  measure: rx_bid_floor {
    type: number
    group_label: "Daily Measures"
    sql: ${TABLE}.rx_bid_floor ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
