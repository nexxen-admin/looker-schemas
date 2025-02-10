view: etl_acr_count_device_id {
  sql_table_name: BI_New.acr_count_device_id ;;

  dimension: count_of_device_id {
    type: number
    sql: ${TABLE}.count_of_device_id ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."date" ;;
  }
  measure: count {
    type: count
  }
}
