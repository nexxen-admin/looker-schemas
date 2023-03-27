view: mssql_oltp_payout_type {
  view_label: "Payout Type"
  sql_table_name: dbo.payout_type (NOLOCK) ;;

  dimension: payout_type_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.payout_type_id ;;
  }

  dimension: description {
    type: string
    label: "Payout Type"
    sql: ${TABLE}.description ;;
  }
}
