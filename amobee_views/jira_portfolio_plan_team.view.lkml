view: portfolio_plan_team {
  sql_table_name: public."AO_D9132D_PLANTEAM" ;;

  dimension: plan_id {
    type: number
    hidden: yes
    sql: ${TABLE}."PLAN_ID" ;;
  }

  dimension: team_id {
    type: number
    hidden: yes
    sql: ${TABLE}."TEAM_ID" ;;
  }
}
