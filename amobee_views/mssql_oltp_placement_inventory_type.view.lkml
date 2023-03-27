view: placement_inventory_type {
  sql_table_name: dbo.placement_inventory_type (NOLOCK) ;;

  dimension: placement_inventory_type_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.placement_inventory_type_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Placement"
    label: "Placement Inventory Type"
    description: "The inventory type of the placement (Network, Exchange, Publisher Private Marketplace, etc.)."
    sql: ${TABLE}.description ;;
    suggest_explore: mssql_oltp_suggest_supply_ref
    suggest_dimension: mssql_oltp_suggest_supply_ref.placement_inventory_type
  }
}
