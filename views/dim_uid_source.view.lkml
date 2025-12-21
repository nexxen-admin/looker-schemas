view: dim_uid_source {
  sql_table_name: BI_New.dim_uid_source ;;

  dimension_group: db_create {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.DB_Create_Date ;;
  }
  dimension_group: db_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.DB_Update_Date ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }
  dimension: uid_source {
    label: "Uid Source Name"
    type: string
    sql: ${TABLE}.uid_source ;;
  }
  dimension: uid_source_key {
    type: number
    sql: ${TABLE}.uid_source_key ;;
  }
  measure: count {
    type: count
  }
}
