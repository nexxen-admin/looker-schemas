view: portfolio_resource_by_assignee {
  sql_table_name: public."AO_82B313_RESOURCE" ;;

  dimension: person_id {
    type: number
    hidden: yes
    sql: ${TABLE}."PERSON_ID" ;;
  }

  dimension: team_id {
    type: number
    hidden: yes
    sql: ${TABLE}."TEAM_ID" ;;
  }
}
