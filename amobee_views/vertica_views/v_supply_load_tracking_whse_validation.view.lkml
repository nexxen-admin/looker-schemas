view: v_supply_load_tracking_whse_validation {

  sql_table_name: RAWDB.LOAD_TRACKING ;;

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
    sql: datediff(hour, TIMESTAMPADD(hour, 24, TIMESTAMPADD(hour, -${v_timezone.utc_offset}::INTEGER, ${load_through_date}::TIMESTAMP)), current_timestamp);;
  }
}
