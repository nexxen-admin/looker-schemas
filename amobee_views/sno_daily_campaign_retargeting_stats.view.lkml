view: daily_campaign_retargeting_stats {
  sql_table_name: DEMAND_MART.DAILY_CAMPAIGN_RETARGETING_STATS ;;

  dimension: billable_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.BILLABLE_IMPRESSIONS ;;
  }

  measure: sum_billable_impressions {
    type: sum
    label: "Retargeting Billable Impressions"
    description: "The number of impressions that were billable to the client"
    value_format_name: decimal_0
    sql: ${billable_impressions} ;;
  }

  dimension: bt_attribute_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.BT_ATTRIBUTE_COST ;;
  }


  dimension: bt_attribute_cost_currency {
    type: string
    hidden: yes
    sql: ${TABLE}.BT_ATTRIBUTE_COST_CURRENCY ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: click_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.CLICK_IMPRESSIONS ;;
  }

  measure: sum_click_impressions {
    type: sum
    label: "Click Impressions"
    hidden: yes
    value_format_name: decimal_0
    sql: ${click_impressions} ;;
  }

  dimension: clicks {
    type: number
    hidden: yes
    sql: ${TABLE}.CLICKS ;;
  }

  measure: sum_clicks {
    type: sum
    label: "Clicks"
    description: "The total of all clicks (where an impression was clicked upon)."
    value_format_name: decimal_0
    sql: ${clicks} ;;
  }

  dimension: cluster_attribute_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.CLUSTER_ATTRIBUTE_COST ;;
  }

  dimension: cluster_attribute_cost_currency {
    hidden: yes
    type: string
    sql: ${TABLE}.CLUSTER_ATTRIBUTE_COST_CURRENCY ;;
  }

  dimension: completed_100 {
    hidden: yes
    type: number
    sql: ${TABLE}.COMPLETED_100 ;;
  }

  measure: sum_completed_100 {
    type: sum
    label: "Completed 100"
    description: "The total of all impression which were 100% completed."
    value_format_name: decimal_0
    sql: ${completed_100} ;;
  }

  measure: completed_100_pct {
    type: number
    label: "Completed 100%"
    description: "The percentage of all impression which were 100% completed."
    value_format_name: percent_2
    sql: COALESCE(1.0 * ${sum_completed_100} / nullif(${sum_completed_pct_impressions},0),0) ;;
  }

  dimension: completed_25 {
    hidden: yes
    type: number
    sql: ${TABLE}.COMPLETED_25 ;;
  }

  measure: sum_completed_25 {
    type: sum
    label: "Completed 25"
    description: "The total of all impression which were 25% completed."
    value_format_name: decimal_0
    sql: ${completed_25} ;;
  }

  measure: completed_25_pct {
    type: number
    label: "Completed 25%"
    description: "The percentage of all impression which were 25% completed."
    value_format_name: percent_2
    sql: COALESCE((1.0* ${sum_completed_25}) /nullif(${sum_completion_pct_impressions},0),0);;
  }

  dimension: completed_50 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_50 ;;
  }

  measure: sum_completed_50 {
    type: sum
    label: "Completed 50"
    description: "The total of all impression which were 50% completed."
    value_format_name: decimal_0
    sql: ${completed_50} ;;
  }

  measure: completed_50_pct {
    type: number
    label: "Completed 50%"
    description: "The percentage of all impression which were 50% completed."
    value_format_name: percent_2
    sql: COALESCE((1.0 * ${sum_completed_50} ) / nullif(${sum_completion_pct_impressions},0),0) ;;
  }

  dimension: completed_75 {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_75 ;;
  }

  measure: sum_completed_75 {
    type: sum
    label: "Completed 75"
    description: "The total of all impression which were 75% completed."
    value_format_name: decimal_0
    sql: ${completed_75} ;;
  }

  measure: completed_75_pct {
    type: number
    label: "Completed 75%"
    description: "The percentage of all impression which were 75% completed."
    value_format_name: percent_2
    sql: COALESCE((1.0 * ${sum_completed_75} ) / nullif(${sum_completion_pct_impressions},0),0) ;;
  }

  dimension: completed_pct_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETED_PCT_IMPRESSIONS ;;
  }

  measure: sum_completed_pct_impressions {
    type: sum
    label: "Completed Percent Impressions"
    description: "The total number of impression where completed (completed 100) is measured."
    value_format_name: decimal_0
    sql: ${completed_pct_impressions} ;;
  }

  dimension: completion_pct_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.COMPLETION_PCT_IMPRESSIONS ;;
  }

  measure: sum_completion_pct_impressions {
    type: sum
    label: "Completion Percent Impressions"
    description: "The total of impressions where completion percentage is measured.
    This is used in calculating the various completion percentages, and VCR"
    value_format_name: decimal_0
    sql: ${completion_pct_impressions} ;;
  }

  dimension: demand_bt_attribute_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_BT_ATTRIBUTE_COST ;;
  }

  dimension: demand_cluster_attribute_cost {
    type: number
    hidden: yes
    sql: ${TABLE}.DEMAND_CLUSTER_ATTRIBUTE_COST ;;
  }

  dimension: demand_currency {
    type: string
    sql: ${TABLE}.DEMAND_CURRENCY ;;
  }

  dimension_group: demand {
    type: time
    view_label: "Dates"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DEMAND_DATE ;;
  }

  dimension: distinct_clicks {
    type: number
    hidden: yes
    sql: ${TABLE}.DISTINCT_CLICKS ;;
  }

  dimension: effective_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.EFFECTIVE_IMPRESSIONS ;;
  }

  measure: sum_effective_impressions {
    type: sum
    label: "Effective Impression"
    description: "The total of all impression which were in target."
    value_format_name: decimal_0
    sql: ${effective_impressions} ;;
  }

  dimension_group: est {
    type: time
    view_label: "Dates"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.EST_DATE ;;
  }

  dimension_group: gmt {
    view_label: "Dates"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.GMT_DATE ;;
  }

  dimension: import_config_id {
    type: number
    hidden: yes
    sql: ${TABLE}.IMPORT_CONFIG_ID ;;
  }

  dimension: impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.IMPRESSIONS ;;
  }

  measure: sum_impressions {
    type: sum
    label: "Impressions"
    description: "The total impressions"
    value_format_name: decimal_0
    sql: ${impressions} ;;
  }

  dimension: is_billing_attribute {
    type: number
    hidden: yes
    sql: ${TABLE}.IS_BILLING_ATTRIBUTE ;;
  }

  dimension: is_cluster_attribute {
    type: number
    hidden: yes
    sql: ${TABLE}.IS_CLUSTER_ATTRIBUTE ;;
  }

  dimension: is_targeted {
    type: number
    label: "Is Targeted"
    sql: ${TABLE}.IS_TARGETED ;;
  }


  dimension: primary_clicks {
    type: number
    hidden: yes
    sql: ${TABLE}.PRIMARY_CLICKS ;;
  }

  dimension: processingid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.PROCESSINGID ;;
  }

  dimension_group: region {
    type: time
    view_label: "Dates"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.REGION_DATE ;;
  }

  dimension: retargeting_attribute_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RETARGETING_ATTRIBUTE_ID ;;
  }

  dimension: timezone_id {
    type: number
    hidden: yes
    sql: ${TABLE}.TIMEZONE_ID ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
