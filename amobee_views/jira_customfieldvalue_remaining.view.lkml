view: customfieldvalue_remaining {
  sql_table_name: public.customfieldvalue ;;

  dimension: issue {
    type: number
    hidden: yes
    sql: ${TABLE}.issue ;;
  }

  dimension: customfield {
    type: number
    hidden: yes
    sql: ${TABLE}.customfield ;;
  }

  dimension: days {
    type: number
    label: "Remaining Days"
    view_label: "Custom Fields"
    sql: ${TABLE}.numbervalue ;;
  }
}
