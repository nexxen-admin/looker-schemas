view: v_load_tracking {
  sql_table_name: RAWDB.LOAD_TRACKING ;;

  dimension: end_timezone {
    type: number
    hidden: yes
    sql: ${TABLE}.END_TIMEZONE ;;
  }

  dimension: load_through_date {
    type: date_raw
    hidden: yes
    sql: ${TABLE}.LOAD_THROUGH_DATE ;;
  }

  dimension: schema_name {
    type: string
    hidden: yes
    sql: ${TABLE}.SCHEMA_NAME ;;
  }

  dimension: start_timezone {
    type: number
    hidden: yes
    sql: ${TABLE}.START_TIMEZONE ;;
  }

  dimension: table_name {
    type: string
    hidden: yes
    sql: ${TABLE}.TABLE_NAME ;;
  }
}
