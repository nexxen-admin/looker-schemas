view: label {
  sql_table_name: public.label ;;



  dimension: issue {
    type: number
    hidden: yes
    sql: ${TABLE}.issue ;;
  }

  dimension: label {
    type: string
    label: "Issue Label"
    view_label: "Issue Labels"
    sql: ${TABLE}.label ;;
  }

}
