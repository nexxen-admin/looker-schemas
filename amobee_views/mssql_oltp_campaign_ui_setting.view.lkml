view: mssql_oltp_campaign_ui_setting {
  label: "Campaign"
  sql_table_name: dbo.campaign_ui_setting (NOLOCK) ;;

  dimension: id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: setting_key {
    type: string
    hidden: yes
    sql: ${TABLE}.setting_key ;;
  }

  dimension: setting_value {
    type: string
    label: "Campaign Custom String"
    sql: COALESCE(${TABLE}.setting_value, '') ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
