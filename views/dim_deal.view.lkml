# The name of this view in Looker is "V Dim Deal"
view: dim_deal {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.V_Dim_Deal ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Agency ID" in Explore.


  dimension: daily_rate_target {
    type: number
    sql: ${TABLE}.Daily_Rate_Target ;;
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

  dimension: deal_auction_type {
    type: string
    description: "Can be either fixed price or normal auction"
    sql: ${TABLE}.Deal_Auction_Type ;;
  }

  dimension: deal_bid_floor {
    type: number
    description: "The bid floor of the specific deal. every bid price below it will be immediately filtered out"
    sql: ${TABLE}.Deal_Bid_Floor ;;
  }

  dimension: deal_data_fee {
    description: "when creating a deal which take use of data targeting or 3rd party vendor,
                  there can be an extra charge to the cost of the bid"
    type: number
    sql: ${TABLE}.Deal_Data_Fee ;;
  }

  dimension: deal_demand_margin_pct {
    type: number
    sql: ${TABLE}.Deal_demand_margin_pct ;;
    value_format: "0\%"
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension: deal_end {
    type: date
    description: "Deal contract End date"
    sql: ${TABLE}.Deal_End ;;
  }

  dimension: deal_id {
    description: "The Deal Externatal ID , contain 1st & 3rd party deals"
    type: string
    sql: ${TABLE}.Deal_ID;;
    case_sensitive: no
  }

  dimension: deal_key {
    type: number
    sql: ${TABLE}.Deal_Key ;;
    hidden: yes
  }

  dimension: deal_brand_key {
    type: number
    sql: ${TABLE}.deal_brand_key ;;
    hidden: yes
  }


  dimension: deal_agency_key {
    type: number
    sql: ${TABLE}.deal_agency_key ;;
    hidden: yes
  }


  dimension: deal_priority_key {
    type: number
    sql: ${TABLE}.deal_priority_key ;;
    hidden: yes
  }

  dimension: deal_name {
    description: "Deal Description"
    type: string
    sql: ${TABLE}.Deal_Name ;;
  }

  dimension: deal_office {
    description: "Indicates the office to which the deal sales is associated with.   This is not the geo targeting of a deals."
    type: string
    sql: ${TABLE}.Deal_Office ;;
  }

  dimension: deal_start {
    type: date
    description: "Deal contract Start date"
    sql: ${TABLE}.Deal_Start ;;
  }

  dimension: deal_supply_margin_pct {
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


  dimension: internal_deal_id {
    type: number
    sql: ${TABLE}.Internal_Deal_ID ;;
  }

  dimension: monthly_rev_target {
    description: "The monthly revenue target of the deal"
    type: number
    sql: ${TABLE}.Monthly_Rev_Target ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: vcr_target {
    type: number
    description: "Video complete rate threshold"
    sql: ${TABLE}.Vcr_Target ;;
  }

  dimension: viewability_target {
    description: "deal viewability target"
    type: number
    sql: ${TABLE}.Viewability_Target ;;
  }

dimension: overall_imp_cap {
  type: number
  description: "The goal of impressions the deal should get "
  sql: ${TABLE}.overall_imp_cap ;;
}

  measure: count {
    type: count
    drill_fields: [deal_name]
    hidden: yes
  }
}
