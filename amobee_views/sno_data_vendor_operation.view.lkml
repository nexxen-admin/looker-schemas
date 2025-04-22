view: data_vendor_operation {
  sql_table_name: DIM.DATA_VENDOR_OPERATION ;;

  dimension: description {
    type: string
    label: "Data Vendor Operation"
    description: "Description of the data operation. Options include Add, Remove, Remove All, Replace."
    view_label: "Acquisition Facets"
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: operation_id {
    type: number
    view_label: "Acquisition Facets"
    hidden: yes
    sql: ${TABLE}.OPERATION_ID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
