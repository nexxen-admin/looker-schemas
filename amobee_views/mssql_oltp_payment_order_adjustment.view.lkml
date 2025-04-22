view: payment_order_adjustment {
  sql_table_name: dbo.payment_order_adjustment (NOLOCK) ;;
  label: "Payment Order Adjustment"

  dimension: payment_order_adjustment_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.payment_order_adjustment_id ;;
  }

  dimension: active {
    type: yesno
    label: "Active"
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: adjustment_amount {
    type: number
    label: "Adjustment Amount"
    value_format_name: decimal_2
    sql: ${TABLE}.adjustment_amount ;;
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
    sql: ${TABLE}.createdon ;;
  }

  dimension: payment_adjustment_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.payment_adjustment_type_id ;;
  }

  dimension: payment_order_id {
    type: string
    hidden: yes
    sql: ${TABLE}.payment_order_id ;;
  }
}
