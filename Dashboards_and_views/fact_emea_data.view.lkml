# The name of this view in Looker is "Fact Emea Data"
view: fact_emea_data {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.fact_emea_data ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Bd User ID" in Explore.

  dimension: bd_user_id {
    type: number
    sql: ${TABLE}.bd_user_id ;;
  }

  dimension: bizdev_owner {
    type: string
    sql: ${TABLE}.bizdev_owner ;;
  }

  measure: current_achievement {
    type: sum
    sql: ${TABLE}.current_achievement ;;
    value_format: "$0.00"
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  # dimension_group: db_updated {
  #   type: time
  #   timeframes: [raw, time, date, week, month, quarter, year]
  #   sql: ${TABLE}.db_updated_date ;;
  # }

  measure: emea_net_rev {
    type: sum
    sql: ${TABLE}.emea_net_rev ;;
    value_format: "$0.00"

  }

  measure: goal {
    type: sum
    sql: ${TABLE}.goal ;;
    value_format: "$0"

  }

  measure: non_emea_cap {
    type: sum
    sql: ${TABLE}.non_emea_cap ;;
    value_format: "$0.00"

  }

  measure: non_emea_net_rev {
    type: sum
    sql: ${TABLE}.non_emea_net_rev ;;
    value_format: "$0.00"

  }

  measure: non_emea_rev_cap {
    type: sum
    sql: ${TABLE}.non_emea_rev_cap ;;
    value_format: "$0.00"

  }

  measure: percent_to_goal {
    type: sum
    sql: ${TABLE}.percent_to_goal ;;
    #value_format: "0\%"

  }

  dimension_group: quarter_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.quarter_start ;;
  }
  measure: count {
    type: count
  }
}
