view: mssql_oltp_campaign {
  sql_table_name: dbo.campaign (NOLOCK) ;;
  label: "Campaign"

  dimension: pl_campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.pl_campaign_id ;;
  }

  dimension: active {
    type: string
    hidden: yes
    sql: ${TABLE}.active ;;
  }

  dimension: advertiser_brand_id {
    type: number
    hidden: yes
    sql: ${TABLE}.advertiser_brand_id ;;
  }

  dimension: advertiser_opt_in {
    type: string
    hidden: yes
    sql: ${TABLE}.advertiser_opt_in ;;
  }

  dimension: agency_fee {
    type: number
    hidden: yes
    sql: ${TABLE}.agency_fee ;;
  }

  dimension: allow_looping {
    type: string
    hidden: yes
    sql: ${TABLE}.allow_looping ;;
  }

  dimension: audience_size {
    type: number
    hidden: yes
    sql: ${TABLE}.audience_size ;;
  }

  dimension: audience_type {
    type: string
    hidden: yes
    sql: ${TABLE}.audience_type ;;
  }

  dimension: audit_factor {
    type: number
    hidden: yes
    sql: ${TABLE}.audit_factor ;;
  }

  dimension: audit_vendor_id {
    type: number
    hidden: yes
    sql: ${TABLE}.audit_vendor_id ;;
  }

  dimension: auto_display_integration {
    type: string
    hidden: yes
    sql: ${TABLE}.auto_display_integration ;;
  }

  dimension: autoallocate_units {
    type: string
    hidden: yes
    sql: ${TABLE}.autoallocate_units ;;
  }

  dimension: budget_cap_adj_factor {
    type: number
    hidden: yes
    sql: ${TABLE}.budget_cap_adj_factor ;;
  }

  dimension: business_deal_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.business_deal_type_id ;;
  }

  dimension: buying_model_id {
    type: number
    hidden: yes
    sql: ${TABLE}.buying_model_id ;;
  }

  dimension: campaign_id {
    type: number
    primary_key: yes
    label: "Campaign ID"
    description: "The system id of the Campaign."
    sql: ${TABLE}.campaign_id ;;
    value_format_name: id
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
    suggest_explore: mssql_oltp_suggest_demand_ref
    suggest_dimension: mssql_oltp_suggest_demand_ref.campaign_name
  }

  dimension: campaign_network_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_network_id ;;
  }

  dimension_group: campaign_start {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.campaign_start_date ;;
  }

  dimension: campaign_statistics_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_statistics_id ;;
  }

  dimension: campaign_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_status_id ;;
  }

  dimension: campaign_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_type_id ;;
  }

  dimension: change_source {
    type: string
    hidden: yes
    sql: ${TABLE}.change_source ;;
  }

  dimension: changedby {
    type: string
    hidden: yes
    sql: ${TABLE}.changedby ;;
  }

  dimension_group: changedon {
    type: time
    label: "Changed On"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.changedon ;;
  }

  dimension: client_non_revenue_generating {
    type: yesno
    label: "Client Non Revenue Generating"
    sql: ${TABLE}.client_non_revenue_generating = 1 ;;
  }

  dimension: companion_pct {
    type: number
    hidden: yes
    sql: ${TABLE}.companion_pct ;;
  }

  dimension: contact_email {
    type: string
    hidden: yes
    sql: ${TABLE}.contact_email ;;
  }

  dimension: contracted_addedvalue_units {
    type: number
    hidden: yes
    sql: ${TABLE}.contracted_addedvalue_units ;;
  }

  dimension: contracted_budget {
    type: number
    hidden: no
    sql: ${TABLE}.contracted_budget ;;
  }

  dimension: contracted_cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.contracted_cpu ;;
  }

  dimension: contracted_units {
    type: number
    hidden: yes
    sql: ${TABLE}.contracted_units ;;
  }

  dimension: cpu {
    type: number
    label: "CPU"
    description: "Cost per unit of the campaign."
    value_format_name: "decimal_2"
    sql: ${TABLE}.cpu ;;
  }

  dimension: cpu_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.cpu_type_id ;;
  }

  dimension: createdby {
    type: string
    sql: ${TABLE}.createdby ;;
  }

  dimension_group: createdon {
    type: time
    label: "Created On"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdon ;;
  }

  dimension_group: createdon_demand {
    type: time
    label: "Createdon Demand"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: dateadd(HH, ${mssql_oltp_timezone.utc_offset}, ${TABLE}.createdon) ;;
  }


  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: daily_budget_cap {
    type: number
    hidden: yes
    sql: ${TABLE}.daily_budget_cap ;;
  }

  dimension: delivery_boost {
    type: number
    hidden: yes
    sql: ${TABLE}.delivery_boost ;;
  }

  dimension: delivery_guaranteed {
    type: string
    hidden: yes
    sql: ${TABLE}.delivery_guaranteed ;;
  }

  dimension: delivery_units {
    type: number
    hidden: yes
    sql: ${TABLE}.delivery_units ;;
  }

  dimension: demand_medium_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.demand_medium_type_id ;;
  }

  dimension: demo_composition_vendor_id {
    type: number
    hidden: yes
    sql: ${TABLE}.demo_composition_vendor_id ;;
  }

  dimension: demo_segment_group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.demo_segment_group_id ;;
  }

  dimension: demo_trp {
    type: number
    hidden: yes
    sql: ${TABLE}.demo_trp ;;
  }

  dimension: desired_spend {
    type: number
    hidden: yes
    sql: ${TABLE}.desired_spend ;;
  }

  dimension: device_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.device_type_id ;;
  }

  dimension: dynamic_sitelist {
    type: string
    hidden: yes
    sql: ${TABLE}.dynamic_sitelist ;;
  }

  dimension: exclude_from_optimization {
    type: string
    hidden: yes
    sql: ${TABLE}.exclude_from_optimization ;;
  }

  dimension: external_ref_id {
    type: string
    hidden: yes
    sql: ${TABLE}.external_ref_id ;;
  }

  dimension: external_survey_id {
    type: string
    hidden: yes
    sql: ${TABLE}.external_survey_id ;;
  }

  dimension: floor_price_cpm {
    type: number
    hidden: yes
    sql: ${TABLE}.floor_price_cpm ;;
  }

  dimension: force_min_comp {
    type: string
    hidden: yes
    sql: ${TABLE}.force_min_comp ;;
  }

  dimension: forecast_comp_pct {
    type: number
    hidden: yes
    sql: ${TABLE}.forecast_comp_pct ;;
  }

  dimension: forecast_frequency {
    type: number
    hidden: yes
    sql: ${TABLE}.forecast_frequency ;;
  }

  dimension: forecast_index {
    type: number
    hidden: yes
    sql: ${TABLE}.forecast_index ;;
  }

  dimension: forecast_max_spend {
    type: number
    hidden: yes
    sql: ${TABLE}.forecast_max_spend ;;
  }

  dimension: format_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.format_type_id ;;
  }

  dimension: freq_cap {
    type: number
    label: "Frequency Cap"
    description: "Number of impressions to be served for the campaign."
    sql: ${TABLE}.freq_cap ;;
  }

  dimension: freq_cap_hours {
    type: number
    label: "Frequency Cap Hours"
    description: "Duration of a single frequency cap of served impressions for the campaign."
    sql: ${TABLE}.freq_cap_hours ;;
  }

  dimension: freq_cap_unit {
    type: number
    hidden: yes
    sql: ${TABLE}.freq_cap_unit ;;
  }

  dimension: geo_and_demo_audience {
    type: number
    hidden: yes
    sql: ${TABLE}.geo_and_demo_audience ;;
  }

  dimension: geo_only_audience {
    type: number
    hidden: yes
    sql: ${TABLE}.geo_only_audience ;;
  }

  dimension: grp_audience_size {
    type: number
    hidden: yes
    sql: ${TABLE}.grp_audience_size ;;
  }

  dimension: has_creative {
    type: string
    hidden: yes
    sql: ${TABLE}.has_creative ;;
  }

  dimension: has_signed_io {
    type: string
    hidden: yes
    sql: ${TABLE}.has_signed_io ;;
  }

  dimension: has_sitelist {
    type: string
    hidden: yes
    sql: ${TABLE}.has_sitelist ;;
  }

  dimension: has_tracking_tags {
    type: string
    hidden: yes
    sql: ${TABLE}.has_tracking_tags ;;
  }

  dimension: health_boost {
    type: number
    hidden: yes
    sql: ${TABLE}.health_boost ;;
  }

  dimension: health_threshold {
    type: number
    hidden: yes
    sql: ${TABLE}.health_threshold ;;
  }

  dimension: hostname {
    type: string
    hidden: yes
    sql: ${TABLE}.hostname ;;
  }

  dimension: insertion_order_id {
    type: number
    hidden: yes
    sql: ${TABLE}.insertion_order_id ;;
  }

  dimension: inside_feasible_set {
    type: string
    hidden: yes
    sql: ${TABLE}.inside_feasible_set ;;
  }

  dimension: inside_feasible_set_at_launch {
    type: number
    hidden: yes
    sql: ${TABLE}.inside_feasible_set_at_launch ;;
  }

  dimension: is_archived {
    type: string
    hidden: yes
    sql: ${TABLE}.is_archived ;;
  }

  dimension: is_auto_bid {
    type: string
    hidden: yes
    sql: ${TABLE}.is_auto_bid ;;
  }

  dimension: is_client_revenue_generating {
    type: string
    hidden: yes
    sql: ${TABLE}.is_client_revenue_generating ;;
  }

  dimension: is_edited {
    type: string
    hidden: yes
    sql: ${TABLE}.is_edited ;;
  }

  dimension: is_editied {
    type: string
    hidden: yes
    sql: ${TABLE}.is_editied ;;
  }

  dimension: is_preemptible {
    type: string
    hidden: yes
    sql: ${TABLE}.is_preemptible ;;
  }

  dimension: is_revenue_generating {
    type: string
    hidden: yes
    sql: ${TABLE}.is_revenue_generating ;;
  }

  dimension: is_running {
    type: string
    hidden: yes
    sql: ${TABLE}.is_running ;;
  }

  dimension: is_test_campaign {
    type: string
    hidden: yes
    sql: ${TABLE}.is_test_campaign ;;
  }

  dimension: is_tva {
    type: string
    hidden: yes
    sql: ${TABLE}.is_tva ;;
  }

  dimension: isfiller {
    type: string
    hidden: yes
    sql: ${TABLE}.isfiller ;;
  }

  dimension: isguaranteed {
    type: string
    hidden: yes
    sql: ${TABLE}.isguaranteed ;;
  }

  dimension: keep_only_known_imps_on_sniff_n_pass {
    type: string
    hidden: yes
    sql: ${TABLE}.keep_only_known_imps_on_sniff_n_pass ;;
  }

  dimension: marketplace_fee {
    type: number
    hidden: yes
    sql: ${TABLE}.marketplace_fee ;;
  }

  dimension: max_daily_media_auto_spend {
    type: number
    hidden: yes
    sql: ${TABLE}.max_daily_media_auto_spend ;;
  }

  dimension: max_gross_auto_bid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.max_gross_auto_bid ;;
  }

  dimension: max_media_auto_bid {
    type: number
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.max_media_auto_bid ;;
  }

  dimension: max_media_auto_spend {
    type: number
    hidden: yes
    sql: ${TABLE}.max_media_auto_spend ;;
  }

  dimension: max_media_cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.max_media_cpu ;;
  }

  dimension: max_volume {
    type: number
    hidden: yes
    sql: ${TABLE}.max_volume ;;
  }

  dimension: min_avg_comp {
    type: number
    hidden: yes
    sql: ${TABLE}.min_avg_comp ;;
  }

  dimension: min_comp_pct {
    type: number
    hidden: yes
    sql: ${TABLE}.min_comp_pct ;;
  }

  dimension: min_imp_margin_frac {
    type: number
    hidden: yes
    sql: ${TABLE}.min_imp_margin_frac ;;
  }

  dimension: min_index {
    type: number
    hidden: yes
    sql: ${TABLE}.min_index ;;
  }

  dimension: min_skim_comp {
    type: number
    hidden: yes
    sql: ${TABLE}.min_skim_comp ;;
  }

  dimension: min_skim_margin {
    type: number
    hidden: yes
    sql: ${TABLE}.min_skim_margin ;;
  }

  dimension: net_max_cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.net_max_cpu ;;
  }

  dimension: nielsen_placement_id {
    type: string
    hidden: yes
    sql: ${TABLE}.nielsen_placement_id ;;
  }

  dimension: notes {
    type: string
    hidden: yes
    sql: ${TABLE}.notes ;;
  }

  dimension: optimization_failure {
    type: string
    hidden: yes
    sql: ${TABLE}.optimization_failure ;;
  }

  dimension: overage_threshold {
    type: number
    label: "Campaign Overage Threshold"
    sql: ${TABLE}.overage_threshold ;;
  }

  dimension: override_campaign_pricevolume {
    type: string
    hidden: yes
    sql: ${TABLE}.override_campaign_pricevolume ;;
  }

  dimension: pl_plan_id {
    type: number
    hidden: yes
    sql: ${TABLE}.pl_plan_id ;;
  }

  dimension: planned_comp_pct {
    type: number
    hidden: yes
    sql: ${TABLE}.planned_comp_pct ;;
  }

  dimension: planned_cpu {
    type: number
    label: "Planned CPU"
    sql: COALESCE(${TABLE}.planned_cpu, 0) ;;
  }

  dimension: planned_frequency {
    type: number
    hidden: yes
    sql: ${TABLE}.planned_frequency ;;
  }

  dimension: planned_index {
    type: number
    hidden: yes
    sql: ${TABLE}.planned_index ;;
  }

  dimension: planned_max_media_cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.planned_max_media_cpu ;;
  }

  dimension: planned_net_max_cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.planned_net_max_cpu ;;
  }

  dimension: planned_reach {
    type: number
    hidden: yes
    sql: ${TABLE}.planned_reach ;;
  }

  dimension: planned_spend {
    type: number
    label: "Planned Spend"
    value_format_name: "decimal_2"
    sql: COALESCE(${TABLE}.planned_spend, 0) ;;
  }

  dimension: planned_volume {
    type: number
    hidden: yes
    sql: ${TABLE}.planned_volume ;;
  }

  dimension: platform_client_id {
    type: number
    hidden: yes
    sql: ${TABLE}.platform_client_id ;;
  }

  dimension: positive_validation_required {
    type: string
    hidden: yes
    sql: ${TABLE}.positive_validation_required ;;
  }

  dimension: preemptable {
    type: string
    hidden: yes
    sql: ${TABLE}.preemptable ;;
  }

  dimension: pricing_vendor_id {
    type: number
    hidden: yes
    sql: ${TABLE}.pricing_vendor_id ;;
  }

  dimension: purchase_model_id {
    type: number
    hidden: yes
    sql: ${TABLE}.purchase_model_id ;;
  }

  dimension: reach {
    type: number
    hidden: yes
    sql: ${TABLE}.reach ;;
  }

  dimension: reporting_business_unit_id {
    type: number
    hidden: yes
    sql: ${TABLE}.reporting_business_unit_id ;;
  }

  dimension: run_on_entire_network {
    type: string
    hidden: yes
    sql: ${TABLE}.run_on_entire_network ;;
  }

  dimension: sequencing_attribute_exposure_level {
    type: number
    hidden: yes
    sql: ${TABLE}.sequencing_attribute_exposure_level ;;
  }

  dimension: sequencing_pixel_url {
    type: string
    hidden: yes
    sql: ${TABLE}.sequencing_pixel_url ;;
  }

  dimension: smoothness_lower {
    type: number
    label: "Campaign Smoothness Lower"
    sql: ${TABLE}.smoothness_lower ;;
  }

  dimension: smoothness_upper {
    type: number
    label: "Campaign Smoothness Upper"
    sql: ${TABLE}.smoothness_upper ;;
  }

  dimension: spread_fraction {
    type: number
    label: "Campaign Spread Fraction"
    sql: ${TABLE}.spread_fraction ;;
  }

  dimension: tag_default_ftp_location {
    type: string
    hidden: yes
    sql: ${TABLE}.tag_default_ftp_location ;;
  }

  dimension: tag_default_ftp_password {
    type: string
    hidden: yes
    sql: ${TABLE}.tag_default_ftp_password ;;
  }

  dimension: tag_default_ftp_username {
    type: string
    hidden: yes
    sql: ${TABLE}.tag_default_ftp_username ;;
  }

  dimension: timezone_id {
    type: number
    hidden: yes
    sql: ${TABLE}.timezone_id ;;
  }

  dimension: trp_audience_size {
    type: number
    hidden: yes
    sql: ${TABLE}.trp_audience_size ;;
  }

  dimension: ui_who_interaction {
    type: string
    hidden: yes
    sql: ${TABLE}.ui_who_interaction ;;
  }

  dimension: units {
    type: number
    label: "Campaign Units"
    sql: ${TABLE}.units ;;
  }

  dimension: updatedby {
    type: string
    hidden: yes
    sql: ${TABLE}.updatedby ;;
  }

  dimension: validation_parameters {
    type: string
    hidden: yes
    sql: ${TABLE}.validation_parameters ;;
  }

  dimension: validation_vendor_id {
    type: number
    hidden: yes
    sql: ${TABLE}.validation_vendor_id ;;
  }

  dimension: video_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.video_type_id ;;
  }

  dimension: campaign_platform_status {
    type: string
    label: "Campaign Platform Status"
    sql: CASE WHEN ${campaign_type_id} = 8 -- TV Direct Sold
            THEN CASE WHEN ${mssql_oltp_deal.deal_status_id} = 1 THEN 'Planning'  --Sent
                  WHEN ${mssql_oltp_deal.deal_status_id} = 6 THEN 'Planning'--Planning
                  WHEN ${mssql_oltp_deal.deal_status_id} = 13 THEN 'Planning'--Negotiating
                  WHEN ${mssql_oltp_deal.deal_status_id} = 4 THEN 'Running' --Launched
                  WHEN ${mssql_oltp_deal.deal_status_id} = 14 THEN 'Cancelled'  --Cancelled
                  WHEN ${mssql_oltp_deal.deal_status_id} = 5 THEN 'Ended' --Ended
                END
          WHEN ${campaign_type_id} = 9 -- TV Buyer deals
            THEN CASE WHEN ${mssql_oltp_deal.deal_status_id} = 1 THEN 'Request Sent' --Sent
                  WHEN ${mssql_oltp_deal.deal_status_id} = 4 THEN 'Running'-- Launched
                  ELSE ${mssql_oltp_deal_status.description}
                END
          WHEN ${campaign_type_id} = 10 -- TV Seller deals
            THEN CASE WHEN ${mssql_oltp_deal.deal_status_id} = 1 THEN 'New Request' --Sent
                  WHEN ${mssql_oltp_deal.deal_status_id} = 4 THEN 'Running' -- Launched
                  ELSE ${mssql_oltp_deal_status.description}
                END
          WHEN ${campaign_type_id} = 4
            THEN CASE WHEN ${mssql_oltp_internal_deal.deal_status_id} = 4 AND ${mssql_oltp_campaign_statistics_v3.flights_end_datetm_raw} < GETUTCDATE() THEN 'Ended'
                  WHEN ${mssql_oltp_internal_deal.deal_status_id} = 4 AND ((${cpu_type_id} <> 5 AND COALESCE(${mssql_oltp_campaign_statistics_v3.billable_units}, 0) >= COALESCE(${units}, 0) AND ${campaign_type_id} <> 3)
                  OR (${cpu_type_id} = 5 AND COALESCE(${mssql_oltp_campaign_statistics_v3.billable_revenue}, 0) >= COALESCE(${forecast_max_spend}, 0) * (1 + COALESCE(${agency_fee}, 0)))) THEN 'Completed'
                  ELSE ${mssql_oltp_deal_status.description}
                END
          WHEN ${mssql_oltp_plan_deal_settings.buyer_plan_id} IS NOT NULL AND ${campaign_status_id} = 5 THEN 'Awaiting Buyer'
          WHEN ${campaign_type_id} = 12 -- Digital Seller deals
            THEN CASE WHEN ${campaign_status_id} = 15 THEN 'Submitted' --Sent
                  ELSE ${mssql_oltp_campaign_status.description}
                END
            ELSE CASE WHEN ${campaign_status_id} = 1 AND ( ${mssql_oltp_campaign_statistics_v3.flights_end_datetm_raw} < GETDATE()
                  OR (${cpu_type_id} NOT IN(4,5) AND COALESCE(${mssql_oltp_campaign_statistics_v3.billable_units},0) >= COALESCE(${units}, 0) AND ${campaign_type_id} <> 3)
                  OR (${cpu_type_id} IN(4,5) AND COALESCE(${mssql_oltp_campaign_statistics_v3.billable_revenue}, 0) >= (COALESCE(${forecast_max_spend}, 0) * (1 + COALESCE(${agency_fee}, 0))))) THEN 'Completed'
                  ELSE (CASE WHEN ${campaign_status_id} = 14 THEN 'Pending Reserved' ELSE ${mssql_oltp_campaign_status.description} END)
                END
        END ;;
  }

#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }

  # ----- Sets of fields for drilling ------
#   set: detail {
#     fields: [
#       pl_campaign_id,
#       campaign_name,
#       tag_default_ftp_username,
#       hostname,
#       campaign.campaign_name,
#       campaign.pl_campaign_id,
#       campaign.tag_default_ftp_username,
#       campaign.hostname,
#       campaign.count,
#       flight.count
#     ]
#   }
}
