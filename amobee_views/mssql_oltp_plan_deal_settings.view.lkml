view: mssql_oltp_plan_deal_settings {
  sql_table_name: dbo.plan_deal_settings (NOLOCK) ;;

  dimension: plan_deal_settings_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.plan_deal_settings ;;
  }

  dimension: buyer_plan_id {
    type: number
    hidden: yes
    sql: ${TABLE}.buyer_plan_id ;;
  }

  dimension: seller_plan_id {
    type: number
    hidden: yes
    sql: ${TABLE}.seller_plan_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }
}
