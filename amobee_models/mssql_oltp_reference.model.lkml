connection: "mssql-oltp"
label: "Reference"

include: "/**/*.view.lkml"
# include: "*.dashboard.lookml"  # include all dashboards in this project

access_grant: can_use_explore { user_attribute: is_itv_user allowed_values: ["no"] }
access_grant: can_see_model {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}

explore: placement {
  label: "Platform Supply Reference"
  description: "This explore includes reference data on the supply side concepts, as well as information within that hierarchy.
  Source is the Platform OLTP database."

  required_access_grants: [can_see_model]

  access_filter: {
    field: mssql_oltp_platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: partner.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${partner.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;


  join: partner {
    type: full_outer
    relationship: many_to_one
    sql_on: ${placement.partner_id} = ${partner.partner_id} ;;
  }

  join: contracting_party {
    relationship: many_to_one
    sql_on: ${partner.contracting_party_id} = ${contracting_party.contracting_party_id} ;;
  }

  join: publisher_group {
    relationship: many_to_one
    sql_on: ${partner.publisher_group_id} = ${publisher_group.publisher_group_id} ;;
  }

  join: office {
    relationship: many_to_one
    sql_on: ${partner.office_id} = ${office.office_id} ;;
  }

  join: business_region {
    relationship: many_to_one
    sql_on: ${partner.business_region_id} = ${business_region.business_region_id} ;;
  }

  join: partner_country {
    relationship: many_to_one
    sql_on: ${partner.country_id} = ${partner_country.country_id} ;;
  }

  join: mssql_oltp_platform_client {
    relationship: many_to_one
    sql_on: ${partner.platform_client_id} = ${mssql_oltp_platform_client.platform_client_id} ;;
  }

  join: mssql_oltp_currency {
    relationship: many_to_one
    sql_on: ${partner.preferred_currency_id} = ${mssql_oltp_currency.currency_id} ;;
    view_label: "Publisher"
  }

  join: mssql_oltp_partner_system_of_record {
    relationship: many_to_one
    sql_on: ${partner.system_of_record_id} = ${mssql_oltp_partner_system_of_record.system_id} ;;
    view_label: "Publisher"
  }

  join: mssql_oltp_partner_xml_xf_type_list {
    relationship: one_to_one
    sql_on: ${partner.partner_id} = ${mssql_oltp_partner_xml_xf_type_list.partner_id} ;;
    view_label: "Publisher"
  }

  join: mssql_oltp_publisher_creative_format_type_list {
    relationship: one_to_one
    sql_on: ${partner.partner_id} = ${mssql_oltp_publisher_creative_format_type_list.partner_id} ;;
    view_label: "Publisher"
  }

  join: mssql_oltp_publisher_competitive_separation_rule_exists {
    relationship: one_to_one
    sql_on: ${partner.partner_id} = ${mssql_oltp_publisher_competitive_separation_rule_exists.partner_id} ;;
    view_label: "Publisher"
  }

  join: mssql_oltp_publisher_platform_status {
    relationship: one_to_one
    sql_on: ${partner.partner_id} = ${mssql_oltp_publisher_platform_status.partner_id} ;;
  }

  join: mssql_oltp_partner_data_controls {
    relationship: one_to_one
    sql_on: ${partner.partner_id} = ${mssql_oltp_partner_data_controls.partner_id} AND ${mssql_oltp_partner_data_controls.active} ;;
    view_label: "Publisher"
  }

  join: mssql_oltp_partner_tracking_domain_list {
    relationship: one_to_many
    sql_on: ${partner.partner_id} = ${mssql_oltp_partner_tracking_domain_list.partner_id} AND ${mssql_oltp_partner_tracking_domain_list.active} ;;
  }

  join: mssql_oltp_tracking_domain_list {
    relationship: many_to_one
    sql_on: ${mssql_oltp_partner_tracking_domain_list.tracking_domain_list_id} = ${mssql_oltp_tracking_domain_list.tracking_domain_list_id} ;;
    view_label: "Publisher"
  }

  join: mssql_oltp_placement_data_controls {
    relationship: one_to_one
    sql_on: ${placement.placement_id} = ${mssql_oltp_placement_data_controls.placement_id} ;;
    view_label: "Placement"
  }

  join: mssql_oltp_platform_client_group {
    relationship: many_to_one
    sql_on: ${mssql_oltp_platform_client.platform_client_group_id} = ${mssql_oltp_platform_client_group.platform_client_group_id} ;;
  }

  join: site_genre {
    relationship: many_to_one
    sql_on: ${placement.site_genre_id} = ${site_genre.site_genre_id} ;;
  }

  join: placement_type {
    relationship: many_to_one
    sql_on: ${placement.placement_type_id} = ${placement_type.placement_type_id} ;;
  }

  join: placement_inventory_type {
    relationship: many_to_one
    sql_on: ${placement.placement_inventory_type_id} = ${placement_inventory_type.placement_inventory_type_id} ;;
  }

  join: fallback_type {
    relationship: many_to_one
    sql_on: ${placement.fallback_type_id} = ${fallback_type.fallback_type_id} ;;
  }

  join: buy_type {
    relationship: many_to_one
    sql_on: ${placement.buy_type_id} = ${buy_type.buy_type_id} ;;
  }

  join: placement_quality {
    relationship: many_to_one
    sql_on: ${placement.placement_quality_id} = ${placement_quality.placement_quality_id} ;;
  }

  join: inventory_source {
    relationship: many_to_one
    sql_on: ${placement.inventory_source_id} = ${inventory_source.inventory_source_id} ;;
  }

  join: mssql_oltp_placement_platform_client_list {
    relationship: one_to_one
    view_label: "Placement"
    sql_on: ${placement.placement_id} = ${mssql_oltp_placement_platform_client_list.placement_id} ;;
  }

  join: mssql_oltp_format_type {
    relationship: many_to_one
    view_label: "Placement"
    sql_on: ${placement.format_type_id} = ${mssql_oltp_format_type.format_type_id} ;;
  }

  join: mssql_oltp_delivery_cap_range {
    relationship: many_to_one
    view_label: "Placement"
    sql_on: ${placement.delivery_cap_range_id} = ${mssql_oltp_delivery_cap_range.delivery_cap_range_id} ;;
  }

  join: mssql_oltp_placement_bid_currency {
    relationship: many_to_one
    view_label: "Placement"
    sql_on: ${placement.bid_currency_id} = ${mssql_oltp_placement_bid_currency.currency_id} ;;
  }

  join: mssql_oltp_m_override {
    relationship: one_to_many
    view_label: "Placement Volume Current Forecast Override"
    sql_on: ${placement.placement_id} = ${mssql_oltp_m_override.placement_id} AND ${mssql_oltp_m_override.active} ;;
  }

  join: placement_country {
    relationship: many_to_one
    sql_on: ${placement.country_id} = ${placement_country.country_id} ;;
  }

  join: placement_domain_whitelist {
    relationship: one_to_many
    sql_on: ${placement.placement_id} = ${placement_domain_whitelist.placement_id} and ${placement_domain_whitelist.active} ;;
  }

  join: placement_payout_schedule {
    relationship: one_to_many
    sql_on: ${placement.placement_id} = ${placement_payout_schedule.placement_id} and ${placement_payout_schedule.active} ;;
  }

  join: placement_payout_currency {
    relationship: many_to_one
    sql_on: ${placement_payout_schedule.native_currency_id} = ${placement_payout_currency.currency_id} and ${placement_payout_currency.active} ;;
  }

  join: placement_payout_type {
    relationship: many_to_one
    sql_on: ${placement_payout_schedule.payout_type_id} = ${placement_payout_type.payout_type_id} and ${placement_payout_type.active} ;;
  }

  join: xf_third_party_placements_deal {
    relationship: one_to_one
    sql_on: ${placement.placement_id} = ${xf_third_party_placements_deal.placement_id} ;;
  }

  join: xf_third_party_placements_seat {
    relationship: one_to_one
    sql_on: ${placement.placement_id} = ${xf_third_party_placements_seat.placement_id} ;;
  }

  join: placement_filter_view {
    relationship: one_to_many
    sql_on: ${placement.placement_id} = ${placement_filter_view.placement_id} ;;
  }

  join: sql_placement_integration_type_assoc {
    relationship: many_to_one
    sql_on: ${placement.placement_id} = ${sql_placement_integration_type_assoc.placement_id}
    and ${sql_placement_integration_type_assoc.active} = 'true' ;;
  }

  join: sql_placement_integration_type {
    relationship: many_to_one
    sql_on: ${sql_placement_integration_type_assoc.placement_integration_type_id} = ${sql_placement_integration_type.placement_integration_type_id};;
  }

  join: approval_review_type {
    relationship: many_to_one
    sql_on: ${approval_review_type.approval_review_type_id} = ${partner.approval_review_type_id} ;;
  }

  join: approval_notification_frequency {
    relationship: many_to_one
    sql_on: ${approval_notification_frequency.approval_notification_frequency_id} = ${partner.approval_notification_frequency_id} ;;
  }

  join: exchange_transparency_level {
    relationship: many_to_one
    sql_on: ${exchange_transparency_level.exchange_transparency_level_id} = ${placement.exchange_transparency_level_id};;
  }

  join: placement_approval {
    relationship: one_to_many
    sql_on: ${placement.placement_id} = ${placement_approval.placement_id} ;;
  }

  join: approval_status {
    relationship: many_to_one
    sql_on: ${placement_approval.approval_status_id} = ${approval_status.approval_status_id} ;;
  }

  join: publisher_approval {
    relationship: many_to_one
    sql_on: ${placement_approval.publisher_approval_id} = ${publisher_approval.publisher_approval_id} ;;
  }

  join: mssql_oltp_flight_media {
    relationship: many_to_many
    sql_on: ${publisher_approval.media_id} = ${mssql_oltp_flight_media.media_id} ;;
    fields: [flight_media_id, active, media_id]
  }

  join: mssql_oltp_flight {
    relationship: many_to_one
    sql_on: ${mssql_oltp_flight_media.flight_id} = ${mssql_oltp_flight.flight_id} ;;
    fields: []
  }

  join: mssql_oltp_campaign {
    relationship: many_to_one
    sql_on: ${mssql_oltp_flight.campaign_id} = ${mssql_oltp_campaign.campaign_id} ;;
    fields: [campaign_id, campaign_name]
  }

  join: demand_platform_client {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.platform_client_id} = ${demand_platform_client.platform_client_id} ;;
    fields: []
  }

  join: demand_platform_client_office {
    relationship: many_to_one
    sql_on: ${demand_platform_client.office_id} = ${demand_platform_client_office.office_id} ;;
    fields: [office_name]
  }

  join: mssql_oltp_mismatch {
    type: inner
    relationship: many_to_one
    sql_on: ${mssql_oltp_flight_media.flight_media_id} = ${mssql_oltp_mismatch.flight_media_id} and ${partner.partner_id} = ${mssql_oltp_mismatch.partner_id} ;;
  }

  join: mssql_oltp_timezone {
    relationship: many_to_one
    sql_on: ${office.timezone_id} = ${mssql_oltp_timezone.timezone_id} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_start_datetm {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_start_datetm.timezone_id}
      and ${mssql_oltp_m_override.start_datetm} >= ${mssql_oltp_timezone_offset_start_datetm.time_range_start_date_raw}
      and ${mssql_oltp_m_override.start_datetm} < ${mssql_oltp_timezone_offset_start_datetm.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_end_datetm {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_end_datetm.timezone_id}
      and ${mssql_oltp_m_override.end_datetm} >= ${mssql_oltp_timezone_offset_end_datetm.time_range_start_date_raw}
      and ${mssql_oltp_m_override.end_datetm} < ${mssql_oltp_timezone_offset_end_datetm.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_expiration_date {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_expiration_date.timezone_id}
      and ${mssql_oltp_m_override.end_datetm} >= ${mssql_oltp_timezone_offset_expiration_date.time_range_start_date_raw}
      and ${mssql_oltp_m_override.end_datetm} < ${mssql_oltp_timezone_offset_expiration_date.time_range_end_date_raw} ;;
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

  join: mssql_oltp_timezone_offset_placement_created {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_created.timezone_id}
      and ${placement.createdon_raw} >= ${mssql_oltp_timezone_offset_placement_created.time_range_start_date_raw}
      and ${placement.createdon_raw} < ${mssql_oltp_timezone_offset_placement_created.time_range_end_date_raw} ;;
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

  join: mssql_oltp_timezone_offset_placement_paused {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_paused.timezone_id}
      and ${placement.paused_date_raw} >= ${mssql_oltp_timezone_offset_placement_paused.time_range_start_date_raw}
      and ${placement.paused_date_raw} < ${mssql_oltp_timezone_offset_placement_paused.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_placement_payout_schedule_start {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_payout_schedule_start.timezone_id}
      and ${placement_payout_schedule.begin_datetm_raw} >= ${mssql_oltp_timezone_offset_placement_payout_schedule_start.time_range_start_date_raw}
      and ${placement_payout_schedule.begin_datetm_raw} < ${mssql_oltp_timezone_offset_placement_payout_schedule_start.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_placement_payout_schedule_end {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_payout_schedule_end.timezone_id}
      and ${placement_payout_schedule.end_datetm_raw} >= ${mssql_oltp_timezone_offset_placement_payout_schedule_end.time_range_start_date_raw}
      and ${placement_payout_schedule.end_datetm_raw} < ${mssql_oltp_timezone_offset_placement_payout_schedule_end.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_platform_client_changed {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_platform_client_changed.timezone_id}
      and ${mssql_oltp_platform_client.changedon_raw} >= ${mssql_oltp_timezone_offset_platform_client_changed.time_range_start_date_raw}
      and ${mssql_oltp_platform_client.changedon_raw} < ${mssql_oltp_timezone_offset_platform_client_changed.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_full_campaign_sitelist_view {
    relationship: one_to_many
    type: inner
    sql_on: ${placement.placement_id} = ${mssql_oltp_full_campaign_sitelist_view.placement_id} ;;
  }

  join: mssql_oltp_campaign_spreader {
    from: mssql_oltp_campaign
    relationship: many_to_one
    sql_on: ${mssql_oltp_full_campaign_sitelist_view.campaign_id} = ${mssql_oltp_campaign_spreader.campaign_id} ;;
    view_label: "Spreader Control"
    fields: [mssql_oltp_campaign_spreader.campaign_name]
  }

  join: mssql_oltp_campaign_placement_constraint_spreader {
    relationship: one_to_many
    sql_on: ${placement.placement_id} = ${mssql_oltp_campaign_placement_constraint_spreader.placement_id} AND ${mssql_oltp_full_campaign_sitelist_view.campaign_id} = ${mssql_oltp_campaign_placement_constraint_spreader.campaign_id} ;;
  }

  join: mssql_oltp_constraint_spreader {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign_placement_constraint_spreader.constraint_id} = ${mssql_oltp_constraint_spreader.constraint_id} ;;
  }

  join: mssql_oltp_platform_client_preference {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign_spreader.platform_client_id} = ${mssql_oltp_platform_client_preference.platform_client_id} AND ${mssql_oltp_platform_client_preference.preference_key} = 'DefaultSpreader' AND ${mssql_oltp_platform_client_preference.active} ;;
  }

  join: mssql_oltp_global_settings {
    relationship: many_to_one
    sql_on: ${mssql_oltp_global_settings.setting_key} = 'DefaultSpreader' ;;
  }

  join: mssql_oltp_campaign_placement_constraint_history {
    relationship: many_to_many
    sql_on: ${mssql_oltp_campaign_placement_constraint_spreader.campaign_placement_constraint_id} = ${mssql_oltp_campaign_placement_constraint_history.campaign_placement_constraint_id} ;;
  }

  join: mssql_oltp_an_hist_platform_client_preference_ct_spreader {
    relationship: many_to_one
    sql_on: ${mssql_oltp_platform_client.platform_client_id} = ${mssql_oltp_an_hist_platform_client_preference_ct_spreader.platform_client_id} ;;
  }

  join: mssql_oltp_campaign_ui_setting_spreader {
    from: mssql_oltp_campaign_ui_setting
    relationship: many_to_many
    sql_on: ${mssql_oltp_full_campaign_sitelist_view.campaign_id} = ${mssql_oltp_campaign_ui_setting_spreader.campaign_id} and ${mssql_oltp_campaign_ui_setting_spreader.setting_key} = 'CampaignInformation' ;;
    view_label: "Spreader Control"
  }

  join: mssql_oltp_pl_plan_spreader {
    from: mssql_oltp_pl_plan
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign_spreader.pl_plan_id} = ${mssql_oltp_pl_plan_spreader.pl_plan_id} ;;
    view_label: "Spreader Control"
    fields: [mssql_oltp_pl_plan_spreader.pl_plan_id, mssql_oltp_pl_plan_spreader.plan_name]
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

explore: hourly_filler_placement_stats_details {
  required_access_grants: [can_see_model]
  label: "Placement Filler Statistics"
  description: "This explore can be used to see hourly filler statistics for supply side attributes (Placement, Publisher, etc.)."
  access_filter: {
    field: mssql_oltp_platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: partner.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${partner.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;


  join: placement {
    relationship: many_to_one
    sql_on: ${placement.placement_id} = ${hourly_filler_placement_stats_details.placement_id} ;;
  }

  join: mssql_oltp_fm_pid_statistics {
    relationship: many_to_many
    sql_on: ${hourly_filler_placement_stats_details.placement_id} = ${mssql_oltp_fm_pid_statistics.placement_id} ;;
 }

  join: partner {
    relationship: many_to_one
    sql_on: ${placement.partner_id} = ${partner.partner_id} ;;
  }

  join: partner_country {
    relationship: many_to_one
    sql_on: ${partner.country_id} = ${partner_country.country_id} ;;
  }

  join: mssql_oltp_platform_client {
    relationship: many_to_one
    sql_on: ${partner.platform_client_id} = ${mssql_oltp_platform_client.platform_client_id} ;;
  }

  join: publisher_group {
    relationship: many_to_one
    sql_on: ${partner.publisher_group_id} = ${publisher_group.publisher_group_id} ;;
  }

  join: office {
    relationship: many_to_one
    sql_on: ${partner.office_id} = ${office.office_id} ;;
  }

  join: business_region {
    relationship: many_to_one
    sql_on: ${partner.business_region_id} = ${business_region.business_region_id} ;;
  }

  join: mssql_oltp_timezone {
    relationship: many_to_one
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${office.timezone_id} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset {
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset.timezone_id}
      and ${hourly_filler_placement_stats_details.keydate_raw} >= ${mssql_oltp_timezone_offset.time_range_start_date_raw}
      and ${hourly_filler_placement_stats_details.keydate_raw} < ${mssql_oltp_timezone_offset.time_range_end_date_raw} ;;
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

  join: mssql_oltp_timezone_offset_placement_created {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_created.timezone_id}
      and ${placement.createdon_raw} >= ${mssql_oltp_timezone_offset_placement_created.time_range_start_date_raw}
      and ${placement.createdon_raw} < ${mssql_oltp_timezone_offset_placement_created.time_range_end_date_raw} ;;
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

  join: mssql_oltp_timezone_offset_placement_paused {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_paused.timezone_id}
      and ${placement.paused_date_raw} >= ${mssql_oltp_timezone_offset_placement_paused.time_range_start_date_raw}
      and ${placement.paused_date_raw} < ${mssql_oltp_timezone_offset_placement_paused.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_platform_client_changed {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_platform_client_changed.timezone_id}
      and ${mssql_oltp_platform_client.changedon_raw} >= ${mssql_oltp_timezone_offset_platform_client_changed.time_range_start_date_raw}
      and ${mssql_oltp_platform_client.changedon_raw} < ${mssql_oltp_timezone_offset_platform_client_changed.time_range_end_date_raw} ;;
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

explore: creative_rejection_view {
  required_access_grants: [can_see_model]
  label: "Creative Rejection Alerting"

  access_filter: {
    field: demand_platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: mssql_oltp_campaign.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${mssql_oltp_campaign.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;


  join: mssql_oltp_campaign {
    relationship: many_to_one
    sql_on: ${creative_rejection_view.campaign_id} = ${mssql_oltp_campaign.campaign_id} ;;
    fields: [platform_client_id]
  }

  join: mssql_oltp_flight {
    relationship: one_to_many
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_flight.campaign_id} ;;
    fields: []
  }

  join: mssql_oltp_campaign_dates {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_dates.campaign_id} ;;
  }

  join: mssql_oltp_flight_media {
    relationship: one_to_many
    sql_on: ${mssql_oltp_flight.flight_id} = ${mssql_oltp_flight_media.flight_id}
    AND ${mssql_oltp_flight_media.media_id} = ${creative_rejection_view.media_id} ;;
    fields: [mssql_oltp_flight_media.flight_media_id]
  }

  join: mssql_oltp_campaign_sitelist {
    relationship: one_to_many
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_sitelist.campaign_id}
    AND ${mssql_oltp_campaign_sitelist.active}
    AND ${mssql_oltp_campaign_sitelist.is_targeted} ;;
  }

  join: placement {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign_sitelist.placement_id} = ${placement.placement_id} ;;
    fields: [placement.placement_name, placement.placement_id]
  }

  join: mssql_oltp_partner_xml_xf_type_list {
    relationship: many_to_one
    sql_on: ${mssql_oltp_partner_xml_xf_type_list.partner_id} = ${creative_rejection_view.partner_id} ;;
  }

  join: mssql_oltp_publisher_approval_history {
    relationship: one_to_many
    sql_on: ${creative_rejection_view.publisher_approval_id} = ${mssql_oltp_publisher_approval_history.publisher_approval_id} ;;
  }

  join: mssql_oltp_customer {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.customer_id} = ${mssql_oltp_customer.customer_id} ;;
    fields: [country_id]
  }

  join: demand_platform_client {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.platform_client_id} = ${demand_platform_client.platform_client_id} ;;
  }

  join: demand_platform_client_office {
    relationship: many_to_one
    sql_on: ${demand_platform_client.office_id} = ${demand_platform_client_office.office_id} ;;
    fields: [office_name]
  }

  join: mssql_oltp_timezone {
    relationship: many_to_one
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_campaign.timezone_id} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset {
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset.timezone_id}
      and ${creative_rejection_view.dst_changed_date_raw} >= ${mssql_oltp_timezone_offset.time_range_start_date_raw}
      and ${creative_rejection_view.dst_changed_date_raw} < ${mssql_oltp_timezone_offset.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_platform_client_preference_UseDaylightSaving {
    from: mssql_oltp_platform_client_preference
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.platform_client_id} = ${mssql_oltp_platform_client_preference_UseDaylightSaving.platform_client_id}
      and ${mssql_oltp_platform_client_preference_UseDaylightSaving.active}
      and ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_key} = 'UseDaylightSaving' ;;
    fields: []
  }
}

explore: mssql_oltp_daypart_alert {
  required_access_grants: [can_see_model]
  label: "Watershed Daypart Alerting"
  hidden: yes

  join: office {
    relationship: many_to_one
    sql_on: ${mssql_oltp_daypart_alert.office_id} = ${office.office_id} ;;
  }

}

explore: brand_rejection {
  required_access_grants: [can_see_model]
  label: "Brand Rejection Alerting"
  hidden: yes

  join: office {
    relationship: many_to_one
    sql_on: ${brand_rejection.office_id} = ${office.office_id} ;;
  }


}

explore: user_access {
  required_access_grants: [can_use_explore, can_see_model]
  label: "User Access"

  join: mssql_oltp_user_activity {
    relationship: many_to_many
    sql_on: ${mssql_oltp_user_activity.user_id} = ${user_access.user_id} ;;
  }

  join: mssql_oltp_platform_client {
    relationship: many_to_one
    fields: []
    sql_on: ${user_access.platform_client_id} = ${mssql_oltp_platform_client.platform_client_id} ;;
  }

  join: mssql_oltp_platform_client_group {
    relationship: many_to_one
    sql_on: ${mssql_oltp_platform_client.platform_client_group_id} = ${mssql_oltp_platform_client_group.platform_client_group_id} ;;
  }
}

explore: user_access_changes {
  required_access_grants: [can_use_explore, can_see_model]
  label: "Platform Client Access Changes"
}

explore: mssql_oltp_eligibility_check {
  required_access_grants: [can_see_model]
  label: "Flight Media Eligibility Check"
  hidden: yes

  join: mssql_oltp_max_fm_schedule {
    relationship: one_to_one
    sql_on: ${mssql_oltp_eligibility_check.flight_id} = ${mssql_oltp_max_fm_schedule.flight_id} ;;
  }

  join: mssql_oltp_campaign {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_eligibility_check.campaign_id} ;;
  }

  join: mssql_oltp_campaign_status {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.campaign_status_id} = ${mssql_oltp_campaign_status.campaign_status_id} ;;
  }

  join: mssql_oltp_flight {
    relationship: one_to_one
    sql_on: ${mssql_oltp_flight.flight_id} = ${mssql_oltp_eligibility_check.flight_id} ;;
  }

  join: mssql_oltp_timezone {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.timezone_id} = ${mssql_oltp_timezone.timezone_id} ;;
  }

  join: mssql_oltp_deal {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_deal.seller_campaign_id} or ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_deal.buyer_campaign_id} ;;
    fields: []
  }

  join: mssql_oltp_deal_status {
    relationship: many_to_one
    sql_on: ${mssql_oltp_deal_status.deal_status_id} = ${mssql_oltp_deal.deal_status_id} ;;
    fields: []
  }

  join: mssql_oltp_internal_deal {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_internal_deal.campaign_id} and ${mssql_oltp_internal_deal.active} ;;
    fields: []
  }

  join: mssql_oltp_campaign_statistics_v3 {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_statistics_v3.campaign_id} ;;
    fields: []
  }

  join: mssql_oltp_pl_plan {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.pl_plan_id} = ${mssql_oltp_pl_plan.pl_plan_id} ;;
    fields: []
  }

  join: mssql_oltp_plan_deal_settings {
    relationship: one_to_one
    sql_on: ${mssql_oltp_plan_deal_settings.seller_plan_id} = ${mssql_oltp_pl_plan.pl_plan_id} ;;
    fields: []
  }

}

