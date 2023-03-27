view: mssql_oltp_campaign_target {
  sql_table_name: dbo.campaign_target (NOLOCK) ;;

  dimension: campaign_target_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.campaign_target_id ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: attribute_id {
    type: number
    hidden: yes
    sql: ${TABLE}.attribute_id ;;
  }

  dimension: attribute_value_id {
    type: number
    hidden: yes
    sql: ${TABLE}.attribute_value_id ;;
  }

  dimension: active {
  type: yesno
  hidden: yes
  sql: ${TABLE}.active = 1 ;;
  }
}
