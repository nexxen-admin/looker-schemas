view: monthly_exchange_rate {
  sql_table_name: DIM.MONTHLY_EXCHANGE_RATE ;;

  dimension: currency_from {
    type: string
    label: "Monthly Currency From"
    description: "The currency the exchange rate is converted from."
    sql: ${TABLE}.CURRENCY_FROM ;;
  }

  dimension: currency_id_from {
    type: number
    label: "Monthly Currency From - ID"
    description: "ID of the currency the exchange rate is converted from."
    value_format_name: id
    sql: ${TABLE}.CURRENCY_ID_FROM ;;
  }

  dimension: currency_id_to {
    type: number
    label: "Monthly Currency To - ID"
    value_format_name: id
    description: "ID of the currency the exchange rate is converted to."
    sql: ${TABLE}.CURRENCY_ID_TO ;;
  }

  dimension: currency_to {
    type: string
    label: "Monthly Currency To"
    description: "The currency the exchange rate is converted to."
    sql: ${TABLE}.CURRENCY_TO ;;
  }

  dimension: exchange_rate {
    type: number
    label: "Monthly Exchange Rate"
    description: "Exchange Rate Value used to convert from one currency to another."
    sql: ${TABLE}.EXCHANGE_RATE ;;
  }

  dimension: keydate {
    type: date
    label: "GMT Month"
    description: "Month in which the exchange rate applies to."
    sql: ${TABLE}.KEYDATE ;;
  }

  dimension: pk_id {
    type: number
    label: "Accounting Exchange Rate ID"
    sql: ${TABLE}.PK_ID ;;
    value_format_name: id
  }

  dimension: spot_rate {
    type: number
    hidden: yes
    sql: ${TABLE}.SPOT_RATE ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