explore: placement_delivery_cap_statistics {
  required_access_grants: [can_use_explore, can_see_model]
  label: "Placement Delivery Cap Metrics"

  join: placement {
    relationship: one_to_one
    sql_on: ${placement_delivery_cap_statistics.placement_id} = ${placement.placement_id} ;;
  }

  join: partner {
    relationship: many_to_one
    sql_on: ${placement.partner_id} = ${partner.partner_id} ;;
  }

  join: office {
    relationship: many_to_one
    sql_on: ${partner.office_id} = ${office.office_id} ;;
  }

  join: business_region {
    relationship: many_to_one
    sql_on: ${partner.business_region_id} = ${business_region.business_region_id} ;;
  }

  join: partner_country {
    relationship: many_to_one
    sql_on: ${partner.country_id} = ${partner_country.country_id} ;;
  }

  join: mssql_oltp_timezone {
    relationship: many_to_one
    sql_on: ${office.timezone_id} = ${mssql_oltp_timezone.timezone_id} ;;
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

  join: mssql_oltp_timezone_offset_placement_created {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_placement_created.timezone_id}
      and ${placement.createdon_raw} >= ${mssql_oltp_timezone_offset_placement_created.time_range_start_date_raw}
      and ${placement.createdon_raw} < ${mssql_oltp_timezone_offset_placement_created.time_range_end_date_raw} ;;
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

explore: mssql_oltp_campaign {
  view_name: mssql_oltp_campaign
  required_access_grants: [can_use_explore, can_see_model]
  label: "Platform Demand Reference"
  description: "This explore includes reference data on the demand side concepts, as well as information within that hierarchy. Source is the Platform OLTP database."
  fields: [ALL_FIELDS*, -mssql_oltp_campaign_dates.tapl_campaign_end_datetm, -mssql_oltp_campaign_dates.tapl_campaign_start_datetm]

  join: mssql_oltp_campaign_status {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.campaign_status_id} = ${mssql_oltp_campaign_status.campaign_status_id} ;;
  }

  join: demand_platform_client {
    relationship: many_to_one
    sql_on: ${mssql_oltp_customer.platform_client_id} = ${demand_platform_client.platform_client_id} ;;
  }

  join: demand_platform_client_office {
    relationship: many_to_one
    sql_on: ${demand_platform_client.office_id} = ${demand_platform_client_office.office_id} ;;
    fields: [office_name]
  }

  join: mssql_oltp_campaign_dates {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_dates.campaign_id} ;;
  }

  join: mssql_oltp_insertion_order {
    relationship: many_to_one
    sql_on: ${mssql_oltp_insertion_order.insertion_order_id} = ${mssql_oltp_campaign.insertion_order_id} ;;
  }

  join: mssql_oltp_advertiser_brand {
    relationship: many_to_one
    sql: {% if mssql_oltp_advertiser_brand.include_all_brands._in_query %}FULL{% else %}LEFT{% endif %} JOIN dbo.advertiser_brand (NOLOCK)  AS mssql_oltp_advertiser_brand ON ${mssql_oltp_campaign.advertiser_brand_id} = ${mssql_oltp_advertiser_brand.adveriser_brand_id} ;;
  }

  join: mssql_oltp_advertiser {
    relationship: many_to_one
    sql_on: ${mssql_oltp_advertiser.adveriser_id} = ${mssql_oltp_advertiser_brand.adveriser_id} ;;
  }

  join: mssql_oltp_customer {
    relationship: many_to_one
    sql_on: ${mssql_oltp_customer.customer_id} = ${mssql_oltp_advertiser.customer_id} ;;
  }

  join: mssql_oltp_activity_log {
    relationship: one_to_many
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_activity_log.campaign_id} ;;
  }

  join: mssql_oltp_user {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.createdby} = ${mssql_oltp_user.user_id} ;;
  }

  join: mssql_oltp_pl_plan {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.pl_plan_id} = ${mssql_oltp_pl_plan.pl_plan_id} ;;
  }

  join: mssql_oltp_deal {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_deal.seller_campaign_id} or ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_deal.buyer_campaign_id} ;;
  }

  join: mssql_oltp_deal_media_plan {
    relationship: one_to_many
    sql_on: ${mssql_oltp_deal.id} = ${mssql_oltp_deal_media_plan.deal_id} ;;
  }

  join: mssql_oltp_demo_composition_vendor {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.demo_composition_vendor_id} = ${mssql_oltp_demo_composition_vendor.demo_composition_vendor_id} ;;
  }

  join: mssql_oltp_campaign_report_settings {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_report_settings.campaign_id} ;;
  }

  join: mssql_oltp_attribution_report {
    relationship: one_to_many
    sql_on: ${mssql_oltp_deal.id} = ${mssql_oltp_attribution_report.entity_id} ;;
  }

  join: mssql_oltp_expression {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_expression.entity_id}
    and ${mssql_oltp_expression.expression_context_id} = 2 and ${mssql_oltp_expression.entity_type_id} = 2 ;;
  }

  join: mssql_oltp_platform_client_group {
    relationship: many_to_one
    sql_on: ${demand_platform_client.platform_client_group_id} = ${mssql_oltp_platform_client_group.platform_client_group_id} ;;
  }

  join: mssql_oltp_timezone {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.timezone_id} = ${mssql_oltp_timezone.timezone_id} ;;
  }

  join: mssql_oltp_deal_status {
    relationship: many_to_one
    sql_on: ${mssql_oltp_deal_status.deal_status_id} = ${mssql_oltp_deal.deal_status_id} ;;
  }

  join: mssql_oltp_plan_deal_settings {
    relationship: one_to_one
    sql_on: ${mssql_oltp_plan_deal_settings.seller_plan_id} = ${mssql_oltp_pl_plan.pl_plan_id} ;;
  }

  join: mssql_oltp_internal_deal {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_internal_deal.campaign_id} and ${mssql_oltp_internal_deal.active} ;;
  }

  join: mssql_oltp_campaign_statistics_v3 {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_statistics_v3.campaign_id} ;;
  }

  join: mssql_oltp_localization_resource_13_5 {
    relationship: one_to_one
    sql_on: ${mssql_oltp_demo_composition_vendor.demo_universe_localization_map} = ${mssql_oltp_localization_resource_13_5.text_name}
    and ${mssql_oltp_localization_resource_13_5.locale_id} = 9 and ${mssql_oltp_localization_resource_13_5.app_id} = 1 ;;
  }

  join: payment_order_entity {
    relationship: one_to_many
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${payment_order_entity.entity_id} and ${payment_order_entity.entity_type_id} = 2 ;;
  }

  join: payment_order {
    relationship: many_to_one
    sql_on: ${payment_order_entity.payment_order_id} = ${payment_order.payment_order_id} ;;
  }

  join: payment_order_status {
    relationship: many_to_one
    sql_on: ${payment_order.status_id} = ${payment_order_status.payment_order_status_id} ;;
  }

  join: payment_gateway {
    relationship: many_to_one
    sql_on: ${payment_order.payment_gateway_id} = ${payment_gateway.payment_gateway_id} ;;
  }

  join: payment_order_adjustment {
    relationship: one_to_many
    sql_on: ${payment_order.payment_order_id} = ${payment_order_adjustment.payment_order_id} ;;
  }

  join: payment_adjustment_type {
    relationship: many_to_one
    sql_on: ${payment_order_adjustment.payment_adjustment_type_id} = ${payment_adjustment_type.payment_adjustment_type_id} ;;
  }

  join: discount_code {
    relationship: many_to_one
    sql_on: ${payment_order.discount_code_id} = ${discount_code.discount_code_id} ;;
  }

  join: payment_order_user {
    from: mssql_oltp_user
    view_label: "Payment Order User"
    relationship: many_to_one
    sql_on: ${payment_order.createdby} = ${payment_order_user.user_id} ;;
  }

  join: mssql_oltp_currency {
    view_label: "Payment Order"
    relationship: many_to_one
    sql_on: ${payment_order.currency_id} = ${mssql_oltp_currency.currency_id} ;;
  }
}

