view: which_platform {
  sql_table_name: public.customfieldoption ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: customvalue {
    type: string
    label: "Which platform"
    view_label: "Custom Fields"
    sql: ${TABLE}.customvalue ;;
  }
}
