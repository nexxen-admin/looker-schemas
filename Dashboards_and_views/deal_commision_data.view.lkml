# The name of this view in Looker is "Deal Commision Data"
view: deal_commision_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Deal_Commission_Data ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Agency" in Explore.

  dimension: agency {
    type: string
    sql: ${TABLE}.agency ;;
  }

  measure: amsplit_cogs {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.AMSplitCogs ;;
  }

  dimension: deal_start {
    type: date
    sql: ${TABLE}.deal_start ;;
  }

  dimension: deal_end {
    type: date
    sql: ${TABLE}.deal_end ;;
  }

  measure: amsplit_net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.AMSplitNetRevenue ;;
  }

  measure: amsplit_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.AMSplitRevenue ;;
  }

  dimension: barter_rebate {
    type: number
    sql: ${TABLE}.barter_rebate ;;
  }


  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: buy_type {
    type: string
    sql: ${TABLE}.Buy_Type ;;
  }

  measure: cogs {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.cogs ;;
  }

  dimension: deal_description {
    type: string
    sql: ${TABLE}.deal_description ;;
  }

  dimension: deal_id {
    type: string
    sql: ${TABLE}.deal_id ;;
  }

  dimension: dsp_name {
    type: string
    sql: ${TABLE}.dsp_name ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event {
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
    sql: ${TABLE}.event_date ;;
  }

  dimension_group: db_update_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_update_date ;;
  }

# Convert the full timestamp to a sortable number (Unix seconds)
  dimension: db_updated_number {
    type: number
    sql: EXTRACT(EPOCH FROM ${db_update_date_raw}) ;;
    label: "DB Updated Unix Time"
    hidden: yes
  }

  measure: max_database_update_timestamp {
    type: max
    sql: ${db_updated_number} ;;
    label: "Max DB Update"
    hidden: yes
  }


  measure: final_database_last_update {
    type: string
    sql: TO_CHAR(TO_TIMESTAMP(${max_database_update_timestamp}), 'YYYY-MM-DD HH24:MI:SS') ;;
    label: "Deal Commision Data DB Update Date"
    html:
    <div style="font-family: Arial, sans-serif; font-size: 11px; line-height: 1.5; text-align: center; color: #000000;">
      <span style="font-weight: normal; word-spacing: 4px;">Deal Commision Data DB Update Date (UTC)</span><br>
      <span style="word-spacing: 15px;">{{ rendered_value }}</span>
    </div> ;;}

  measure: gross_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Gross_Revenue ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  measure: net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.net_revenue ;;
  }

  dimension: office {
    type: string
    sql: ${TABLE}.Office ;;
  }

  measure: ops_split_cogs {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.OpsSplitCogs ;;
  }

  measure: ops_split_net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.OpsSplitNetRevenue ;;
  }

  measure: ops_split_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.OpsSplitRevenue ;;
  }

  dimension: personnel_name {
    type: string
    sql: ${TABLE}.personnel_name ;;
  }

  dimension: personnel_role {
    type: string
    sql: ${TABLE}.personnel_role ;;
  }

  dimension: deal_type {
    type: string
    sql: ${TABLE}.deal_type ;;
  }

  measure: sales_split_barter_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplitBarterRebate ;;
  }

  measure: sales_split_cogs {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplitCogs ;;
  }

  measure: sales_split_net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplitNetRevenue ;;
  }

  measure: sales_split_net_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplitNetRevenue_No_Rebate ;;
  }

  measure: sales_split_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplitRevenue ;;
  }

  measure: sales_split_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplitRevenue_No_Rebate ;;
  }

  measure: total_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.TotalRevenue ;;
  }

  measure: split_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: case when ${TABLE}.personnel_role='Account Manager' then CAST(${TABLE}.AMSplitRevenue AS float)
              when ${TABLE}.personnel_role='Sales' then CAST(${TABLE}.SalesSplitRevenue AS float)
              else CAST(${TABLE}.OpsSplitRevenue AS float) end  ;;
  }

  measure: split_net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: case when ${TABLE}.personnel_role='Account Manager' then CAST(${TABLE}.AMSplitNetRevenue AS float)
              when ${TABLE}.personnel_role='Sales' then CAST(${TABLE}.SalesSplitNetRevenue AS float)
              else CAST(${TABLE}.OpsSplitNetRevenue AS float) end  ;;
  }

  measure: split_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: case when ${TABLE}.personnel_role='Sales' then CAST(${TABLE}.SalesSplitRevenue_No_Rebate AS float)
              else null end  ;;
  }

  measure: split_net_revenue_no_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: case when ${TABLE}.personnel_role='Sales' then CAST(${TABLE}.SalesSplitNetRevenue_No_Rebate AS float)
      else null end  ;;
  }

  dimension: rebate_percent {
    type: number
    sql: ${TABLE}.rebate_percent;;
  }

  dimension: days_in_quarter{
    type: number
    sql:   datediff('day',${adjusted_delivered_start_date},case when ${deal_end} >=
    '2024-12-31' then '2024-12-31' else ${deal_end} end)+1;;
  }

  dimension: yesterday_date {
    type: date
    sql: date_trunc('day',current_timestamp)-1 ;;
    hidden: yes
  }

  dimension: adjusted_delivered_start_date {
    type: date
    sql: case when ${deal_start} > ${quarter_start} then ${deal_start} else ${quarter_start} end ;;
  }

  dimension: adjusted_delivered_end_date {
    type: date
    sql: case when ${deal_end} > ${yesterday_date} then
  ${yesterday_date} else ${deal_end} end ;;
  }

  dimension: days_so_far {
    type: number
    sql: datediff('day',${adjusted_delivered_start_date},${adjusted_delivered_end_date})+1 ;;
  }

  measure: current_q_daily_run_rate {
    type: number
    sql: ${split_revenue} / nullif(${max_days_so_far},0) ;;
    value_format: "$#,##0.00"
  }

  dimension: quarter_start {
    type: date
    sql: date_trunc('quarter',current_timestamp) ;;
  }

  measure: max_days_so_far {
    type: max
    sql: ${days_so_far} ;;
    hidden: yes
  }

  measure: max_days_in_quarter {
    type: max
    sql: ${days_in_quarter} ;;
    hidden: yes
  }

  measure: current_q_projected_split_rev {
    type: number
    sql: (${split_revenue} / nullif(${max_days_so_far},0))*${max_days_in_quarter} ;;
    value_format: "$#,##0.00"
  }


  measure: count {
    type: count
    drill_fields: [dsp_name, personnel_name]
  }
}
