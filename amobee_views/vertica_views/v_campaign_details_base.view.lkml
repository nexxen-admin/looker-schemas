view: v_campaign_details_base {
  sql_table_name: DIM.CAMPAIGN_DETAILS_BASE_VIEW;;
  label: "Campaign"

  dimension: advertiser_brand_id {
    type: string
    hidden: yes
    sql: ${TABLE}.ADVERTISER_BRAND_ID ;;
  }

  dimension: audit_vendor {
    type: string
    label: "Audit Vendor"
    description: "The name of the Audit Vendor for the Camapign, if applicable."
    sql: ${TABLE}.AUDIT_VENDOR ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.audit_vendor
  }

  dimension: audit_vendor_id {
    type: string
    hidden: yes
    sql: ${TABLE}.AUDIT_VENDOR_ID ;;
  }

  dimension_group: begin_datetime_local {
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
    label: "Begin Time - Local"
    description: "The start time of the Campaign in the Campaign's timezone."
    sql: ${TABLE}.BEGIN_DATETIME_LOCAL ;;
  }

  dimension_group: dst_begin_datetime_local {
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
    label: "[DST] Begin Time - Local"
    description: "The start time of the Campaign in the Campaign's timezone accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then TIMESTAMPADD(hour, -${v_timezone.utc_offset}, ${TABLE}.BEGIN_DATETIME_LOCAL) AT TIMEZONE ${v_timezone.timezone_name}
      else ${TABLE}.BEGIN_DATETIME_LOCAL end ;;
  }

  dimension: business_hemisphere_description {
    type: string
    hidden: yes
    sql: ${TABLE}.BUSINESS_HEMISPHERE_DESCRIPTION ;;
  }

  dimension: business_hemisphere_id {
    type: string
    hidden: yes
    sql: ${TABLE}.BUSINESS_HEMISPHERE_ID ;;
  }

  dimension: business_region_currency_id {
    type: string
    hidden: yes
    sql: ${TABLE}.BUSINESS_REGION_CURRENCY_ID ;;
  }

  dimension: business_region_description {
    type: string
    hidden: yes
    label: "Business Region"
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Demand Platform Client{% endif %}"
    description: "The business region of the demand customer (Americas, Europe, or Asia)."
    sql: ${TABLE}.BUSINESS_REGION_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.business_region_description
  }

  dimension: business_region_id {
    type: string
    hidden: yes
    sql: ${TABLE}.BUSINESS_REGION_ID ;;
  }

  dimension: buying_market_id {
    type: string
    hidden: yes
    sql: ${TABLE}.BUYING_MARKET_ID ;;
  }

  dimension: campaign_active {
    type: yesno
    label: "Campaign is Active"
    description: "A yes/no indicator if the campaign is active."
    sql: ${TABLE}.CAMPAIGN_ACTIVE ;;
  }

  dimension_group: campaign_end_date {
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
    label: "Campaign End"
    description: "The end date of the campaign in UTC."
    sql: TIMESTAMPADD('minute',-1,${TABLE}.CAMPAIGN_END_DATE) ;;
  }

  dimension_group: dst_campaign_end_date {
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
    label: "[DST] Campaign Local End"
    description: "The end date of the campaign in local time accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then TIMESTAMPADD('minute', -1, ${TABLE}.CAMPAIGN_END_DATE) AT TIME ZONE 'UTC' AT TIME ZONE ${v_timezone.timezone_name}
      else TIMESTAMPADD('minute',-1,${TABLE}.CAMPAIGN_END_DATE) end ;;
  }

  dimension: campaign_id {
    type: number
    primary_key: yes
    label: "Campaign ID"
    description: "The system id of the Campaign."
    link: {    label: "Inspect"
      url: "/dashboards/36?Campaign ID={{value}}"}
    link: {    label: "Manage"
      url: "https://{% if _user_attributes['is_itv_user'] == 'yes' %}theaddressableplatform.amobee{% else %}platform.videologygroup{% endif %}.com/Customer/Campaign/Workspace/{{value}}"}
    sql: ${TABLE}.CAMPAIGN_ID ;;
    value_format_name: id
  }

  dimension: campaign_name {
    type: string
    label: "Campaign Name"
    sql: ${TABLE}.CAMPAIGN_NAME ;;
    drill_fields: [v_flight_details.flight_description, v_flight_media_details_base.media_name, v_flight_media_details_base.flight_media_id]
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.campaign_name

  }

  dimension: campaign_name_custom {
    type: string
    label: "Campaign Name"
    view_label: "Custom Dimensions"
    description: "Customized Campaign Name for UK Operations. Excludes characters including and after a '#' symbol"
    sql: CASE
          WHEN POSITION('#' IN ${campaign_name}) <= 1
          THEN ${campaign_name}
          ELSE SUBSTRING(${campaign_name} FROM 1 FOR POSITION('#' IN ${campaign_name}) - 1)
      END  ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.campaign_name_custom
  }

  dimension: campaign_network_description {
    type: string
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_NETWORK_DESCRIPTION ;;
  }

  dimension: campaign_network_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_NETWORK_ID ;;
  }

  dimension: campaign_objective {
    type: string
    label: "Campaign Objective"
    description: "The objective of the campaign."
    sql: ${TABLE}.CAMPAIGN_OBJECTIVE ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.campaign_objective
  }

  dimension_group: campaign_start_date {
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
    label: "Campaign Start"
    description: "The start date of the campaign in UTC."
    sql: ${TABLE}.CAMPAIGN_START_DATE ;;
  }

  dimension_group: dst_campaign_start_date {
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
    label: "[DST] Campaign Local Start"
    description: "The start date of the campaign in local time accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then ${TABLE}.CAMPAIGN_START_DATE AT TIME ZONE 'UTC' AT TIME ZONE ${v_timezone.timezone_name}
      else ${TABLE}.CAMPAIGN_START_DATE end ;;
  }

  dimension: campaign_status_description {
    type: string
    label: "Campaign Status"
    description: "The current status of the campaign (i.e. running, paused, ended, etc.)"
    sql: COALESCE(CASE WHEN ${campaign_type_id} IN (8, 9, 10) THEN ${TABLE}.misc_deal_status_description END, ${TABLE}.CAMPAIGN_STATUS_DESCRIPTION) ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.campaign_status_description
  }

  dimension: campaign_info {
    type: string
    label: "Campaign Information"
    description: "Campaign custom string"
    sql: COALESCE(${TABLE}.misc_campaign_info, '') ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.campaign_info
  }

  dimension: campaign_status_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_STATUS_ID ;;
  }

  dimension: campaign_targeting_type {
    type: string
    label: "Campaign Targeting Type"
    description: "The type of targeting for the campaign"
    sql: ${TABLE}.CAMPAIGN_TARGETING_TYPE ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.campaign_targeting_type
  }

  dimension: campaign_type_description {
    type: string
    label: "Campaign Type"
    sql: ${TABLE}.CAMPAIGN_TYPE_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.campaign_type_description
  }

  dimension: campaign_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_TYPE_ID ;;
  }

  dimension: changedon {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: checksum_value {
    type: string
    hidden: yes
    sql: ${TABLE}.CHECKSUM_VALUE ;;
  }

  dimension: client_non_revenue_generating {
    type: yesno
    label: "Non-revenue generating"
    description: "A yes/no indicator if the campaign is non revenue generating."
    sql: ${TABLE}.CLIENT_NON_REVENUE_GENERATING ;;
  }

  dimension: contracted_addedvalue_units {
    type: number
    label: "Contracted Added Value Units"
    description: "The number of units that were added at no charge as defined in the contract."
    value_format_name: decimal_0
    sql: ${TABLE}.CONTRACTED_ADDEDVALUE_UNITS ;;
  }

  dimension: contracted_budget {
    type: number
    label: "Campaign Contracted Budget"
    description: "The amount of budget to deliver as defined in the contract."
    value_format_name: decimal_2
    sql: ${TABLE}.CONTRACTED_BUDGET ;;
  }

  measure:  sum_contracted_budget {
    type: sum
    label: "Campaign Contracted Budget"
    description: "The amount of budget to deliver as defined in the contract."
    value_format_name: decimal_0
    sql: ${contracted_budget};;
  }

  dimension: contracted_cpu {
    type: number
    label: "Contracted CPU"
    description: "The contracted Cost per Unit"
    value_format_name: decimal_2
    sql: ${TABLE}.CONTRACTED_CPU ;;
  }

  dimension: audit_factor {
    type: number
    label: "Audit Factor"
    description: "The Audit Factor."
    value_format_name: decimal_2
    sql: ${TABLE}.AUDIT_FACTOR ;;
  }

  dimension: contracted_units {
    type: number
    label: "Campaign Contracted Units"
    description: "The number of units to deliver as defined in the contract."
    value_format_name: decimal_0
    sql: ${TABLE}.CONTRACTED_UNITS ;;
  }

  measure:  sum_contracted_units {
    type: sum
    label: "Campaign Contracted Units"
    description: "The number of units to deliver as defined in the contract."
    value_format_name: decimal_0
    sql: ${contracted_units};;
  }

  measure: max_contracted_units {
    type: max
    hidden:yes
    value_format_name: decimal_0
    sql: ${contracted_units};;
  }

  dimension: cpu {
    type: number
    label: "CPU"
    description: "The actual CPU of the campaign."
    value_format_name: decimal_2
    sql: ${TABLE}.CPU ;;
  }

  measure: max_cpu {
    type: max
    description: "Max CPU on the campaign"
    value_format_name: decimal_2
#    hidden: yes
    sql: ${cpu} ;;
  }

  dimension: cpu_type_description {
    type: string
    label: "CPU Type"
    description: "The CPU type of the campagin.  Examples include, CPM, CPCV, dCPM, etc."
    sql: ${TABLE}.CPU_TYPE_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.cpu_type_description
  }

  dimension: cpu_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CPU_TYPE_ID ;;
  }

  measure: max_cpu_type_id {
    type: max
    hidden: yes
    sql: ${cpu_type_id} ;;
  }

  dimension_group: createdon {
    label: "Created On "
    type: time
    timeframes: [raw, date, time, week, quarter, year]
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CUSTOMER_ID ;;
  }

  dimension: customer_io_number {
    type: string
    label: "Customer IO Number"
    description: "The Insertion Order Number as the customer defines it."
    sql: ${TABLE}.CUSTOMER_IO_NUMBER ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.customer_io_number
  }

  dimension: deal_placement_id {
    type: string
    hidden: yes
    sql: ${TABLE}.DEAL_PLACEMENT_ID ;;
  }

  dimension: demo_composition_vendor_id {
    type: string
    label: "Demo Composition Vendor ID"
    description: "ID of the targeted demographic available in the country the campaign runs in"
    sql: ${TABLE}.DEMO_COMPOSITION_VENDOR_ID ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.demo_composition_vendor_id
  }

  dimension: demo_composition_vendor {
    type: string
    label: "Demo Composition Vendor"
    description: "Vendor representing targeted demographic available in the country the campaign runs in"
    sql: CASE WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 1 then 'Comscore Media Matrix'
              WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 2 then 'Nielsen OCR'
              WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 3 then 'Comscore VCE'
              WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 4 then 'AT&T Linear'
              WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 5 then 'AT&T Addressable'
              WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 6 then 'Bell'
              WHEN ${TABLE}.DEMO_COMPOSITION_VENDOR_ID = 7 then 'Rogers'
              ELSE 'OTHER' END ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.demo_composition_vendor
  }

  dimension: demo_segment_group_description {
    type: string
    label: "Demo Segment Group"
    description: "The Demo Segment Group of the campaign.  Examples include Ages 18 and older, US Standard, UK Standard, etc."
    sql: ${TABLE}.DEMO_SEGMENT_GROUP_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.demo_segment_group_description
  }

  dimension: demo_composition_vendor_description {
    type: string
    label: "Demo Composition Vendor"
    description: "Demo composition vendor description"
    sql: ${TABLE}.DEMO_COMPOSITION_VENDOR_DESCRIPTION ;;
  }

  dimension: demo_segment_group_id {
    type: string
    hidden: yes
    sql: ${TABLE}.DEMO_SEGMENT_GROUP_ID ;;
  }

  dimension: device_type_description {
    type: string
    label: "Device Type"
    description: "The device type the campaign is targeted to.  Examples include, PC, Mobile, Agnostic, etc."
    sql: ${TABLE}.DEVICE_TYPE_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.device_type_description
  }

  dimension: device_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.DEVICE_TYPE_ID ;;
  }

  dimension_group: end_datetime_local {
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
    label: "End Time - Local"
    description: "The end time of the Campaign in the Campaign's timezone."
    sql: TIMESTAMPADD('minute',-1,${TABLE}.END_DATETIME_LOCAL) ;;
  }

  dimension_group: dst_end_datetime_local {
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
    label: "[DST] End Time - Local"
    description: "The end time of the Campaign in the Campaign's timezone accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then TIMESTAMPADD(hour, -${v_timezone.utc_offset}, TIMESTAMPADD('minute',-1,${TABLE}.END_DATETIME_LOCAL)) AT TIMEZONE ${v_timezone.timezone_name}
      else TIMESTAMPADD('minute',-1,${TABLE}.END_DATETIME_LOCAL) end ;;
  }

  dimension: format_type_description {
    type: string
    label: "Format Type"
    description: "The format of the campaign's targeting.  Examples include, Digitial Video, Display, Linear TV, etc."
    sql: ${TABLE}.FORMAT_TYPE_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.format_type_description
  }

  dimension: format_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.FORMAT_TYPE_ID ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.format_type_id
  }

  dimension: grp_audience_size {
    type: number
    label: "GRP Audience"
    description: "The size of the audience for this campaign used in measuring gross rating points."
    sql: ${TABLE}.GRP_AUDIENCE_SIZE ;;
  }

  dimension: insertion_order_id {
    type: number
    hidden: yes
    sql: ${TABLE}.INSERTION_ORDER_ID ;;
  }

  dimension: preemptible {
    type: yesno
    label: "Preemptible"
    description: "A yes/no indicator if the campaign is preemptible."
    sql: ${TABLE}.PREEMPTIBLE ;;
  }

  dimension: is_revenue_generating {
    type: yesno
    label: "Revenue Generating"
    description: "A yes/no indicator if the campaign is revenue generating for the company."
    sql: ${TABLE}.IS_REVENUE_GENERATING ;;
  }


  dimension: is_test_campaign {
    type: yesno
    label: "Test Campaign"
    description: "A yes/no indicator if the campaign is a test campaign."
    sql: ${TABLE}.IS_TEST_CAMPAIGN ;;
  }

  dimension: isfiller {
    type: yesno
    label: "House"
    description: "A yes/no indicator if the campaign is a house/filler campaign."
    sql: ${TABLE}.ISFILLER ;;
  }

  dimension: isguaranteed {
    type: yesno
    label: "Guaranteed"
    description: "A yes/no indicator if the campaign is guaranteed."
    sql: ${TABLE}.ISGUARANTEED ;;
  }

  dimension: launched_by_id {
    type: string
    hidden: yes
    sql: ${TABLE}.LAUNCHEDBY  ;;
  }

  dimension: office_id {
    type: number
    hidden: yes
    sql: ${TABLE}.OFFICE_ID ;;
  }

  dimension: office_name {
    type: string
    hidden: yes
    sql: ${TABLE}.OFFICE_NAME ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.office_name
  }

  dimension: pl_plan_id {
    type: number
    label: "Plan ID"
    description: "The system ID of the Plan"
    #hidden: yes
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Plan{% endif %}"
    sql: ${TABLE}.PL_PLAN_ID ;;
    value_format_name: id
  }

  measure: count_of_plans {
    type: number
    label: "Count of Plans"
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Plan{% endif %}"
    description: "The distinct count of Plans."
    sql: count(distinct ${pl_plan_id}) ;;
  }

  dimension: plan_name {
    type: string
    label: "Plan"
    description: "The name of the Plan,"
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Plan{% endif %}"
    sql: ${TABLE}.PL_PLAN_NAME ;;
    drill_fields: [campaign_details_base.campaign_name, flight_details.flight_description, flight_media_details_base.media_name, flight_media_details_base.flight_media_id]
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.plan_name
  }

  dimension: plan_culture {
    type: string
    hidden: yes
    sql: ${TABLE}.PLAN_CULTURE ;;
  }

  dimension: plan_end_date {
    type: date
    label: "Plan End Date"
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Plan{% endif %}"
    description: "The end date of the Plan in UTC."
    sql: TIMESTAMPADD(minute, -1, ${TABLE}.PLAN_END_DATE) ;;
  }

  dimension: dst_plan_end_date {
    type: date
    label: "[DST] Plan Local End Date"
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Plan{% endif %}"
    description: "The end date of the Plan in local time accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then TIMESTAMPADD(minute, -1, ${TABLE}.PLAN_END_DATE) AT TIMEZONE ${v_timezone.timezone_name}
      else TIMESTAMPADD(minute, -1, ${TABLE}.PLAN_END_DATE) end ;;
  }

  dimension: plan_start_date {
    type: date
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Plan{% endif %}"
    label: "Plan Start Date"
    description: "The start date of the plan in UTC."
    sql: ${TABLE}.PLAN_START_DATE ;;
  }

  dimension: dst_plan_start_date {
    type: date
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Plan{% endif %}"
    label: "[DST] Plan Local Start Date"
    description: "The start date of the plan in local time accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then ${TABLE}.PLAN_START_DATE AT TIMEZONE ${v_timezone.timezone_name}
      else ${TABLE}.PLAN_START_DATE end ;;
  }

  dimension: planned_spend {
    type: number
    label: "Campaign Planned Spend"
    description: "The amount of planned spend for the campaign,"
    value_format_name: decimal_2
    sql: ${TABLE}.PLANNED_SPEND ;;
  }

  measure: campaign_planned_net_spend {
    type: sum
    label: "Campaign Planned Net Spend"
    description: "The campaign planned net spend."
    value_format_name: decimal_2
    hidden: yes
    sql: ${planned_spend} ;;
  }

  measure: sum_campaign_budget {
    type: number
    label: "Campaign Planned Spend"
    description: "The campaign planned spend."
    value_format_name: decimal_2
    sql: ${campaign_planned_net_spend} * (1 + COALESCE(${agency_fee},0)) ;;
  }

  measure: max_planned_spend {
    type: max
    hidden:yes
    sql: ${planned_spend} ;;
  }

  dimension: platform_client_description {
    type: string
    hidden: yes
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Demand Platform Client{% endif %}"
    label: "Platform Client"
    description: "The name of the Platform Client"
    sql: ${TABLE}.PLATFORM_CLIENT_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.platform_client_description
  }

  dimension: platform_client_group_description {
    type: string
    label: "Platform Client Group"
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Demand Platform Client{% endif %}"
    description: "A logical grouping of platform clients."
    sql: ${TABLE}.PLATFORM_CLIENT_GROUP_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.platform_client_group_description
  }

  dimension: platform_client_id {
    type: number
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Demand Platform Client{% endif %}"
    label: "Platform Client ID"
    description: "The system ID of the Platform Client"
    hidden: yes
    sql: ${TABLE}.PLATFORM_CLIENT_ID ;;
    value_format_name: id
  }

  measure: count_of_platform_client {
    type: number
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Demand Platform Client{% endif %}"
    label: "Count of Platform Clients"
    description: "The distinct count of Demand Platform Clients."
    sql: count(distinct ${platform_client_id}) ;;
  }

  dimension: platform_client_group_id {
    type: number
    label: "Platform Client Group ID"
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Demand Platform Client{% endif %}"
    sql: ${TABLE}.PLATFORM_CLIENT_GROUP_ID ;;
    value_format_name: id
  }

  dimension: pricing_vendor_id {
    type: number
    label: "Pricing Vendor ID"
    sql: ${TABLE}.PRICING_VENDOR_ID ;;
    value_format_name: id
  }

  dimension: pricing_vendor_name {
    type: string
    label: "Pricing Vendor"
    sql: case when ${TABLE}.PRICING_VENDOR_ID = 101 then 'Videology'
              when ${TABLE}.PRICING_VENDOR_ID = 102 then 'Moat'
              when ${TABLE}.PRICING_VENDOR_ID = 103 then 'DoubleVerify'
              when ${TABLE}.PRICING_VENDOR_ID = 104 then 'Integral Ad Science'
              else 'Other' end;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.pricing_vendor_name
  }

  dimension: reporting_business_unit_description {
    type: string
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Demand Platform Client{% endif %}"
    label: "Reporting Business Unit"
    description: "A grouping of platform clients derived for and used in reporting."
    sql: ${TABLE}.REPORTING_BUSINESS_UNIT_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.reporting_business_unit_description
  }

  dimension: reporting_business_unit_id {
    type: number
    view_label: "{% if _explore._name == 'auction_log' and _view._name == 'campaign_details_seller' %}Seller Deal Campaign{% elsif _explore._name == 'auction_log' and _view._name == 'campaign_details_buyer' %}Buyer Campaign{% else %}Demand Platform Client{% endif %}"
    label: "Reporting Business Unit ID"
    description: "A grouping of platform clients derived for and used in reporting."
    sql: ${TABLE}.REPORTING_BUSINESS_UNIT_ID ;;
  }

  dimension: spread_fraction {
    type: number
    hidden: yes
    sql: ${TABLE}.SPREAD_FRACTION ;;
  }

  dimension: timezone_id {
    type: number
    label: "Timezone"
    hidden: yes
    sql: ${TABLE}.TIMEZONE_ID ;;
  }

  dimension: trp_audience_size {
    type: number
    label: "TRP Audience"
    description: "The total size of the audience available for the selected targeting used for calculating targeted rating points."
    sql: ${TABLE}.TRP_AUDIENCE_SIZE ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: count_of_campaigns {
    type:  number
    label: "Count of Campaigns"
    description: "The distinct count of Campaigns."
    sql:  count (distinct ${campaign_id}) ;;
  }

  measure: is_filler {
    type: max
    label: "Isfiller"
    description: "A yes/no indicator if the campaign is a house/filler campaign."
    sql: CASE WHEN ${TABLE}.ISFILLER = 0 then '0' ELSE '1' END;;
  }


  dimension: campaign_total_days {
    type: number
    hidden: yes
    description: "The total number of days in the campaign."
    label: "Campaign Total Days"
    sql: datediff('day',${campaign_start_date_raw},${campaign_end_date_raw}) ;;
  }

  measure: max_campaign_total_days {
    type: max
    hidden: yes
    description: "The total number of days in the campaign."
    label: "Campaign Total Days"
    sql: ${campaign_total_days};;
  }

  dimension: campaign_remaining_days {
    type: number
    hidden: yes
    description: "The total number of days remaining (end date - yesterday) in the campaign."
    label: "Campaign Remaining Days"
    sql: CASE when datediff('day',TIMESTAMPADD('day',-1,current_date()),${campaign_end_date_raw}) < 0 then 0
      else datediff('day',TIMESTAMPADD('day',-1,current_date()),${campaign_end_date_raw}) end;;
  }

  measure: max_campaign_remaining_days {
    type: max
    hidden: yes
    description: "The total number of days remaining (end date - yesterday) in the campaign."
    label: "Campaign Remaining Days"
    sql: ${campaign_remaining_days};;
  }

  dimension: campaign_elapsed_days {
    type: number
    hidden: yes
    description: "The total number of days that have elasped since the beginning of the campaign."
    label: "Campaign Elapsed Days"
    sql: Case when ${campaign_remaining_days} > ${campaign_total_days} then 0
              when ${campaign_remaining_days} < 0 then ${campaign_total_days}
              else ${campaign_total_days} - ${campaign_remaining_days} end  ;;
  }

  measure: max_campaign_elapsed_days {
    type: max
    hidden: yes
    description: "The total number of days that have elasped since the beginning of the campaign."
    label: "Campaign Elapsed Day"
    sql: ${campaign_elapsed_days}  ;;
  }

  measure: agency_fee {
    type: max
    label: "Campaign Agency Fee"
    description: "The percentage amount that the agency charges to the customer.  This is added to net spend to determine gross spend."
    value_format_name: percent_2
    sql: ${v_flight_media_details_base.agency_fee} ;;
  }

  dimension: is_amobee_served {
    type: yesno
    hidden: yes
    sql: ${TABLE}.misc_is_amobee_served::boolean ;;
  }

  dimension: is_amobee_served_string {
    type: string
    hidden: yes
    sql: ${TABLE}.misc_is_amobee_served::varchar ;;
  }

  dimension: is_amobee_served_changedon {
    type: date_time
    hidden: yes
    sql: ${TABLE}.misc_is_amobee_served_changedon ;;
  }

  dimension: plan_status {
    type: string
    label: "Plan Status"
    description: "Current status of the plan (Running, Ended, Planned)"
    sql: case
           when current_timestamp between ${plan_start_date} and ${plan_end_date} then 'Running'
           when current_timestamp > ${plan_end_date} then 'Ended'
           when current_timestamp < ${plan_start_date} then 'Planned'
         end ;;
  }

  measure: amobee_served_plans {
    type: count_distinct
    label: "Amobee Served Plans"
    description: "Number of plans served by Amobee"
    sql: case when ${is_amobee_served} then ${pl_plan_id} end ;;
  }

  measure: non_amobee_served_plans {
    type: count_distinct
    label: "Non-Amobee Served Plans"
    description: "Number of plans not served by Amobee"
    sql: case when not ${is_amobee_served} then ${pl_plan_id} end ;;
  }

  measure: plans_passed_to_itv_yesterday {
    type: count_distinct
    label: "Plans Passed to ITV Yesterday"
    description: "Number of plans that were started to be served by ITV yesterday"
    filters: {
      field: is_amobee_served_string
      value: "f"
    }
    filters: {
      field: is_amobee_served_changedon
      value: "yesterday"
    }
    sql: ${pl_plan_id} ;;
  }

  dimension: spend_discount {
    type: number
    label: "Spend Discount"
    value_format_name: percent_2
    description: "The percentage amount of spend discount for campaign."
    sql:coalesce(${TABLE}.SPEND_DISCOUNT/100,0);;
  }

  dimension: is_discounted {
    type: yesno
    label: "Is Discounted"
    description: "Is discount provided for campaign."
    sql:${spend_discount} > 0;;
  }

  dimension_group: date_ordered {
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
    label: "Ordered"
    description: "Launch time of the deal."
    sql: ${TABLE}.misc_date_ordered ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      campaign_name,
      plan_name,
      office_name,
      v_platform_client.platform_client_id,
      v_platform_client.platform_type_name,
      v_platform_client.office_name,
      v_pl_plan.pl_plan_id,
      v_pl_plan.plan_name,
      v_demo_segment_group.demo_segment_group_id,
      v_buying_market.buying_market_id,
      v_buying_market.buying_market_name,
      v_buying_market.office_name,
      v_timezone.timezone_id
    ]
  }
}
