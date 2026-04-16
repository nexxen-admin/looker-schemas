view: dim_rtb_device_type {
  sql_table_name: BI_New.dim_rtb_device_type ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
  }
  dimension: rtb_device_type_id {
    type: number
    sql: ${TABLE}.rtb_device_type_id ;;
  }
  dimension: rtb_device_type_name {
    type: string
    sql: ${TABLE}.rtb_device_type_name ;;
  }
  measure: count {
    type: count
    drill_fields: [rtb_device_type_name]
  }
}
