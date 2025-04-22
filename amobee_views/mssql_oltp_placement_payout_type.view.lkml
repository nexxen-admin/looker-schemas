view: placement_payout_type {
  sql_table_name: dbo.payout_type (NOLOCK) ;;

  dimension: payout_type_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.payout_type_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Placement Payout Schedule"
    label: "Payout Type"
    description: "The type of placement payout."
    sql: ${TABLE}.description ;;
  }
}
