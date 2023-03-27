view: why_users {
  sql_table_name: dbo.users (NOLOCK) ;;

  dimension: name {
    type: string
    hidden: yes
    sql: ${TABLE}.name ;;
  }

  dimension: team_id {
    type: number
    hidden: yes
    sql: ${TABLE}.team_id ;;
  }
}
