view: mssql_oltp_delivery_cap_range {
  label: "Delivery Cap Range"
  sql_table_name: dbo.delivery_cap_range (NOLOCK) ;;

  dimension: delivery_cap_range_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.delivery_cap_range_id ;;
  }

  dimension: description {
    type: string
    label: "Delivery Range Cap"
    sql: ${TABLE}.description ;;
  }
}
