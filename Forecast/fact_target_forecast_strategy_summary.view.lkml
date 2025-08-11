view: fact_target_forecast_strategy_summary {
  sql_table_name: BI_DSP.fact_forecast_strategy_summary ;;

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
    value_format: "0.00%"
    # label: "% Of Target GR Forecast"
  }
  dimension: percent_of_target_nr_forecast {
    type: number
    sql: ${TABLE}.percent_of_target_nr_forecast ;;
    value_format: "0.00%"
    # label: "% Of Target NR Forecast"
  }
  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }
  dimension: revenue_line {
    type: string
    sql: ${TABLE}.revenue_line ;;
  }
  dimension: schedule_converted_revenue_v2 {
    type: number
    sql: ${TABLE}.schedule_converted_revenue_v2 ;;
  }
  dimension: seller {
    type: string
    sql: ${TABLE}.seller ;;
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

    dimension: Strat_Sales_Team {
      type: string
      sql: ${TABLE}.Strat_Sales_Team ;;
  }

  dimension: Strat_Sales_RVP {
    type: string
    sql: ${TABLE}.Strat_Sales_RVP ;;
    drill_fields: [revenue_line, Strat_Sales_Team]
  }


  dimension: new_enterprise_team {
    type: string
    sql: ${TABLE}.new_enterprise_team ;;
  }


  ###--MEASURES--###


  measure: sum_gr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.GR_Forecast_Full_Credit ;;
    value_format: "$#,##0.00"
    label: "GR Forecast"
    view_label: "GR"
  }

  measure: sum_unweighted_tl_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Unweighted_TL_Upside_New_Forecast_v2 ;;
    value_format: "$#,##0.00"
    label: "GR Unweighted Upside"
    view_label: "GR"
  }
  measure: sum_weighted_tl_upside_new_forecast_v2 {
    type: sum
    sql: ${TABLE}.Weighted_TL_Upside_New_Forecast_v2 ;;
    value_format: "$#,##0.00"
    label: "GR Weighted Upside"
    view_label: "GR"
  }

  measure: sum_nr_forecast_full_credit {
    type: sum
    sql: ${TABLE}.NR_Forecast_Full_Credit ;;
    value_format: "$#,##0.00"
    label: "NR Forecast"
    view_label: "NR"
    }

  measure: sum_net_revenue_target {
    type: sum
    sql: ${TABLE}.net_revenue_target ;;
    value_format: "$#,##0.00"
    label: "NR Target"
    view_label: "Target"
  }

  measure: sum_gross_revenue_target {
    type: sum
    sql: ${TABLE}.gross_revenue_target ;;
    value_format: "$#,##0.00"
    label: "GR Target"
    view_label: "Target"
  }

  measure: sum_booked_full_credit {
    type: sum
    sql: ${TABLE}.Booked_Full_Credit ;;
    value_format: "$#,##0.00"
    label: "GR Booked"
    view_label: "GR"
  }

  measure:sum_net_revenue_booked {
    type: sum
    sql: ${TABLE}.Net_Revenue_Booked ;;
    value_format: "$#,##0.00"
    label: "NR Booked"
    view_label: "NR"
  }

  measure: sum_gr_booked_to_forecast_delta {
    type: sum
    sql: ${TABLE}.GR_Booked_to_Forecast_Delta ;;
    value_format: "$#,##0.00"
    label: "GR Booked to Forecast (Delta)"
    view_label: "GR"
  }

  measure: sum_nr_booked_to_forecast_delta {
    type: sum
    sql: ${TABLE}.NR_Booked_to_Forecast_Delta ;;
    value_format: "$#,##0.00"
    label: "NR Booked to Forecast (Delta)"
    view_label: "NR"
  }

  measure: delta_nr_booked {
    type: number
    label: "Delta Between NR Booked and Target"
    sql: ${sum_net_revenue_booked} - ${sum_net_revenue_target} ;;
    value_format: "$#,##0.00"
    view_label: "NR"
  }
  measure: P_of_Target_NR_Booked {
    type: number
    label: "% of Target NR Booked"
    sql: CASE
          WHEN ${fact_target_forecast_strategy_summary.sum_net_revenue_target} = 0 THEN 0
          ELSE ${fact_target_forecast_strategy_summary.sum_net_revenue_booked}
          / NULLIF(${fact_target_forecast_strategy_summary.sum_net_revenue_target}, 0)
          END ;;
    value_format: "0.00%"
    view_label: "NR"
  }

  # measure: sum_percent_of_target_gr_forecast {
  #   type: sum
  #   sql: ${TABLE}.percent_of_target_gr_forecast ;;
  #   value_format: "0.00%"
  #   label: "% Of Target GR Forecast"
  #   view_label: "GR"
  # }

  measure: sum_percent_of_target_gr_forecast {
    type: number
    label: "% of Target GR Forecast"
    sql: CASE
          WHEN ${fact_target_forecast_strategy_summary.sum_gross_revenue_target} = 0 THEN 0
          ELSE ${fact_target_forecast_strategy_summary.sum_gr_forecast_full_credit}
              / NULLIF(${fact_target_forecast_strategy_summary.sum_gross_revenue_target}, 0)
      END ;;
    value_format: "0.00%"
    view_label: "GR"
  }

  # measure: sum_percent_of_target_nr_forecast {
  #   type: sum
  #   sql: ${TABLE}.percent_of_target_nr_forecast ;;
  #   value_format: "0.00%"
  #   label: "% Of Target NR Forecast"
  #   view_label: "NR"
  # }

  measure: sum_percent_of_target_nr_forecast {
    type: number
    label: "% of Target NR Forecast"
    sql: CASE
          WHEN ${fact_target_forecast_strategy_summary.sum_net_revenue_target} = 0 THEN 0
          ELSE ${fact_target_forecast_strategy_summary.sum_nr_forecast_full_credit}
              / NULLIF(${fact_target_forecast_strategy_summary.sum_net_revenue_target}, 0)
      END ;;
    value_format: "0.00%"
    view_label: "NR"
  }

  measure: sum_weighted_nr_upside_and_nr_forecast {
    type: sum
    sql: ${TABLE}.Weighted_NR_Upside_New_Forecast_v2 + ${TABLE}.NR_Forecast_Full_Credit;;
    value_format: "$#,##0.00"
    label: "NR Forecast + NR Upside (Weighted)"
    view_label: "NR"
  }

  measure: sum_weighted_nr_upside_and_nr_forecast_to_target {
    type: average
    sql: CASE
          WHEN ${TABLE}.net_revenue_target = 0 THEN 0
          ELSE (${TABLE}.Weighted_NR_Upside_New_Forecast_v2 + ${TABLE}.NR_Forecast_Full_Credit)
              / NULLIF(${TABLE}.net_revenue_target, 0)
      END ;;
    value_format: "0.00%"
    label: "NR Forecast + NR Upside % to Target"
    view_label: "NR"
  }

  measure: count {
    type: count
  }
}
