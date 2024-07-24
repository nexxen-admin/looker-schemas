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

  measure: barter_rebate {
    type: sum
    label: "Barter Rebate"
    value_format: "$#,##0"
    sql: ${TABLE}.Barter_Rebate ;;
  }

  measure: bidswitch_platform_cost {
    type: sum
    label: "Bidswitch Platform Cost"
    value_format: "$#,##0"
    sql: ${TABLE}.Bidswitch_Platform_Cost ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: COGS {
    type: sum
    label: "COGS"
    value_format: "$#,##0"
    sql: ${TABLE}.COGS ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.


  dimension_group: Quarter_Start {
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
    sql: ${TABLE}.Quarter_Start ;;
  }

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

  measure: Revenue {
    type: sum
    label: "Gross Revenue"
    value_format: "$#,##0"
    sql: ${TABLE}.Revenue ;;
  }

  measure: net_revenue {
    type: sum
    label: "Net Revenue"
    value_format: "$#,##0"
    sql: ${TABLE}.Net_Revenue ;;
  }

  dimension: operations_owner {
    type: string
    label: "Ops Owner"
    sql: ${TABLE}.operations_owner ;;
  }

  dimension: country {
    type: string
    label: "Country"
    sql: ${TABLE}.country ;;
  }

  dimension: operations_owner_id {
    type: string
    label: "Ops Owner ID"
    sql: ${TABLE}.operations_owner_id ;;
  }

  dimension: pub_group {
    type: string
    label: "Pub Group"
    sql: ${TABLE}.pub_group ;;
  }

  measure: pub_platform_fee {
    type: sum
    label: "Pub Platform Fee"
    value_format: "$#,##0"
    sql: ${TABLE}.Pub_Platform_Fee ;;
  }

  dimension: revenue_region {
    type: string
    label: "Revenue Group"
    sql: ${TABLE}.Revenue_Region ;;
  }

  measure: ssp_platform_fee {
    type: sum
    label: "SSP Platform Fee"
    value_format: "$#,##0"
    sql: ${TABLE}.SSP_Platform_Fee ;;
  }

  dimension: supply_id {
    type: number
    label: "Supply ID"
    sql: ${TABLE}.supply_id ;;
  }

  dimension: supply_name {
    type: string
    label: "Supply Name"
    sql: ${TABLE}.supply_name ;;
  }

  dimension: supply_source {
    type: string
    label: "Supply Source"
    sql: ${TABLE}.supply_source ;;
  }

  dimension: Demand_Source {
    type: string
    label: "Demand Source"
    sql: ${TABLE}.Demand_Source ;;
  }

  measure: revenue_demand_adjustment {
    type: sum
    sql: ${TABLE}.Revenue_Demand_Adjustment ;;
    value_format: "$#,##0.00"
  }

  measure: cogs_demand_adjustment {
    type: sum
    sql: ${TABLE}.Cogs_Demand_Adjustment ;;
    value_format: "$#,##0.00"
  }

  measure: traffic_source_fee {
    type: sum
    sql: ${TABLE}.Traffic_Source_Fee ;;
    value_format: "$#,##0.00"
  }

  #dimension: is_gam {
  #  type: string
   # sql:
   #   {% if _user_attributes['allowed_users_sam_lt ']  == 'yes' and ${pub_group}="gam" %}
   #       ${TABLE}.operations_owner
    #  {% else %}
   #       '[REDACTED]'
    #  {% endif %}   ;;
 # }

  measure: count {
    type: count
    drill_fields: [supply_name]
  }
}
