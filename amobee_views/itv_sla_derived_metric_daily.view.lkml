view: derived_metric_daily {

  sql_table_name:
    {% if _model._name == 'itv_sla' %}
      SLA.DERIVED_METRIC_DAILY
    {% elsif _model._name == 'dsp_sla' %}
      SLA_DSP.DERIVED_METRIC_DAILY
    {% else %}
      UNDEF_MODEL.DERIVED_METRIC_DAILY
    {% endif %} ;;

  dimension_group: created {
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
    sql: ${TABLE}."CREATED_TIME" ;;
  }

  dimension_group: metric {
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
    sql: ${TABLE}."METRIC_DATE" ;;
  }

  dimension: metric_id {
    type: string
    sql: ${TABLE}."METRIC_ID" ;;
  }

  dimension: metric_tag {
    type: string
    sql: ${TABLE}."METRIC_TAG" ;;
  }

  dimension: metric_value {
    type: number
    sql: ${TABLE}."METRIC_VALUE" ;;
  }

  dimension: metric_value_count {
    type: number
    label: "Count"
    sql: ${TABLE}."METRIC_VALUE" ;;
  }

  dimension: metric_value_2 {
    type: number
    sql: ${TABLE}."METRIC_VALUE_2" ;;
  }

  dimension: metric_count {
    type: number
    sql: ${TABLE}."METRIC_COUNT" ;;
  }

  dimension: metric_count_2 {
    type: number
    sql: ${TABLE}."METRIC_COUNT_2" ;;
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

  measure: count {
    type: count
    drill_fields: []
  }

  measure: daily_metric_value {
    type: sum
    value_format: "0.0000"
    sql: ${metric_value} ;;
  }

  measure: daily_metric_value_2 {
    type: sum
    value_format: "0.0000"
    sql: ${metric_value_2} ;;
  }

  measure: daily_metric_count {
    type: sum
    sql: ${metric_count} ;;
  }
}
