view: portfolio_plan_by_team {
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
    label: "Assigned POD"
    sql: ${TABLE}."TITLE" ;;
  }
}
