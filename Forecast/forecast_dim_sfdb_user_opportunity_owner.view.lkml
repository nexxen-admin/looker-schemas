view: forecast_dim_sfdb_user_opportunity_owner {
  sql_table_name: BI_DSP.dim_sfdb_user_opportunity_owner ;;

  dimension: opp_owner_company_name {
    type: string
    sql: ${TABLE}.opp_owner_company_name ;;
  }
  dimension: opp_owner_division {
    type: string
    sql: ${TABLE}.opp_owner_division ;;
  }
  dimension: opp_owner_full_name {
    type: string
    sql: ${TABLE}.opp_owner_full_name ;;
  }
  dimension: opp_owner_id {
    type: string
    sql: ${TABLE}.opp_owner_id ;;
  }
  dimension: opp_owner_user_name {
    type: string
    sql: ${TABLE}.opp_owner_user_name ;;
  }
  dimension: user_key_id {
    type: number
    sql: ${TABLE}.user_key_id ;;
  }
  measure: count {
    type: count
    drill_fields: [opp_owner_user_name, opp_owner_company_name, opp_owner_full_name]
  }
}
