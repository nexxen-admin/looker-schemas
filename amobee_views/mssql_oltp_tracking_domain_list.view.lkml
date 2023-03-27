view: mssql_oltp_tracking_domain_list {
  label: "Tracking Domain List"
  sql_table_name: dbo.tracking_domain_list (NOLOCK) ;;

  dimension: tracking_domain_list_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.tracking_domain_list_id ;;
  }

  dimension: tracking_domain_list_name {
    type: string
    label: "Permitted Vendors List"
    sql: ${TABLE}.tracking_domain_list_name ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
