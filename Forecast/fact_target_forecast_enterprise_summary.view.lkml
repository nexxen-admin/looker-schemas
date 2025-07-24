view: fact_target_forecast_enterprise_summary {
  sql_table_name: BI_DSP.fact_forecast_enterprise_summary ;;

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }
  dimension: booked_full_credit {
    type: number
    sql: ${TABLE}.Booked_Full_Credit ;;
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
  dimension_group: event_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_month ;;
  }
  dimension: generalist_name {
    type: string
    sql: ${TABLE}.Generalist_Name ;;
  }
  dimension: gr_booked_to_forecast_delta {
    type: number
    sql: ${TABLE}.GR_Booked_to_Forecast_Delta ;;
  }
  dimension: gr_forecast_full_credit {
    type: number
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
  }
  dimension: gross_revenue_target {
    type: number
    sql: ${TABLE}.gross_revenue_target ;;
  }
  dimension: net_revenue_booked {
    type: number
    sql: ${TABLE}.Net_Revenue_Booked ;;
  }
  dimension: net_revenue_target {
    type: number
    sql: ${TABLE}.net_revenue_target ;;
  }
  dimension: nr_booked_to_forecast_delta {
    type: number
    sql: ${TABLE}.NR_Booked_to_Forecast_Delta ;;
  }
  dimension: nr_forecast_full_credit {
    type: number
    sql: ${TABLE}.NR_Forecast_Full_Credit ;;
  }
  dimension: nr_forecast_nr_upside_weighted_new {
    type: number
    sql: ${TABLE}.NR_Forecast_NR_Upside_Weighted_NEW ;;
  }
  dimension: percent_of_target_gr_forecast {
    type: number
    sql: ${TABLE}.percent_of_target_gr_forecast ;;
    value_format: "0.0%"
  }
  dimension: percent_of_target_nr_forecast {
    type: number
    sql: ${TABLE}.percent_of_target_nr_forecast ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }
  dimension: related_brand {
    type: string
    sql: ${TABLE}.Related_Brand ;;
  }
  dimension: revenue_line {
    type: string
    sql: ${TABLE}.revenue_line ;;
  }
  dimension: schedule_converted_revenue_v2 {
    type: number
    sql: ${TABLE}.schedule_converted_revenue_v2 ;;
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

  ###--MEASURES--###

  measure: sum_gr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
    value_format: "#,##0.00"
    label: "GR Forecast"
    view_label: "GR Forecast"
  }

  measure: sum_nr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.NR_Forecast_Full_Credit ;;
    value_format: "#,##0.00"
    label: "NR Forecast"
    view_label: "NR Forecast"
  }

  measure: sum_unweighted_nr_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Unweighted_NR_Upside_New_Forecast_v2 ;;
    value_format: "#,##0.00"
    label: "NR Unweighted Upside"
    view_label: "NR Forecast"
  }

  measure: sum_weighted_nr_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Weighted_NR_Upside_New_Forecast_v2 ;;
    value_format: "#,##0.00"
    label: "NR weighted Upside"
    view_label: "NR Forecast"
  }

  measure: sum_unweighted_tl_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Unweighted_TL_Upside_New_Forecast_v2 ;;
    value_format: "#,##0.00"
    label: "GR Unweighted Upside"
    view_label: "GR Forecast"
  }

  measure: sum_weighted_tl_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Weighted_TL_Upside_New_Forecast_v2 ;;
    value_format: "#,##0.00"
    label: "GR weighted Upside"
    view_label: "GR Forecast"
  }


  measure: sum_booked_full_credit {
    type: sum
    sql: ${TABLE}.Booked_Full_Credit ;;
    value_format: "#,##0.00"
    label: "GR Booked"
    view_label: "GR Booked"
  }

  measure: sum_net_revenue_booked {
    type: sum
    sql: ${TABLE}.Net_Revenue_Booked ;;
    value_format: "#,##0.00"
    label: "NR Booked"
    view_label: "NR Booked"
  }

  measure: sum_net_revenue_target {
    type: sum
    sql: ${TABLE}.net_revenue_target ;;
    value_format: "#,##0.00"
    label: "NR Target"
  }

  measure: sum_gross_revenue_target {
    type: sum
    sql: ${TABLE}.gross_revenue_target ;;
    value_format: "#,##0.00"
    label: "GR Target"
  }

  measure:sum_gr_booked_to_forecast_delta {
    type: sum
    sql: ${TABLE}.GR_Booked_to_Forecast_Delta ;;
  }

  measure:sum_nr_booked_to_forecast_delta {
    type: sum
    sql: ${TABLE}.NR_Booked_to_Forecast_Delta ;;
  }

  # measure: p_of_target_gr_forecast {
  #   type: number
  #   sql: ${TABLE}.percent_of_target_gr_forecast ;;
  #   value_format: "0.0%"
  # }

  measure: delta_nr_forecast {
    type: number
    label: "Delta Between NR Forecast and Target"
    sql: ${sum_nr_forecast_full_credit} - ${sum_net_revenue_target} ;;
    value_format: "#,##0.00"
    view_label: "NR Forecast"
  }

  measure: delta_nr_booked {
    type: number
    label: "Delta Between NR Booked and Target"
    sql: ${sum_net_revenue_booked} - ${sum_net_revenue_target} ;;
    value_format: "#,##0.00"
    view_label: "NR Booked"
  }

  measure: count {
    type: count
    drill_fields: [account_name, generalist_name]
  }
}
