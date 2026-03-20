view: fact_dsp_dv_sivt_reporting {
  sql_table_name: BI_DSP.fact_dsp_dv_sivt_reporting ;;

  dimension: app_id {
    type: string
    sql: ${TABLE}.app_id ;;
  }
  dimension: app_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.app_id_key ;;
  }
  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date_key ;;
  }
  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
  }
  dimension: environment_key {
    type: number
    sql: ${TABLE}.environment_key ;;
  }
  dimension: exchange_line_item_id {
    type: string
    sql: ${TABLE}.exchange_line_item_id ;;
  }
  dimension: exchange_line_item_key {
    type: number
    sql: ${TABLE}.exchange_line_item_key ;;
  }
  dimension: inventory_source_id {
    type: number
    sql: ${TABLE}.inventory_source_id ;;
  }
  dimension: inventory_source_key {
    type: number
    sql: ${TABLE}.inventory_source_key ;;
  }
  dimension: tld {
    type: string
    label: "TLD"
    sql: ${TABLE}.tld ;;
  }
  dimension: tld_key {
    type: number
    label: "TLD Key"
    sql: ${TABLE}.tld_key ;;
  }

  #-------------------------------------------------------MEASURES-----------------------------------------------------
  measure: bot_fraud_imps_measured {
    type: sum
    label:"Bot Fraud Impressions (Measured)"
    sql: ${TABLE}.bot_fraud_imps_measured ;;
  }
  measure: bot_fraud_imps_scaled {
    type: sum
    label:"Bot Fraud Impressions (Scaled)"
    sql: ${TABLE}.bot_fraud_imps_scaled ;;
  }
  measure: data_center_traffic_imps_measured {
    type: sum
    label:"Data Center Traffic Impressions (Measured)"
    sql: ${TABLE}.data_center_traffic_imps_measured ;;
  }
  measure: data_center_traffic_imps_scaled {
    type: sum
    label:"Data Center Traffic Impressions (Scaled)"
    sql: ${TABLE}.data_center_traffic_imps_scaled ;;
  }
  measure: dv_net_ads {
    type: sum
    label: "DV Net Ads"
    sql: ${TABLE}.dv_net_ads ;;
  }
  measure: emulator_impressions_measured {
    type: sum
    label:"Emulator Impressions (Measured)"
    sql: ${TABLE}.emulator_impressions_measured ;;
  }
  measure: emulator_impressions_scaled {
    type: sum
    label:"Emulator Impressions (Scaled)"
    sql: ${TABLE}.emulator_impressions_scaled ;;
  }
  measure: hijacked_device_impressions_measured {
    type: sum
    label:"Hijacked Device Impressions (Measured)"
    sql: ${TABLE}.hijacked_device_impressions_measured ;;
  }
  measure: hijacked_device_impressions_scaled {
    type: sum
    label:"Hijacked Device Impressions (Scaled)"
    sql: ${TABLE}.hijacked_device_impressions_scaled ;;
  }
  measure: impressions {
    type: sum
    label: "Impressions 1P"
    sql: ${TABLE}.impressions ;;
  }
  measure: injected_ad_impressions_measured {
    type: sum
    label:"Injected Ad Impressions (Measured)"
    sql: ${TABLE}.injected_ad_impressions_measured ;;
  }
  measure: injected_ad_impressions_scaled {
    type: sum
    label:"Injected Ad Impressions (Scaled)"
    sql: ${TABLE}.injected_ad_impressions_scaled ;;
  }
  measure: inventory_cost {
    type: sum
    label: "Inv Cost"
    value_format: "$#,##0.00"
    sql: ${TABLE}.inventory_cost ;;
  }
  measure: ivt_cost {
    type: sum
    label: "IVT Cost"
    value_format: "$#,##0.00"
    sql: ${TABLE}.ivt_cost ;;
  }
  measure: sivt_impressions_measured {
    type: sum
    label:"SIVT Impressions (Measured)"
    sql: ${TABLE}.sivt_impressions_measured ;;
  }
  measure: sivt_impressions_scaled {
    type: sum
    label:"SIVT Impressions (Scaled)"
    sql: ${TABLE}.sivt_impressions_scaled ;;
  }
  measure: sivt_rate {
    type: sum
    label: "SIVT Rate"
    value_format: "0.00%"
    sql: ${TABLE}.sivt_rate ;;
  }

}
