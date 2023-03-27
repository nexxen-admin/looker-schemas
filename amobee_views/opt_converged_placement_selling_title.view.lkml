view: converged_placement_selling_title {
  sql_table_name: AN_SMART..converged_placement_selling_title (NOLOCK) ;;
  label: "Placement Selling Title"

  dimension: placement_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: selling_group_id {
    type: number
    label: "Selling Group"
    sql: ${TABLE}.selling_group_id ;;
    value_format_name: id
  }

  dimension: selling_title_id {
    type: string
    label: "Selling Title ID"
    value_format_name: id
    sql: ${TABLE}.selling_title_id ;;
  }

  dimension: selling_title_name {
    type: string
    label: "Selling Title"
    sql: ${TABLE}.selling_title_name ;;
  }

}
