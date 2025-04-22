view: mssql_oltp_platform_client_group {
  sql_table_name: dbo.platform_client_group (NOLOCK) ;;

  dimension: platform_client_group_id {
    primary_key: yes
    type: number
    view_label: "Demand Platform Client"
    label: "Platform Client Group ID"
    description: "The platform client group id of the publisher."
    sql: ${TABLE}.platform_client_group_id ;;
    value_format_name: id
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: description {
    type: string
    view_label: "Demand Platform Client"
    label: "Platform Client Group"
    description: "A grouping of platform clients."
    sql: ${TABLE}.description ;;
  }
}