explore: mssql_oltp_campaign_wopr_only {
  required_access_grants: [can_see_model]
  extends: [mssql_oltp_campaign]
  label: "Platform Demand Reference (for WOPR only)"
  description: "This explore includes reference data on the demand side concepts, as well as information within that hierarchy. Source is the Platform OLTP database."
  fields: [ALL_FIELDS*]

  join: mssql_oltp_campaign_ui_setting {
    relationship: one_to_many
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_ui_setting.campaign_id} and ${mssql_oltp_campaign_ui_setting.setting_key} = 'CampaignInformation' ;;
  }

  join: mssql_oltp_cpu_type {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.cpu_type_id} = ${mssql_oltp_cpu_type.cpu_type_id} ;;
  }

  join: mssql_oltp_campaign_settings {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_settings.campaign_id} ;;
  }

  join: mssql_oltp_expression {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_expression.entity_id} ;;
  }

  join: mssql_oltp_expression_document {
    relationship: one_to_one
    sql_on: ${mssql_oltp_expression.expression_value_id} = ${mssql_oltp_expression_document.expression_document_id} ;;
  }

  join: mssql_oltp_expression_document_plain {
    relationship: one_to_many
    sql_on: ${mssql_oltp_expression_document.expression_document_id} = ${mssql_oltp_expression_document_plain.expression_document_id} ;;
  }

  join: mssql_oltp_campaign_target {
    relationship: one_to_many
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_target.campaign_id} ;;
  }

  join: mssql_oltp_attribute_value {
    relationship: many_to_one
    sql_on: CASE WHEN ${mssql_oltp_campaign_settings.use_advanced_targeting} THEN ${mssql_oltp_expression_document_plain.expression_group_item} ELSE CAST(${mssql_oltp_campaign_target.attribute_value_id} AS NVARCHAR(400)) END =
    CASE WHEN ${mssql_oltp_campaign_settings.use_advanced_targeting} THEN ${mssql_oltp_attribute_value.code} ELSE CAST(${mssql_oltp_attribute_value.attribute_value_id} AS NVARCHAR(400)) END ;;
  }

  join: mssql_oltp_attribute {
    relationship: many_to_one
    sql_on: ${mssql_oltp_attribute_value.attribute_id} = ${mssql_oltp_attribute.attribute_id} ;;
  }

  join: mssql_oltp_user_data_vendor {
    relationship: many_to_one
    sql_on: ${mssql_oltp_attribute_value.max_range} = ${mssql_oltp_user_data_vendor.user_data_vendor_id} ;;
    sql_where: (${mssql_oltp_user_data_vendor.active} OR (${mssql_oltp_campaign_settings.use_advanced_targeting} AND ${mssql_oltp_user_data_vendor.user_data_vendor_id} = 0 ) OR (${mssql_oltp_campaign_settings.use_advanced_targeting} AND ${mssql_oltp_user_data_vendor.user_data_vendor_id} is null))  ;;
  }

  join: mssql_oltp_user_data_vendor_type {
    relationship: many_to_one
    sql_on: ${mssql_oltp_user_data_vendor.user_data_vendor_type_id} = ${mssql_oltp_user_data_vendor_type.user_data_vendor_type_id} ;;
  }

  join: mssql_oltp_geo_location {
    relationship: many_to_many
    sql_on: CASE WHEN ${mssql_oltp_campaign_settings.use_advanced_targeting} THEN ${mssql_oltp_attribute_value.attribute_value_id} ELSE ${mssql_oltp_campaign_target.attribute_value_id} END =
    ${mssql_oltp_geo_location.geo_location_id} ;;
  }

  join: mssql_oltp_retargeting_attribute {
    relationship: many_to_one
    sql_on: CASE WHEN ${mssql_oltp_campaign_settings.use_advanced_targeting} THEN ${mssql_oltp_attribute_value.attribute_value_id} ELSE ${mssql_oltp_campaign_target.attribute_value_id} END = ${mssql_oltp_retargeting_attribute.retargeting_attribute_id} ;;
  }

  join: mssql_oltp_behavioral_category {
    relationship: many_to_one
    sql_on: ${mssql_oltp_retargeting_attribute.behavioral_category_id} = ${mssql_oltp_behavioral_category.behavioral_category_id} ;;
  }

  join: mssql_oltp_marketplace_connection {
    relationship: one_to_many
    sql_on: ${demand_platform_client.platform_client_id} = ${mssql_oltp_marketplace_connection.buyer_platform_client_id}
      or ${demand_platform_client.platform_client_id} = ${mssql_oltp_marketplace_connection.seller_platform_client_id} ;;
  }
}

