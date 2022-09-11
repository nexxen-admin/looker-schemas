# The name of this view in Looker is "V Dim Player Width Passed"
view: v_dim_player_width_passed {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_TVDSP.V_Dim_Player_Width_Passed ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: db_create {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Create_Date ;;
  }

  dimension_group: db_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Update_Date ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Player Width Passed Exact Width" in Explore.

  dimension: player_width_passed_exact_width {
    type: number
    sql: ${TABLE}.Player_Width_Passed_Exact_Width ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_player_width_passed_exact_width {
    type: sum
    sql: ${player_width_passed_exact_width} ;;
  }

  measure: average_player_width_passed_exact_width {
    type: average
    sql: ${player_width_passed_exact_width} ;;
  }

  dimension: player_width_passed_key {
    type: number
    sql: ${TABLE}.Player_Width_Passed_Key ;;
  }

  dimension: player_width_passed_range {
    type: string
    sql: ${TABLE}.Player_Width_Passed_Range ;;
  }

  dimension: range_sort_column {
    type: number
    sql: ${TABLE}.Range_Sort_Column ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
