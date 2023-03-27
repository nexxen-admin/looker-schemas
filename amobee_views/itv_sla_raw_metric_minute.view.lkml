view: raw_metric_minute {

  sql_table_name:
    {% if _model._name == 'itv_sla' %}
      SLA.RAW_METRIC_MINUTE
    {% elsif _model._name == 'dsp_sla' %}
      SLA_DSP.RAW_METRIC
    {% elsif _model._name == 'itv_sla_sbx' %}
      SBX.SLA.RAW_METRIC_MINUTE
    {% else %}
      UNDEF_MODEL.RAW_METRIC
    {% endif %} ;;

  dimension: metric_id {
    type: string
    sql: ${TABLE}."METRIC_ID" ;;
  }

  dimension: metric_tag {
    type: string
    sql: ${TABLE}."METRIC_TAG" ;;
  }

  dimension_group: metric {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."METRIC_TIME" ;;
  }

  dimension_group: created_time {
    type: time
    timeframes: [
      date,
      time,
    ]
    sql: ${TABLE}.created_time ;;
  }

  dimension_group: metric_time_et {
    type: time
    timeframes: [time, date]
    sql: CONVERT_TIMEZONE('UTC', 'America/New_York', metric_time) ;;
  }

  dimension_group: metric_time_ct {
    type: time
    timeframes: [time, date]
    sql: CONVERT_TIMEZONE('UTC', 'America/Denver', metric_time) ;;
  }

  dimension_group: metric_time_pt {
    type: time
    timeframes: [time, date]
    sql: CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', metric_time) ;;
  }

  dimension_group: metric_time_aet {
    type: time
    timeframes: [time, date]
    sql: CONVERT_TIMEZONE('UTC', 'Australia/Sydney', metric_time) ;;
  }

  dimension_group: metric_time_jst {
    type: time
    timeframes: [time, date]
    sql: CONVERT_TIMEZONE('UTC', 'Asia/Tokyo', metric_time) ;;
  }

  dimension_group: metric_time_hkt {
    type: time
    timeframes: [time, date]
    sql: CONVERT_TIMEZONE('UTC', 'Asia/Hong_Kong', metric_time) ;;
  }

  dimension_group: metric_2 {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."METRIC_TIME_2" ;;
  }

  dimension: metric_value {
    type: number
    sql: ${TABLE}."METRIC_VALUE" ;;
  }

  dimension: metric_count {
    type: number
    sql: ${TABLE}."METRIC_COUNT" ;;
  }

  dimension: metric_status {
    type: string
    sql: ${TABLE}."METRIC_STATUS" ;;
  }

  dimension: metric_key {
    type: string
    sql: ${TABLE}."METRIC_KEY" ;;
  }

  dimension: platform_client_id {
    type: number
    value_format: "0"
    sql: ${TABLE}."PLATFORM_CLIENT_ID" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."REGION" ;;
  }

  dimension: maint_ticket {
    type: string
    sql: ${TABLE}."MAINT_TICKET" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: metric_value_sum {
    type:sum
    sql: ${TABLE}."METRIC_VALUE" ;;

  }

  measure: metric_value_mean {
    type: percentile
    percentile:  50
    value_format: "0.##"
    sql:  ${TABLE}.metric_value  ;;
  }

  measure: metric_value_lower_quantile {
    type: percentile
    percentile:  25
    value_format: "0.##"
    sql:  ${TABLE}.metric_value  ;;
  }

  measure: metric_value_upper_quantile {
    type: percentile
    percentile:  75
    value_format: "0.##"
    sql:  ${TABLE}.metric_value  ;;
  }

  measure: metric_value_98_quantile {
    type: percentile
    percentile:  98
    value_format: "0.##"
    sql:  ${TABLE}.metric_value  ;;
  }

  measure: metric_value_min {
    type: min
    value_format: "0.##"
    sql:  ${TABLE}.metric_value  ;;
  }

  measure: metric_value_max {
    type: max
    value_format: "0.##"
    sql:  ${TABLE}.metric_value  ;;
  }

  measure: metric_value_avg {
    type: average
    value_format: "0.##"
    sql:  ${TABLE}.metric_value  ;;
  }

}
