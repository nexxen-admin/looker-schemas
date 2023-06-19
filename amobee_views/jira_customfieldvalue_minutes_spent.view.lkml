view: customfieldvalue_minutes_spent {
  sql_table_name: public.customfieldvalue ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

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

  dimension: minutes_spent {
    type: number
    label: "Minutes Spent"
    view_label: "Custom Fields"
    sql: ${TABLE}.numbervalue ;;
  }
}
