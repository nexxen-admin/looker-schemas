view: placement_quality {
  sql_table_name: dbo.placement_quality (NOLOCK) ;;

  dimension: placement_quality_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.placement_quality_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Placement"
    label: "Placement Quality"
    description: "The quality of the placement (Prime, Pulse, Open, etc.)."
    sql: ${TABLE}.description ;;
  }
}
