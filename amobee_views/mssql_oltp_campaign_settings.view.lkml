view: mssql_oltp_campaign_settings {
  sql_table_name: dbo.campaign_settings (NOLOCK) ;;

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: use_advanced_targeting {
    type: yesno
    hidden: yes
    sql: ${TABLE}.use_advanced_targeting = 1 ;;
  }
}
