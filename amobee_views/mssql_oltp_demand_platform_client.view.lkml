view: demand_platform_client {
  sql_table_name: dbo.platform_client (NOLOCK) ;;
  label: "Demand Platform Client"

  dimension: platform_client_id {
    primary_key: yes
    type: number
    label: "Platform Client ID"
    sql: ${TABLE}.platform_client_id ;;
  }

  dimension: active {
    type: yesno
    label: "Platform Client Active"
    description: "A yes/no indicator if the platform client is currently active."
    sql: ${TABLE}.active = 1 ;;
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

  dimension: platform_client_group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.platform_client_group_id ;;
  }

  dimension: business_region_id {
    type: number
    hidden: yes
    sql: ${TABLE}.business_region_id ;;
  }
}
