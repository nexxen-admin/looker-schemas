view: dim_deal {
  sql_table_name: BI_New.V_Dim_Deal ;;

  dimension: agency_id {
    label: "Agency ID"
    type: number
    sql: ${TABLE}.Agency_ID ;;
    hidden: yes
  }

  dimension: daily_rate_target {
    label: "Daily Target"
    type: number
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
    label: "Deal Auction Type"
    type: string
    sql: ${TABLE}.Deal_Auction_Type ;;
  }

  dimension: deal_bid_floor {
    label: "Deal Bid Floor"
    type: number
    sql: ${TABLE}.Deal_Bid_Floor ;;
  }

  dimension: deal_data_fee {
    label: "Deal Data Fee"
    type: number
    sql: ${TABLE}.Deal_Data_Fee ;;
  }

  dimension: deal_demand_margin_pct {
    label: "Deal Demand Margin Pct"
    type: number
    sql: ${TABLE}.Deal_demand_margin_pct ;;
  }

  dimension_group: deal_end {
    label: "Deal End"
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
    sql: ${TABLE}.Deal_End ;;
  }

  dimension: deal_id {
    label: "Deal ID"
    type: string
    sql: ${TABLE}.Deal_ID ;;
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.Deal_Key ;;
    hidden: yes
  }

  dimension: deal_name {
    label: "Deal Name"
    type: string
    sql: ${TABLE}.Deal_Name ;;
  }

  dimension: deal_office {
    label: "Deal Office"
    type: string
    sql: ${TABLE}.Deal_Office ;;
  }

  dimension_group: deal_start {
    label: "Deal Start"
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
    label: "Deal Supply Margin Pct"
    type: number
    sql: ${TABLE}.Deal_supply_margin_pct ;;
  }

  dimension: deal_type_id {
    type: number
    sql: ${TABLE}.Deal_Type_ID ;;
    hidden: yes
  }

  dimension: deal_type_key {
    type: number
    sql: ${TABLE}.Deal_Type_Key ;;
    hidden: yes
  }

  dimension: dsp_seat {
    type: string
    sql: ${TABLE}.DSP_Seat ;;
    hidden: yes
  }

  dimension: internal_deal_id {
    type: number
    sql: ${TABLE}.Internal_Deal_ID ;;
    hidden: yes
  }

  dimension: monthly_rev_target {
    label: "Revenue Target (Monthly)"
    type: number
    sql: ${TABLE}.Monthly_Rev_Target ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: vcr_target {
    label: "VCR Target"
    type: number
    sql: ${TABLE}.Vcr_Target ;;
  }

  dimension: viewability_target {
    label: "Vieability Target"
    type: number
    sql: ${TABLE}.Viewability_Target ;;
  }

  measure: count {
    type: count
    drill_fields: [deal_name]
    hidden: yes
  }
}
