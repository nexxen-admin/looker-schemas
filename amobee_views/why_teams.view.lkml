view: why_teams {
  sql_table_name: dbo.teams (NOLOCK) ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.Id ;;
  }

  dimension: name {
    type: string
    label: "Team"
    sql: ${TABLE}.name ;;
  }
}
