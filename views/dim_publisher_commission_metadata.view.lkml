view: dim_publisher_commission_metadata {
  sql_table_name: BI_New.dim_publisher_commission_metadata ;;

  dimension_group: commission_begin_date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    label: "Commission Start Date"
    sql: ${TABLE}.commission_begin_date_key ;;
  }
  dimension_group: commission_end_date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    label: "Commission End Date"
    sql: ${TABLE}.commission_end_date_key ;;
  }

  dimension_group: current_start {
    label: "Current Publisher Start Date"
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.current_start_date ;;
  }

  dimension: days_since_prior_activity {
    type: number
    sql: ${TABLE}.days_since_prior_activity ;;
  }

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }

  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }

  dimension: is_current {
    type: number
    sql: ${TABLE}.is_current ;;
    description: "Flag that marks the last activity log for a publisher. 1-last activity, 0- previous activity"
  }

  dimension_group: last_activity {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.last_activity_date ;;
    description: "The most recent event_date on which the publisher generated revenue within the 365-day period"
  }

  dimension_group: prior_activity {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.prior_activity_date ;;
    description: "The prior period of the last activity"
  }

  dimension_group: prior_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.prior_start_date ;;
    description: "`Start day of prior activity"
  }

  dimension: pub_key {
    type: number
    sql: ${TABLE}.pub_key ;;
    hidden: yes
  }

  dimension_group: commissionable_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: case when ${fact_ad_daily_agg.date_key_raw} between ${commission_begin_date_key_raw} and ${commission_end_date_key_raw} then ${fact_ad_daily_agg.date_key_raw} else null end ;;
  }

  measure: count {
    type: count
  }
}
