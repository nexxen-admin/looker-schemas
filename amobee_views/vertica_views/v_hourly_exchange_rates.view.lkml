view: v_hourly_exchange_rates{
  label: "Hourly exchange rates"
  sql_table_name: RAWDB.HOURLY_EXCHANGE_RATE ;;

  dimension: hourly_exchange_rate_id {
    type: string
    hidden: yes
    sql: ${TABLE}.hourly_exchange_rate_id ;;
  }

  dimension: keydate {
    type: date_time
    view_label: "Exchange rates"
    label: "Keydate Hour"
    sql: ${TABLE}.keydate ;;
  }

  measure: count_keydate {
    type: number
    label: "Count of Exchange Rates"
    view_label: "Exchange rates"
    sql: count(${TABLE}.keydate) ;;
  }

  measure: count_exp_rates {
    type: number
    label: "Expected Daily Exchange Rates"
    view_label: "Exchange rates"
    hidden: yes
    sql: COALESCE((power(count(distinct ${currency_id_from}) , 2.0) * 24.0) ,0) ;;
  }

  dimension_group: key_date {
    type: time
    label: "Key"
    view_label: "Exchange rates"
    timeframes: [raw,date,month]
    sql: ${TABLE}.keydate ;;
  }

  dimension_group: dst_key_date {
    type: time
    label: "[DST] Local"
    view_label: "Exchange rates"
    timeframes: [raw, date, month]
    sql: case when ${v_platform_client.use_daylight_saving} then (${TABLE}.keydate) AT TIMEZONE ${v_timezone.timezone_name}
      else ${TABLE}.keydate end ;;
  }

  dimension: currency_id_from {
    type: number
    view_label: "Exchange rates"
    label: "Currency id from"
    sql: ${TABLE}.currency_id_from ;;
    value_format_name: id
  }

  dimension: currency_from {
    type: string
    view_label: "Exchange rates"
    label: "Currency from"
    sql: ${TABLE}.currency_from ;;
    bypass_suggest_restrictions: yes
  }

  dimension: currency_id_to {
    type: number
    view_label: "Exchange rates"
    label: "Currency id to"
    sql: ${TABLE}.currency_id_to ;;
    value_format_name: id
  }

  dimension: currency_to {
    type: string
    view_label: "Exchange rates"
    label: "Currency to"
    sql: ${TABLE}.currency_to ;;
    bypass_suggest_restrictions: yes
  }

  dimension: exchange_rate {
    type: number
    view_label: "Exchange rates"
    label: "Exchange rate"
    sql: ${TABLE}.exchange_rate ;;
  }

  dimension: active {
    type: string
    view_label: "Exchange rates"
    label: "Active"
    sql: ${TABLE}.active ;;
    bypass_suggest_restrictions: yes
  }

  dimension: createdon {
    type: date
    hidden: yes
    sql: ${TABLE}.createdon ;;
  }

}
