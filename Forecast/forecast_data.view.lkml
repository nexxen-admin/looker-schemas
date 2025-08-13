view: forecast_data {
  sql_table_name: BI_DSP.Forecast_Data ;;

  dimension: generalist_rep {
    type: string
    sql: ${TABLE}.Generalist_Rep ;;
  }
  dimension: has_opportunitylineitem {
    type: number
    sql: ${TABLE}.has_opportunitylineitem ;;
  }
  dimension: io_super_region {
    type: string
    sql: ${TABLE}.IO_Super_Region ;;
  }
  dimension: io_type {
    type: string
    sql: ${TABLE}.IO_Type ;;
  }
  dimension: new_enterprise_team {
    type: string
    sql: ${TABLE}.new_enterprise_team ;;
  }
  dimension_group: opportunity_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_end_date ;;
  }
  dimension: opportunity_id {
    type: string
    sql: ${TABLE}.Opportunity_ID ;;
  }
  dimension: opportunity_margin {
    type: number
    sql: ${TABLE}.opportunity_Margin ;;
  }
  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }
  dimension: opportunity_probability {
    type: number
    sql: ${TABLE}.opportunity_probability ;;
  }
  dimension: opportunity_proposed_spend {
    type: number
    sql: ${TABLE}.opportunity_proposed_spend ;;
  }
  dimension: opportunity_record_type {
    type: string
    sql: ${TABLE}.opportunity_record_type ;;
  }
  dimension_group: opportunity_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_start_date ;;
  }
  dimension: report_month {
    type: date
    datatype: date
    sql: ${TABLE}.report_month ;;
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
  dimension: snapshot_forecast_checkbox {
    type: number
    sql: ${TABLE}.Snapshot_Forecast_Checkbox ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }
  dimension: unweighted_nr_upside_new_forecast_v2 {
    type: number
    sql: ${TABLE}.Unweighted_NR_Upside_New_Forecast_v2 ;;
  }
  dimension: weighted_nr_upside_new_forecast_v2 {
    type: number
    sql: ${TABLE}.Weighted_NR_Upside_New_Forecast_v2 ;;
  }
  measure: count {
    type: count
    drill_fields: [opportunity_name]
    hidden: yes
  }
}
