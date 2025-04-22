view: payment_adjustment_type {
  sql_table_name: dbo.payment_adjustment_type (NOLOCK) ;;
  label: "Payment Order Adjustment"

  dimension: payment_adjustment_type_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.payment_adjustment_type_id ;;
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
    label: "Adjustment Type"
    sql: ${TABLE}.description ;;
  }
}
