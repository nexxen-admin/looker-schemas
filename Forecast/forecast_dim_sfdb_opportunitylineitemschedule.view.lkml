view: forecast_dim_sfdb_opportunitylineitemschedule {
  sql_table_name: BI_DSP.dim_sfdb_opportunitylineitemschedule ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension: actualized__c {
    type: number
    sql: ${TABLE}.actualized__c ;;
  }
  dimension: booked_full_credit {
    type: number
    sql: ${TABLE}.Booked_Full_Credit ;;
  }
  dimension: closed_or_open {
    type: string
    sql: ${TABLE}.Closed_Or_Open ;;
  }
  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }
  dimension_group: end_date__c {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.end_date__c ;;
  }
  dimension: gr_booked_to_forecast_delta {
    type: number
    sql: ${TABLE}.GR_Booked_to_Forecast_Delta ;;
  }
  dimension: gr_forecast_full_credit {
    type: number
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
  }
  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
  }
  dimension: is_free__c {
    type: number
    sql: ${TABLE}.is_free__c ;;
  }
  dimension_group: lastmodifieddate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.lastmodifieddate ;;
  }
  dimension: net_revenue_booked {
    type: number
    sql: ${TABLE}.Net_Revenue_Booked ;;
  }
  dimension: nr_booked_to_forecast_delta {
    type: number
    sql: ${TABLE}.NR_Booked_to_Forecast_Delta ;;
  }
  dimension: nr_forecast__nr_upside_weighted_new {
    type: number
    sql: ${TABLE}.NR_Forecast__NR_Upside_Weighted_NEW ;;
  }
  dimension: nr_forecast_full_credit {
    type: number
    sql: ${TABLE}.NR_Forecast_Full_Credit ;;
  }
  dimension: opportunity_margin {
    type: number
    sql: ${TABLE}.opportunity_Margin ;;
  }
  dimension: opportunitylineitemid {
    type: string
    sql: ${TABLE}.opportunitylineitemid ;;
  }
  dimension: opportunitylineitemschedule_key {
    type: number
    sql: ${TABLE}.opportunitylineitemschedule_key ;;
  }
  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
  }
  dimension: schedule_converted_revenue_v2 {
    type: number
    sql: ${TABLE}.schedule_converted_revenue_v2 ;;
  }
  dimension_group: scheduledate {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.scheduledate ;;
  }
  dimension_group: systemmodstamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.systemmodstamp ;;
  }
  dimension: unweighted_nr_forecast_tremor_leadership {
    type: number
    sql: ${TABLE}.Unweighted_NR_Forecast_Tremor_Leadership ;;
  }
  dimension: unweighted_nr_upside_new_forecast_v2 {
    type: number
    sql: ${TABLE}.Unweighted_NR_Upside_New_Forecast_v2 ;;
  }
  dimension: unweighted_tl_upside_new_forecast_v2 {
    type: number
    sql: ${TABLE}.Unweighted_TL_Upside_New_Forecast_v2 ;;
  }
  dimension: useredits__c {
    type: number
    sql: ${TABLE}.useredits__c ;;
  }
  dimension: weighted_forecasted_spend_tremor_leadership {
    type: number
    sql: ${TABLE}.Weighted_Forecasted_Spend_Tremor_Leadership ;;
  }
  dimension: weighted_nr_forecast_tremor_leadership {
    type: number
    sql: ${TABLE}.Weighted_NR_Forecast_Tremor_Leadership ;;
  }
  dimension: weighted_nr_upside_new_forecast_v2 {
    type: number
    sql: ${TABLE}.Weighted_NR_Upside_New_Forecast_v2 ;;
  }
  dimension: weighted_scheduled_converted_revenue {
    type: number
    sql: ${TABLE}.Weighted_Scheduled_Converted_Revenue ;;
  }
  dimension: weighted_tl_upside_new_forecast_v2 {
    type: number
    sql: ${TABLE}.Weighted_TL_Upside_New_Forecast_v2 ;;
  }


       #####--MEASURES---####

  measure: sum_booked_full_credit {
    type: sum
    sql: ${TABLE}.Booked_Full_Credit ;;
    label: "GR Booked"
  }

  measure: sum_gr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
    label: "GR Forecast"
  }

  measure: sum_nr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.NR_Forecast_Full_Credit ;;
    label: "NR Forecast"
  }

  measure: sum_net_revenue_booked {
    type: sum
    sql: ${TABLE}.Net_Revenue_Booked;;
    label: "NR Booked"
    }

  measure: sum_unweighted_tl_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Unweighted_TL_Upside_New_Forecast_v2 ;;
    label: "Unweighted TL Upside"
  }

  measure: sum_unweighted_nr_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.unweighted_nr_upside_new_forecast_v2 ;;
    label: "Unweighted NR Upside"
  }

  measure: sum_weighted_nr_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Weighted_NR_Upside_New_Forecast_v2 ;;
    label: "Weighted NR Upside"
  }

  measure: sum_weighted_tl_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Weighted_TL_Upside_New_Forecast_v2 ;;
    label: "Weighted TL Upside"
  }

  measure: sum_schedule_converted_revenue_v2 {
    type: sum
    sql: ${TABLE}.schedule_converted_revenue_v2 ;;
    label: "Schedule Converted Revenue v2"
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
