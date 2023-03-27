view: aur_placement_details {
  sql_table_name: dim.placement_details ;;
  label: "Placement"


  dimension: placement_id {
    primary_key: yes
    type: number
    label: "Placement ID"
    description: "The internal identifier of the placement."
    sql: ${TABLE}.placement_id ;;
    value_format_name: id
  }

  dimension: account_executive_name {
    type: string
    view_label: "Publisher"
    label: "Account Executive"
    description: "The name of the internal account executive for the publisher."
    sql: ${TABLE}.account_executive_name ;;
  }

  dimension: accounting_subsidiary_id {
    type: number
    hidden: yes
    sql: ${TABLE}.accounting_subsidiary_id ;;
  }

  dimension: audit_factor {
    type: number
    hidden: yes
    sql: ${TABLE}.audit_factor ;;
  }

  dimension: business_region {
    type: string
    view_label: "Publisher"
    label: "Partner Business Region"
    description: "The business region of the publisher."
    sql: ${TABLE}.business_region ;;
  }

  dimension: business_region_id {
    type: number
    hidden: yes
    sql: ${TABLE}.business_region_id ;;
  }

  dimension: buy_source {
    type: string
    label: "Buy Source"
    sql: ${TABLE}.buy_source ;;
  }

  dimension: buy_source_id {
    type: number
    label: "Buy Source ID"
    sql: ${TABLE}.buy_source_id ;;
    value_format_name: id
  }

  dimension: buy_type {
    type: string
    label: "Buy Type"
    description: "The manner in which we buy the inventory (guaranteed, passback, exchange, etc.)"
    sql: ${TABLE}.buy_type ;;
  }

  dimension: buy_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.buy_type_id ;;
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
    hidden: yes
    sql: ${TABLE}.changedon ;;
  }

  dimension: contracting_party {
    type: string
    view_label: "Publisher"
    label: "Contracting Party"
    description: "The name of the entity which contracted with the publisher."
    sql: ${TABLE}.contracting_party ;;
  }

  dimension: contracting_party_id {
    type: number
    hidden: yes
    sql: ${TABLE}.contracting_party_id ;;
  }

  dimension: default_agency_fee {
    type: number
    label: "Publisher Agency Fee"
    hidden: yes
    sql: ${TABLE}.default_agency_fee ;;
  }

  dimension: default_exchange_fee {
    type: number
    label: "Exchange Fee"
    description: "The percentage amount of the exchage fee."
    sql: ${TABLE}.default_exchange_fee ;;
  }

  dimension: delivery_cap {
    type: number
    hidden: yes
    sql: ${TABLE}.delivery_cap ;;
  }

  dimension: device_type {
    type: string
    label: "Placement Device Type"
    description: "The device type of the placement (PC, Mobile, etc.)"
    sql: ${TABLE}.device_type ;;
  }

  dimension: device_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.device_type_id ;;
  }

  dimension_group: end_datetime {
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
    hidden: yes
    sql: ${TABLE}.end_datetime ;;
  }

  dimension: fallback_type_id {
    type: yesno
    hidden: yes
    sql: ${TABLE}.fallback_type_id ;;
  }

  dimension: flight_name {
    type: string
    hidden: yes
    sql: ${TABLE}.flight_name ;;
  }

  dimension: flight_volume {
    type: number
    hidden: yes
    sql: ${TABLE}.flight_volume ;;
  }

  dimension: format_type {
    type: string
    label: "Placement Format Type"
    description: "The format of the placement (Digital Video, Display, Linear TV, etc.)."
    sql: ${TABLE}.format_type ;;
  }

  dimension: format_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.format_type_id ;;
  }

  dimension: has_click_ping {
    type: yesno
    hidden: yes
    sql: ${TABLE}.has_click_ping ;;
  }

  dimension: has_end_ping {
    type: yesno
    hidden: yes
    sql: ${TABLE}.has_end_ping ;;
  }

  dimension: has_quartile_pings {
    type: yesno
    hidden: yes
    sql: ${TABLE}.has_quartile_pings ;;
  }

  dimension: has_whitelist {
    type: yesno
    label: "Has Whitelist"
    description: "Dimension is used to identify domains that have been whitelisted"
    sql: ${TABLE}.has_whitelist ;;
  }

  dimension: inventory_parent {
    type: string
    hidden: yes
    sql: ${TABLE}.inventory_parent ;;
  }

  dimension: inventory_source_description {
    type: string
    label: "Inventory Source"
    description: "The source of the inventory. This is typically the name of the exchange."
    sql: case when ${TABLE}.inventory_source_description is null then 'Direct Tags' else ${TABLE}.inventory_source_description end ;;
  }

  dimension: inventory_source_id {
    type: number
    label: "Inventory source ID"
    sql: ${TABLE}.inventory_source_id ;;
  }

  dimension: inventory_source_type {
    type: string
    hidden: yes
    sql: ${TABLE}.inventory_source_type ;;
  }

  dimension: inventory_type {
    type: string
    hidden: yes
    sql: ${TABLE}.inventory_type ;;
  }

  dimension: inventory_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.inventory_type_id ;;
  }

  dimension: is_matchbuy {
    type: yesno
    label: "Matchbuy"
    description: "Method in which campaigns are decisioned"
    sql: ${TABLE}.is_matchbuy ;;
  }

  dimension: is_network_served {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_network_served ;;
  }

  dimension: is_test_placement {
    type: yesno
    label: "Test Placement"
    description: "A yes/no indicator if the placement is a test placement."
    sql: ${TABLE}.is_test_placement ;;
  }

  dimension: is_videology_stats_billing {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_videology_stats_billing ;;
  }

  dimension: is_vmx_placement {
    type: yesno
    hidden: yes
    sql: ${TABLE}.is_vmx_placement ;;
  }

  dimension: liability {
    type: yesno
    label: "Liability"
    description: "A yes/no indicator if the company has payment liablity."
    sql: ${TABLE}.liability ;;
  }

  dimension: long_placement_name {
    type: string
    label: "Long Name"
    description: "The long placement name."
    sql: ${TABLE}.long_placement_name ;;
  }

  dimension: partner_country {
    type: string
    view_label: "Publisher"
    label: "Publisher Country"
    description: "The country of the office of the publisher."
    sql: ${TABLE}.partner_country ;;
  }

  dimension: partner_country_id {
    type: number
    sql: ${TABLE}.partner_country_id ;;
    value_format_name: id
  }

  dimension: partner_id {
    type: number
    view_label: "Publisher"
    label: "Publisher ID"
    description: "The internal identifier of the Publisher"
    sql: ${TABLE}.partner_id ;;
    value_format_name: id
  }

  measure: count_of_publishers {
    type: number
    label: "Count of Publishers"
    view_label: "Publisher"
    description: "The distinct count of Publishers."
    sql: count(distinct ${partner_id}) ;;
  }


  dimension: partner_name {
    type: string
    view_label: "Publisher"
    label: "Publisher"
    description: "The name of the Publisher."
    sql: ${TABLE}.partner_name ;;
  }

  dimension: partner_office {
    type: string
    view_label: "Publisher"
    label: "Publisher Office"
    description: "The location of the office of the publisher."
    sql: ${TABLE}.partner_office ;;
  }

  dimension: partner_office_id {
    type: number
    hidden: yes
    sql: ${TABLE}.partner_office_id ;;
  }

  dimension: partner_timezone_id {
    type: number
    hidden: yes
    sql: ${TABLE}.partner_timezone_id ;;
  }

  dimension: passback_allowed {
    type: yesno
    hidden: yes
    sql: ${TABLE}.passback_allowed ;;
  }

  dimension: placement_active {
    type: yesno
    label: "Placement Active"
    description: "A yes/no indicator if the placement is currently active."
    sql: ${TABLE}.placement_active ;;
  }

  dimension: placement_alias {
    type: string
    label: "Placement Alias"
    description: "An alias name used for the placement when the real name can't be displayed."
    sql: ${TABLE}.placement_alias ;;
  }

  dimension: placement_country {
    type: string
    label: "Placement Country"
    description: "The country of the placement, which may or may not be the country of the publisher."
    sql: ${TABLE}.placement_country ;;
  }

  measure: count_of_placements {
    type: number
    label: "Count of Placements"
    description: "The distinct count of Placements."
    sql: count(distinct ${placement_id}) ;;
  }

  dimension: placement_country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_country_id ;;
  }

  dimension: placement_integration_type {
    type: string
    label: "Placement Integration"
    description: "The manner in which the integration with the placement is handeled (VAST 2.0, VPAID, etc.)"
    sql: ${TABLE}.placement_integration_type ;;
  }

  dimension: placement_integration_type_id {
    type: number
    label: "Placement Integration Type ID"
    description: "The internal unique identifier of the Placement Integration type."
    sql: ${TABLE}.placement_integration_type_id ;;
    value_format_name: id
  }

  dimension: placement_inventory_medium_type {
    type: string
    hidden: yes
    sql: ${TABLE}.placement_inventory_medium_type ;;
  }

  dimension: placement_inventory_medium_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_inventory_medium_type_id ;;
  }

  dimension: placement_inventory_type {
    type: string
    label: "Placement Inventory Type"
    description: "The inventory type of the placement (Network, Exchange, Publisher Private Marketplace, etc.)."
    sql: ${TABLE}.placement_inventory_type ;;
  }

  dimension: placement_inventory_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_inventory_type_id ;;
  }

  dimension: placement_is_paused {
    type: yesno
    hidden: yes
    sql: ${TABLE}.placement_is_paused ;;
  }

  dimension: placement_name {
    type: string
    label: "Placement"
    description: "The name of the placement."
    sql: ${TABLE}.placement_name ;;
  }

  dimension: placement_quality {
    type: string
    label: "Placement Quality"
    description: "The quality of the placement (Prime, Pulse, Open, etc.)."
    sql: ${TABLE}.placement_quality ;;
  }

  dimension: placement_quality_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_quality_id ;;
  }

  dimension: placement_site_genre {
    type: string
    label: "Site Genre"
    description: "Genre associated with the Placement."
    sql: ${TABLE}.placement_site_genre ;;
  }

  dimension: placement_site_genre_id {
    type: number
    label: "Site Genre ID"
    description: "Unique identifer of the Site Genre."
    sql: ${TABLE}.placement_site_genre_id ;;
    value_format_name: id
  }

  dimension: placement_status {
    type: string
    sql: CASE WHEN ${placement_status_id} = 1 THEN 'Active' WHEN ${placement_status_id} <> 1 THEN 'Paused' END ;;
    suggestions: ["Active", "Paused"]
  }

  dimension: placement_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_status_id ;;
  }

  dimension: placement_timezone_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_timezone_id ;;
  }

  dimension: placement_type {
    type: string
    label: "Placement Type"
    description: "The type of placement (Cheap, Medium Priced, Expensive, RTB, etc.)."
    sql: ${TABLE}.placement_type ;;
  }

  dimension: placement_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_type_id ;;
  }

  dimension: placement_utc_offset {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_utc_offset ;;
  }

  dimension: platform_client {
    type: string
    view_label: "Supply Platform Client"
    label: "Supply Platform Client"
    description: "The platform client name of the supply partner."
    sql: ${TABLE}.platform_client ;;
    drill_fields: [partner_name, placement_name]
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
    sql: ${TABLE}.platform_client_id ;;
    value_format_name: id
  }

  dimension: platform_client_is_publisher {
    type: string
    hidden: yes
    sql: ${TABLE}.platform_client_is_publisher ;;
  }

  dimension: preferred_currency {
    type: string
    hidden: yes
    sql: ${TABLE}.preferred_currency ;;
  }

  dimension: preferred_currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.preferred_currency_id ;;
  }

  dimension: publisher_group {
    type: string
    label: "Publisher Group"
    view_label: "Publisher"
    description: "A grouping of publisher that are the same entity but have different publishers in the system."
    sql: ${TABLE}.publisher_group ;;
  }

  dimension: publisher_group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.publisher_group_id ;;
  }

  dimension: publisher_platform_client_group {
    type: string
    view_label: "Supply Platform Client"
    label: "Supply Platform Client Group"
    description: "A grouping of supply platform clients."
    sql: ${TABLE}.publisher_platform_client_group ;;
  }

  dimension: publisher_platform_client_group_id {
    type: number
    label: "Platform Client Group ID"
    view_label: "Supply Platform Client"
    sql: ${TABLE}.publisher_platform_client_group_id ;;
    value_format_name: id
  }

  dimension: publisher_utc_offset {
    type: number
    hidden: yes
    sql: ${TABLE}.publisher_utc_offset ;;
  }

  dimension: region_currency {
    type: string
    hidden: yes
    sql: ${TABLE}.region_currency ;;
  }

  dimension: region_currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.region_currency_id ;;
  }

  dimension: region_utc_offset {
    type: number
    hidden: yes
    sql: ${TABLE}.region_utc_offset ;;
  }

  dimension: skippable {
    type: string
    label: "Is Skippable (Yes/No)"
    description: "Yes/No indicator if placement is skippable"
    sql: ${TABLE}.skippable ;;
  }

  dimension_group: start_datetime {
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
    hidden: yes
    sql: ${TABLE}.start_datetime ;;
  }

  dimension: transparency_type {
    type: string
    label: "Transparency Type"
    description: "Indicates if/how the placement name can be shown in reporting."
    sql: ${TABLE}.transparency_type ;;
  }

  dimension: transparency_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.transparency_type_id ;;
  }

  dimension: vmm_biddable_placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.vmm_biddable_placement_id ;;
  }

  dimension: whiteops_selection_type {
    type: string
    sql: ${TABLE}.whiteops_selection_type ;;
  }

  dimension: whiteops_selection_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.whiteops_selection_type_id ;;
  }

}
