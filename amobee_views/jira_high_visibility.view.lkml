view: high_visibility {
  sql_table_name: public.customfieldoption ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: customvalue {
    type: yesno
    label: "High Visibility"
    view_label: "Custom Fields"
    sql: ${TABLE}.customvalue = 'Yes';;
  }
}
