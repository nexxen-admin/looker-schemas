view: mssql_oltp_partner_tracking_domain_list {
  label: "Partner Tracking Domain List"
  sql_table_name: dbo.partner_tracking_domain_list (NOLOCK) ;;

  dimension: partner_tracking_domain_list_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.partner_tracking_domain_list_id ;;
  }

  dimension: partner_id {
    type: number
    hidden: yes
    sql: ${TABLE}.partner_id ;;
  }

  dimension: tracking_domain_list_id {
    type: number
    hidden: yes
    sql: ${TABLE}.tracking_domain_list_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
