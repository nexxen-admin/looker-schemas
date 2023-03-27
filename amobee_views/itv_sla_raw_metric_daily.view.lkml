view: raw_metric_daily {
  sql_table_name: SLA.RAW_METRIC_DAILY ;;

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
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."METRIC_TIME" ;;
  }

  dimension: metric_value {
    type: number
    sql: ${TABLE}."METRIC_VALUE" ;;
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
}