explore: mssql_oltp_domain_blacklist {
  required_access_grants: [can_use_explore, can_see_model]
  label: "Domain Blacklist"
  sql_always_where: ${mssql_oltp_domain_blacklist.active} = 1 ;;
}

explore: mssql_oltp_data_vendor_cost_schedule {
  required_access_grants: [can_use_explore, can_see_model]
  fields: [ALL_FIELDS*, -mssql_oltp_platform_client.dst_changedon_raw, -mssql_oltp_platform_client.dst_changedon_date, -mssql_oltp_platform_client.dst_changedon_time,
    -mssql_oltp_platform_client.dst_changedon_week, -mssql_oltp_platform_client.dst_changedon_month, -mssql_oltp_platform_client.dst_changedon_quarter,
    -mssql_oltp_platform_client.dst_changedon_year]
  label: "Cost Schedule"

  join: mssql_oltp_payout_type {
    relationship: many_to_one
    sql_on: ${mssql_oltp_data_vendor_cost_schedule.payout_type_id} = ${mssql_oltp_payout_type.payout_type_id};;
  }

  join: mssql_oltp_platform_client {
    relationship: many_to_one
    sql_on: ${mssql_oltp_data_vendor_cost_schedule.platform_client_id} = ${mssql_oltp_platform_client.platform_client_id} ;;
  }

  join: mssql_oltp_currency {
    relationship: many_to_one
    sql_on: ${mssql_oltp_data_vendor_cost_schedule.currency_id} = ${mssql_oltp_currency.currency_id} ;;
  }

  join: mssql_oltp_country {
    relationship: many_to_one
    sql_on: ${mssql_oltp_data_vendor_cost_schedule.country_id} = ${mssql_oltp_country.country_id} ;;
  }
}

