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

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Av Mp Net" in Explore.

  measure: av_mp_net {
    type: sum
    sql: ${TABLE}."AV MP Net" ;;
  }

  measure: av_mp_total_rev {
    type: sum
    sql: ${TABLE}."AV MP Total Rev" ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
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
  }

  measure: inventory {
    type: sum
    sql: ${TABLE}.inventory ;;
  }

  dimension: media_type {
    type: string
    sql: ${TABLE}.media_type ;;
  }

  measure: player_total_rev {
    type: sum
    sql: ${TABLE}."Player Total Rev" ;;
  }

  measure: pub_mp_net {
    type: sum
    sql: ${TABLE}."Pub MP Net" ;;
  }

  measure: pub_mp_total_rev {
    type: sum
    sql: ${TABLE}."Pub MP Total Rev" ;;
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.requests ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  measure: sf {
    type: sum
    sql: ${TABLE}.SF ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
