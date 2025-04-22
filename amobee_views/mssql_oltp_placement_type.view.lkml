view: placement_type {
  sql_table_name: dbo.placement_type (NOLOCK) ;;

  dimension: placement_type_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.placement_type_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Placement"
    label: "Placement Type"
    description: "The type of placement (Cheap, Medium Priced, Expensive, RTB, etc.)."
    sql: ${TABLE}.description ;;
    suggest_explore: mssql_oltp_suggest_supply_ref
    suggest_dimension: mssql_oltp_suggest_supply_ref.placement_type
  }
}
