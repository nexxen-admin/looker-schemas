# The name of this view in Looker is "Consolidated Revenue"
view: consolidated_revenue {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.consolidated_revenue ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Category" in Explore.

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }

  measure: cost_2_days_ago {
    type: sum
    sql: ${TABLE}.COST_2_DAYS_AGO ;;
    value_format: "$#,##0.00"
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  dimension: device_type {
    type: string
    sql: ${TABLE}.Device_Type ;;
  }

  measure: gross_monthly_target {
    type: sum
    sql: ${TABLE}.Gross_Monthly_Target ;;
    value_format: "$#,##0.00"
  }

  measure: gross_mtd_target {
    type: sum
    sql: ${TABLE}.Gross_MTD_Target ;;
    value_format: "$#,##0.00"
  }

  measure: gross_qtd_target {
    type: sum
    sql: ${TABLE}.Gross_QTD_Target ;;
    value_format: "$#,##0.00"
  }

  measure: gross_quarterly_target {
    type: sum
    sql: ${TABLE}.Gross_Quarterly_Target ;;
    value_format: "$#,##0.00"
  }

  measure: gross_yearly_target {
    type: sum
    sql: ${TABLE}.Gross_Yearly_Target ;;
    value_format: "$#,##0.00"
  }

  measure: gross_yesterday_target {
    type: sum
    sql: ${TABLE}.Gross_Yesterday_Target ;;
    value_format: "$#,##0.00"
  }

  measure: gross_ytd_target {
    type: sum
    sql: ${TABLE}.Gross_YTD_Target ;;
    value_format: "$#,##0.00"
  }

  measure: mtd_cost {
    type: sum
    sql: ${TABLE}.MTD_COST ;;
    value_format: "$#,##0.00"
  }

  measure: mtd_revenue {
    type: sum
    sql: ${TABLE}.MTD_Revenue ;;
    value_format: "$#,##0.00"
  }

  measure: net_monthly_target {
    type: sum
    sql: ${TABLE}.Net_Monthly_Target ;;
    value_format: "$#,##0.00"
  }

  measure: net_mtd_target {
    type: sum
    sql: ${TABLE}.Net_MTD_Target ;;
    value_format: "$#,##0.00"
  }

  measure: net_qtd_target {
    type: sum
    sql: ${TABLE}.Net_QTD_Target ;;
    value_format: "$#,##0.00"
  }

  measure: net_quarterly_target {
    type: sum
    sql: ${TABLE}.Net_Quarterly_Target ;;
    value_format: "$#,##0.00"
  }

  measure: net_yearly_target {
    type: sum
    sql: ${TABLE}.Net_Yearly_Target ;;
    value_format: "$#,##0.00"
  }

  measure: net_yesterday_target {
    type: sum
    sql: ${TABLE}.Net_Yesterday_Target ;;
    value_format: "$#,##0.00"
  }

  measure: net_ytd_target {
    type: sum
    sql: ${TABLE}.Net_YTD_Target ;;
    value_format: "$#,##0.00"
  }

  measure: qtd_cost {
    type: sum
    sql: ${TABLE}.QTD_COST ;;
    value_format: "$#,##0.00"
  }

  measure: qtd_revenue {
    type: sum
    sql: ${TABLE}.QTD_REVENUE ;;
    value_format: "$#,##0.00"
  }

  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }

  measure: rev_2_days_ago {
    type: sum
    sql: ${TABLE}.REV_2_DAYS_AGO ;;
    value_format: "$#,##0.00"
  }

  dimension: subcategory {
    type: string
    sql: ${TABLE}.Subcategory ;;
    value_format: "$#,##0.00"
  }

  measure: yesterday_cost {
    type: sum
    sql: ${TABLE}.YESTERDAY_COST ;;
    value_format: "$#,##0.00"
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: yesterday {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.YESTERDAY_DATE ;;
  }

  measure: yesterday_revenue {
    type: sum
    sql: ${TABLE}.YESTERDAY_REVENUE ;;
    value_format: "$#,##0.00"
  }

  measure: ytd_cost {
    type: sum
    sql: ${TABLE}.YTD_COST ;;
    value_format: "$#,##0.00"
  }

  measure: ytd_revenue {
    type: sum
    sql: ${TABLE}.YTD_REVENUE ;;
    value_format: "$#,##0.00"

  }
  measure: count {
    type: count
  }
}
