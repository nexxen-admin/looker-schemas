view: metric_info {

  sql_table_name: METRIC_INFO ;;

  dimension: component {
    type: string
    sql: ${TABLE}."COMPONENT" ;;
  }

  dimension: metric_id {
    type: string
    sql: ${TABLE}."METRIC_ID" ;;
  }

  dimension: time_unit {
    type: number
    sql: ${TABLE}."TIME_UNIT" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
