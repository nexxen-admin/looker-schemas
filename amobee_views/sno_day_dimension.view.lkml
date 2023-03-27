view: day_dimension {
  sql_table_name: DIM.DAY_DIMENSION ;;

  dimension: broadcast_month {
    type: number
    sql: ${TABLE}.BROADCAST_MONTH ;;
  }

  dimension: broadcast_quarter {
    type: number
    sql: ${TABLE}.BROADCAST_QUARTER ;;
  }

  dimension_group: broadcast_sunday {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.BROADCAST_SUNDAY ;;
  }

  dimension: broadcast_week {
    type: number
    sql: ${TABLE}.BROADCAST_WEEK ;;
  }

  dimension: broadcast_year {
    type: number
    sql: ${TABLE}.BROADCAST_YEAR ;;
  }

  dimension_group: date_value {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DATE_VALUE ;;
  }

  dimension: day_name {
    type: string
    sql: ${TABLE}.DAY_NAME ;;
  }

  dimension: day_number_of_month {
    type: number
    sql: ${TABLE}.DAY_NUMBER_OF_MONTH ;;
  }

  dimension: day_number_of_quarter {
    type: number
    sql: ${TABLE}.DAY_NUMBER_OF_QUARTER ;;
  }

  dimension: day_number_of_year {
    type: number
    sql: ${TABLE}.DAY_NUMBER_OF_YEAR ;;
  }

  dimension_group: first_of_month {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.FIRST_OF_MONTH ;;
  }

  dimension: long_month_name {
    type: string
    sql: ${TABLE}.LONG_MONTH_NAME ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.MONTH ;;
  }

  dimension: month_number_of_quarter {
    type: number
    sql: ${TABLE}.MONTH_NUMBER_OF_QUARTER ;;
  }

  dimension: month_number_of_year {
    type: number
    sql: ${TABLE}.MONTH_NUMBER_OF_YEAR ;;
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}.QUARTER ;;
  }

  dimension: short_month_name {
    type: string
    sql: ${TABLE}.SHORT_MONTH_NAME ;;
  }

  dimension: week_number_of_year {
    type: number
    sql: ${TABLE}.WEEK_NUMBER_OF_YEAR ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.YEAR ;;
  }

  measure: count {
    type: count
    drill_fields: [day_name, short_month_name, long_month_name]
  }

  measure: count_days {
    type: number
    label: "Count of Days"
    sql:  count(${date_value_date});;
  }

}
