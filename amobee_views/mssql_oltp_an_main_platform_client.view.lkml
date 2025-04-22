view: an_main_platform_client {
  # this view was created to use with connections which have base other base table than AN_MAIN
  sql_table_name: AN_MAIN.dbo.platform_client (NOLOCK) ;;
  label: "Platform Client"

  dimension: platform_client_id {
    primary_key: yes
    type: number
    label: "Platform Client ID"
    sql: ${TABLE}.platform_client_id ;;
  }

  dimension: office_id {
    type: number
    hidden: yes
    sql: ${TABLE}.office_id ;;
  }

  dimension: description {
    type: string
    label: "Platform Client"
    sql: ${TABLE}.description ;;
    suggest_explore: mssql_oltp_suggest_demand_ref
    suggest_dimension: mssql_oltp_suggest_demand_ref.demand_platform_client
  }
}
