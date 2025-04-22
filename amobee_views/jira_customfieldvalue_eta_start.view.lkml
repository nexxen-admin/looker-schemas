view: customfieldvalue_eta_start {
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

  dimension: eta_end {
    type: date
    label: "Automated ETA Start"
    view_label: "Custom Fields"
    sql: ${TABLE}.datevalue ;;
    convert_tz: no
  }
}
