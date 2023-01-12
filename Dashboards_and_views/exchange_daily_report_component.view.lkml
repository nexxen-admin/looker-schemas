# The name of this view in Looker is "Exchange Daily Report Component"
view: exchange_daily_report_component {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Exchange_daily_report_component ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Cost" in Explore.

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
    #sql: ${cost} ;;
  #}

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

  dimension: file_record {
    type: string
    sql: ${TABLE}.file_record ;;
  }

  dimension: record_type {
    type: string
    sql: ${TABLE}.record_type ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.Revenue ;;
  }

  dimension: subcategory {
    type: string
    sql: ${TABLE}.subcategory ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