explore: mssql_oltp_flight_media_statistics {
  required_access_grants: [can_use_explore, can_see_model]
  label: "Flight Media Statistics"

  join: videology_flightmedia_statistics_view {
    relationship: one_to_one
    sql_on: ${mssql_oltp_flight_media_statistics.flight_media_id} = ${videology_flightmedia_statistics_view.flight_media_id} ;;
  }

  join: mssql_oltp_flight_media {
    relationship: one_to_one
    sql_on: ${mssql_oltp_flight_media.flight_media_id} = ${mssql_oltp_flight_media_statistics.flight_media_id} ;;
  }

  join: flight_statistics_v3 {
    relationship: one_to_many
    type: full_outer
    sql_on: ${mssql_oltp_flight_media.flight_id} = ${flight_statistics_v3.flight_id} ;;
  }

  join: mssql_oltp_flight {
    relationship: many_to_one
    sql_on: {% if flight_statistics_v3._in_query %}COALESCE(${mssql_oltp_flight_media.flight_id}, flight_statistics_v3.flight_id){% else %}${mssql_oltp_flight_media.flight_id}{% endif %} = ${mssql_oltp_flight.flight_id} ;;
  }

  join: mssql_oltp_campaign {
    relationship: many_to_one
    sql_on: ${mssql_oltp_flight.campaign_id} = ${mssql_oltp_campaign.campaign_id} ;;
  }

  join: mssql_oltp_campaign_type {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.campaign_type_id} = ${mssql_oltp_campaign_type.campaign_type_id} ;;
  }

  join: mssql_oltp_external_deal {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_external_deal.campaign_id} ;;
  }

  join: mssql_oltp_deal_term {
    relationship: many_to_one
    sql_on: ${mssql_oltp_external_deal.deal_term_id} = ${mssql_oltp_deal_term.deal_term_id} ;;
  }

  join: mssql_oltp_campaign_status {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.campaign_status_id} = ${mssql_oltp_campaign_status.campaign_status_id} ;;
  }

  join: mssql_oltp_campaign_dates {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_dates.campaign_id} ;;
  }

  join: mssql_oltp_platform_client {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.platform_client_id} = ${mssql_oltp_platform_client.platform_client_id} ;;
  }

  join: mssql_oltp_timezone {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.timezone_id} = ${mssql_oltp_timezone.timezone_id} ;;
  }

  join: mssql_oltp_deal {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_deal.seller_campaign_id} or ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_deal.buyer_campaign_id} ;;
    fields: []
  }

  join: mssql_oltp_deal_status {
    relationship: many_to_one
    sql_on: ${mssql_oltp_deal_status.deal_status_id} = ${mssql_oltp_deal.deal_status_id} ;;
    fields: []
  }

  join: mssql_oltp_internal_deal {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_internal_deal.campaign_id} and ${mssql_oltp_internal_deal.active} ;;
    fields: []
  }

  join: mssql_oltp_campaign_statistics_v3 {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_statistics_v3.campaign_id} ;;
    fields: []
  }

  join: mssql_oltp_pl_plan {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.pl_plan_id} = ${mssql_oltp_pl_plan.pl_plan_id} ;;
    fields: []
  }

  join: mssql_oltp_plan_deal_settings {
    relationship: one_to_one
    sql_on: ${mssql_oltp_plan_deal_settings.seller_plan_id} = ${mssql_oltp_pl_plan.pl_plan_id} ;;
    fields: []
  }

  join: mssql_oltp_timezone_offset_platform_client_changed {
    from: mssql_oltp_timezone_offset
    relationship: one_to_many
    sql_on: ${mssql_oltp_timezone.timezone_id} = ${mssql_oltp_timezone_offset_platform_client_changed.timezone_id}
      and ${mssql_oltp_platform_client.changedon_raw} >= ${mssql_oltp_timezone_offset_platform_client_changed.time_range_start_date_raw}
      and ${mssql_oltp_platform_client.changedon_raw} < ${mssql_oltp_timezone_offset_platform_client_changed.time_range_end_date_raw} ;;
    fields: []
  }

  join: mssql_oltp_platform_client_preference_UseDaylightSaving {
    from: mssql_oltp_platform_client_preference
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.platform_client_id} = ${mssql_oltp_platform_client_preference_UseDaylightSaving.platform_client_id}
      and ${mssql_oltp_platform_client_preference_UseDaylightSaving.active}
      and ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_key} = 'UseDaylightSaving' ;;
    fields: []
  }
}

