view: resolution_team {
  sql_table_name: public.customfieldoption ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: customvalue {
    type: string
    label: "Resolution Team"
    view_label: "Custom Fields"
    sql: ${TABLE}.customvalue ;;
  }
}
