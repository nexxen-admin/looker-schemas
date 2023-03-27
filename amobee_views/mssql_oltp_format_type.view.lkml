view: mssql_oltp_format_type {
  label: "Format Type"
  sql_table_name: dbo.format_type (NOLOCK) ;;

  dimension: format_type_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.format_type_id ;;
  }

  dimension: description {
    type: string
    label: "Placement Format"
    sql: ${TABLE}.description ;;
    suggest_explore: mssql_oltp_suggest_supply_ref
    suggest_dimension: mssql_oltp_suggest_supply_ref.format_type
  }
}
