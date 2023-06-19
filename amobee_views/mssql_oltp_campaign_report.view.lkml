view: mssql_oltp_campaign_report {
  sql_table_name: dbo.campaign_report (NOLOCK) ;;

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: post_report_approved {
    type: string
    label: "Post Report Enabled"
    view_label: "Campaign"
    sql: case when ${TABLE}.report_id is not null then 'Yes' else 'No' end ;;
  }
}
