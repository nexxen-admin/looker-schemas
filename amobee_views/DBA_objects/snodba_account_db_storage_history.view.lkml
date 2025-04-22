view: snodba_account_db_storage_history {

  derived_table: {
    sql:
    select USAGE_DATE, DATABASE_NAME,AVERAGE_DATABASE_BYTES
    from table(information_schema.database_storage_usage_history(dateadd('days',-21,current_date()),current_date()));;
  }

  dimension_group: usage {
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
    sql: ${TABLE}."USAGE_DATE" ;;
  }

  dimension: database_name {
    type: string
    sql: ${TABLE}."DATABASE_NAME" ;;
  }

  dimension: average_database_bytes {
    type:  number
    sql: ${TABLE}."AVERAGE_DATABASE_BYTES";;
  }

  measure: average_database_bytes_sum {
    type: sum
    sql: ${average_database_bytes}/1024/1024/1024 ;;
  }



}
