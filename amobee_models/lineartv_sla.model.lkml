connection: "snowflake"

include: "/**/*.view.lkml"

label: "LinearTV Health and SLA"

datagroup: lineartv_sla_metric_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: lineartv_sla_metric_default_datagroup

access_grant: can_see_model {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}

explore: media_plan_workflow {
  required_access_grants: [can_see_model]
  label: "Media Plan Generation"
  join: sla_lookup {
    type: left_outer
    sql_on: (sla_lookup_id = 'atv.platform_client_id.provider_name' and lookup_key = platform_client_id) ;;
    relationship: one_to_one
  }
}

explore: ingestion {
  required_access_grants: [can_see_model]
  label: "Ingestion Health"
}

explore: ingestion_supply {
  required_access_grants: [can_see_model]
  label: "Ingestion Health Supply"
}

explore: ingestion_viewership {
  required_access_grants: [can_see_model]
  label: "Ingestion Health Viewership"
}

explore: reporting {required_access_grants: [can_see_model]}

explore: campaign_setup_and_ui {
  required_access_grants: [can_see_model]
  join: sla_lookup {
    type: left_outer
    sql_on: (sla_lookup_id = 'atv.platform_client_id.provider_name' and lookup_key = platform_client_id) ;;
    relationship: one_to_one
  }
}

explore: sno_smartmon_event {
  required_access_grants: [can_see_model]
  label: "Reporting Metrics"

  join: platform_client {
    relationship: many_to_one
    sql_on: ${platform_client.platform_client_id} = ${sno_smartmon_event.platform_client_id} ;;
  }

  sql_always_where: ${sno_smartmon_event.name} = 'reporting_metrics' ;;
}
