view: customfieldvalue_alpha_date {
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

  dimension: alpha_date {
    type: date
    label: "Alpha date"
    view_label: "Custom Fields"
    sql: ${TABLE}.datevalue ;;
    convert_tz: no
  }
}
