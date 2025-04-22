view: sla_alert_log {
  sql_table_name: "SLA_ALERT_LOG"
    ;;

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

  dimension: sla_alert_info_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."SLA_ALERT_INFO_ID" ;;
    value_format_name: id
  }

  dimension_group: sla_report {
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
    sql: ${TABLE}."SLA_REPORT_DATE" ;;
  }

  dimension: sla_value {
    type: number
    sql: ${TABLE}."SLA_VALUE" ;;
  }

  dimension: sla_value_formatted {
    type:  string
    label: "SLA Value"
    sql: CASE
          WHEN sla_report_info.sla_value_type = 0 THEN concat((round(${sla_value}, 4) * 100),'%')
          ELSE concat(${sla_value},'')
          END ;;
  }

  measure: count {
    type: count
    drill_fields: [sla_alert_info.name, sla_alert_info.sla_alert_info_id]
  }
}
