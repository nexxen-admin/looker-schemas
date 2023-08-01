view: daily_ccp_metrics {
  view_label: "Daily CCP Metrics"
  sql_table_name: DEMAND_MART.DAILY_CCP_METRICS ;;

  dimension_group: asofdate {
    type: time
    label: "As Of"
    hidden: yes
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.ASOFDATE ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension_group: changedon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension_group: createdon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: daily_ccp_eoc {
    type: number
    hidden: yes
    sql: ${TABLE}.DAILY_CCP_EOC ;;
  }

  measure: sum_daily_ccp_eoc {
    type: sum
    label: "Daily CCP"
    description: "The number of units to deliver by day to ensure complete delivery by the end of the flight / campaign, etc. Only use UTC Date dimension when displaying data by date."
    value_format_name: decimal_0
    sql: ${daily_ccp_eoc} ;;
  }

  measure: sum_remaining_daily_ccp_eoc {
    type: sum
    label: "Remaining CCP"
    description: "The number of remaining units to deliver by day to ensure complete delivery by the end of the flight / campaign, etc. Only use UTC Date dimension when displaying data by date."
    value_format_name: decimal_0
    sql: ${daily_ccp_eoc} ;;
    filters: {
      field: asofdate_date
      value: "after today"
    }
  }

  measure: exp_rev {
    type: sum
    label: "Expected Revenue"
    description: "(CCP Audit / 1000) * (Budget / Target Units * 1000)"
    value_format_name: decimal_2
    sql: ${daily_ccp_eoc_audit}/1000 * COALESCE((${campaign_demand_units_budget.budget}/NULLIF(${campaign_demand_units_budget.campaign_delivery_units},0)) * 1000,0) ;;
  }

  measure: sum_daily_ccp_eoc_yesterday {
    type: sum
    label: "Daily CCP Yesterday"
    description: "Number of units to deliver by day to ensure complete delivery by the end of the flight / campaign, etc. Only use UTC Date dimension when displaying data by date."
    value_format_name: decimal_0
    sql: ${daily_ccp_eoc} ;;
    filters: {
      field: keydate_date
      value:"Yesterday"
    }
  }

  measure: sum_daily_icp {
    type: sum
    label: "Daily ICP"
    description: "The initial number of units to deliver by day to ensure complete delivery by the end of the flight / campaign, etc. Only use UTC Date dimension when displaying data by date."
    value_format_name: decimal_0
    sql: ${daily_icp} ;;
  }

  measure: sum_remaining_daily_icp {
    type: sum
    label: "Remaining ICP"
    description: "The remaining number of units to deliver by day to ensure complete delivery by the end of the flight / campaign, etc. Only use UTC Date dimension when displaying data by date."
    value_format_name: decimal_0
    sql: ${daily_icp} ;;
    filters: {
      field: asofdate_date
      value: "after today"
    }
  }

  measure: sum_daily_icp_yesterday {
    type: sum
    label: "Daily ICP Yesterday"
    description: "The initial number of units to deliver by day to ensure complete delivery by the end of the flight / campaign, etc. Only use UTC Date dimension when displaying data by date."
    value_format_name: decimal_0
    sql: ${daily_icp} ;;
    filters: {
      field: keydate_date
      value:"Yesterday"
    }
  }

  dimension: daily_ccp_eoc_audit {
    type: number
    hidden: yes
    sql: ${TABLE}.DAILY_CCP_EOC_AUDIT ;;
  }

  measure: sum_daily_ccp_eoc_audit {
    type: sum
    label: "Daily CCP Audit"
    description: "The daily goal of the flight / campaign, etc. Only use UTC Date dimension when displaying data by date."
    value_format_name: decimal_0
    sql: ${daily_ccp_eoc_audit} ;;
  }

  measure: sum_daily_ccp_eoc_audit_yesterday {
    type: sum
    label: "Daily CCP Audit Yesterday"
    description: "Number of units to deliver by day to ensure complete delivery by the end of the flight / campaign, etc. Only use UTC Date dimension when displaying data by date."
    value_format_name: decimal_0
    sql: case when ${keydate_raw} = case when ${demand_mart_load_tracking_start_timezone.utc_offset} > 0 then dateadd(d, -1, ${demand_mart_load_tracking.load_through_date}) else ${demand_mart_load_tracking.load_through_date} end then ${daily_ccp_eoc_audit} else 0 end ;;
  }

  measure: daily_ccp_eoc_audit_diff_yesterday_gmt {
    type: number
    label: "Daily CCP Audit Diff Yesterday UTC"
    description: "Difference between expected and actual units served yesterday in UTC"
    value_format: "#,##0;(#,##0)"
    sql: coalesce(${daily_core_stats.sum_billable_units_yesterday_gmt}, 0) - coalesce(${sum_daily_ccp_eoc_audit_yesterday}, 0) ;;
  }

  dimension: daily_icp {
    type: number
    hidden: yes
    sql: ${TABLE}.DAILY_ICP ;;
  }

  dimension: daily_icp_audit {
    type: number
    hidden: yes
    sql: ${TABLE}.DAILY_ICP_AUDIT ;;
  }

  dimension: flight_id {
    type: number
    hidden: yes
    sql: ${TABLE}.FLIGHT_ID ;;
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension: hours_can_serve {
    type: number
    hidden: yes
    sql: ${TABLE}.HOURS_CAN_SERVE ;;
  }

  dimension: insertion_order_id {
    type: number
    hidden: yes
    sql: ${TABLE}.INSERTION_ORDER_ID ;;
  }

  dimension_group: keydate {
    type: time
    label: "CCP"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    description: "The date in UTC for which this ICP/CCP is effective."
    sql: ${TABLE}.KEYDATE ;;
  }

  dimension: keyid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.KEYID ;;
  }

  dimension: primary_key {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.PK_ID ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
