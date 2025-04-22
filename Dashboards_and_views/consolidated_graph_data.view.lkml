# The name of this view in Looker is "Consolidated Graph Data"
view: consolidated_graph_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.consolidated_graph_data ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Cost" in Explore.

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
    value_format: "$#,##0.00"
  }

  measure: daily_gross_target {
    type: sum
    sql: ${TABLE}.daily_gross_target ;;
  }

  measure: daily_net_target {
    type: sum
    sql: ${TABLE}.daily_net_target ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.Device_Type ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: event {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_date ;;
  }

  measure: gp {
    type: sum
    sql: ${TABLE}.GP ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "$#,##0.00"
  }
  measure: count {
    type: count
  }
}
