view: sub_type {
  sql_table_name: public.customfieldoption ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: sub_type {
    label: "Sub-Type"
    type: string
    sql: ${TABLE}.customvalue ;;
  }
}
