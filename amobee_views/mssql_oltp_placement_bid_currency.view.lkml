view: mssql_oltp_placement_bid_currency {
  label: "Placement Bid Currency"
  sql_table_name: dbo.currency (NOLOCK) ;;

  dimension: currency_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.currency_id ;;
  }

  dimension: currency_name {
    type: string
    label: "Bid Currency"
    sql: ${TABLE}.currency_name ;;
  }
}
