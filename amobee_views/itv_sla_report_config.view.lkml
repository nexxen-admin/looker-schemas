view: sla_report_config {
  sql_table_name: SLA_REPORT_CONFIG ;;

  dimension: config_key {
    type: string
    sql: ${TABLE}."CONFIG_KEY" ;;
  }

  dimension: config_value {
    type: number
    sql: ${TABLE}."CONFIG_VALUE" ;;
  }

  dimension: sla_report_info_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."SLA_REPORT_INFO_ID" ;;
    value_format_name: id
  }

  measure: count {
    type: count
    drill_fields: [sla_report_info.sla_report_info_id, sla_report_info.name]
  }
}
