view: bt_data_provider_core {
  sql_table_name: DIM.USER_DATA_VENDOR_VIEW ;;

    dimension: user_data_vendor_id {
      label: "Source Provider ID"
      primary_key: yes
      type: string
      hidden: yes
      description: "ID of the provider"
      sql: ${TABLE}.USER_DATA_VENDOR_ID ;;
    }

    dimension: description {
      type: string
      label: "BT Data Provider"
      view_label: "Supplemental Facets"
      description: "The name of the behavioral attribute data provider."
      sql: ${TABLE}.DESCRIPTION ;;
    }
}
