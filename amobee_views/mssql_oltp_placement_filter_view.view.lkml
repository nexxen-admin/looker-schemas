view: placement_filter_view {
  sql_table_name: dbo.placement_filter_view (NOLOCK) ;;
  label: "Placement Filter"

  dimension: description {
    type: string
    label: "Placement Filter Type"
    sql: ${TABLE}.description ;;
  }

  dimension: filter_value {
    type: string
    label: "Placement Filter"
    sql: ${TABLE}.filter_value ;;
  }

  dimension: placement_filter_id {
    primary_key: yes
    type: number
    label: "Placement Filter ID"
    sql: ${TABLE}.placement_filter_id ;;
    value_format_name: id
  }

  dimension: placement_filter_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_filter_type_id ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  measure: count {
    type: count_distinct
    label: "Count of Placement Filters"
    description: "The distinct count of placement filters."
    sql: ${placement_filter_id} ;;
  }
}
