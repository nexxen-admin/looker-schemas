view: is_good_bad_escalation {
  sql_table_name: public.customfieldoption ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: customvalue {
    type: string
    label: "Is Good/Bad Escalation?"
    view_label: "Custom Fields"
    sql: ${TABLE}.customvalue ;;
    suggestions: ["Good", "Bad"]
  }
}
