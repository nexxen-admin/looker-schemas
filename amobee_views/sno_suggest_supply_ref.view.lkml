view: suggest_supply_ref {
  derived_table: {
    sql:  select
            pd.account_executive_name,
            pd.business_region,
            pd.buy_source,
            pd.buy_type,
            pd.contracting_party,
            pd.default_exchange_fee,
            pd.device_type,
            pd.format_type,
            pd.inventory_source_description,
            pd.inventory_source_id,
            pd.long_placement_name,
            pd.partner_country,
            pd.partner_id,
            pd.partner_name,
            pd.partner_office,
            pd.placement_alias,
            pd.placement_country,
            pd.placement_country_id,
            pd.placement_integration_type,
            pd.placement_integration_type_id,
            pd.placement_inventory_type,
            pd.placement_name,
            pd.placement_quality,
            pd.placement_site_genre,
            pd.placement_site_genre_id,
            pd.placement_type,
            pd.platform_client_id,
            pd.platform_client,
            pd.publisher_group,
            pd.publisher_platform_client_group,
            pd.skippable,
            pd.transparency_type,
            pd.transparency_type_id,
            CASE WHEN pd.placement_inventory_type IN('Private Exchange', 'Exchange') THEN pd.placement_name ELSE CONCAT('Placement - ', pd.placement_id) END as conversion_placement_name
          from
            dim.placement_details_base pd ;;
  }

  dimension: account_executive_name {
    type: string
    sql: ${TABLE}.ACCOUNT_EXECUTIVE_NAME ;;
  }

  dimension: business_region {
    type: string
    sql: ${TABLE}.BUSINESS_REGION ;;
  }

  dimension: buy_source {
    type: string
    sql: ${TABLE}.BUY_SOURCE ;;
  }

  dimension: buy_type {
    type: string
    sql: ${TABLE}.BUY_TYPE ;;
  }

  dimension: contracting_party {
    type: string
    sql: ${TABLE}.CONTRACTING_PARTY ;;
  }

  dimension: default_exchange_fee {
    type: string
    sql: ${TABLE}.DEFAULT_EXCHANGE_FEE ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.DEVICE_TYPE ;;
  }

  dimension: format_type {
    type: string
    sql: ${TABLE}.FORMAT_TYPE ;;
  }

  dimension: inventory_source_description {
    type: string
    sql: case when ${TABLE}.INVENTORY_SOURCE_DESCRIPTION is null then 'Direct Tags' else ${TABLE}.INVENTORY_SOURCE_DESCRIPTION end ;;
  }

  dimension: inventory_source_id {
    type: string
    sql: ${TABLE}.INVENTORY_SOURCE_ID ;;
  }

  dimension: long_placement_name {
    type: string
    sql: ${TABLE}.LONG_PLACEMENT_NAME ;;
  }

  dimension: partner_country {
    type: string
    sql: ${TABLE}.PARTNER_COUNTRY ;;
  }

  dimension: partner_id {
    type: string
    sql: ${TABLE}.PARTNER_ID ;;
  }

  dimension: partner_name {
    type: string
    sql: ${TABLE}.PARTNER_NAME ;;
  }

  dimension: partner_name_transparent {
    type: string
    sql: CASE WHEN ${transparency_type_id} = 1 THEN ${partner_name} ELSE 'Non-Transparent Partner Stats' END ;;
  }

  dimension: partner_office {
    type: string
    sql: ${TABLE}.PARTNER_OFFICE ;;
  }

  dimension: placement_alias {
    type: string
    sql: ${TABLE}.PLACEMENT_ALIAS ;;
  }

  dimension: placement_country {
    type: string
    sql: ${TABLE}.PLACEMENT_COUNTRY ;;
  }

  dimension: placement_country_id {
    type: number
    sql: ${TABLE}.PLACEMENT_COUNTRY_ID ;;
    value_format_name: id
  }

  dimension: placement_integration_type {
    type: string
    sql: ${TABLE}.PLACEMENT_INTEGRATION_TYPE ;;
  }

  dimension: placement_integration_type_id {
    type: string
    sql: ${TABLE}.PLACEMENT_INTEGRATION_TYPE_ID ;;
  }

  dimension: placement_inventory_type {
    type: string
    sql: ${TABLE}.PLACEMENT_INVENTORY_TYPE ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.PLACEMENT_NAME ;;
  }

  dimension: placement_name_transparent {
    type: string
    sql: CASE WHEN ${transparency_type_id} = 1 THEN ${placement_name} ELSE 'Non-Transparent Placement Stats' END ;;
  }

  dimension: placement_quality {
    type: string
    sql: ${TABLE}.PLACEMENT_QUALITY ;;
  }

  dimension: placement_site_genre {
    type: string
    sql: ${TABLE}.PLACEMENT_SITE_GENRE ;;
  }

  dimension: placement_site_genre_id {
    type: string
    sql: ${TABLE}.PLACEMENT_SITE_GENRE_ID ;;
  }

  dimension: placement_type {
    type: string
    sql: ${TABLE}.PLACEMENT_TYPE ;;
  }

  dimension: platform_client_id {
    type: number
    sql: ${TABLE}.PLATFORM_CLIENT_ID ;;
    value_format_name: id
  }

  dimension: platform_client {
    type: string
    sql: ${TABLE}.PLATFORM_CLIENT ;;
  }

  dimension: publisher_group {
    type: string
    sql: ${TABLE}.PUBLISHER_GROUP ;;
  }

  dimension: publisher_platform_client_group {
    type: string
    sql: ${TABLE}.PUBLISHER_PLATFORM_CLIENT_GROUP ;;
  }

  dimension: skippable {
    type: string
    sql: ${TABLE}.SKIPPABLE ;;
  }

  dimension: transparency_type {
    type: string
    sql: ${TABLE}.TRANSPARENCY_TYPE ;;
  }

  dimension: transparency_type_id {
    type: string
    sql: ${TABLE}.TRANSPARENCY_TYPE_ID ;;
  }

  dimension: conversion_placement_name {
    type: string
    sql: ${TABLE}.CONVERSION_PLACEMENT_NAME ;;
  }
}
