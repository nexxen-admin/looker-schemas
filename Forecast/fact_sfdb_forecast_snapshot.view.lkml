view: fact_sfdb_forecast_snapshot {
  sql_table_name: BI_DSP.fact_sfdb_forecast_snapshot ;;

  dimension: account_manager {
    type: string
    sql: ${TABLE}.Account_Manager ;;
  }
  dimension: account_manager_2 {
    type: string
    sql: ${TABLE}.Account_Manager_2 ;;
  }
  dimension: account_name {
    type: string
    sql: ${TABLE}.Account_Name ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }
  dimension: deal_type {
    type: string
    sql: ${TABLE}.Deal_Type ;;
  }
  dimension: forecast_bet {
    type: number
    sql: ${TABLE}.Forecast_Bet ;;
  }
  dimension: generalist_rep {
    type: string
    sql: ${TABLE}.Generalist_Rep ;;
  }
  dimension: gr_forecast_full_credit {
    type: number
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
  }
  dimension: holding_company {
    type: string
    sql: ${TABLE}.Holding_company ;;
  }
  dimension: io_booked_units {
    type: number
    sql: ${TABLE}.IO_Booked_Units ;;
  }
  dimension: io_group_name {
    type: string
    sql: ${TABLE}.IO_Group_Name ;;
  }
  dimension: io_region {
    type: string
    sql: ${TABLE}.IO_Region ;;
  }
  dimension: io_sales_team {
    type: string
    sql: ${TABLE}.IO_Sales_Team ;;
  }
  dimension: io_super_region {
    type: string
    sql: ${TABLE}.IO_Super_Region ;;
  }
  dimension: io_type {
    type: string
    sql: ${TABLE}.IO_Type ;;
  }
  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.Opportunity_ID ;;
  }
  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }
  dimension: opportunity_owner {
    type: string
    sql: ${TABLE}.Opportunity_Owner ;;
  }
  dimension: related_brand_id {
    type: string
    sql: ${TABLE}.Related_Brand_ID ;;
  }
  dimension: related_brand_name {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }
  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }
  dimension: revenue_line {
    type: string
    sql: ${TABLE}.revenue_line ;;
  }
  dimension_group: schedule_revenue_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.schedule_revenue_end_date ;;
  }
  dimension_group: schedule_revenue_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.schedule_revenue_start_date ;;
  }
  dimension: snapshot_booked_full_credit {
    type: number
    sql: ${TABLE}.snapshot_booked_full_credit ;;
  }
  dimension_group: snapshot {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.snapshot_date ;;
  }
  dimension: snapshot_net_revenue_booked {
    type: number
    sql: ${TABLE}.snapshot_net_revenue_booked ;;
  }
  dimension: snapshot_nr_forecast_full_credit {
    type: number
    sql: ${TABLE}.snapshot_NR_forecast_full_credit ;;
  }
  dimension: social_specialist {
    type: string
    sql: ${TABLE}.Social_Specialist ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension: tv_specialist {
    type: string
    sql: ${TABLE}.TV_Specialist ;;
  }
  measure: count {
    type: count
    drill_fields: [related_brand_name, account_name, opportunity_name, io_group_name]
  }
}
