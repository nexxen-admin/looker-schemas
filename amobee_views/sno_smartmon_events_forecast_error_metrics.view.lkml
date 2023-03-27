view: sno_smartmon_events_forecast_error_metrics {
  sql_table_name: smartmon.events ;;
  label: "Forecast Error metrics"

  dimension: name {
    type: string
    hidden: yes
    sql: ${TABLE}.name ;;
  }

  dimension: partner_id {
    type: number
    label: "Partner ID"
    sql: json_extract_path_text(${TABLE}.labels, 'partner_id') ;;
  }

  dimension: time_horizon {
    type: string
    label: "Time Horizon"
    sql: json_extract_path_text(${TABLE}.labels, 'time_horizon') ;;
  }

  dimension_group: time {
    type: time
    label: "Forecast"
    timeframes: [
      raw,
      time,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.time ;;
  }

  dimension_group: createdon {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdon ;;
  }

  dimension: value {
    type: number
    label: "Value"
    sql: ${TABLE}.value ;;
  }

  measure: value_avg_measure {
    type: average
    label: "Value (Avg Measure)"
    sql: ${TABLE}.value ;;
  }

  measure: value_avg_measure_percentage {
    type: average
    value_format: "0.00%"
    label: "Value (Avg Measure) Percentage Format"
    sql: ${TABLE}.value ;;
  }

  dimension: h2o_app_change {
    type: number
    label: "h2o App Change"
    sql: json_extract_path_text(${TABLE}.labels, 'h2o_app_change') ;;
  }

  dimension: h2o_version {
    type: string
    label: "h2o Version"
    sql: json_extract_path_text(${TABLE}.labels, 'h2o_version') ;;
  }

  dimension: merged_data_filter_name {
    type: string
    label: "Merged Data Filter Name"
    sql: json_extract_path_text(${TABLE}.labels, 'merged_data_filter_name') ;;
  }

  dimension: metric {
    type: string
    label: "Metric"
    sql: json_extract_path_text(${TABLE}.labels, 'metric') ;;
  }

  dimension: metric_level {
    type: string
    label: "Metric Level"
    sql: json_extract_path_text(${TABLE}.labels, 'metric_level') ;;
  }

  dimension: days {
    type: number
    label: "Days"
    sql: CASE WHEN ${time_horizon} = '0_2_day' THEN 2
      WHEN ${time_horizon} = '2_14_day' THEN 12
      WHEN ${time_horizon} = '14_60_day' THEN 46
      ELSE NULL END ;;
  }

  measure: days_avg_measure {
    type: average
    label: "Days (Avg Measure)"
    sql: ${days} ;;
  }

  dimension: avg_value {
    type: number
    label: "Avg Value"
    sql: CASE WHEN ${metric} IN ('missing_forecast_volume', 'extra_forecast_volume', 'filtered_forecasted', 'filtered_observed') THEN ${value}/${days}
      ELSE NULL END ;;
  }

  measure: avg_value_avg_measure {
    type: average
    label: "Avg Value (Avg Measure)"
    sql: ${avg_value} ;;
  }
}
