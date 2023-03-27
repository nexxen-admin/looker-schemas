view: payment_order_entity {
  sql_table_name: dbo.payment_order_entity (NOLOCK) ;;
  label: "Payment Order"

  dimension: payment_order_entity_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.payment_order_entity_id ;;
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

  dimension: cost {
    type: number
    hidden: yes
    sql: ${TABLE}.cost ;;
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

  dimension: entity_id {
    type: number
    hidden: yes
    sql: ${TABLE}.entity_id ;;
  }

  dimension: entity_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.entity_type_id ;;
  }

  dimension: payment_order_id {
    type: string
    hidden: yes
    sql: ${TABLE}.payment_order_id ;;
  }
}
