# The name of this view in Looker is "Investor Kpi"
view: investor_kpi {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Investor_KPI ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Bid Requests" in Explore.

  measure: bid_requests {
    type: sum
    sql: ${TABLE}.Bid_Requests ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.Cost ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  #measure: total_cost {
   # type: sum
    #sql: ${cost} ;;
  #}

  #measure: average_cost {
   # type: average
  #  sql: ${cost} ;;
  #}

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

  dimension: imp_type {
    type: string
    sql: ${TABLE}.Imp_Type ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
  }

  dimension: screen_type {
    type: string
    sql: ${TABLE}.Screen_Type ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}."Source" ;;
  }

  measure: total_revenue {
    type: sum
    sql: ${TABLE}.Total_Revenue ;;
    value_format: "$#,##0"
  }

  measure: Net_Revenue{
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}.Total_Revenue-${TABLE}.Cost ;;
  }

  measure: Margin {
    type: sum
    sql: (${TABLE}.Total_Revenue-${TABLE}.Cost)/${TABLE}.Total_Revenue ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
