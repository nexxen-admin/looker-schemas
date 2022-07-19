# The name of this view in Looker is "Sam Lt Comm"
view: sam_lt_comm {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.sam_LT_COMM ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Barter Rebate" in Explore.

  dimension: barter_rebate {
    type: number
    sql: ${TABLE}.Barter_Rebate ;;
  }

  dimension: bidswitch_platform_cost {
    type: number
    sql: ${TABLE}.Bidswitch_Platform_Cost ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_bidswitch_platform_cost {
    type: sum
    sql: ${bidswitch_platform_cost} ;;
  }

  measure: average_bidswitch_platform_cost {
    type: average
    sql: ${bidswitch_platform_cost} ;;
  }

  dimension: cogs_amer {
    type: number
    sql: ${TABLE}.cogs_AMER ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event_month {
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
    sql: ${TABLE}.Event_Month ;;
  }

  dimension: gross_revenue_amer {
    type: number
    sql: ${TABLE}.gross_revenue_AMER ;;
  }

  dimension: media_math_rebate {
    type: number
    sql: ${TABLE}.MediaMath_Rebate ;;
  }

  dimension: net_revenue {
    type: number
    sql: ${TABLE}.Net_Revenue ;;
  }

  dimension: operations_owner {
    type: string
    sql: ${TABLE}.operations_owner ;;
  }

  dimension: operations_owner_id {
    type: string
    sql: ${TABLE}.operations_owner_id ;;
  }

  dimension: pub_group {
    type: string
    sql: ${TABLE}.pub_group ;;
  }

  dimension: pub_platform_fee {
    type: number
    sql: ${TABLE}.Pub_Platform_Fee ;;
  }

  dimension: pubmatic_platform_fee {
    type: number
    sql: ${TABLE}.Pubmatic_Platform_Fee ;;
  }

  dimension: revenue_group {
    type: string
    sql: ${TABLE}.revenue_group ;;
  }

  dimension: ssp_platform_fee {
    type: number
    sql: ${TABLE}.SSP_Platform_Fee ;;
  }

  dimension: supply_id {
    type: string
    sql: ${TABLE}.supply_id ;;
  }

  dimension: supply_name {
    type: string
    sql: ${TABLE}.supply_name ;;
  }

  dimension: supply_source {
    type: string
    sql: ${TABLE}.supply_source ;;
  }

  measure: count {
    type: count
    drill_fields: [supply_name]
  }
}
