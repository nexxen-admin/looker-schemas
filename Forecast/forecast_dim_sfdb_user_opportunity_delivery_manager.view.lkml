view: forecast_dim_sfdb_user_opportunity_delivery_manager {
  sql_table_name: BI_DSP.dim_sfdb_user_opportunity_delivery_manager ;;

  dimension: opp_delivery_manager_company_name {
    type: string
    sql: ${TABLE}.opp_delivery_manager_company_name ;;
  }
  dimension: opp_delivery_manager_division {
    type: string
    sql: ${TABLE}.opp_delivery_manager_division ;;
  }
  dimension: opp_delivery_manager_full_name {
    type: string
    sql: ${TABLE}.opp_delivery_manager_full_name ;;
  }
  dimension: opp_delivery_manager_id {
    type: string
    sql: ${TABLE}.opp_delivery_manager_id ;;
  }
  dimension: opp_delivery_manager_user_name {
    type: string
    sql: ${TABLE}.opp_delivery_manager_user_name ;;
  }
  dimension: opp_delivery_manager_userroleid {
    type: string
    sql: ${TABLE}.opp_delivery_manager_userroleid ;;
  }
  dimension: user_key_id {
    type: number
    sql: ${TABLE}.user_key_id ;;
  }
  measure: count {
    type: count
    drill_fields: [opp_delivery_manager_company_name, opp_delivery_manager_user_name, opp_delivery_manager_full_name]
  }
}
