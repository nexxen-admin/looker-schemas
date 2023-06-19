view: portfolio_program_by_team {
  sql_table_name: public."AO_D9132D_PROGRAM" ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}."ID" ;;
  }

  dimension: title {
    type: string
    view_label: "Portfolio Project"
    label: "Program by Team"
    sql: ${TABLE}."TITLE" ;;
  }
}
