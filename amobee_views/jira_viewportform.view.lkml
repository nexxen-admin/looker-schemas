view: viewportform {
  sql_table_name: public."AO_54307E_VIEWPORTFORM" ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}."ID" ;;
  }

  dimension: key {
    type: string
    hidden: yes
    sql: ${TABLE}."KEY" ;;
  }

  dimension: name {
    type: string
    label: "Customer Request Type"
    view_label: "Custom Fields"
    sql: ${TABLE}."NAME" ;;
  }
}
