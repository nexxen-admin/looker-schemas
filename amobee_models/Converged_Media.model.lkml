connection: "an_opt"
label: "TV Media Plans"

include: "/**/*.view.lkml"
#include: "*.dashboard.lookml"  # include all dashboards in this project

access_grant: can_see_model {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}


explore: converged_fox_deal_staging {
  label: "FNG Deals"
  required_access_grants: [can_see_model]

  sql_always_where: ${converged_fox_deal_staging.pull_type}  = 'adhoc_call' ;;

  always_filter: {
    filters: {field: campaign_id}
  }

}

explore: converged_fox_deal_spot_staging {
  label: "FNG Spots"
  required_access_grants: [can_see_model]

  sql_always_where: ${converged_fox_deal_spot_staging.pull_type}  = 'adhoc_call' ;;

  always_filter: {
    filters: {field: spot_id}
    filters: {field: deal_id}
  }
}


explore: placement {
  label: "TV Supply Reference"
  required_access_grants: [can_see_model]

  join: converged_placement_selling_title {
    relationship: one_to_one
    sql_on: ${placement.placement_id} = ${converged_placement_selling_title.placement_id} ;;
  }

  join: partner {
    relationship: one_to_many
    sql_on: ${placement.partner_id} = ${partner.partner_id} ;;
  }

  join: converged_payout_schedule_new {
    relationship: one_to_many
    sql_on: ${placement.placement_id} = ${converged_payout_schedule_new.placement_id} ;;
  }

  join: converged_placement_max_spots {
    relationship: one_to_many
    sql_on: ${placement.placement_id} = ${converged_placement_max_spots.placement_id} ;;
  }

  join: office {
    relationship: many_to_one
    sql_on: ${partner.office_id} = ${office.office_id} ;;
  }

  join: mssql_oltp_timezone {
    relationship: many_to_one
    sql_on: ${office.timezone_id} = ${mssql_oltp_timezone.timezone_id} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_placement_changed {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_changed.timezone_id}
      and ${placement.changedon_raw} >= ${mssql_oltp_timezone_offset_placement_changed.time_range_start_date_raw}
      and ${placement.changedon_raw} < ${mssql_oltp_timezone_offset_placement_changed.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_placement_created {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_created.timezone_id}
      and ${placement.createdon_raw} >= ${mssql_oltp_timezone_offset_placement_created.time_range_start_date_raw}
      and ${placement.createdon_raw} < ${mssql_oltp_timezone_offset_placement_created.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_placement_paused {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_paused.timezone_id}
      and ${placement.paused_date_raw} >= ${mssql_oltp_timezone_offset_placement_paused.time_range_start_date_raw}
      and ${placement.paused_date_raw} < ${mssql_oltp_timezone_offset_placement_paused.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_partner_changed {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_partner_changed.timezone_id}
      and ${partner.changedon_raw} >= ${mssql_oltp_timezone_offset_partner_changed.time_range_start_date_raw}
      and ${partner.changedon_raw} < ${mssql_oltp_timezone_offset_partner_changed.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_partner_created {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_partner_created.timezone_id}
      and ${partner.createdon_raw} >= ${mssql_oltp_timezone_offset_partner_created.time_range_start_date_raw}
      and ${partner.createdon_raw} < ${mssql_oltp_timezone_offset_partner_created.time_range_end_date_raw} ;;
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

explore: converged_li_forecast_staging_new {
  label: "Demo Estimates"
  required_access_grants: [can_see_model]

  join: cluster {
    relationship: many_to_one
    type: inner
    sql_on: ${cluster.cluster_id} = ${converged_li_forecast_staging_new.cluster_id} and ${converged_li_forecast_staging_new.source_id} = 99 ;;
  }

  join: rta_group_adhoc {
    relationship: many_to_one
    type: inner
    sql_on: ${converged_li_forecast_staging_new.rta_group_id} = ${rta_group_adhoc.rta_group_id};;
  }

  join: placement {
    relationship: many_to_one
    type: inner
    sql_on: ${cluster.placement_id} = ${placement.placement_id};;
  }

  join: partner {
    relationship: one_to_many
    sql_on: ${placement.partner_id} = ${partner.partner_id} ;;
  }

  join: office {
    relationship: many_to_one
    sql_on: ${partner.office_id} = ${office.office_id} ;;
  }

  join: mssql_oltp_timezone {
    relationship: many_to_one
    sql_on: ${office.timezone_id} = ${mssql_oltp_timezone.timezone_id} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_partner_changed {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_partner_changed.timezone_id}
      and ${partner.changedon_raw} >= ${mssql_oltp_timezone_offset_partner_changed.time_range_start_date_raw}
      and ${partner.changedon_raw} < ${mssql_oltp_timezone_offset_partner_changed.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_partner_created {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_partner_created.timezone_id}
      and ${partner.createdon_raw} >= ${mssql_oltp_timezone_offset_partner_created.time_range_start_date_raw}
      and ${partner.createdon_raw} < ${mssql_oltp_timezone_offset_partner_created.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_placement_changed {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_changed.timezone_id}
      and ${placement.changedon_raw} >= ${mssql_oltp_timezone_offset_placement_changed.time_range_start_date_raw}
      and ${placement.changedon_raw} < ${mssql_oltp_timezone_offset_placement_changed.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_placement_created {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_created.timezone_id}
      and ${placement.createdon_raw} >= ${mssql_oltp_timezone_offset_placement_created.time_range_start_date_raw}
      and ${placement.createdon_raw} < ${mssql_oltp_timezone_offset_placement_created.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_placement_paused {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_paused.timezone_id}
      and ${placement.paused_date_raw} >= ${mssql_oltp_timezone_offset_placement_paused.time_range_start_date_raw}
      and ${placement.paused_date_raw} < ${mssql_oltp_timezone_offset_placement_paused.time_range_end_date_raw} ;;
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
