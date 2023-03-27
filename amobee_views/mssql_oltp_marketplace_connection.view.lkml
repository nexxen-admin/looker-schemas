view: mssql_oltp_marketplace_connection {
  sql_table_name: dbo.marketplace_connection  (NOLOCK) ;;
  label: "Marketplace Connection"

  dimension: marketplace_connection_id {
    type: number
    primary_key: yes
    value_format_name: id
    hidden: yes
    sql: ${TABLE}.marketplace_connection_id ;;
  }

  dimension: seller_platform_client_id {
    type: number
    value_format_name: id
    label: "Seller Platform Client ID"
    sql: ${TABLE}.seller_platform_client_id ;;
  }

  dimension: buyer_platform_client_id {
    type: number
    value_format_name: id
    label: "Buyer Platform Client ID"
    sql: ${TABLE}.buyer_platform_client_id ;;
  }
}
