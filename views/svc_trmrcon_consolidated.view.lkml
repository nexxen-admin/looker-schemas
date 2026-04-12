view: svc_trmrcon_consolidated {
  sql_table_name: bi.SVC_TRMRCon_Consolidated ;;

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.Advertiser_Name ;;
  }
  dimension: billing_agency {
    type: string
    sql: ${TABLE}.Billing_Agency ;;
  }
  dimension: buying_channel {
    type: string
    sql: ${TABLE}.Buying_Channel ;;
  }
  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }
  dimension: demand_cost {
    type: number
    sql: ${TABLE}.Demand_Cost ;;
  }
  dimension: demand_revenue {
    type: number
    sql: ${TABLE}.Demand_Revenue ;;
  }
  dimension: device_type {
    type: string
    sql: ${TABLE}.Device_type ;;
  }
  dimension: dmnd_ss_platform_revenue {
    type: number
    sql: ${TABLE}.DMND_SS_Platform_Revenue ;;
  }
  dimension: dsp_account {
    type: string
    sql: ${TABLE}.DSP_Account ;;
  }
  dimension: e2_e_cost {
    type: number
    sql: ${TABLE}.E2E_Cost ;;
  }
  dimension: e2_e_revenue {
    type: number
    sql: ${TABLE}.E2E_Revenue ;;
  }
  dimension_group: event_month {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Event_Month ;;
  }
  dimension: exchange_cost {
    type: number
    sql: ${TABLE}.Exchange_Cost ;;
  }
  dimension: exchange_revenue {
    type: number
    sql: ${TABLE}.Exchange_Revenue ;;
  }
  dimension: impression_type {
    type: string
    sql: ${TABLE}.Impression_Type ;;
  }
  dimension: margin_group {
    type: string
    sql: ${TABLE}.Margin_Group ;;
  }
  dimension: pub_id {
    type: string
    sql: ${TABLE}.Pub_ID ;;
  }
  dimension: publisher {
    type: string
    sql: ${TABLE}.Publisher ;;
  }
  dimension: source_table {
    type: string
    sql: ${TABLE}.Source_Table ;;
  }
  dimension: ssp {
    type: string
    sql: ${TABLE}.SSP ;;
  }
  measure: count {
    type: count
    drill_fields: [advertiser_name]
  }
}
