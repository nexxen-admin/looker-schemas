view: placement {
  sql_table_name: AN_MAIN..placement (NOLOCK) ;;
  label: "Placement"

  dimension: placement_id {
    primary_key: yes
    type: number
    label: "Placement ID"
    description: "The internal identifier of the placement."
    sql: ${TABLE}.placement_id ;;
    value_format_name: id
  }

  dimension: active {
    type: yesno
    label: "Placement Active"
    description: "A yes/no indicator if the placement is currently active."
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: allow_repeated_ads {
    type: yesno
    hidden: yes
    sql: ${TABLE}.allow_repeated_ads = 1 ;;
  }

  dimension: always_on_impressions_urls_required {
    type: yesno
    label: "Always on Impressions URLs Required"
    sql: ${TABLE}.always_on_impressions_urls_required = 1 ;;
  }

  dimension: avg_monthly_volume {
    type: number
    hidden: yes
    sql: ${TABLE}.avg_monthly_volume ;;
  }

  dimension: bid_currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.bid_currency_Id ;;
  }

  dimension: brand_repeated_ads_count {
    type: number
    label: "Brand Level Frequency Cap"
    sql: ${TABLE}.brand_repeated_ads_count ;;
  }

  dimension: brand_repeated_ads_expiry_minutes {
    type: number
    label: "Brand Level Frequency Cap Period"
    description: "Brand Level Frequency Cap Period (in minutes)"
    sql: ${TABLE}.brand_repeated_ads_expiry_minutes ;;
  }

  dimension: buy_demo_data {
    type: yesno
    hidden: yes
    sql: ${TABLE}.buy_demo_data = 1 ;;
  }

  dimension: buy_source_id {
    type: number
    hidden: yes
    sql: ${TABLE}.buy_source_id ;;
  }

  dimension: buy_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.buy_type_id ;;
  }

  dimension: can_access_cookie {
    type: yesno
    label: "Placement Can Access Cookie"
    sql: ${TABLE}.can_access_cookie = 1 ;;
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
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "Placement Changed"
    description: "The date/time when placement was changed."
    sql: ${TABLE}.changedon ;;
  }

  dimension_group: dst_changedon {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "[DST] Placement Local Changed"
    description: "The date/time when placement was changed in local time (accounting DST - if this option is enabled for the Platform Client)."
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset_placement_changed.utc_offset}, ${TABLE}.changedon)
      else ${TABLE}.changedon end ;;
  }

  dimension: companion_reqd {
    type: yesno
    hidden: yes
    sql: ${TABLE}.companion_reqd = 1 ;;
  }

  dimension: companions_per_imp {
    type: number
    hidden: yes
    sql: ${TABLE}.companions_per_imp ;;
  }

  dimension: comscore_placement_name {
    type: string
    hidden: yes
    sql: ${TABLE}.comscore_placement_name ;;
  }

  dimension: country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.country_id ;;
  }

  dimension: cpm_multiplier {
    type: number
    label: "Placement CPM Multiplier"
    sql: ${TABLE}.cpm_multiplier ;;
  }

  dimension: createdby {
    type: string
    hidden: yes
    sql: ${TABLE}.createdby ;;
  }

  dimension_group: createdon {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "Placement Created"
    description: "The date/time when placement was created."
    sql: ${TABLE}.createdon ;;
  }

  dimension_group: dst_createdon {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "[DST] Placement Local Created"
    description: "The date/time when placement was created in local time (accounting DST - if this option is enabled for the Platform Client)."
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset_placement_created.utc_offset}, ${TABLE}.createdon)
      else ${TABLE}.createdon end ;;
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: default_exchange_fee {
    type: number
    label: "Placement Exchange Fee"
    description: "The percentage amount of the exchage fee."
    sql: ${TABLE}.default_exchange_fee ;;
  }

  dimension: default_min_cpm {
    type: number
    label: "Placement Default Min CPM"
    sql: ${TABLE}.default_min_cpm ;;
  }

  dimension: default_nonvideo_cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.default_nonvideo_cpu ;;
  }

  dimension: default_video_cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.default_video_cpu ;;
  }

  dimension: delivery_cap {
    type: number
    label: "Placement Delivery Cap"
    sql: ${TABLE}.delivery_cap ;;
  }

  dimension: delivery_cap_range_id {
    type: number
    hidden: yes
    sql: ${TABLE}.delivery_cap_range_id ;;
  }

  dimension: delivery_cap_range_timezone_id {
    type: number
    hidden: yes
    sql: ${TABLE}.delivery_cap_range_timezone_id ;;
  }

  dimension: device_type_id {
    type: string
    label: "Placement Device Type"
    sql: CASE WHEN ${TABLE}.device_type_id = 1 THEN 'PC'
              WHEN ${TABLE}.device_type_id = 2 THEN 'Mobile'
              WHEN ${TABLE}.device_type_id = 3 THEN 'Connected TV'
              WHEN ${TABLE}.device_type_id = 4 THEN 'Advanced TV'
              WHEN ${TABLE}.device_type_id = 5 THEN 'Digital Out of Home'
              WHEN ${TABLE}.device_type_id = 6 THEN 'Agnostic'
              WHEN ${TABLE}.device_type_id = 7 THEN 'TV' ELSE '' END
              ;;
    suggestions: ["PC","Mobile","Connected TV","Advanced TV","Digital Out of Home","Agnostic","TV"]
  }

  dimension: dsp_visibility {
    type: yesno
    label: "Placement DSP Visibility"
    sql: ${TABLE}.dsp_visibility = 1 ;;
  }

  dimension: exchange_custom_url {
    type: string
    label: "Placement Exchange Custom URL"
    sql: ${TABLE}.exchange_custom_url ;;
  }

  dimension: exchange_transparency_level_id {
    type: number
    hidden: yes
    sql: ${TABLE}.exchange_transparency_level_id ;;
  }

  dimension: external_cdn_pattern {
    type: string
    hidden: yes
    sql: ${TABLE}.external_cdn_pattern ;;
  }

  dimension: fallback_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.fallback_type_id ;;
  }

  dimension: fallback_url {
    type: string
    hidden: yes
    sql: ${TABLE}.fallback_url ;;
  }

  dimension: format_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.format_type_id ;;
  }

  dimension: freq_cap {
    type: number
    label: "Placement Frequency Cap"
    sql: ${TABLE}.freq_cap ;;
  }

  dimension: freq_cap_hours {
    type: number
    label: "Placement Frequency Cap Period"
    description: "Placement Level Frequency Cap Period (in hours)"
    sql: ${TABLE}.freq_cap_hours ;;
  }

  dimension: freq_tier_id {
    type: number
    hidden: yes
    sql: ${TABLE}.freq_tier_id ;;
  }

  dimension: has_click_ping {
    type: yesno
    hidden: yes
    sql: ${TABLE}.has_click_ping = 1 ;;
  }

  dimension: has_end_ping {
    type: yesno
    hidden: yes
    sql: ${TABLE}.has_end_ping = 1 ;;
  }

  dimension: has_quartile_pings {
    type: yesno
    hidden: yes
    sql: ${TABLE}.has_quartile_pings = 1 ;;
  }

  dimension: hostname {
    type: string
    hidden: yes
    sql: ${TABLE}.hostname ;;
  }

  dimension: include_in_optimization {
    type: yesno
    hidden: yes
    sql: ${TABLE}.include_in_optimization = 1 ;;
  }

  dimension: integration_tag {
    type: string
    hidden: yes
    sql: ${TABLE}.integration_tag ;;
  }

  dimension: inventory_medium_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.inventory_medium_type_id ;;
  }

  dimension: inventory_source_id {
    type: number
    hidden: yes
    sql: ${TABLE}.inventory_source_id ;;
  }

  dimension: inventory_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.inventory_type_id ;;
  }

  dimension: is_inventory_type_parent {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_inventory_type_parent = 1 ;;
  }

  dimension: is_matchbuy {
    type: yesno
    label: "Placement Matchbuy"
    description: "Method in which campaigns are decisioned."
    sql: ${TABLE}.is_matchbuy = 1 ;;
  }

  dimension: is_network_served {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_network_served = 1 ;;
  }

  dimension: is_pod {
    type: yesno
    label: "Placement Is AdPod"
    description: "A yes/no indicator if placement is adpod."
    sql: ${TABLE}.is_pod = 1 ;;
  }

  dimension: is_syndicator_brand {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_syndicator_brand = 1 ;;
  }

  dimension: is_targeted {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_targeted = 1 ;;
  }

  dimension: is_test_placement {
    type: yesno
    label: "Test Placement"
    description: "A yes/no indicator if the placement is a test placement."
    sql: ${TABLE}.is_test_placement = 1 ;;
  }

  dimension: is_vmx_placement {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_vmx_placement = 1 ;;
  }

  dimension: liability {
    type: yesno
    label: "Placement Liability"
    description: "A yes/no indicator if the company has payment liablity."
    sql: ${TABLE}.liability = 1 ;;
  }

  dimension: mapping_reqd {
    type: yesno
    hidden: yes
    sql: ${TABLE}.mapping_reqd = 1 ;;
  }

  dimension: max_ad_duration {
    type: number
    label: "Placement Max Ad Duration"
    sql: ${TABLE}.max_ad_duration ;;
  }

  dimension: max_fraud_exposure {
    type: number
    hidden: yes
    sql: ${TABLE}.max_fraud_exposure ;;
  }

  dimension: midroll_interval {
    type: number
    hidden: yes
    sql: ${TABLE}."mid-roll_interval" ;;
  }

  dimension: midrolls_served {
    type: yesno
    hidden: yes
    sql: ${TABLE}."mid-rolls_served" = 1 ;;
  }

  dimension: min_ad_duration {
    type: number
    label: "Placement Min Ad Duration"
    sql: ${TABLE}.min_ad_duration ;;
  }

  dimension: min_cpm_adjustment {
    type: number
    hidden: yes
    sql: ${TABLE}.min_cpm_adjustment ;;
  }

  dimension: min_monthly_volume {
    type: number
    label: "Placement Min Monthly Volume"
    sql: ${TABLE}.min_monthly_volume ;;
  }

  dimension: min_percent_sniff_and_pass {
    type: number
    hidden: yes
    sql: ${TABLE}.min_percent_sniff_and_pass ;;
  }

  dimension: min_units_on_sniff_and_pass {
    type: number
    hidden: yes
    sql: ${TABLE}.min_units_on_sniff_and_pass ;;
  }

  dimension: monthly_avail_volume {
    type: number
    label: "Placement Monthly Avail Volume"
    sql: ${TABLE}.monthly_avail_volume ;;
  }

  dimension: nielsen_impression_url_required {
    type: yesno
    label: "Placement Nielsen Impression URL Required"
    sql: ${TABLE}.nielsen_impression_url_required = 1 ;;
  }

  dimension: notes {
    type: string
    label: "Description"
    sql: ${TABLE}.notes ;;
  }

  dimension: operator_id {
    type: number
    hidden: yes
    sql: ${TABLE}.operator_id ;;
  }

  dimension: opt_in_buyers {
    type: yesno
    hidden: yes
    sql: ${TABLE}.opt_in_buyers = 1 ;;
  }

  dimension: override_min_cpm {
    type: yesno
    hidden: yes
    sql: ${TABLE}.override_min_cpm = 1 ;;
  }

  dimension: override_monthly_avail_volume {
    type: yesno
    label: "Placement Override Monthly Avail Volume"
    sql: ${TABLE}.override_monthly_avail_volume = 1 ;;
  }

  dimension: partner_id {
    type: number
    hidden: yes
    sql: ${TABLE}.partner_id ;;
  }

  dimension: passback_allowed {
    type: yesno
    hidden: yes
    sql: ${TABLE}.passback_allowed = 1 ;;
  }

  dimension_group: paused_date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "Placement Paused"
    description: "The date/time when placement was paused."
    sql: ${TABLE}.paused_date ;;
  }

  dimension_group: dst_paused_date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "[DST] Placement Local Paused"
    description: "The date/time when placement was paused in local time (accounting DST - if this option is enabled for the Platform Client)."
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset_placement_paused.utc_offset}, ${TABLE}.paused_date)
      else ${TABLE}.paused_date end ;;
  }

  dimension: placement_alias {
    type: string
    label: "Placement Alias"
    description: "An alias name used for the placement when the real name can't be displayed."
    sql: ${TABLE}.placement_alias ;;
  }

  dimension: placement_integration_type_id {
    type: number
    #hidden: yes
    sql: ${TABLE}.placement_integration_type_id ;;
    value_format_name: id
  }

  dimension: placement_inventory_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_inventory_type_id ;;
  }

  dimension: placement_is_paused {
    type: yesno
    label: "Paused Placement"
    description: "A yes/no indicator if the placement is a paused placement."
    sql: ${TABLE}.placement_is_paused = 1 ;;
  }

  dimension: placement_name {
    type: string
    label: "Placement"
    description: "Placement name both for deals and placements."
    sql: ${TABLE}.placement_name ;;
    suggest_explore: mssql_oltp_suggest_supply_ref
    suggest_dimension: mssql_oltp_suggest_supply_ref.placement_name
  }

  dimension: placement_quality_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_quality_id ;;
  }

  dimension: placement_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_status_id ;;
  }

  dimension: placement_status {
    type: string
    label: "Placement Status"
    description: "The status of placement (Active, Paused, Inactive)."
    sql: CASE WHEN NOT ${active} OR ${TABLE}.active IS NULL THEN 'Inactive'
              ELSE CASE WHEN ${placement_is_paused} THEN 'Paused'
                   ELSE 'Active'
              END
         END ;;
    suggestions: ["Active","Inactive","Paused"]
  }

  dimension: placement_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_type_id ;;
  }

  dimension: pod_duration {
    type: number
    label: "Placement Ad Pod Duration"
    sql: ${TABLE}.pod_duration ;;
  }

  dimension: pod_location_id {
    type: number
    hidden: yes
    sql: ${TABLE}.pod_location_id ;;
  }

  dimension: pod_max_ads {
    type: number
    hidden: yes
    sql: ${TABLE}.pod_max_ads ;;
  }

  dimension: pod_must_fill {
    type: string
    hidden: yes
    sql: ${TABLE}.pod_must_fill ;;
  }

  dimension: pre_emptable_contracts {
    type: yesno
    hidden: yes
    sql: ${TABLE}.pre_emptable_contracts = 1 ;;
  }

  dimension: prerolls_served {
    type: yesno
    hidden: yes
    sql: ${TABLE}."pre-rolls_served" = 1 ;;
  }

  dimension: publisher_source {
    type: number
    hidden: yes
    sql: ${TABLE}.publisher_source ;;
  }

  dimension: redirect_clicks {
    type: yesno
    hidden: yes
    sql: ${TABLE}.redirect_clicks = 1 ;;
  }

  dimension: redirect_list_based {
    type: yesno
    hidden: yes
    sql: ${TABLE}.redirect_list_based = 1 ;;
  }

  dimension: repeated_ads_count {
    type: number
    hidden: yes
    sql: ${TABLE}.repeated_ads_count ;;
  }

  dimension: repeated_ads_expiry_minutes {
    type: number
    hidden: yes
    sql: ${TABLE}.repeated_ads_expiry_minutes ;;
  }

  dimension: require_external_cdn {
    type: yesno
    label: "Placement Requires External CDN"
    sql: ${TABLE}.require_external_cdn = 1 ;;
  }

  dimension: site_genre_id {
    type: number
    hidden: yes
    sql: ${TABLE}.site_genre_id ;;
  }

  dimension: skippable {
    type: string
    label: "Placement Skippable Type"
    sql: CASE WHEN ${TABLE}.skippable = 0  then 'No Skip'
              WHEN ${TABLE}.skippable = 1  then 'Skippable'
              WHEN ${TABLE}.skippable = 2  then 'Allow Both'
              ELSE 'Other' END ;;
    suggestions: ["No Skip","Skippable","Allow Both","Other"]
  }

  dimension: sync_with_google {
    type: yesno
    label: "Placement User Sync"
    description: "Placement User Sync/Placement Sync with Google."
    sql: ${TABLE}.sync_with_google = 1 ;;
  }

  dimension: tag_default_duration {
    type: number
    hidden: yes
    sql: ${TABLE}.tag_default_duration ;;
  }

  dimension: tag_default_use_pd1 {
    type: string
    hidden: yes
    sql: ${TABLE}.tag_default_use_pd1 ;;
  }

  dimension: tag_default_use_pd2 {
    type: string
    hidden: yes
    sql: ${TABLE}.tag_default_use_pd2 ;;
  }

  dimension: tier {
    type: number
    label: "Placement Tier"
    description: "Supply Quality Rating"
    sql: ${TABLE}.tier ;;
  }

  dimension: updatedby {
    type: string
    hidden: yes
    sql: ${TABLE}.updatedby ;;
  }

  dimension: url {
    type: string
    hidden: yes
    sql: ${TABLE}.url ;;
  }

  dimension: use_network_level_forecast {
    type: yesno
    hidden: yes
    sql: ${TABLE}.use_network_level_forecast = 1 ;;
  }

  dimension: userdata_expire_time {
    type: number
    hidden: yes
    sql: ${TABLE}.userdata_expire_time ;;
  }

  dimension: userdata_frequency {
    type: number
    hidden: yes
    sql: ${TABLE}.userdata_frequency ;;
  }

  dimension: userdata_frequency_period {
    type: number
    hidden: yes
    sql: ${TABLE}.userdata_frequency_period ;;
  }

  dimension: vendor_site_id {
    type: string
    hidden: yes
    sql: ${TABLE}.vendor_site_id ;;
  }

  dimension: video_platform_id {
    type: number
    hidden: yes
    sql: ${TABLE}.video_platform_id ;;
  }

  dimension: vmm_biddable_placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.vmm_biddable_placement_id ;;
  }

  dimension: whiteops_selection_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.whiteops_selection_type_id ;;
  }

  dimension: width_height_id {
    type: number
    hidden: yes
    sql: ${TABLE}.width_height_id ;;
  }

  dimension: enable_double_verify_prebid {
    type: yesno
    label: "DoubleVerify Pre Bid"
    sql: ${TABLE}.enable_double_verify_prebid = 1 ;;
  }

  measure: count {
    type: count_distinct
    label: "Count of Placements"
    description: "The distinct count of Placements."
    sql: ${placement_id} ;;
  }
}
