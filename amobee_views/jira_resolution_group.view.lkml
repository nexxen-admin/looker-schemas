view: resolution_group {
  sql_table_name: public.customfieldoption ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: customvalue {
    type: string
    label: "Resolution Group"
    view_label: "Custom Fields"
    sql: ${TABLE}.customvalue ;;
  }
}
