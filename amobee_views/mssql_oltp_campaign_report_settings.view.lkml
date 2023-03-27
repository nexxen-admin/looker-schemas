view: mssql_oltp_campaign_report_settings {
  sql_table_name: dbo.campaign_report_settings (NOLOCK) ;;

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: attribution_report_hash {
    type: string
    label: "Attribution Enabled"
    view_label: "Campaign"
    sql: case when ${TABLE}.attribution_report_hash is not null then 'Yes' else 'No' end ;;
  }
}
