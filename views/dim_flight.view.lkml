view: dim_flight {
  sql_table_name: BI_New.V_Dim_Flight ;;

  dimension: adjusted_amount {
    label: "Adjustment Amount"
    type: number
    sql: ${TABLE}.Adjusted_Amount ;;
  }

  dimension: advertiser_id {
    label: "Advertiser ID"
    type: number
    sql: ${TABLE}.Advertiser_ID ;;
  }

  dimension: advertiser_name {
    label: "Advertiser Name"
    type: string
    sql: ${TABLE}.Advertiser_name ;;
  }

  dimension: agency_id {
    label: "Agency ID"
    type: number
    sql: ${TABLE}.Agency_ID ;;
  }

  dimension: agency_name {
    label: "Agency Name"
    type: string
    sql: ${TABLE}.Agency_Name ;;
  }

  dimension: billing_ad_server {
    label: "Billing Ad Server"
    type: string
    sql: ${TABLE}.billing_ad_server ;;
  }

  dimension: booked_amount {
    label: "Booked Amount"
    type: number
    sql: ${TABLE}.Booked_Amount ;;
  }

  dimension: brand_id {
    label: "Brand ID"
    type: number
    sql: ${TABLE}.Brand_ID ;;
  }

  dimension: brand_name {
    label: "Brand Name"
    type: string
    sql: ${TABLE}.Brand_name ;;
  }

  dimension: budget {
    label: "Budget"
    type: number
    sql: ${TABLE}.Budget ;;
  }

  dimension: buy_sub_type {
    label: "Buy Sub Type"
    type: string
    sql: ${TABLE}.Buy_Sub_Type ;;
  }

  dimension: buy_type {
    label: "Buy Type"
    type: string
    sql: ${TABLE}.Buy_Type ;;
  }

  dimension: campaign_id {
    label: "Campaign ID"
    type: number
    sql: ${TABLE}.Campaign_ID ;;
  }

  dimension: campaign_name {
    label: "Campaign Name"
    type: string
    sql: ${TABLE}.Campaign_Name ;;
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

  dimension: end {
    label: "End Date"
    type: date
    sql: ${TABLE}.End_Date ;;
  }

  dimension: flight_id {
    label: "Flight ID"
    type: string
    sql: ${TABLE}.Flight_ID ;;
  }

  dimension: flight_key {
    type: number
    sql: ${TABLE}.Flight_Key ;;
    hidden: yes
  }

  dimension: flight_name {
    label: "Flight Name"
    type: string
    sql: ${TABLE}.Flight_Name ;;
  }

  dimension: flight_number {
    label: "Flight Number"
    type: string
    sql: ${TABLE}.Flight_Number ;;
  }

  dimension: line_id {
    label: "Line ID"
    type: string
    sql: ${TABLE}.Line_id ;;
  }

  dimension: network_id {
    label: "Network ID"
    type: number
    sql: ${TABLE}.Network_ID ;;
  }

  dimension: network_name {
    label: "Network Name"
    type: string
    sql: ${TABLE}.Network_Name ;;
  }

  dimension: rate_type {
    label: "Rate Type"
    type: string
    sql: ${TABLE}.Rate_Type ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_INFO ;;
    hidden: yes
  }

  dimension: start {
    label: "Start_Date"
    type: date
    sql: ${TABLE}.Start_Date ;;
  }

  dimension: status {
    label: "Status"
    type: string
    sql: ${TABLE}.Status ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      agency_name,
      campaign_name,
      flight_name,
      advertiser_name,
      brand_name,
      network_name
    ]
  }
}
