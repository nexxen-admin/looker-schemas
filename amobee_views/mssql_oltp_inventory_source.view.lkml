view: inventory_source {
  sql_table_name: dbo.inventory_source (NOLOCK) ;;

  dimension: inventory_source_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.inventory_source_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Placement"
    label: "Placement Inventory Source"
    description: "The source of the inventory. This is typically the name of the exchange."
    sql: CASE WHEN ${TABLE}.Description IS NULL THEN 'Direct Tags' ELSE ${TABLE}.Description END  ;;
  }

  dimension: inventory_source_type {
    type: string
    view_label: "Placement"
    label: "Placement Inventory Source Type"
    description: "The source type of the inventory."
    sql: ${TABLE}.inventory_source_type ;;
  }
}
