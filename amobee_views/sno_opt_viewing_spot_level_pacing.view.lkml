view: sno_opt_viewing_spot_level_pacing {
  sql_table_name: "OPT"."VIEWING_SPOT_LEVEL_PACING" ;;
  label: "Viewing Spot Level Pacing"

  parameter: show_only_latest_report {
    label: "Show only latest [approved] report for each campaign"
    type: unquoted
    allowed_value: {
      label: "Show all"
      value: "all"
    }
    allowed_value: {
      label: "Show the latest (any approval status)"
      value: "latest_any"
    }
    allowed_value: {
      label: "Show approved (the latest)"
      value: "latest_approved"
    }
  }

  dimension: aired_program_name {
    type: string
    sql: ${TABLE}."AIRED_PROGRAM_NAME" ;;
  }

  dimension: campaign_id {
    type: number
    value_format_name: id
    sql: ${TABLE}."CAMPAIGN_ID" ;;
  }

  dimension: deal_number {
    type: string
    sql: ${TABLE}."DEAL_NUMBER" ;;
    suggestable: no
  }

  measure: count_distinct_deal_number {
    type: count_distinct
    sql: ${TABLE}."DEAL_NUMBER" ;;
  }

  # measure: list_distinct_deal_number {
  #   type: list
  #   list_field: deal_number
  # }

  dimension: demo_impressions {
    type: number
    sql: ${TABLE}."DEMO_IMPRESSIONS" ;;
  }

  measure: sum_demo_impressions {
    type: sum
    sql: ${TABLE}."DEMO_IMPRESSIONS" ;;
  }

  dimension: demo_metric_value {
    type: number
    sql: ${TABLE}."DEMO_METRIC_VALUE" ;;
  }

  dimension: demo_ue {
    type: number
    sql: ${TABLE}."DEMO_UE" ;;
  }

  dimension: equivalized_units {
    type: number
    sql: ${TABLE}."EQUIVALIZED_UNITS" ;;
  }

  measure: sum_equivalized_units {
    type: sum
    sql: ${TABLE}."EQUIVALIZED_UNITS" ;;
  }

  dimension_group: hittime {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."HITTIME" ;;
  }

  measure: min_hittime {
    type: date_second
    sql: MIN(${TABLE}."HITTIME") ;;
  }

  measure: max_hittime {
    type: date_second
    sql: MAX(${TABLE}."HITTIME") ;;
  }

  dimension: impression_type {
    type: string
    sql: ${TABLE}."IMPRESSION_TYPE" ;;
  }

  measure: count_distinct_impression_type {
    type: count_distinct
    sql: ${TABLE}."IMPRESSION_TYPE" ;;
  }

  # measure: list_distinct_impression_type {
  #   type: list
  #   list_field: impression_type
  # }

  dimension: impressions {
    type: number
    sql: ${TABLE}."IMPRESSIONS" ;;
  }

  measure: sum_impressions {
    type: sum
    sql: ${TABLE}."IMPRESSIONS" ;;
  }

  dimension: master_demo {
    type: string
    sql: ${TABLE}."MASTER_DEMO" ;;
    suggestable: no
  }

  dimension: media_key {
    type: string
    sql: ${TABLE}."MEDIA_KEY" ;;
    suggestable: no
  }

  dimension: methodology {
    type: string
    sql: ${TABLE}."METHODOLOGY" ;;
  }

  dimension: msmt_network_code {
    type: string
    sql: ${TABLE}."MSMT_NETWORK_CODE" ;;
  }

  dimension_group: msmt {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."MSMT_TIME" ;;
  }

  dimension: network_code {
    type: string
    sql: ${TABLE}."NETWORK_CODE" ;;
  }

  measure: count_distinct_network_code {
    type: count_distinct
    sql: ${TABLE}."NETWORK_CODE" ;;
  }

  # measure: list_distinct_network_code {
  #   type: list
  #   list_field: network_code
  # }

  dimension: placement_id {
    type: number
    value_format_name: id
    sql: ${TABLE}."PLACEMENT_ID" ;;
  }

  dimension: posted {
    type: string
    sql: ${TABLE}."POSTED" ;;
  }

  dimension: rating_stream {
    type: string
    sql: ${TABLE}."RATING_STREAM" ;;
  }

  dimension: report_id {
    type: string
    sql: ${TABLE}."REPORT_ID" ;;
    suggestable: no
  }

  dimension_group: run {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."RUN_DATE" ;;
  }

  dimension: selling_title_name {
    type: string
    sql: ${TABLE}."SELLING_TITLE_NAME" ;;
  }

  dimension: selling_title_number {
    type: string
    suggestable: no
    sql: ${TABLE}."SELLING_TITLE_NUMBER" ;;
  }

  dimension: spot_type {
    type: string
    sql: ${TABLE}."SPOT_TYPE" ;;
  }

  dimension: stage {
    type: string
    sql: ${TABLE}."STAGE" ;;
  }

  measure: count_distinct_stage {
    type: count_distinct
    sql: ${TABLE}."STAGE" ;;
  }

  # measure: list_distinct_stage {
  #   type: list
  #   list_field: stage
  # }

  dimension: strategic_impressions {
    type: number
    sql: ${TABLE}."STRATEGIC_IMPRESSIONS" ;;
  }

  measure: sum_strategic_impressions {
    type: sum
    sql: ${TABLE}."STRATEGIC_IMPRESSIONS" ;;
  }

  dimension: strategic_metric_value {
    type: number
    sql: ${TABLE}."STRATEGIC_METRIC_VALUE" ;;
  }

  dimension: strategic_ue {
    type: number
    sql: ${TABLE}."STRATEGIC_UE" ;;
  }

  dimension: third_party_demo_impressions {
    type: number
    sql: ${TABLE}."THIRD_PARTY_DEMO_IMPRESSIONS" ;;
  }

  measure: sum_third_party_demo_impressions {
    type: sum
    sql: ${TABLE}."THIRD_PARTY_DEMO_IMPRESSIONS" ;;
  }

  dimension: tppid {
    type: number
    value_format_name: id
    sql: ${TABLE}."TPPID" ;;
  }

  dimension: unit_rate {
    type: number
    sql: ${TABLE}."UNIT_RATE" ;;
  }

  measure: sum_unit_rate {
    type: sum
    sql: ${TABLE}."UNIT_RATE" ;;
  }

  dimension: universe_impressions {
    type: number
    sql: ${TABLE}."UNIVERSE_IMPRESSIONS" ;;
  }

  measure: sum_universe_impressions {
    type: sum
    sql: ${TABLE}."UNIVERSE_IMPRESSIONS" ;;
  }

  dimension: universe_metric_value {
    type: number
    sql: ${TABLE}."UNIVERSE_METRIC_VALUE" ;;
  }

  dimension: universe_ue {
    type: number
    sql: ${TABLE}."UNIVERSE_UE" ;;
  }

  dimension: usn {
    type: string
    sql: ${TABLE}."USN" ;;
    suggestable: no
  }

  dimension_group: broadcast {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."BROADCAST_DAY" ;;
  }

  measure: count_distinct_usn {
    type: count_distinct
    sql: ${TABLE}."USN" ;;
  }

  # measure: list_distinct_usn {
  #   type: list
  #   list_field: usn
  # }

  measure: latest_ingested_report {
    type: date_time
    label: "Last Report Ingested Date"
    sql: MAX(${run_raw}) ;;
  }

  measure: distinct_campaign {
    type: count_distinct
    label: "Count Distinct Campaign"
    sql: ${TABLE}."CAMPAIGN_ID" ;;
  }
}
