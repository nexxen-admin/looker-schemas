view: mssql_oltp_deal_status {
  label: "Deal"
  sql_table_name: dbo.deal_status (NOLOCK) ;;

  dimension: deal_status_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.deal_status_id ;;
  }

  dimension: description {
    type: string
    label: "Deal Status"
    sql: ${TABLE}.description ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    label: "Active"
    sql: ${TABLE}.active = 1 ;;
  }
}
