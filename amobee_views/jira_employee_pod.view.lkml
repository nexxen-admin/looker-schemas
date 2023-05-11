view: employee_pod {
  sql_table_name: public."AO_D9132D_PLAN" ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}."ID" ;;
  }

  dimension: is_assigned {
    type: yesno
    label: "Is Assigned POD"
    view_label: "Employee POD"
    sql: ${issue_pod.id} IS NULL ;;
  }

  dimension: employee_pod_order {
    type: string
    hidden: yes
    sql: CASE WHEN ${is_assigned} THEN ${portfolio_plan.atv_order}
      ELSE ${issue_pod.atv_order} END ;;
  }

  dimension: employee_pod {
    type:  string
    view_label: "Employee POD"
    label: "Employee ATV Capacity POD"
    order_by_field: employee_pod_order
    sql:  CASE WHEN ${is_assigned} THEN ${portfolio_plan.atv_pod}
      ELSE ${issue_pod.atv_pod} END ;;
  }

  measure: working_employees_count {
    type: count_distinct
    label: "Working in POD"
    view_label: "Employee POD"
    sql:  CASE WHEN ${is_assigned}
           THEN NULL
           ELSE  ${insight_object_email.email}
           END ;;
  }

  measure: assigned_employees_count {
    type: count_distinct
    label: "Assigned in POD"
    view_label: "Employee POD"
    sql: CASE WHEN ${is_assigned}
          THEN ${insight_object_email.email}
          ELSE NULL
          END ;;
  }
}
