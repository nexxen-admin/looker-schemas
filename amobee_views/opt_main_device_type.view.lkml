view: opt_main_device_type {
  # You can specify the table name if it's different from the view name:
  sql_table_name: AN_MAIN..device_type ;;

  # Define your dimensions and measures here, like this:
  dimension: device_type_id {
    description: "device_type_id"
    type: number
    sql: ${TABLE}.device_type_id ;;
    value_format_name: id
  }

  dimension: device_descripition {
    description: "Device"
    type: string
    sql: ${TABLE}.description ;;
  }

}
