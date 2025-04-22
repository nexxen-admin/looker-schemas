view: customfieldvalue_project_eta_end {
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
    label: "Automated ETA End"
    view_label: "Portfolio Project"
    sql: ${TABLE}.datevalue ;;
    convert_tz: no
  }
}
