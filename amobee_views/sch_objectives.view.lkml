view: objectives {
  sql_table_name: scheduler.objectives ;;

  dimension: id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: active {
    type: yesno
    description: "A yes/no indicator if the Objective is active."
    sql: ${TABLE}.active ;;
  }

  dimension_group: created {
    type: time
    label: "Objective Created"
    view_label: "Dates"
    description: "The date the objective was created."
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_date ;;
  }

  dimension: parameters {
    type: string
    hidden: yes
    sql: ${TABLE}.parameters ;;
  }

  dimension: schedule_expression {
    type: string
    description: "The cron expression for the objective (when the objective will fire)."
    sql: ${TABLE}.schedule_expression ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.start_time ;;
  }

  dimension: text {
    type: string
    label: "Objective Description"
    description: "The description of the objective."
    sql: ${TABLE}.text ;;
  }

  dimension: title {
    type: string
    label: "Objective Name"
    description: "The name of the objective."
    sql: ${TABLE}.title ;;
  }

  dimension_group: updated {
    type: time
    label: "Objective Updated"
    view_label: "Dates"
    description: "The date the Objective was last updated."
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_date ;;
  }

  measure: count {
    type: count
    drill_fields: [id, jobs.count, schedules.count]
  }
}
