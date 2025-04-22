view: portfolio_plan {
  sql_table_name: public."AO_D9132D_PLAN" ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}."ID" ;;
  }

  dimension: program_id {
    type: number
    hidden: yes
    sql: ${TABLE}."PROGRAM_ID" ;;
  }

  dimension: title {
    type: string
    view_label: "Portfolio Project"
    label: "POD"
    sql: ${TABLE}."TITLE" ;;
  }

  dimension: atv_order {
    type: string
    hidden: yes
    sql:  CASE WHEN ${program_id} = 20 THEN '0' || ${title}
          ELSE '1' END ;;
  }

  dimension: atv_pod {
    type:  string
    view_label: "Portfolio Project"
    label: "ATV Capacity POD"
    order_by_field: atv_order
    sql:  CASE WHEN ${program_id} = 20 THEN ${title}
          ELSE 'Others' END
 ;;
  }
}
