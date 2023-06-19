view: component {
  sql_table_name: public.component ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: cname {
    type: string
    label: "Component"
    view_label: "Custom Fields"
    sql: ${TABLE}.cname ;;
  }
}
