view: fact_ad_daily_agg {
  sql_table_name: BI_New.Fact_Ad_Daily_Agg_with_date ;;

  dimension: a_domain_key {
    type: number
    sql: ${TABLE}.A_Domain_Key ;;
  hidden: yes
  }

  measure:: cogs {
    label: "Cogs"
    type: sum
    value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.cogs ;;
  }

  measure:: cost {
    label: "Cost(M)"
    type: sum
    value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.cost ;;
  }

  dimension: country_key {
    type: number
    sql: ${TABLE}.Country_Key ;;
    hidden: yes
  }

  dimension_group: date_key {
    label: "Date"
    group_label: "Time Frame"
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
    label: "Impressions(M)"
    value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.impression_pixel ;;
  }

  measure: impression_win {
    type: sum
    label: "Wins(M)"
    value_format: "#,##0.0,,\"\""
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
    label: "Inbound Requests(M)"
    value_format: "#,##0.0,,\"\""
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
    label: "Bids(M)"
    value_format: "#,##0.0,,\"\""
    group_label: "Daily Measures"
    sql: ${TABLE}.responses ;;
  }

  measure: revenue {
    type: sum
    label: "Revenue(M)"
    value_format: "#,##0"
    group_label: "Daily Measures"
    sql: ${TABLE}.revenue ;;
  }

  measure: rmp_requests {
    type: sum
    label: "Pub Requests(M)"
    value_format: "#,##0.0,,\"\""
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
