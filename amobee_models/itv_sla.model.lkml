connection: "snowflake"

include: "/**/*.view.lkml"                     # include all views in this project

label: "ITV SLA"

datagroup: itv_sla_metric_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: itv_sla_metric_default_datagroup



explore: daily_gw_report_snapshot {

  join: sla_report_info {
    type: inner
    sql_on: ${daily_gw_report_snapshot.sla_report_info_id} = ${sla_report_info.sla_report_info_id} ;;
    relationship: many_to_one
  }
}

explore: daily_report_snapshot {

  join: sla_report_info {
    type: inner
    sql_on: ${daily_report_snapshot.sla_report_info_id} = ${sla_report_info.sla_report_info_id} ;;
    relationship: many_to_one
  }
  join: sla_lookup {
    type: left_outer
    sql_on: (sla_lookup_id = 'atv.platform_client_id.provider_name' and lookup_key in (${daily_report_snapshot.platform_client_ids})) ;;
    relationship: one_to_one
  }
}

explore: derived_gw_metric_daily {

  join: golden_window {
    type: inner
    sql_on: ${derived_gw_metric_daily.golden_window_id} = ${golden_window.golden_window_id} ;;
    relationship: many_to_one
  }
}

explore: derived_metric_daily {

  join: sla_lookup {
    type: left_outer
    sql_on: (sla_lookup_id = 'atv.platform_client_id.provider_name' and lookup_key = ${derived_metric_daily.platform_client_id}) ;;
    relationship: one_to_one
  }
}

explore: golden_window {}

explore: metric_info {}

explore: monthly_gw_report_snapshot {

  join: sla_report_info {
    type: inner
    sql_on: ${monthly_gw_report_snapshot.sla_report_info_id} = ${sla_report_info.sla_report_info_id} ;;
    relationship: many_to_one
  }
}

explore: monthly_report_snapshot {

  join: sla_report_info {
    type: inner
    sql_on: ${sla_report_info_id} = ${sla_report_info.sla_report_info_id} ;;
    relationship: many_to_one
  }
  join: monthly_report_info {
    type: left_outer
    sql_on: ${sla_report_info_id} = ${monthly_report_info.sla_report_info_id} and
      ${report_date} = ${monthly_report_info.report_date} ;;
    relationship: many_to_one
  }
  join: sla_lookup {
    type: left_outer
    sql_on: (sla_lookup_id = 'atv.platform_client_id.provider_name' and lookup_key in (${monthly_report_snapshot.platform_client_ids})) ;;
    relationship: one_to_one
  }
}

explore: raw_metric_daily {

  join: sla_lookup {
    type: left_outer
    sql_on: (sla_lookup_id = 'atv.platform_client_id.provider_name' and lookup_key = ${raw_metric_daily.platform_client_id}) ;;
    relationship: one_to_one
  }
}

explore: raw_metric_minute {

  join: sla_lookup {
    type: left_outer
    sql_on: (sla_lookup_id = 'atv.platform_client_id.provider_name' and lookup_key = ${raw_metric_minute.platform_client_id}) ;;
    relationship: one_to_one
  }
}

explore: sla_report_info {}

explore: monthly_report_info {

  join: sla_report_info {
    type: inner
    sql_on: ${sla_report_info_id} = ${sla_report_info.sla_report_info_id} ;;
    relationship: many_to_one
  }
}

explore: sla_false_positive {

  join: sla_report_info {
    type: inner
    sql_on: ${sla_report_info_id} = ${sla_report_info.sla_report_info_id};;
    relationship: one_to_one
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
    sql_on: ${sla_alert_email_list_id} = ${sla_alert_email_list.sla_alert_email_list_id} AND ${sla_alert_info.platform} = 'ITV' ;;
    relationship: one_to_one
  }
}

explore: sla_alert_log {

  join: sla_alert_info {
    type: inner
    sql_on: ${sla_alert_info_id} = ${sla_alert_info.sla_alert_info_id};;
    relationship: one_to_one
  }
  join: sla_report_info {
    type: left_outer
    sql_on: ${sla_alert_info.sla_report_info_id} = ${sla_report_info.sla_report_info_id};;
    relationship: one_to_one
  }
}

explore: sla_lookup {}
