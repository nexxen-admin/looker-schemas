view: derived_gw_metric_daily {
  sql_table_name: SLA.DERIVED_GW_METRIC_DAILY ;;

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

  dimension: golden_window_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."GOLDEN_WINDOW_ID" ;;
    value_format_name: id
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

  dimension: platform_client_id {
    type: number
    sql: ${TABLE}."PLATFORM_CLIENT_ID" ;;
    value_format_name: id
  }

  dimension: region {
    type: string
    sql: ${TABLE}."REGION" ;;
  }

  measure: count {
    type: count
    drill_fields: [golden_window.golden_window_id]
  }
}
