view: customfieldvalue_days {
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

  dimension: days {
    type: number
    label: "Days"
    view_label: "Custom Fields"
    sql: ${TABLE}.numbervalue ;;
  }

  measure: days_sum {
    type: sum
    view_label: "Custom Fields"
    sql: ${days} ;;
  }

  measure: not_closed_issues_days_sum {
    type: sum
    view_label: "Custom Fields"
    sql: CASE WHEN ${issuestatus.statuscategory} != 3 THEN ${days} END ;;
  }
}