explore: mssql_oltp_an_hist_campaign {
  required_access_grants: [can_use_explore, can_see_model]
  label: "Campaign Settings KPI"

  join: mssql_oltp_campaign {
    relationship: many_to_one
    sql_on: ${mssql_oltp_an_hist_campaign.campaign_id} = ${mssql_oltp_campaign.campaign_id} ;;
    fields: [
      mssql_oltp_campaign.createdon_raw,
      mssql_oltp_campaign.createdon_time,
      mssql_oltp_campaign.createdon_date,
      mssql_oltp_campaign.createdon_week,
      mssql_oltp_campaign.createdon_month,
      mssql_oltp_campaign.createdon_quarter,
      mssql_oltp_campaign.createdon_year
    ]
  }

  join: mssql_oltp_campaign_dates {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_dates.campaign_id} ;;
  }

  join: mssql_oltp_campaign_type {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.campaign_type_id} = ${mssql_oltp_campaign_type.campaign_type_id} ;;
    fields: [mssql_oltp_campaign_type.description]
  }

  join: mssql_oltp_campaign_status {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.campaign_status_id} = ${mssql_oltp_campaign_status.campaign_status_id} ;;
  }

  join: mssql_oltp_format_type {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.format_type_id} = ${mssql_oltp_format_type.format_type_id} ;;
    view_label: "Campaign"
  }

  join: demand_platform_client {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.platform_client_id} = ${demand_platform_client.platform_client_id} ;;
  }

  join: mssql_oltp_demand_platform_client_business_region {
    relationship: many_to_one
    sql_on: ${demand_platform_client.business_region_id} = ${mssql_oltp_demand_platform_client_business_region.business_region_id} ;;
  }

  join: demand_platform_client_office {
    relationship: many_to_one
    sql_on: ${demand_platform_client.office_id} = ${demand_platform_client_office.office_id} ;;
  }
}

