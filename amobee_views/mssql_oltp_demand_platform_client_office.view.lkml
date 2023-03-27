view: demand_platform_client_office {
  sql_table_name: dbo.office (NOLOCK) ;;

  dimension: office_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.office_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: office_name {
    type: string
    view_label: "Demand Platform Client"
    label: "Platform Client Office"
    description: "The location of the office of the demand platform client."
    sql: ${TABLE}.office_name ;;
    suggest_explore: mssql_oltp_suggest_demand_ref
    suggest_dimension: mssql_oltp_suggest_demand_ref.office_name
  }
}
