view: mssql_oltp_internal_deal {
  sql_table_name: dbo.internal_deal (NOLOCK) ;;

  dimension: campaign_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: deal_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.deal_status_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
