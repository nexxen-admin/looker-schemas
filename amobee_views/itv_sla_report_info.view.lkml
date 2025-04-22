view: sla_report_info {

  sql_table_name:SLA_REPORT_INFO ;;

  drill_fields: [sla_report_info_id]

  dimension: sla_report_info_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."SLA_REPORT_INFO_ID" ;;
    value_format_name: id
  }

  dimension: component {
    type: string
    sql: ${TABLE}."COMPONENT" ;;
  }

  dimension: name {
    type: string
    label: "SLA Name"
    sql: ${TABLE}."NAME" ;;
  }

  dimension: report_order {
    type: number
    sql: ${TABLE}."REPORT_ORDER" ;;
  }

  dimension: service {
    type: string
    sql: ${TABLE}."SERVICE" ;;
  }

  dimension: sla_value_type {
    type: number
    sql: ${TABLE}.sla_value_type ;;
  }
  dimension: sla_high_threshold_value {
    type: string
    label: "SLA Threshold Raw"
    sql: ${TABLE}.sla_high_threshold_value ;;
  }

  dimension: sla_high_threshold_value_formatted {
    label: "SLA Threshold"
    type:  string
    sql: CASE
    WHEN ${sla_value_type} = 0 THEN concat((round(${sla_high_threshold_value}, 4) * 100), '%')
    ELSE concat(${sla_high_threshold_value}, '')
    END ;;
  }

  dimension: metric_owner {
    type: string
    label: "Component"
    sql: ${TABLE}.metric_owner;;
  }

  dimension: client_id {
    type: string
    sql: ${TABLE}.client_id;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      sla_report_info_id,
      name,
      daily_gw_report_snapshot.count,
      daily_report_snapshot.count,
      monthly_gw_report_snapshot.count,
      monthly_report_snapshot.count,
      sla_report_config.count
    ]
  }
}
