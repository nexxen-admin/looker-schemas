view: customfieldvalue_automated_time_spent {
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

  dimension: time_spent {
    type: number
    label: "Automated Time Spent"
    view_label: "Custom Fields"
    sql: ${TABLE}.numbervalue ;;
  }
}
