view: customfieldvalue_loe {
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

  dimension: loe {
    type: number
    label: "LOE"
    view_label: "Custom Fields"
    sql: ${TABLE}.numbervalue ;;
  }

  measure: loe_sum {
    type: sum
    label: "LOE Sum"
    view_label: "Custom Fields"
    sql: ${TABLE}.numbervalue ;;
  }
}
