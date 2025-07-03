view: forecast_dim_sfdb_user_opportunity_account_manager {
  sql_table_name: BI_DSP.dim_sfdb_user_opportunity_account_manager ;;

  dimension: opp_account_manager_company_name {
    type: string
    sql: ${TABLE}.opp_account_manager_company_name ;;
  }
  dimension: opp_account_manager_division {
    type: string
    sql: ${TABLE}.opp_account_manager_division ;;
  }
  dimension: opp_account_manager_full_name {
    type: string
    sql: ${TABLE}.opp_account_manager_full_name ;;
  }
  dimension: opp_account_manager_id {
    type: string
    sql: ${TABLE}.opp_account_manager_id ;;
  }
  dimension: opp_account_manager_user_name {
    type: string
    sql: ${TABLE}.opp_account_manager_user_name ;;
  }
  dimension: user_key_id {
    type: number
    sql: ${TABLE}.user_key_id ;;
  }
  measure: count {
    type: count
    drill_fields: [opp_account_manager_user_name, opp_account_manager_full_name, opp_account_manager_company_name]
  }
}
