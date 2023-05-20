view: new_warehouse_cost {
derived_table: {
  sql:
      SELECT warehouse_name,
         start_time as start_time,
         CREDITS_USED
      FROM ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
      ;;
  }

  dimension: primary_key {
    primary_key: yes
    sql: concat(${TABLE}.start_time,${TABLE}.warehouse_name)  ;;
  }
  dimension_group: capture {
    type: time
    timeframes: [
      raw,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_time ;;
  }

  dimension: warehouse_name {
    type: string
    sql: ${TABLE}.warehouse_name ;;
  }

  dimension: credits_used {
    type: number
    sql: ${TABLE}.CREDITS_USED ;;
  }

  measure: sum_credits {
    type: sum
    sql: ${TABLE}.CREDITS_USED ;;
  }

  measure: avg_credits {
    type: average
    sql: ${TABLE}.CREDITS_USED ;;
  }

}
