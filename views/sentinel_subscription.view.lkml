view: sentinel_subscription {
  sql_table_name: public."subscription" ;;

  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}."id" ;;
  }

  dimension: userid {
    type: string
    sql: ${TABLE}."userid" ;;
  }

  dimension_group: deleted {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."deleted" ;;
  }

  dimension: rules_id {
    type: number
    hidden: yes
    sql: ${TABLE}."rulesId" ;;
  }

  measure: count {
    type: count
  }

}
