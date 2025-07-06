view: forecast_dim_sfdb_opportunity_employee {
  sql_table_name: BI_DSP.dim_sfdb_opportunity_employee ;;

  dimension: account_lead {
    type: string
    sql: ${TABLE}.Account_Lead ;;
  }
  dimension: account_manager {
    type: string
    sql: ${TABLE}.Account_Manager ;;
  }
  dimension: atv_account_manager {
    type: string
    sql: ${TABLE}.ATV_Account_Manager ;;
  }
  dimension: atv_platform_ops {
    type: string
    sql: ${TABLE}.ATV_Platform_Ops ;;
  }
  dimension: atv_product_strategist {
    type: string
    sql: ${TABLE}.ATV_Product_Strategist ;;
  }
  dimension: campaign_manager {
    type: string
    sql: ${TABLE}.Campaign_Manager ;;
  }
  dimension: channel_strategist {
    type: string
    sql: ${TABLE}.Channel_Strategist ;;
  }
  dimension: client_partner {
    type: string
    sql: ${TABLE}.Client_Partner ;;
  }
  dimension: coe_rep {
    type: string
    sql: ${TABLE}.COE_Rep ;;
  }
  dimension: corp_entity_id {
    type: string
    sql: ${TABLE}.corp_entity_id ;;
  }
  dimension: corp_entity_name {
    type: string
    sql: ${TABLE}.corp_entity_name ;;
  }
  dimension_group: createddate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.createddate ;;
  }
  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }
  dimension: engagement_manager {
    type: string
    sql: ${TABLE}.Engagement_Manager ;;
  }
  dimension: enterprise_rep {
    type: string
    sql: ${TABLE}.Enterprise_Rep ;;
  }
  dimension: executive_sponsor {
    type: string
    sql: ${TABLE}.Executive_Sponsor ;;
  }
  dimension: generalist_rep {
    type: string
    sql: ${TABLE}.Generalist_Rep ;;
  }
  dimension_group: lastmodifieddate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastmodifieddate ;;
  }
  dimension: lead_analyst {
    type: string
    sql: ${TABLE}.Lead_Analyst ;;
  }
  dimension: opportunity_account_owner {
    type: string
    sql: ${TABLE}.opportunity_account_owner ;;
  }
  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.opportunity_id ;;
  }
  dimension: opportunity_key {
    type: number
    sql: ${TABLE}.opportunity_key ;;
  }
  dimension: performance_strategist {
    type: string
    sql: ${TABLE}.Performance_Strategist ;;
  }
  dimension: product_consultant {
    type: string
    sql: ${TABLE}.Product_Consultant ;;
  }
  dimension: regional_vp {
    type: string
    sql: ${TABLE}.Regional_VP ;;
  }
  dimension: sales_planner {
    type: string
    sql: ${TABLE}.Sales_Planner ;;
  }
  dimension: senior_account_manager {
    type: string
    sql: ${TABLE}.Senior_Account_Manager ;;
  }
  dimension: service_coordinator {
    type: string
    sql: ${TABLE}.Service_Coordinator ;;
  }
  dimension: social_specialist {
    type: string
    sql: ${TABLE}.Social_Specialist ;;
  }
  dimension: solutions_engineer {
    type: string
    sql: ${TABLE}.Solutions_Engineer ;;
  }
  dimension: strategic_insights {
    type: string
    sql: ${TABLE}.Strategic_Insights ;;
  }
  dimension: trader {
    type: string
    sql: ${TABLE}.Trader ;;
  }
  dimension: tv_specialist {
    type: string
    sql: ${TABLE}.TV_Specialist ;;
  }
  measure: count {
    type: count
    drill_fields: [corp_entity_name]
  }
}
