view: tech_support_ticket {
  sql_table_name: public.customfieldoption ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: customvalue {
    type: yesno
    label: "Tech Support Ticket?"
    view_label: "Custom Fields"
    sql: ${TABLE}.customvalue = 'Yes' ;;
  }
}
