view: payment_order {
  sql_table_name: dbo.payment_order (NOLOCK) ;;
  label: "Payment Order"

  dimension: payment_order_id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.payment_order_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: amount {
    type: number
    hidden: yes
    sql: ${TABLE}.amount ;;
  }

  dimension: change_source {
    type: string
    hidden: yes
    sql: ${TABLE}.change_source ;;
  }

  dimension: changedby {
    type: string
    hidden: yes
    sql: ${TABLE}.changedby ;;
  }

  dimension_group: changedon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.changedon ;;
  }

  dimension: createdby {
    type: string
    hidden: yes
    sql: ${TABLE}.createdby ;;
  }

  dimension_group: createdon {
    type: time
    label: "Created"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdon ;;
  }

  dimension: currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_id ;;
  }

  dimension: discount_code_id {
    type: string
    hidden: yes
    sql: ${TABLE}.discount_code_id ;;
  }

  dimension: payment_amount {
    type: number
    label: "Payment Amount"
    value_format_name: decimal_2
    sql: ${TABLE}.payment_amount ;;
  }

  dimension: payment_gateway_id {
    type: number
    hidden: yes
    sql: ${TABLE}.payment_gateway_id ;;
  }

  dimension: payment_webhook_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.payment_webhook_type_id ;;
  }

  dimension: session_id {
    type: string
    label: "Session Id"
    sql: ${TABLE}.session_id ;;
  }

  dimension: status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.status_id ;;
  }

  dimension_group: timestamp {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.timestamp ;;
  }
}
