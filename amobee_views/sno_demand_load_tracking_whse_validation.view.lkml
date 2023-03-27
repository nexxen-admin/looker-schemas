view: sno_demand_load_tracking_whse_validation {

  sql_table_name: DEMAND_MART.LOAD_TRACKING ;;

  dimension: end_timezone {
    type: number
    sql: ${TABLE}.END_TIMEZONE ;;
  }

  dimension: load_through_date {
    type: date_time
    sql: ${TABLE}.LOAD_THROUGH_DATE ;;
  }

  dimension: schema_name {
    type: string
    sql: ${TABLE}.SCHEMA_NAME ;;
  }

  dimension: start_timezone {
    type: number
    sql: ${TABLE}.START_TIMEZONE ;;
  }

  dimension: table_name {
    type: string
    sql: ${TABLE}.TABLE_NAME ;;
  }

  dimension: timedelta {
    type: number
    sql: datediff(hour, dateadd(hour, 24, dateadd(hour, -${timezone.utc_offset}, ${load_through_date})), current_timestamp);;
  }
}
