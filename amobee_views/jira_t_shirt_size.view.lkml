view: t_shirt_size {
  sql_table_name: public.customfieldoption ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: sequence {
    type: number
    hidden: yes
  }

  dimension: customvalue {
    type: string
    label: "T-Shirt Size"
    view_label: "Custom Fields"
    order_by_field: sequence
    sql: ${TABLE}.customvalue ;;
  }
}
