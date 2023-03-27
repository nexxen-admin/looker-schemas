view: atv_placement_details {
  sql_table_name: druid.atv_placement_details ;;

  dimension_group: __time {
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
    sql: ${TABLE}."__time" ;;
  }

  dimension: buy_source_id {
    type: string
    sql: ${TABLE}."buy_source_id" ;;
  }

  dimension: can_access_cookie {
    type: string
    sql: ${TABLE}."can_access_cookie" ;;
  }

  dimension: count_atv_placement_details {
    type: number
    sql: ${TABLE}."count" ;;
  }

  dimension: created_on {
    type: string
    sql: ${TABLE}."created_on" ;;
  }

  dimension: data_cost_responsible_party {
    type: string
    sql: ${TABLE}."data_cost_responsible_party" ;;
  }

  dimension: default_exchange_feedouble {
    type: string
    sql: ${TABLE}."default_exchange_feedouble" ;;
  }

  dimension: device_type_id {
    type: string
    sql: ${TABLE}."device_type_id" ;;
  }

  dimension: format_type_id {
    type: string
    sql: ${TABLE}."format_type_id" ;;
  }

  dimension: has_end_ping {
    type: string
    sql: ${TABLE}."has_end_ping" ;;
  }

  dimension: has_quartile_pings {
    type: string
    sql: ${TABLE}."has_quartile_pings" ;;
  }

  dimension: partner_name {
    type: string
    sql: ${TABLE}."partner_name" ;;
  }

  dimension: passback_allowed {
    type: string
    sql: ${TABLE}."passback_allowed" ;;
  }

  dimension: placement_id {
    type: string
    sql: ${TABLE}."placement_id" ;;
  }

  dimension: placement_inventory_type_id {
    type: string
    sql: ${TABLE}."placement_inventory_type_id" ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}."placement_name" ;;
  }

  dimension: placement_status_id {
    type: string
    sql: ${TABLE}."placement_status_id" ;;
  }

  dimension: preferred_currency {
    type: string
    sql: ${TABLE}."preferred_currency" ;;
  }

  dimension: site_genre {
    type: string
    sql: ${TABLE}."site_genre" ;;
  }

  dimension: sum_buy_type_id {
    type: number
    sql: ${TABLE}."sum_buy_type_id" ;;
    value_format_name: id
  }

  dimension: sum_changed_on {
    type: number
    sql: ${TABLE}."sum_changed_on" ;;
  }

  dimension: sum_country_id {
    type: number
    sql: ${TABLE}."sum_country_id" ;;
    value_format_name: id
  }

  dimension: sum_exchange_transparency_level_id {
    type: number
    sql: ${TABLE}."sum_exchange_transparency_level_id" ;;
    value_format_name: id
  }

  dimension: sum_has_click_ping {
    type: number
    sql: ${TABLE}."sum_has_click_ping" ;;
  }

  dimension: sum_inventory_medium_type {
    type: number
    sql: ${TABLE}."sum_inventory_medium_type" ;;
  }

  dimension: sum_inventory_medium_type_id {
    type: number
    sql: ${TABLE}."sum_inventory_medium_type_id" ;;
    value_format_name: id
  }

  dimension: sum_is_matchbuy {
    type: number
    sql: ${TABLE}."sum_is_matchbuy" ;;
  }

  dimension: sum_is_network_served {
    type: number
    sql: ${TABLE}."sum_is_network_served" ;;
  }

  dimension: sum_ivt_detection_enabled {
    type: number
    sql: ${TABLE}."sum_ivt_detection_enabled" ;;
  }

  dimension: sum_partner_id {
    type: number
    sql: ${TABLE}."sum_partner_id" ;;
    value_format_name: id
  }

  dimension: sum_placement_inventory_type {
    type: number
    sql: ${TABLE}."sum_placement_inventory_type" ;;
  }

  dimension: sum_placement_type_id {
    type: number
    sql: ${TABLE}."sum_placement_type_id" ;;
    value_format_name: id
  }

  dimension: sum_platform_client_group_id {
    type: number
    sql: ${TABLE}."sum_platform_client_group_id" ;;
    value_format_name: id
  }

  dimension: sum_platform_client_id {
    type: number
    sql: ${TABLE}."sum_platform_client_id" ;;
    value_format_name: id
  }

  dimension: sum_publisher_group {
    type: number
    sql: ${TABLE}."sum_publisher_group" ;;
  }

  dimension: sum_region_currency {
    type: number
    sql: ${TABLE}."sum_region_currency" ;;
  }

  dimension: sum_site_genre_id {
    type: number
    sql: ${TABLE}."sum_site_genre_id" ;;
    value_format_name: id
  }

  dimension: sum_ssp_member {
    type: number
    sql: ${TABLE}."sum_ssp_member" ;;
  }

  dimension: sum_supply_utc_offset {
    type: number
    sql: ${TABLE}."sum_supply_utc_offset" ;;
  }

  dimension: sum_vendor_site_id {
    type: number
    sql: ${TABLE}."sum_vendor_site_id" ;;
    value_format_name: id
  }

  dimension: sum_vmm_biddable_placement_id {
    type: number
    sql: ${TABLE}."sum_vmm_biddable_placement_id" ;;
    value_format_name: id
  }

  dimension: supply_region_utc_offset {
    type: string
    sql: ${TABLE}."supply_region_utc_offset" ;;
  }

  dimension: sync_with_google {
    type: string
    sql: ${TABLE}."sync_with_google" ;;
  }

  measure: count {
    type: count
    drill_fields: [partner_name, placement_name]
  }
}
