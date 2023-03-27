view: aur_plan_details {
  label: "Plan"
  sql_table_name: dim.plan_details ;;

  dimension: pl_plan_id {
    type: number
    label: "Plan ID"
    description: "Unique ID of the Plan."
    sql: ${TABLE}.pl_plan_id ;;
    value_format_name: id
  }

  dimension: plan_active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.plan_active ;;
  }

  dimension: plan_budget {
    type: number
    hidden: yes
    sql: ${TABLE}.plan_budget ;;
  }

  dimension: plan_end {
    type: date
    label: "Plan End Date"
    sql: DATE_ADD(${TABLE}.plan_end_date, INTERVAL -1 MINUTE) ;;
  }

  dimension: plan_start {
    type: date
    label: "Plan Start Date"
    description: "Start Date of the Plan"
    sql: ${TABLE}.plan_start_date ;;
  }

  dimension: plan_name {
    type: string
    label: "Plan Name"
    description: "Name of the Plan."
    sql: ${TABLE}.plan_name ;;
  }

  dimension: plan_status {
    type: string
    description: "Status of the Plan"
    sql: ${TABLE}.plan_status ;;
  }

  dimension: plan_status_id {
    type: yesno
    hidden: yes
    sql: ${TABLE}.plan_status_id ;;
  }

  dimension: plan_units {
    type: number
    hidden: yes
    sql: ${TABLE}.plan_units ;;
  }

}
