# The name of this view in Looker is "Unruly Player"
view: unruly_player_demands {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Unruly_Player_Demands ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: activity {
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
    sql: ${TABLE}.activity_date ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}.year ;;
  }

  dimension: seat_name {
    type: string
    sql: ${TABLE}.seat_name ;;
  }

  dimension: pub_id {
    type: number
    sql: ${TABLE}.pub_id ;;
  }


  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Av Mp Net" in Explore.

  measure: av_mp_net {
    type: sum
    sql: ${TABLE}."AV MP Net" ;;
    value_format: "#,##0"
  }

  measure: av_mp_total_rev {
    type: sum
    sql: ${TABLE}."AV MP Total Rev" ;;
    value_format: "#,##0"
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
    value_format: "#,##0"
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  # measure: total_cost {
  #   type: sum
  #   sql: ${cost} ;;
  # }

  # measure: average_cost {
  #   type: average
  #   sql: ${cost} ;;
  # }

  dimension: data_base {
    type: string
    sql: ${TABLE}."DataBase" ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
  }

  measure: inventory {
    type: sum
    sql: ${TABLE}.inventory ;;
    value_format: "#,##0"
  }

  dimension: media_type {
    type: string
    sql: ${TABLE}.media_type ;;
  }

  measure: player_total_rev {
    type: sum
    sql: ${TABLE}."Player Total Rev" ;;
    value_format: "#,##0"
  }

  measure: pub_mp_net {
    type: sum
    sql: ${TABLE}."Pub MP Net" ;;
    value_format: "#,##0"
  }

  measure: pub_mp_total_rev {
    type: sum
    sql: ${TABLE}."Pub MP Total Rev" ;;
    value_format: "#,##0"
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.requests ;;
    value_format: "#,##0"
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "#,##0"
  }

  measure: sf {
    type: sum
    sql: ${TABLE}.SF ;;
    value_format: "#,##0"
  }

  measure: MyCast_20 {
    type: sum
    sql: ${TABLE}."MyCast 20%" ;;
    value_format: "#,##0"
  }

  measure: Widgets_AI {
    type: sum
    sql: ${TABLE}."Widgets AI" ;;
    value_format: "#,##0"
  }

  measure: Wiseroll_LTD_Yeda {
    label:"Wiseroll LTD + Yeda"
    type: sum
    sql: ${TABLE}."Wiseroll LTD + Yeda" ;;
    value_format: "#,##0"
  }


  measure: count {
    type: count
    drill_fields: []
  }
}
