view: mssql_oltp_user_data_vendor_type {
  sql_table_name: dbo.user_data_vendor_type (NOLOCK) ;;

  dimension: user_data_vendor_type_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.user_data_vendor_type_id ;;
  }

  dimension: description {
    type: string
    view_label: "Campaign"
    label: "Data Provider Type"
    sql: ${TABLE}.description ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
