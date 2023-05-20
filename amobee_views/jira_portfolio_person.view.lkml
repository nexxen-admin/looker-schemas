view: portfolio_person {
  sql_table_name: public."AO_82B313_PERSON" ;;

  dimension: id {
      primary_key: yes
      type: number
      hidden: yes
      sql: ${TABLE}."ID" ;;
  }

  dimension: jira_user_id {
      type: string
      hidden: yes
      sql: ${TABLE}."JIRA_USER_ID" ;;
  }
}
