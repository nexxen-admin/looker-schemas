connection: "snowflake"

include: "/**/*.view.lkml"

label: "LinearTV Health and SLA"

datagroup: lineartv_sla_metric_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: lineartv_sla_metric_default_datagroup

explore: media_plan_workflow {
  label: "Media Plan Generation"
  join: sla_lookup {
    type: left_outer
    sql_on: (sla_lookup_id = 'atv.platform_client_id.provider_name' and lookup_key = platform_client_id) ;;
    relationship: one_to_one
  }
}

explore: ingestion {
  label: "Ingestion Health"
}

explore: ingestion_supply {
  label: "Ingestion Health Supply"
}

explore: ingestion_viewership {
  label: "Ingestion Health Viewership"
}

explore: reporting {}

explore: campaign_setup_and_ui {
  join: sla_lookup {
    type: left_outer
    sql_on: (sla_lookup_id = 'atv.platform_client_id.provider_name' and lookup_key = platform_client_id) ;;
    relationship: one_to_one
  }
}

explore: sno_smartmon_event {
  label: "Reporting Metrics"

  join: platform_client {
    relationship: many_to_one
    sql_on: ${platform_client.platform_client_id} = ${sno_smartmon_event.platform_client_id} ;;
  }

  sql_always_where: ${sno_smartmon_event.name} = 'reporting_metrics' ;;
}
