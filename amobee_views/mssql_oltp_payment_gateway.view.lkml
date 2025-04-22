view: payment_gateway {
  sql_table_name: dbo.payment_gateway (NOLOCK) ;;
  label: "Payment Order"

  dimension: payment_gateway_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.payment_gateway_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
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

  dimension: description {
    type: string
    label: "Gateway"
    sql: ${TABLE}.description ;;
  }
}
