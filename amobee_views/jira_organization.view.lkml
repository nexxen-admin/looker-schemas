view: organization {
  sql_table_name: public."AO_54307E_ORGANIZATION" ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}."ID" ;;
  }

  dimension: name {
    type: string
    label: "Organizations"
    view_label: "Custom Fields"
    sql: ${TABLE}."NAME" ;;
  }
}
