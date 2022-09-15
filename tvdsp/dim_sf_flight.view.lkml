# The name of this view in Looker is "Dim Sf Flight"
view: dim_sf_flight {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.Dim_SF_Flight ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Ad Server" in Explore.

  dimension: ad_server {
    type: string
    sql: ${TABLE}.Ad_Server ;;
  }

  dimension: ad_unit_type {
    type: string
    sql: ${TABLE}.Ad_Unit_Type ;;
  }

  dimension: added_value {
    type: string
    sql: ${TABLE}.Added_Value ;;
  }

  dimension: booked_quantity {
    type: number
    sql: ${TABLE}.Booked_Quantity ;;
  }

  dimension: client_blacklist {
    type: string
    sql: ${TABLE}.Client_Blacklist ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: currency_code {
    type: string
    sql: ${TABLE}.Currency_Code ;;
  }

  dimension: data_partner {
    type: string
    sql: ${TABLE}.Data_Partner ;;
  }

  dimension: data_upcharge_product {
    type: string
    sql: ${TABLE}.Data_Upcharge_Product ;;
  }

  dimension: daypart_details_hours {
    type: string
    sql: ${TABLE}.Daypart_Details_Hours ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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

  dimension: dmas {
    type: string
    sql: ${TABLE}.DMAS ;;
  }

  dimension_group: end_date {
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
    sql: ${TABLE}.End_Date ;;
  }

  dimension: flight_booked_revenue {
    type: number
    sql: ${TABLE}.Flight_Booked_Revenue ;;
  }

  dimension: flight_booked_revenue_usd {
    type: number
    sql: ${TABLE}.Flight_Booked_Revenue_USD ;;
  }

  dimension: flight_daypart_details_day {
    type: string
    sql: ${TABLE}.Flight_Daypart_Details_Day ;;
  }

  dimension: flight_duration {
    type: string
    sql: ${TABLE}.Flight_duration ;;
  }

  dimension: flight_number {
    type: string
    sql: ${TABLE}.Flight_Number ;;
  }

  dimension: flight_unit_price_usd {
    type: number
    sql: ${TABLE}.Flight_Unit_Price_USD ;;
  }

  dimension: fraud_verification_vendor {
    type: string
    sql: ${TABLE}.Fraud_Verification_Vendor ;;
  }

  dimension: frequency_cap {
    type: number
    sql: ${TABLE}.Frequency_Cap ;;
  }

  dimension: frequency_cap_period {
    type: string
    sql: ${TABLE}.Frequency_Cap_Period ;;
  }

  dimension: group_name {
    type: string
    sql: ${TABLE}.Group_Name ;;
  }

  dimension: guarantee {
    type: string
    sql: ${TABLE}.Guarantee ;;
  }

  dimension: line_booked_quantity {
    type: number
    sql: ${TABLE}.Line_Booked_Quantity ;;
  }

  dimension: line_booked_revenue {
    type: number
    sql: ${TABLE}.Line_Booked_Revenue ;;
  }

  dimension: line_booked_revenue_usd {
    type: number
    sql: ${TABLE}.Line_Booked_Revenue_USD ;;
  }

  dimension: line_end {
    type: date
    sql: ${TABLE}.Line_End_Date ;;
  }

  dimension: line_id {
    type: string
    sql: ${TABLE}.Line_ID ;;
  }

  dimension: line_start {
    type: date

    sql: ${TABLE}.Line_Start_Date ;;
  }

  dimension: make_good {
    type: string
    sql: ${TABLE}.Make_Good ;;
  }

  dimension: package_description {
    type: string
    sql: ${TABLE}.Package_Description ;;
  }

  dimension: primary_optimization_kpi {
    type: string
    sql: ${TABLE}.Primary_Optimization_KPI ;;
  }

  dimension: rate_type {
    type: string
    sql: ${TABLE}.Rate_Type ;;
  }

  dimension: record_id {
    type: string
    sql: ${TABLE}.Record_ID ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: screen_type {
    type: string
    sql: ${TABLE}.Screen_Type ;;
  }

  dimension: screen_type_key {
    type: number
    sql: ${TABLE}.Screen_Type_Key ;;
    hidden: yes
  }

  dimension: sf_flight_key {
    type: number
    sql: ${TABLE}.SF_Flight_Key ;;
    hidden: yes
  }

  dimension: sf_opportunity_id {
    type: string
    sql: ${TABLE}.SF_Opportunity_ID ;;
  }

  dimension: sf_opportunity_key {
    type: number
    sql: ${TABLE}.SF_Opportunity_Key ;;
    hidden: yes
  }

  dimension: start_date {
    type: date
    sql: ${TABLE}.Start_Date ;;
  }

  dimension: states {
    type: string
    sql: ${TABLE}.States ;;
  }

  dimension: target_details {
    type: string
    sql: ${TABLE}.Target_Details ;;
  }

  dimension: unit_price {
    type: number
    sql: ${TABLE}.Unit_Price ;;
  }

  dimension: viewability_verification_vendor {
    type: string
    sql: ${TABLE}.Viewability_Verification_Vendor ;;
  }

  dimension: viewable_guarantee {
    type: number
    sql: ${TABLE}.Viewable_Guarantee ;;
  }

  measure: count {
    type: count
    drill_fields: [group_name]
    hidden: yes
  }
}
