view: v_dim_exchange_rate_to_usd_currency {
  sql_table_name: BI_DSP.v_dim_netsuite_daily_exchange_rate_usd_currency ;;

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key ;;
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
  dimension: exchange_rate {
    type: number
    sql: ${TABLE}.exchange_rate ;;
  }
  dimension: from_currency_id {
    type: number
    sql: ${TABLE}.from_currency_id ;;
  }
  dimension: from_currency_iso {
    type: string
    sql: ${TABLE}.from_currency_iso ;;
  }
  dimension: netsuite_daily_exchange_rate_key {
    type: number
    sql: ${TABLE}.netsuite_daily_exchange_rate_key ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
  }
  dimension: to_currency_id {
    type: number
    sql: ${TABLE}.to_currency_id ;;
  }
  dimension: to_currency_iso {
    type: string
    sql: ${TABLE}.to_currency_iso ;;
  }
  measure: count {
    type: count
  }
}
