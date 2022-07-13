# The name of this view in Looker is "Sam"
view: sam {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.sam ;;
  drill_fields: [sam_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: sam_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.SAM_ID ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Active Days In Quarter" in Explore.

  dimension: active_days_in_quarter {
    type: number
    sql: ${TABLE}.Active_Days_In_Quarter ;;
  }

  dimension: barter_rebate_to_date {
    type: number
    sql: ${TABLE}.Barter_Rebate_to_Date ;;
  }

  dimension: baseline_target {
    type: number
    sql: ${TABLE}.Baseline_Target ;;
  }

  dimension: cogs_to_date {
    type: number
    sql: ${TABLE}.COGS_to_Date ;;
  }

  dimension: days_in_quarter {
    type: number
    sql: ${TABLE}.Days_in_Quarter ;;
  }

  dimension: dsp_platform_cost_to_date {
    type: number
    sql: ${TABLE}.DSP_Platform_Cost_to_Date ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  measure: goal_target {
    type: sum
    sql: ${TABLE}.Goal_Target ;;
  }

  measure: gross_revenue_to_date {
    type: sum
    sql: ${TABLE}.Gross_Revenue_to_Date ;;
  }

  measure: growth_target {
    type: sum
    sql: ${TABLE}.Growth_Target ;;
  }

  measure: mm_rebate_to_date {
    type: sum
    sql: ${TABLE}.MM_Rebate_to_Date ;;
  }

  measure: net_revenue_to_date {
    type: sum
    sql: ${TABLE}.Net_Revenue_to_Date ;;
  }

  measure: platform_cost_to_date {
    type: sum
    sql: ${TABLE}.Platform_Cost_to_Date ;;
  }

  measure: pub_platform_fee_to_date {
    type: sum
    sql: ${TABLE}.Pub_Platform_Fee_to_Date ;;
  }

  measure: qtd_baseline_target {
    type: sum
    sql: ${TABLE}.QTD_Baseline_Target ;;
  }

  measure: qtd_goal_target {
    type: sum
    sql: ${TABLE}.QTD_Goal_Target ;;
  }

  dimension: qtd_growth_target {
    type: number
    sql: ${TABLE}.QTD_Growth_Target ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: quarter_start {
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
    sql: ${TABLE}.Quarter_Start_Date ;;
  }

  dimension: sam {
    type: string
    sql: ${TABLE}.SAM ;;
  }

  dimension: sam_manager {
    type: string
    sql: ${TABLE}.SAM_Manager ;;
  }

  dimension: sam_manager_id {
    type: string
    sql: ${TABLE}.SAM_Manager_ID ;;
  }

  set: detail {
    fields: [
      quarter_start_date,
      sam_id,
      sam,
      sam_manager_id,
      sam_manager,
      active_days_in_quarter,
      days_in_quarter
    ]
  }
}
