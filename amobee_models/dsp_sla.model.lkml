connection: "snowflake"

include: "/**/*.view.lkml"

label: "DSP SLA"

datagroup: dsp_sla_metric_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: dsp_sla_metric_default_datagroup

explore: daily_report_snapshot {
  join: sla_report_info {
    type: left_outer
    sql_on: ${daily_report_snapshot.sla_report_info_id} = ${sla_report_info.sla_report_info_id} ;;
    relationship: many_to_one
  }
}

explore: derived_metric_daily {}

explore: metric_info {}

explore: monthly_report_snapshot {
  join: sla_report_info {
    type: left_outer
    sql_on: ${sla_report_info_id} = ${sla_report_info.sla_report_info_id} ;;
    relationship: many_to_one
  }
  join: monthly_report_info {
    type: left_outer
    sql_on: ${sla_report_info_id} = ${monthly_report_info.sla_report_info_id} and
      ${report_date} = ${monthly_report_info.report_date} ;;
    relationship: many_to_one
  }
}

explore: raw_metric_minute {}

explore: sla_report_info {}

explore: monthly_report_info {
  join: sla_report_info {
    type: inner
    sql_on: ${sla_report_info_id} = ${sla_report_info.sla_report_info_id} ;;
    relationship: many_to_one
  }
}

explore: sla_alert_info {
  join: sla_report_info {
    type: left_outer
    sql_on: ${sla_report_info_id} = ${sla_report_info.sla_report_info_id};;
    relationship: one_to_one
  }
  join: sla_alert_email_list {
    type: inner
    sql_on: ${sla_alert_email_list_id} = ${sla_alert_email_list.sla_alert_email_list_id} AND ${sla_alert_info.platform} = 'DSP' ;;
    relationship: one_to_one
  }
}
