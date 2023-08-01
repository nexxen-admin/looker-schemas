view: bt_cluster_provider_core {
  sql_table_name: DIM.USER_DATA_VENDOR_VIEW ;;

  dimension: user_data_vendor_id {
    type: string
    label: "Source Provider ID"
    primary_key: yes
    hidden: yes
    description: "ID of the provider"
    sql: ${TABLE}.USER_DATA_VENDOR_ID ;;
  }

  dimension: description {
    type: string
    label: "BT Cluster Provider"
    view_label: "Supplemental Facets"
    description: "The name of the behavioral attribute cluster data provider."
    sql: ${TABLE}.DESCRIPTION ;;
  }
}
