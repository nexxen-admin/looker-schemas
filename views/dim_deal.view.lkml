view: dim_deal {
  sql_table_name: BI_New.V_Dim_Deal ;;

  dimension: agency_id {
    type: number
    description: ""
    sql: ${TABLE}.Agency_ID ;;
  }

  dimension: daily_rate_target {
    type: number
    description: ""
    sql: ${TABLE}.Daily_Rate_Target ;;
  }

  dimension_group: db_create {
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
    sql: ${TABLE}.DB_Create_Date ;;
    hidden: yes
  }


  dimension_group: db_update {
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
    sql: ${TABLE}.DB_Update_Date ;;
    hidden: yes
  }

  dimension: deal_auction_type {
    type: string
    description: ""
    sql: ${TABLE}.Deal_Auction_Type ;;
  }

  dimension: deal_bid_floor {
    type: number
    description: ""
    sql: ${TABLE}.Deal_Bid_Floor ;;
  }

  dimension: deal_data_fee {
    type: number
    description: ""
    sql: ${TABLE}.Deal_Data_Fee ;;
  }

  dimension: deal_demand_margin_pct {
    type: number
    description: ""
    sql: ${TABLE}.Deal_demand_margin_pct ;;
  }

  dimension_group: deal_end {
    type: time
    description: "Deal contract End date"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Deal_End ;;
  }

  dimension: deal_id {
    description: "The Deal Externatal ID , contain 1st & 3rd party deals"
    type: string
    sql: ${TABLE}.Deal_ID ;;
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.Deal_Key ;;
    hidden: yes
  }

  dimension: deal_name {
    description: "Deal Description"
    type: string
    sql: ${TABLE}.Deal_Name ;;
  }

  dimension: deal_office {
    type: string
    description: "The Office to which the Deal is associated"
    sql: ${TABLE}.Deal_Office ;;
  }

  dimension_group: deal_start {
    description: "Deal contract Start date"
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
    sql: ${TABLE}.Deal_Start ;;
  }

  dimension: deal_supply_margin_pct {
    type: number
    sql: ${TABLE}.Deal_supply_margin_pct ;;
  }

  dimension: deal_type_id {
    type: number
    sql: ${TABLE}.Deal_Type_ID ;;
  }

  dimension: deal_type_key {
    type: number
    sql: ${TABLE}.Deal_Type_Key ;;
    hidden:yes
  }

  dimension: dsp_seat {
    type: string
    sql: ${TABLE}.DSP_Seat ;;
    hidden:yes
  }

  dimension: internal_deal_id {
    type: number
    sql: ${TABLE}.Internal_Deal_ID ;;
  }

  dimension: monthly_rev_target {
    type: number
    sql: ${TABLE}.Monthly_Rev_Target ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: vcr_target {
    description: ""
    type: number
    sql: ${TABLE}.Vcr_Target ;;
  }

  dimension: viewability_target {
    description: "deal viewability target"
    type: number
    sql: ${TABLE}.Viewability_Target ;;
  }

  measure: count {
    type: count
    drill_fields: [deal_name]
    hidden: yes
  }
}
