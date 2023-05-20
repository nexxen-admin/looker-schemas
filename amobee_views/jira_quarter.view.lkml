view: quarter {
  sql_table_name: public.label ;;

  dimension: issue {
    type: number
    hidden: yes
    sql: ${TABLE}.issue ;;
  }

  dimension: customfield {
    type: number
    hidden: yes
    sql: ${TABLE}.fieldid ;;
  }

  dimension: quarter {
    type: string
    sql: ${TABLE}.label ;;
    label: "Quarter"
    view_label: "Custom Fields"
  }
}
