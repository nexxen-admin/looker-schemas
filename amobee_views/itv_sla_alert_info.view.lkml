view: sla_alert_info {
  sql_table_name: "SLA_ALERT_INFO"
    ;;
  drill_fields: [sla_alert_info_id]

  dimension: sla_alert_info_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."SLA_ALERT_INFO_ID" ;;
    value_format_name: id
  }

  dimension: alert_type {
    type: number
    sql: ${TABLE}."ALERT_TYPE" ;;
  }

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

  dimension: db_table {
    type: string
    sql: ${TABLE}."DB_TABLE" ;;
  }

  dimension: email_message {
    type: string
    sql: ${TABLE}."EMAIL_MESSAGE" ;;
  }

  dimension_group: last_modified {
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
    sql: ${TABLE}."LAST_MODIFIED_TIME" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}."PLATFORM" ;;
  }

  dimension: raw_metrics {
    type: string
    sql: ${TABLE}."RAW_METRICS" ;;
  }

  dimension: raw_metrics_tags {
    type: string
    sql: ${TABLE}."RAW_METRICS_TAGS" ;;
  }

  dimension: search_condition {
    type: string
    label: "SLA Alert Condition"
    sql: ${TABLE}."SEARCH_CONDITION" ;;
  }

  dimension: sla_alert_email_list_id {
    type: string
    sql: ${TABLE}."SLA_ALERT_EMAIL_LIST_ID" ;;
  }

  dimension: sla_alert_schedule_id {
    type: string
    sql: ${TABLE}."SLA_ALERT_SCHEDULE_ID" ;;
  }

  dimension: sla_report_info_id {
    type: number
    sql: ${TABLE}."SLA_REPORT_INFO_ID" ;;
    value_format_name: id
  }

  measure: count {
    type: count
    drill_fields: [sla_alert_info_id, name, sla_alert_log.count]
  }
}
