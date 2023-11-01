connection: "an_opt"

include: "/**/*.view.lkml"
#include: "*.dashboard.lookml"  # include all dashboards in this project

access_grant: can_use_explore { user_attribute: is_itv_user allowed_values: ["no"] }




explore: rta_group_finder {
  required_access_grants: [can_use_explore]
  label: "RTA Group ID Finder"
  view_name: opt_smart_converged_campaign
  fields: [ALL_FIELDS*]
  description: "This can be used to obtain the demo or strategic target audience of a campaign and then use it to check ad_exposure/reach_frequency"
  access_filter: {
    field: opt_smart_converged_campaign.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${opt_smart_converged_campaign.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;

}


explore: opt_rpt_placement_at_glance_stats {
  required_access_grants: [can_use_explore]
  label: "Placement at a Glance"
  description: "This can be used to obtain to view pre-aggregated placement stats"
  access_filter: {
    field: opt_main_placement.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${opt_main_placement.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;


  join: opt_main_placement {
    relationship:  many_to_one
    sql_on:  ${opt_rpt_placement_at_glance_stats.placement_id} = ${opt_main_placement.placement_id} ;;
    type:  left_outer
  }
}

explore: rta_rules_present {
  required_access_grants: [can_use_explore]
  label: "RTA Rules Violations"

  join: opt_country {
    relationship: many_to_one
    sql_on: ${rta_rules_present.country_id} = ${opt_country.country_id} ;;
  }
}

explore: opt_retargeting_attribute  {
  required_access_grants: [can_use_explore]
  label: "RTA Reach and Usage"
  description: "This explore is used for pulling retargeting attributes, reach, usage and retargeting information"

  access_filter: {
    field: opt_retargeting_attribute.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${opt_retargeting_attribute.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;


  join: campaign_target{
    relationship: one_to_many
    sql_on: ${opt_retargeting_attribute.retargeting_attribute_id} = ${campaign_target.attribute_value_id};;
  }

  join: daily_placement_attribute_value_eligibility_stats {
    relationship: one_to_many
    sql_on: ${opt_retargeting_attribute.retargeting_attribute_id} = ${daily_placement_attribute_value_eligibility_stats.attribute_value_id};;
  }
}

explore: daily_placement_attribute_value_eligibility_stats {
  required_access_grants: [can_use_explore]
  label: "Eligible Requests and Segments"
  description: "This explore includes retargeting segments request eligibility metrics."

  access_filter: {
    field: opt_retargeting_attribute.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${opt_retargeting_attribute.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;


  join: opt_retargeting_attribute {
    view_label: "Attribute Value Facets"
    relationship: many_to_one
    type: full_outer
    sql_on: ${opt_retargeting_attribute.retargeting_attribute_id} = ${daily_placement_attribute_value_eligibility_stats.attribute_value_id};;
  }
}


explore: scale_metric {

  label: "Allocation Metrics"
  description: "This explore can be used to check allocation metrics. Do not use fields from across different allocation metrics
  (Example: using quanity metric date for scale metric) unless it is intended (Example: house fields used in scale metric).
  Additionally, the metrics and calculations used in this explore are customised for this reporting purpose only and can differ
  to allocation metrics in other explores and in the platform."
  access_filter: {
    field: an_main_platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: scale_metric.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${scale_metric.platform_client_id} IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;

  join: misallocation_house {
    relationship: many_to_one
    sql_on: ${scale_metric.utc_date_date} = ${misallocation_house.utc_date_date} ;;
    type: left_outer
  }

  join: quantity_metric {
    relationship: many_to_many
    sql_on: ${quantity_metric.utc_date_date} = ${scale_metric.utc_date_date} ;;
    type: left_outer
  }

  join: misallocation_persistence {
    relationship: many_to_one
    sql_on: ${misallocation_persistence.campaign_id} = ${scale_metric.campaign_id} ;;
    type: left_outer
  }

  join: an_main_platform_client {
    relationship: many_to_one
    sql_on: ${scale_metric.platform_client_id} = ${an_main_platform_client.platform_client_id} ;;
    fields: [an_main_platform_client.office_id]
  }
}

explore: opt_misdelivery {

  label: "Allocation vs Delivery"
  access_filter: {
    field: an_main_platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: opt_misdelivery.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${opt_misdelivery.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;


  join: opt_main_placement {
    relationship:  many_to_one
    sql_on:  ${opt_misdelivery.placement_id} = ${opt_main_placement.placement_id} ;;
    type:  left_outer
  }

  join: opt_op_plan_fm_info {
    relationship: many_to_one
    sql_on:  ${opt_misdelivery.flight_media_id} =${opt_op_plan_fm_info.flight_media_id} and ${opt_misdelivery.utc_date_date} = ${opt_op_plan_fm_info.utc_date_date} ;;
    type:  left_outer
  }

  join: partner {
    relationship: many_to_one
    sql_on: ${opt_main_placement.partner_id} = ${partner.partner_id} ;;
    fields: []
  }

  join: office {
    relationship: many_to_one
    sql_on: ${partner.office_id} = ${office.office_id} ;;
    fields: []
  }

  join: an_main_platform_client {
    relationship: many_to_one
    sql: LEFT HASH JOIN AN_MAIN.dbo.platform_client (NOLOCK) AS an_main_platform_client ON ${opt_misdelivery.platform_client_id} = ${an_main_platform_client.platform_client_id} ;;
    fields: [an_main_platform_client.office_id]
  }

  join: mssql_oltp_timezone {
    relationship: many_to_one
    sql_on: ${office.timezone_id} = ${mssql_oltp_timezone.timezone_id} ;;
    fields: []
  }

  join: opt_main_timezone_offset {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${opt_main_timezone_offset.timezone_id}
      and ${opt_misdelivery.utc_date_raw} >= ${opt_main_timezone_offset.time_range_start_date_raw}
      and ${opt_misdelivery.utc_date_raw} < ${opt_main_timezone_offset.time_range_end_date_raw} ;;
    fields: []
  }

  join: opt_main_timezone_offset_op_plan_fm_flight_start {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${opt_main_timezone_offset_op_plan_fm_flight_start.timezone_id}
      and ${opt_op_plan_fm_info.flight_start_raw} >= ${opt_main_timezone_offset_op_plan_fm_flight_start.time_range_start_date_raw}
      and ${opt_op_plan_fm_info.flight_start_raw} < ${opt_main_timezone_offset_op_plan_fm_flight_start.time_range_end_date_raw} ;;
    fields: []
  }

  join: opt_main_timezone_offset_op_plan_fm_flight_end {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${opt_main_timezone_offset_op_plan_fm_flight_end.timezone_id}
      and ${opt_op_plan_fm_info.flight_end_raw} >= ${opt_main_timezone_offset_op_plan_fm_flight_end.time_range_start_date_raw}
      and ${opt_op_plan_fm_info.flight_end_raw} < ${opt_main_timezone_offset_op_plan_fm_flight_end.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_platform_client_preference_UseDaylightSaving {
    from: mssql_oltp_platform_client_preference
    relationship: many_to_one
    sql_on: ${partner.platform_client_id} = ${mssql_oltp_platform_client_preference_UseDaylightSaving.platform_client_id}
      and ${mssql_oltp_platform_client_preference_UseDaylightSaving.active}
      and ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_key} = 'UseDaylightSaving' ;;
    fields: []
  }
}

explore: opt_cluster_kpi_performance_view  {
  required_access_grants: [can_use_explore]
  label: "Clusters KPI"
}

explore: cluster_kpi_performance {
  required_access_grants: [can_use_explore]
  view_name: opt_main_placement
  label: "Cluster KPI Performance"
  description: "Explore is used to pull segment with or without eligible requests"
  fields: [ALL_FIELDS*]

  access_filter: {
    field: opt_main_placement.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${opt_main_placement.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;


  join: opt_smart_cluster {
    relationship: one_to_many
    sql_on: ${opt_smart_cluster.placement_id} = ${opt_main_placement.placement_id};;
  }

  join: opt_smart_cluster_kpi_performance {
    relationship: one_to_many
    sql_on: ${opt_smart_cluster_kpi_performance.cluster_id} = ${opt_smart_cluster.cluster_id};;
  }

  join: opt_smart_kpi {
    relationship: one_to_many
    sql_on: ${opt_smart_cluster_kpi_performance.kpi_id} = ${opt_smart_kpi.kpi_id};;
  }

  join: opt_main_pricing_vendor {
    relationship: one_to_many
    sql_on: ${opt_main_pricing_vendor.pricing_vendor_id} = ${opt_smart_cluster_kpi_performance.vendor_id};;
  }

  join: opt_main_country {
    relationship: one_to_many
    sql_on: ${opt_main_country.country_id} = ${opt_main_placement.country_id};;
  }

  join: opt_main_device_type {
    relationship: one_to_many
    sql_on: ${opt_main_device_type.device_type_id} = ${opt_main_placement.device_type_id};;
  }
}

explore: opt_inventory_assignment {
  required_access_grants: [can_use_explore]
  label: "Inventory Assignment"
  description: "View Inventory Campaign targets and Campaign CCP"
}

explore: opt_total_ccp {

  label: "Total CCP"
  description: "Campaign CCP"
  access_filter: {
    field: opt_total_ccp.platform_client_office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: opt_total_ccp.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${opt_total_ccp.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;

}
