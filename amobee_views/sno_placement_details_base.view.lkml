view: placement_details_base {
  label: "Placement"
  sql_table_name: DIM.PLACEMENT_DETAILS_BASE ;;

  dimension: market_code {
    type: string
    hidden: yes
    sql: 'Videology' ;;
  }

  dimension: account_executive_name {
    type: string
    view_label: "{% if _explore._name == 'auction_log' %}Seller Placement{% else %}Publisher{% endif %}"
    label: "Account Executive"
    description: "The name of the internal account executive for the publisher."
    sql: ${TABLE}.ACCOUNT_EXECUTIVE_NAME ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.account_executive_name
  }

  dimension: accounting_subsidiary_id {
    type: string
    hidden: yes
    sql: ${TABLE}.ACCOUNTING_SUBSIDIARY_ID ;;
  }

  dimension: audit_factor {
    type: string
    hidden: yes
    sql: ${TABLE}.AUDIT_FACTOR ;;
  }

  dimension: business_region {
    type: string
    view_label: "{% if _explore._name == 'auction_log' %}Seller Placement{% else %}Publisher{% endif %}"
    label: "Partner Business Region"
    description: "The business region of the publisher."
    sql: ${TABLE}.BUSINESS_REGION ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.business_region
  }

  dimension: business_region_id {
    type: string
    hidden: yes
    sql: ${TABLE}.BUSINESS_REGION_ID ;;
  }

  dimension: buy_source {
    type: string
    label: "Buy Source"
    sql: ${TABLE}.BUY_SOURCE ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.buy_source
  }

  dimension: buy_source_id {
    type: number
    label: "Buy Source ID"
    sql: ${TABLE}.BUY_SOURCE_ID ;;
    value_format_name: id
  }

  dimension: buy_source_6 {
    label: "Buy_Source_6"
    hidden: yes
    type: string
    sql: CASE ${publisher_platform_client_group_id}
         WHEN 6
            THEN 'Cadreon'
         ELSE 'Videology'
         END ;;
  }

  dimension: buy_type {
    type: string
    label: "Buy Type"
    description: "The manner in which we buy the inventory (guaranteed, passback, exchange, etc.)"
    sql: ${TABLE}.BUY_TYPE ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.buy_type
  }

  dimension: buy_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.BUY_TYPE_ID ;;
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

  dimension: contracting_party {
    type: string
    view_label: "{% if _explore._name == 'auction_log' %}Seller Placement{% else %}Publisher{% endif %}"
    label: "Contracting Party"
    description: "The name of the entity which contracted with the publisher."
    sql: ${TABLE}.CONTRACTING_PARTY ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.contracting_party
  }

  dimension: contracting_party_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CONTRACTING_PARTY_ID ;;
  }

  dimension: default_agency_fee {
    type: string
    label: "Publisher Agency Fee"
    hidden: yes
    sql: ${TABLE}.DEFAULT_AGENCY_FEE ;;
  }

  dimension: default_exchange_fee {
    type: string
    label: "Exchange Fee"
    description: "The percentage amount of the exchage fee."
    sql: ${TABLE}.DEFAULT_EXCHANGE_FEE ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.default_exchange_fee
  }

  dimension: delivery_cap {
    type: string
    hidden: yes
    sql: ${TABLE}.DELIVERY_CAP ;;
  }

  dimension: device_type {
    type: string
    label: "Placement Device Type"
    description: "The device type of the placement (PC, Mobile, etc.)"
    sql: ${TABLE}.DEVICE_TYPE ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.device_type
  }

  dimension: device_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.DEVICE_TYPE_ID ;;
  }

  dimension: format_type {
    type: string
    label: "Placement Format Type"
    description: "The format of the placement (Digital Video, Display, Linear TV, etc.)."
    sql: ${TABLE}.FORMAT_TYPE ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.format_type
  }

  dimension: format_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.FORMAT_TYPE_ID ;;
  }

  dimension: has_click_ping {
    type: yesno
    hidden: yes
    sql: ${TABLE}.HAS_CLICK_PING ;;
  }

  dimension: has_end_ping {
    type: yesno
    hidden: yes
    sql: ${TABLE}.HAS_END_PING ;;
  }

  dimension: has_quartile_pings {
    type: yesno
    hidden: yes
    sql: ${TABLE}.HAS_QUARTILE_PINGS ;;
  }

  dimension: has_whitelist {
    type: yesno
    label: "Has Whitelist"
    description: "Dimension is used to identify domains that have been whitelisted"
    sql: ${TABLE}.HAS_WHITELIST ;;
  }

  dimension: inventory_parent {
    type: string
    hidden: yes
    sql: ${TABLE}.INVENTORY_PARENT ;;
  }

  dimension: inventory_source_description {
    type: string
    label: "Inventory Source"
    description: "The source of the inventory.  This is typically the name of the exchange."
    sql: case when ${TABLE}.INVENTORY_SOURCE_DESCRIPTION is null then 'Direct Tags' else ${TABLE}.INVENTORY_SOURCE_DESCRIPTION end  ;;
    drill_fields: [partner_name,placement_name]
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.inventory_source_description
  }

  dimension: inventory_source_id {
    type: string
    label: "Inventory Source ID"
    sql: ${TABLE}.INVENTORY_SOURCE_ID ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.inventory_source_id
  }

  dimension: inventory_source_type {
    type: string
    hidden: yes
    sql: ${TABLE}.INVENTORY_SOURCE_TYPE ;;
  }

  dimension: inventory_type {
    type: string
    hidden: yes
    sql: ${TABLE}.INVENTORY_TYPE ;;
  }

  dimension: inventory_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.INVENTORY_TYPE_ID ;;
  }

  dimension: site_id {
    type: number
    hidden: yes
    sql: CASE
          WHEN 1 > 0
             THEN NULL
          ELSE 1
          END ;;
  }

  dimension: site_name {
    type: number
    hidden: yes
    sql: CASE
          WHEN 1 > 0
             THEN NULL
          ELSE 1
          END ;;
  }

  dimension: is_matchbuy {
    type: yesno
    label: "Matchbuy"
    description: "Method in which campaigns are decisioned"
    sql: ${TABLE}.IS_MATCHBUY ;;
  }

  dimension: is_network_served {
    type: yesno
    hidden: yes
    sql: ${TABLE}.IS_NETWORK_SERVED ;;
  }

  dimension: is_test_placement {
    type: yesno
    label: "Test Placement"
    description: "A yes/no indicator if the placement is a test placement."
    sql: ${TABLE}.IS_TEST_PLACEMENT ;;
  }

  dimension: is_videology_stats_billing {
    type: yesno
    hidden: yes
    sql: ${TABLE}.IS_VIDEOLOGY_STATS_BILLING ;;
  }

  dimension: is_vmx_placement {
    type: yesno
    hidden: yes
    sql: ${TABLE}.IS_VMX_PLACEMENT ;;
  }

  dimension: liability {
    type: yesno
    label: "Liability"
    description: "A yes/no indicator if the company has payment liablity."
    sql: ${TABLE}.LIABILITY ;;
  }

  dimension: long_placement_name {
    type: string
    label: "Long Name"
    description: "The long placement name."
    sql: ${TABLE}.LONG_PLACEMENT_NAME ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.long_placement_name
  }

  dimension: partner_country {
    type: string
    view_label: "{% if _explore._name == 'auction_log' %}Seller Placement{% else %}Publisher{% endif %}"
    label: "Publisher Country"
    description: "The country of the office of the publisher."
    sql: ${TABLE}.PARTNER_COUNTRY ;;
    drill_fields: [partner_name,placement_name]
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.partner_country
  }

  dimension: partner_country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PARTNER_COUNTRY_ID ;;
  }

  dimension: partner_id {
    type: number
    view_label: "{% if _explore._name == 'auction_log' %}Seller Placement{% else %}Publisher{% endif %}"
    label: "Publisher ID"
    description: "The internal identifier of the Publisher"
    sql: ${TABLE}.PARTNER_ID ;;
    value_format_name: id
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.partner_id
  }

  dimension: partner_name {
    type: string
    view_label: "{% if _explore._name == 'auction_log' %}Seller Placement{% else %}Publisher{% endif %}"
    label: "Publisher"
    description: "The name of the Publisher."
    sql: CASE WHEN ${transparency_type_id} = 1 THEN ${TABLE}.PARTNER_NAME ELSE CONCAT('partner - ',  ${partner_id} * 2) END ;;
    drill_fields: [placement_name]
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.partner_name
  }

  dimension: partner_name_transparent {
    type:  string
    view_label: "{% if _explore._name == 'auction_log' %}Seller Placement{% else %}Publisher{% endif %}"
    label: "Publisher Transparent"
    description: "The name of the partner if placement is transparent. 'partner - ' + partner_id * 2 otherwise"
    sql: CASE WHEN ${transparency_type_id} = 1 or 5 THEN ${partner_name} ELSE 'Non-Transparent Partner Stats' END ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.partner_name_transparent
  }

  measure: count_of_publishers {
    type: number
    label: "Count of Publishers"
    view_label: "{% if _explore._name == 'auction_log' %}Seller Placement{% else %}Publisher{% endif %}"
    description: "The distinct count of Publishers."
    sql: count(distinct ${partner_id}) ;;
  }

  dimension: partner_office {
    type: string
    view_label: "{% if _explore._name == 'auction_log' %}Seller Placement{% else %}Publisher{% endif %}"
    label: "Publisher Office"
    description: "The location of the office of the publisher."
    sql: ${TABLE}.PARTNER_OFFICE ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.partner_office
  }

  dimension: partner_office_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PARTNER_OFFICE_ID ;;
  }

  dimension: partner_timezone_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PARTNER_TIMEZONE_ID ;;
  }

  dimension: passback_allowed {
    type: yesno
    hidden: yes
    sql: ${TABLE}.PASSBACK_ALLOWED ;;
  }

  dimension: placement_active {
    type: yesno
    label: "Placement Active"
    description: "A yes/no indicator if the placement is currently active."
    sql: ${TABLE}.PLACEMENT_ACTIVE ;;
  }

  dimension: placement_alias {
    type: string
    label: "Placement Alias"
    description: "An alias name used for the placement when the real name can't be displayed."
    sql: coalesce(${TABLE}.PLACEMENT_ALIAS, ${TABLE}.PLACEMENT_NAME) ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.placement_alias
  }

  dimension: placement_country {
    type: string
    label: "Placement Country"
    description: "The country of the placement, which may or may not be the country of the publisher."
    sql: ${TABLE}.PLACEMENT_COUNTRY ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.placement_country
  }

  dimension: placement_country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLACEMENT_COUNTRY_ID ;;
  }

  dimension: placement_id {
    type: number
    label: "Placement ID"
    description: "The internal identifier of the placement."
    sql: ${TABLE}.PLACEMENT_ID ;;
    value_format_name: id
  }

  measure: count_of_placements {
    type: number
    label: "Count of Placements"
    description: "The distinct count of Placements."
    sql: count(distinct ${placement_id}) ;;
  }

  dimension: placement_integration_type {
    type: string
    label: "Placement Integration"
    description: "The manner in which the integration with the placement is handeled (VAST 2.0, VPAID, etc.)"
    sql: ${TABLE}.PLACEMENT_INTEGRATION_TYPE ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.placement_integration_type
  }

  dimension: placement_integration_type_id {
    type: string
    hidden: no
    description: "The internal unique identifier of the Placement Integration type."
    sql: ${TABLE}.PLACEMENT_INTEGRATION_TYPE_ID ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.placement_integration_type_id
  }

  dimension: placement_inventory_medium_type {
    type: string
    hidden: yes
    sql: ${TABLE}.PLACEMENT_INVENTORY_MEDIUM_TYPE ;;
  }

  dimension: placement_inventory_medium_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PLACEMENT_INVENTORY_MEDIUM_TYPE_ID ;;
  }

  dimension: placement_inventory_type {
    type: string
    label: "Placement Inventory Type"
    description: "The inventory type of the placement (Network, Exchange, Publisher Private Marketplace, etc.)."
    sql: ${TABLE}.PLACEMENT_INVENTORY_TYPE ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.placement_inventory_type
  }

  dimension: placement_inventory_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PLACEMENT_INVENTORY_TYPE_ID ;;
  }

  dimension: placement_is_paused {
    type: yesno
    hidden: yes
    sql: ${TABLE}.PLACEMENT_IS_PAUSED ;;
  }

  dimension: placement_name {
    type: string
    label: "Placement"
    description: "The name of the placement."
    sql: ${TABLE}.PLACEMENT_NAME ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.placement_name
  }

  dimension: placement_name_transparent {
    type:  string
    view_label: "{% if _explore._name == 'auction_log' %}Seller Placement{% else %}Placement{% endif %}"
    label: "Placement Transparent"
    description: "The name of the placement if it is transparent. Non-Transparent Placement Stats otherwise"
    sql: CASE WHEN ${transparency_type_id} = 1 or 5 THEN ${placement_name} ELSE 'Non-Transparent Placement Stats' END ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.placement_name_transparent
  }

  dimension: placement_quality {
    type: string
    label: "Placement Quality"
    description: "The quality of the placement (Prime, Pulse, Open, etc.)."
    sql: ${TABLE}.PLACEMENT_QUALITY ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.placement_quality
  }

  dimension: placement_quality_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PLACEMENT_QUALITY_ID ;;
  }

  dimension: placement_site_genre {
    type: string
    label: "Site Genre"
    description: "Genre associated with the Placement."
    sql: ${TABLE}.PLACEMENT_SITE_GENRE ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.placement_site_genre
  }

  dimension: placement_site_genre_id {
    type: string
    label: "Site Genre ID"
    description: "Unique identifer of the Site Genre."
    sql: ${TABLE}.PLACEMENT_SITE_GENRE_ID ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.placement_site_genre_id
  }

  dimension: placement_status {
    type: string
    sql: CASE WHEN ${placement_status_id} = 1 THEN 'Active' WHEN ${placement_status_id} <> 1 THEN 'Paused' END ;;
    suggestions: ["Active", "Paused"]
  }

  dimension: placement_status_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PLACEMENT_STATUS_ID ;;
  }

  dimension: placement_timezone_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLACEMENT_TIMEZONE_ID ;;
  }

  dimension: placement_type {
    type: string
    label: "Placement Type"
    description: "The type of placement (Cheap, Medium Priced, Expensive, RTB, etc.)."
    sql: ${TABLE}.PLACEMENT_TYPE ;;
    drill_fields: [placement_name]
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.placement_type
  }

  dimension: placement_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PLACEMENT_TYPE_ID ;;
  }

  dimension: placement_utc_offset {
    type: string
    label: "Placement UTC Offset"
    sql: ${TABLE}.PLACEMENT_UTC_OFFSET ;;
  }

  dimension: platform_client {
    type: string
    view_label: "Supply Platform Client"
    label: "Supply Platform Client"
    description: "The platform client name of the supply partner."
    sql: ${TABLE}.PLATFORM_CLIENT ;;
    drill_fields: [partner_name, placement_name]
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.platform_client
  }

  dimension: platform_client_xaxis {
    type: string
    view_label: "Custom Dimensions"
    label: "Supply Platform Client"
    description: "Supply Platform Client = 'Videology' when Supply Platform Client is not Xaxis-Self Service"
    sql: CASE WHEN ${TABLE}.PLATFORM_CLIENT != 'Xaxis Self-Service' THEN 'Videology'
         ELSE ${TABLE}.PLATFORM_CLIENT END ;;
    suggestions: ["Videology", "Xaxis Self-Service"]
  }

  measure: count_of_supply_platform_clients {
    type: number
    view_label: "Supply Platform Client"
    label: "Count of Platform Clients"
    description: "The distinct count of Supply Platform Clients."
    sql: count(distinct ${platform_client_id}) ;;
  }

  dimension: platform_client_id {
    type: number
    view_label: "Supply Platform Client"
    label: "Supply Platform Client ID"
    description: "The platform client id of the supply partner."
    sql: ${TABLE}.PLATFORM_CLIENT_ID ;;
    value_format_name: id
  }

  dimension: platform_client_is_publisher {
    type: string
    hidden: yes
    sql: ${TABLE}.PLATFORM_CLIENT_IS_PUBLISHER ;;
  }

  dimension: preferred_currency {
    type: string
    hidden: yes
    sql: ${TABLE}.PREFERRED_CURRENCY ;;
  }

  dimension: preferred_currency_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PREFERRED_CURRENCY_ID ;;
  }

  dimension: publisher_group {
    type: string
    label: "Publisher Group"
    view_label: "{% if _explore._name == 'auction_log' %}Seller Placement{% else %}Publisher{% endif %}"
    description: "A grouping of publisher that are the same entity but have different publishers in the system."
    sql: ${TABLE}.PUBLISHER_GROUP ;;
    drill_fields: [partner_name, placement_name]
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.publisher_group
  }

  dimension: publisher_group_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PUBLISHER_GROUP_ID ;;
  }

  dimension: publisher_platform_client_group {
    type: string
    view_label: "Supply Platform Client"
    label: "Supply Platform Client Group"
    description: "A grouping of supply platform clients."
    sql: ${TABLE}.PUBLISHER_PLATFORM_CLIENT_GROUP ;;
    drill_fields: [platform_client, partner_name, placement_name]
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.publisher_platform_client_group
  }

  dimension: publisher_platform_client_group_id {
    type: string
    label: "Supply Platform Client Group ID"
    view_label: "{% if _explore._name == 'auction_log' %}Supply Platform Client{% endif %}"
    sql: ${TABLE}.PUBLISHER_PLATFORM_CLIENT_GROUP_ID ;;
  }

  dimension: publisher_utc_offset {
    type: string
    hidden: yes
    sql: ${TABLE}.PUBLISHER_UTC_OFFSET ;;
  }

  dimension: region_currency {
    type: string
    hidden: yes
    sql: ${TABLE}.REGION_CURRENCY ;;
  }

  dimension: region_currency_id {
    type: string
    hidden: yes
    sql: ${TABLE}.REGION_CURRENCY_ID ;;
  }

  dimension: region_utc_offset {
    type: string
    hidden: yes
    sql: ${TABLE}.REGION_UTC_OFFSET ;;
  }

  dimension: skippable {
    type: string
    label: "Is Skippable (Yes/No)"
    description: "Yes/No indicator if placement is skippable"
    sql: ${TABLE}.SKIPPABLE;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.skippable
  }

  dimension: transparency_type {
    type: string
    label: "Transparency Type"
    description: "Indicates if/how the placement name can be shown in reporting."
    sql: ${TABLE}.TRANSPARENCY_TYPE ;;
    suggest_explore: suggest_supply_ref
    suggest_dimension: suggest_supply_ref.transparency_type
  }

  dimension: transparency_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.TRANSPARENCY_TYPE_ID ;;
  }

  dimension: vmm_biddable_placement_id {
    type: string
    hidden: yes
    sql: ${TABLE}.VMM_BIDDABLE_PLACEMENT_ID ;;
  }

  dimension: whiteops_selection_type {
    label: "Fraud Selection Type"
    type: string
    sql:
      CASE WHEN ${TABLE}.ENABLE_DOUBLE_VERIFY_PREBID THEN 'On'
      ELSE 'Off' END;;
    suggestions: ["On", "Off"]
  }

  dimension: whiteops_selection_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.WHITEOPS_SELECTION_TYPE_ID ;;
  }

  dimension: tier {
    type: number
    label: "Placement Tier"
    description: "Supply Quality Rating"
    sql: ${TABLE}.TIER ;;
  }

  dimension: is_pod {
    type: yesno
    label: "Is AdPod"
    description: "Yes/No indicator if placement is adpod"
    sql:  ${TABLE}.is_pod ;;
  }

  dimension: fallback_type_id {
    type: number
    label: "Fallback Type ID"
    description: "Fallback Type ID"
    sql: ${TABLE}.fallback_type_id ;;
    value_format_name: id
  }

  measure: max_fallback_type_id {
    type: max
    label: "Max Fallback Type ID"
    description: "Fallback Type ID"
    sql: ${TABLE}.fallback_type_id ;;
  }

  dimension: pod_duration {
    type: number
    label: "Ad Pod Duration"
    description: "Duration of the Ad Pod segment, in seconds."
    sql: ${TABLE}.pod_duration ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: default_min_cpm {
    type: number
    label: "Default Min CPM"
    sql: ${TABLE}.DEFAULT_MIN_CPM ;;
  }

  dimension: partner {
    type: string
    hidden: yes
    sql:  CASE
          WHEN ${placement_inventory_type} IN (
               'Private Exchange',
               'Exchange')
               THEN ${partner_name}
          ELSE 'Publisher-' || CAST((${partner_id} * 2) AS VARCHAR)
          END;;
  }

  dimension: partnerid {
    type: string
    hidden: yes
    sql: CASE
        WHEN ${placement_inventory_type} IN (
            'Private Exchange'
            ,'Exchange')
              THEN ${partner_id}
        ELSE (${partner_id} * 2)
        END;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      placement_name,
      long_placement_name,
      partner_name,
      account_executive_name,
      placement_status.placement_status_id,
      placement_inventory_type.placement_inventory_type_id,
      platform_client.platform_client_id,
      platform_client.platform_type_name,
      platform_client.office_name,
      placement_integration_type.placement_integration_type_id
    ]
  }
}
