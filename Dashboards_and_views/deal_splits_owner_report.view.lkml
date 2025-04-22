# The name of this view in Looker is "Deal Splits Owner Report"
view: deal_splits_owner_report {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Deal_splits_owner_report ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Agency" in Explore.

  dimension: agency {
    type: string
    sql: ${TABLE}.agency ;;
  }

  dimension: deal_type {
    type: string
    sql: ${TABLE}.deal_type ;;
  }

  measure: amsplit_cogs {
    type: sum
    sql: ${TABLE}.AMSplitCogs ;;
  }

  measure: amsplit_net_revenue {
    type: sum
    sql: ${TABLE}.AMSplitNetRevenue ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  #measure: total_amsplit_net_revenue {
    #type: sum
   # sql: ${amsplit_net_revenue} ;;
  #}

  ##measure: average_amsplit_net_revenue {
   #type: average
    #sql: ${amsplit_net_revenue} ;;
  #}

  measure: amsplit_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.AMSplitRevenue ;;
  }

  measure: barter_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.barter_rebate ;;
  }

  dimension: brand {
    type: string
    drill_fields: [agency]
    sql: ${TABLE}.brand ;;
  }

  dimension: buy_type {
    type: string
    drill_fields: [brand, agency]
    sql: ${TABLE}.Buy_Type ;;
  }

  measure: cogs {
    type: sum
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

  measure: gross_revenue {
    type: sum
    label: "Deal Reveneu"
    value_format: "$#,##0.00"
    sql: ${TABLE}.Gross_Revenue ;;
  }

  measure: net_revenue {
    type: sum
    label: "Net Revenue"
    value_format: "$#,##0.00"
    sql: ${TABLE}.net_revenue ;;
  }

  dimension: office {
    type: string
    sql: ${TABLE}.Office ;;
  }

  measure: ops_split_cogs {
    type: sum
    value_format: "#,##0.00"
    sql: ${TABLE}.OpsSplitCogs ;;
  }

  measure: ops_split_net_revenue {
    type: sum
    label: "Split Net Revenue"
    value_format: "$#,##0.00"
    sql: ${TABLE}.OpsSplitNetRevenue ;;
  }

  measure: ops_split_revenue {
    type: sum
    label: "Split Revenue"
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

  measure: sales_split_barter_rebate {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.SalesSplitBarterRebate ;;
  }

  measure: sales_split_cogs {
    type: sum
    value_format: "#,##0.00"
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

  measure: count {
    type: count
    drill_fields: [personnel_name, dsp_name]
  }
}