explore: mssql_oltp_an_hist_campaign_target {
  required_access_grants: [can_use_explore, can_see_model]
  label: "Campaign Targeting KPI"

  join: mssql_oltp_campaign {
    relationship: many_to_one
    sql_on: ${mssql_oltp_an_hist_campaign_target.campaign_id} = ${mssql_oltp_campaign.campaign_id} ;;
    fields: [
      mssql_oltp_campaign.createdon_raw,
      mssql_oltp_campaign.createdon_time,
      mssql_oltp_campaign.createdon_date,
      mssql_oltp_campaign.createdon_week,
      mssql_oltp_campaign.createdon_month,
      mssql_oltp_campaign.createdon_quarter,
      mssql_oltp_campaign.createdon_year
    ]
  }

  join: mssql_oltp_campaign_dates {
    relationship: one_to_one
    sql_on: ${mssql_oltp_campaign.campaign_id} = ${mssql_oltp_campaign_dates.campaign_id} ;;
  }

  join: mssql_oltp_campaign_type {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.campaign_type_id} = ${mssql_oltp_campaign_type.campaign_type_id} ;;
    fields: [mssql_oltp_campaign_type.description]
  }

  join: mssql_oltp_campaign_status {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.campaign_status_id} = ${mssql_oltp_campaign_status.campaign_status_id} ;;
  }

  join: mssql_oltp_format_type {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.format_type_id} = ${mssql_oltp_format_type.format_type_id} ;;
    view_label: "Campaign"
  }

  join: demand_platform_client {
    relationship: many_to_one
    sql_on: ${mssql_oltp_campaign.platform_client_id} = ${demand_platform_client.platform_client_id} ;;
  }

  join: mssql_oltp_demand_platform_client_business_region {
    relationship: many_to_one
    sql_on: ${demand_platform_client.business_region_id} = ${mssql_oltp_demand_platform_client_business_region.business_region_id} ;;
  }

  join: demand_platform_client_office {
    relationship: many_to_one
    sql_on: ${demand_platform_client.office_id} = ${demand_platform_client_office.office_id} ;;
  }
}

explore: mssql_oltp_suggest_demand_ref {
  required_access_grants: [can_see_model]
  access_filter: {
    field: mssql_oltp_suggest_demand_ref.country_id
    user_attribute: access_filter_country_id
  }
  access_filter: {
    field: mssql_oltp_suggest_demand_ref.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${mssql_oltp_suggest_demand_ref.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;

  hidden: yes
}

explore: mssql_oltp_suggest_supply_ref {
  required_access_grants: [can_see_model]
  access_filter: {
    field: mssql_oltp_suggest_supply_ref.country_id
    user_attribute: access_filter_country_id
  }
  access_filter: {
    field: mssql_oltp_suggest_supply_ref.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} 1=1 {% else %} (${mssql_oltp_suggest_supply_ref.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;

  hidden: yes
}
