view: v_deal_flight_media_details {
  label: "Deal Flight Media Details"
  sql_table_name: DIM.DEAL_FLIGHT_MEDIA_DETAILS_VIEW ;;

  dimension: active {
    type: yesno
    label: "Active"
    view_label: "Deal Flight Media"
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: ad_url {
    type: string
    hidden: yes
    sql: ${TABLE}.AD_URL ;;
  }

  dimension: advertiser_brand_id {
    type: number
    sql: ${TABLE}.ADVERTISER_BRAND_ID ;;
    value_format_name: id
  }

  dimension: bidder_id {
    type: number
    sql: ${TABLE}.BIDDER_ID ;;
    value_format_name: id
  }

  dimension: brand_url {
    type: string
    sql: ${TABLE}.BRAND_URL ;;
  }

  dimension: buyer_advertiser_name {
    type: string
    sql: ${TABLE}.BUYER_ADVERTISER_NAME ;;
  }

  dimension: buyer_brand_name {
    type: string
    sql: ${TABLE}.BUYER_BRAND_NAME ;;
  }

  dimension: buyer_customer_name {
    type: string
    sql: ${TABLE}.BUYER_CUSTOMER_NAME ;;
  }

  dimension: buyer_flight_media_id {
    type: number
    sql: ${TABLE}.BUYER_FLIGHT_MEDIA_ID ;;
    value_format_name: id
  }

  dimension: buyer_media_id {
    type: number
    sql: ${TABLE}.BUYER_MEDIA_ID ;;
    value_format_name: id
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.CAMPAIGN_ID ;;
    value_format_name: id
  }

  dimension: campaign_type {
    type: string
    sql: ${TABLE}.CAMPAIGN_TYPE ;;
  }

  dimension: change_source {
    type: string
    sql: ${TABLE}.CHANGE_SOURCE ;;
  }

  dimension: changedby {
    type: string
    sql: ${TABLE}.CHANGEDBY ;;
  }

  dimension: changedon {
    type: string
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: createdby {
    type: string
    sql: ${TABLE}.CREATEDBY ;;
  }

  dimension: createdon {
    type: string
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: deal_media_id {
    type: number
    sql: ${TABLE}.DEAL_MEDIA_ID ;;
    value_format_name: id
  }

  dimension: deal_term_description {
    type: string
    sql: ${TABLE}.DEAL_TERM_DESCRIPTION ;;
  }

  dimension: external_buyer_media_id {
    type: string
    label: "External Buyer Media ID"
    sql: ${TABLE}.EXTERNAL_BUYER_MEDIA_ID ;;
  }

  dimension: is_house {
    type: yesno
    sql: ${TABLE}.IS_HOUSE ;;
  }

  dimension: placement_id {
    type: number
    sql: ${TABLE}.PLACEMENT_ID ;;
    value_format_name: id
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.PLATFORM ;;
  }

  dimension: seller_advertiser_name {
    type: string
    sql: ${TABLE}.SELLER_ADVERTISER_NAME ;;
  }

  dimension: seller_brand_name {
    type: string
    sql: ${TABLE}.SELLER_BRAND_NAME ;;
  }

  dimension: seller_customer_name {
    type: string
    sql: ${TABLE}.SELLER_CUSTOMER_NAME ;;
  }

  dimension: seller_flight_media_id {
    type: number
    sql: ${TABLE}.SELLER_FLIGHT_MEDIA_ID ;;
    value_format_name: id
  }

  dimension: seller_industry_segment {
    type: string
    sql: ${TABLE}.SELLER_INDUSTRY_SEGMENT ;;
  }

  dimension: seller_media_id {
    type: number
    sql: ${TABLE}.SELLER_MEDIA_ID ;;
    value_format_name: id
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      seller_customer_name,
      seller_advertiser_name,
      seller_brand_name,
      buyer_customer_name,
      buyer_advertiser_name,
      buyer_brand_name
    ]
  }
}
