# The name of this view in Looker is "Unruly Pmp"
view: unruly_pmp {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.unruly_pmp ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account Name" in Explore.

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: billing_agency {
    type: string
    sql: ${TABLE}.billing_agency ;;
  }

  dimension: classification {
    type: string
    sql: ${TABLE}.Classification ;;
  }

  dimension: deal_description {
    type: string
    sql: ${TABLE}.deal_description ;;
  }

  dimension: deal_id {
    type: string
    sql: ${TABLE}.Deal_ID ;;
  }

  dimension: deal_sales_people_count {
    type: number
    sql: ${TABLE}.Deal_Sales_People_Count ;;
  }

  dimension: deal_sales_person {
    type: string
    sql: ${TABLE}.Deal_Sales_Person ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: division {
    type: string
    sql: ${TABLE}.division ;;
  }

  dimension: dsp_account {
    type: string
    sql: ${TABLE}.dsp_account ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: est_close {
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
    sql: ${TABLE}.est_close_date ;;
  }

  dimension_group: event_month {
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
    sql: ${TABLE}.event_month ;;
  }

  dimension: op_owner {
    type: string
    sql: ${TABLE}.op_owner ;;
  }

  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_ID ;;
  }

  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }

  dimension: parent_account {
    type: string
    sql: ${TABLE}.parent_account ;;
  }

  dimension: parent_billing_agency {
    type: string
    sql: ${TABLE}.parent_billing_agency ;;
  }

  dimension: rev_type {
    type: string
    sql: ${TABLE}.Rev_Type ;;
  }

  dimension: split_deal_cogs {
    type: number
    sql: ${TABLE}.Split_Deal_COGS ;;
  }

  dimension: split_deal_impressions {
    type: number
    sql: ${TABLE}.Split_Deal_Impressions ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_split_deal_impressions {
    type: sum
    sql: ${split_deal_impressions} ;;
  }

  measure: average_split_deal_impressions {
    type: average
    sql: ${split_deal_impressions} ;;
  }

  dimension: split_deal_revenue {
    type: number
    sql: ${TABLE}.Split_Deal_Revenue ;;
  }

  dimension: total_cogs {
    type: number
    sql: ${TABLE}.Total_COGS ;;
  }

  dimension: total_impressions {
    type: number
    sql: ${TABLE}.Total_Impressions ;;
  }

  dimension: total_revenue {
    type: number
    sql: ${TABLE}.Total_Revenue ;;
  }

  dimension: un_opportunity {
    type: string
    sql: ${TABLE}.un_opportunity ;;
  }

  measure: count {
    type: count
    drill_fields: [account_name, opportunity_name]
  }
}
