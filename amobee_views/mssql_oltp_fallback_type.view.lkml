view: fallback_type {
  sql_table_name: dbo.fallback_type (NOLOCK) ;;

  dimension: fallback_type_id {
    primary_key: yes
    type: number
    view_label: "Placement"
    label: "Fallback Type ID"
    description: "Fallback Type ID"
    sql: ${TABLE}.fallback_type_id ;;
    value_format_name: id
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Placement"
    label: "Fallback Type"
    description: "Fallback Type"
    sql: ${TABLE}.description ;;
  }
}
