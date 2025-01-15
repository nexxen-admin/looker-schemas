view: v_dim_publisher_commission_metadata {
  sql_table_name: BI_New.v_dim_publisher_commission_metadata ;;

  dimension_group: commission_begin_date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.commission_begin_date_key ;;
    description: "The date on which publisher starts the commissionable period (logic based)"
  }
  dimension_group: commission_end_date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.commission_end_date_key ;;
    description: "The date on which publisher ends the commissionable period. (logic based)"
  }
  dimension_group: current_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.current_start_date ;;
    description: "The earliest date on which the publisher generated revenue within the 365 day period"
  }
  dimension: days_since_last_activity_date {
    type: number
    sql: ${TABLE}.days_since_last_activity_date ;;
    description: "# of days passed between yesterday's date and the last time the publisher was active. Can help to identify how long publisher is not active"
  }
  dimension: days_since_prior_activity {
    type: number
    sql: ${TABLE}.days_since_prior_activity ;;
    description: "# of days passed between prior activity date and current start date. Day Diff between current start date and prior activity date"
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
    description: "Flag to indentify most current record of commission for the specific publisher"
  }
  dimension_group: last_activity_date {
    type: time
    label: "Last Activity"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.last_activity_date ;;
    description: "The most recent date on which the publisher generated revenue within the 365 day period"
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
    description: "The earliest date on which the publisher generated revenue before the current start date, for new publishers, this date will be 1900"
  }
  dimension: pub_key {
    type: number
    sql: ${TABLE}.pub_key ;;
  }
  measure: count {
    type: count
  }
}
