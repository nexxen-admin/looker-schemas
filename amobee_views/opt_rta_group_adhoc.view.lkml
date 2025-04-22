view: rta_group_adhoc {
  sql_table_name: AN_SMART..rta_group_adhoc (NOLOCK) ;;
  label: "Retargeting Attribute"

  dimension: active {
    type: number
    hidden: yes
    sql: ${TABLE}.active ;;
  }

  dimension_group: changedon {
    type: time
    hidden: yes
    timeframes: [time, date, month]
    sql: ${TABLE}.changedon ;;
  }

  dimension_group: createdon {
    type: time
    hidden: yes
    timeframes: [time, date, month]
    sql: ${TABLE}.createdon ;;
  }

  dimension: description {
    type: string
    label: "RTA Group"
    sql: ${TABLE}.description ;;
  }

  dimension: is_converged_planning {
    type: number
    hidden: yes
    sql: ${TABLE}.is_converged_planning ;;
  }

  dimension: rta_group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.rta_group_id ;;
  }

  dimension: user {
    type: string
    hidden: yes
    sql: ${TABLE}."user" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
