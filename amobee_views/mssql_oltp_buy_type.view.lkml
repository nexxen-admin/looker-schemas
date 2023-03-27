view: buy_type {
  sql_table_name: dbo.buy_type (NOLOCK) ;;

  dimension: buy_type_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.buy_type_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Placement"
    label: "Placement Buy Type"
    description: "The manner in which we buy the inventory (guaranteed, passback, exchange, etc.)"
    sql: ${TABLE}.description ;;
  }
}
