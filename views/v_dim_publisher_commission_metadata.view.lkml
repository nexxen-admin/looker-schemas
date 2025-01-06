view: v_dim_publisher_commission_metadata {
  sql_table_name: BI_New.v_dim_publisher_commission_metadata ;;

  dimension_group: commission_begin_date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.commission_begin_date_key ;;
  }
  dimension_group: commission_end_date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.commission_end_date_key ;;
  }
  dimension_group: current_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.current_start_date ;;
  }
  dimension: days_since_last_activity_date {
    type: number
    sql: ${TABLE}.days_since_last_activity_date ;;
  }
  dimension: days_since_prior_activity {
    type: number
    sql: ${TABLE}.days_since_prior_activity ;;
  }
  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }
  dimension: is_current {
    type: number
    sql: ${TABLE}.is_current ;;
  }
  dimension_group: last_activity_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.last_activity_date ;;
  }
  dimension_group: prior_activity {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.prior_activity_date ;;
  }
  dimension_group: prior_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.prior_start_date ;;
  }
  dimension: pub_key {
    type: number
    sql: ${TABLE}.pub_key ;;
  }
  measure: count {
    type: count
  }
}
