view: mediaplanner_allocation_view {
  label: "Allocation Metrics"
  sql_table_name: OPT.MEDIAPLANNER_ALLOCATION_VIEW ;;

  dimension: pkey {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.ID ;;
  }

  dimension_group: allocation_date {
    type: time
    label: "Allocation"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ALLOCATION_DATE ;;
    datatype: date
    convert_tz: no
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension_group: run_date {
    type: time
    label: "Run"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.RUNDATE ;;
    datatype: date
    convert_tz: no
  }

  dimension: pay_rate {
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.ALLOCATION_DATE >= CURRENT_DATE() THEN ${TABLE}.PAY_RATE ELSE 0 END ;;
  }

  dimension: pay_rate_total {
    type: number
    hidden: yes
    sql: ${TABLE}.PAY_RATE ;;
  }

  dimension: win_rate {
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.ALLOCATION_DATE >= CURRENT_DATE() THEN ${TABLE}.WIN_RATE ELSE 0 END ;;
  }

  dimension: win_rate_total {
    type: number
    hidden: yes
    sql: ${TABLE}.WIN_RATE ;;
  }

  dimension: x_allocation {
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.ALLOCATION_DATE >= CURRENT_DATE() THEN ${TABLE}.X_ALLOCATION ELSE 0 END ;;
  }

  dimension: x_allocation_total {
    type: number
    hidden: yes
    sql: ${TABLE}.X_ALLOCATION ;;
  }

  dimension: y_allocation {
    type: number
    hidden: yes
    sql: CASE WHEN ${TABLE}.ALLOCATION_DATE >= CURRENT_DATE() THEN ${TABLE}.Y_ALLOCATION ELSE 0 END ;;
  }

  dimension: y_allocation_total {
    type: number
    hidden: yes
    sql: ${TABLE}.Y_ALLOCATION ;;
  }

  measure: impressions {
    type: sum
    label: "Allocation Impressions"
    description: "The number of impression currently allocated to deliver by the Videology optimal allocation technology."
    value_format_name: decimal_0
    sql: (${x_allocation} + ${y_allocation}) * ${win_rate} ;;
  }

  measure: impressions_total {
    type: sum
    label: "Total Allocation Impressions"
    description: "The number of impression currently allocated to deliver by the Videology optimal allocation technology. Includes allocation impression from the past."
    value_format_name: decimal_0
    sql: (${x_allocation_total} + ${y_allocation_total}) * ${win_rate_total} ;;
  }

  measure: spend {
    type: sum
    label: "Allocation Spend"
    description: "The spend currently allocated to deliver by the Videology optimal allocation technology."
    value_format_name: decimal_0
    sql: ${x_allocation} * ${win_rate} * ${pay_rate} ;;
  }

  measure: spend_total {
    type: sum
    label: "Total Allocation Spend"
    description: "The spend currently allocated to deliver by the Videology optimal allocation technology. Includes allocation spend from the past."
    sql: ${x_allocation_total} * ${win_rate_total} * ${pay_rate_total} ;;
  }

  measure: units {
    type: sum
    label: "Allocation Units"
    description: "The number of units currently allocated to deliver by the Videology optimal allocation technology."
    value_format_name: decimal_0
    sql: ${x_allocation} * ${win_rate} * ${pay_rate} ;;
  }

  measure: units_total {
    type: sum
    label: "Total Allocation Units"
    description: "The number of units currently allocated to deliver by the Videology optimal allocation technology. Includes allocation units from the past."
    value_format_name: decimal_0
    sql: ${x_allocation_total} * ${win_rate_total} * ${pay_rate_total} ;;
  }

  measure: flight_allocation_delta {
    type: sum
    label: "Flight Allocation Delta"
    description: "The delta metric represents the difference between total allocated and total planned units. If this metric is 0, the campaign is allocated in full.
    if this metric is greater than 0, the campaign is at risk of underdelivery."
    sql: ${TABLE}.ALLOCATION_DELTA ;;
  }

  measure: campaign_allocation_delta {
    type: sum
    label: "Campaign Allocation Delta"
    value_format_name: decimal_0
    description: "The delta metric represents the difference between total allocated and total planned units. If this metric is 0, the campaign is allocated in full.
    if this metric is greater than 0, the campaign is at risk of underdelivery."
    sql: ${TABLE}.ALLOCATION_DELTA ;;
  }

  measure: count {
    type: count
    hidden: yes
    label: "Count"
    drill_fields: []
  }
}
