view: user_id_type {
  sql_table_name: DIM.USER_ID_TYPE ;;

  dimension: description {
    type: string
    label: "User Data Type"
    description: "Type of User Data (ie. Cookie, ADID, etc.)"
    view_label: "Acquisition Facets"
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: user_id_type {
    type: string
    hidden: yes
    sql: ${TABLE}.USER_ID_TYPE ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
