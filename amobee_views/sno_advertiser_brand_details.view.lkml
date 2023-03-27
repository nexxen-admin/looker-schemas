view: advertiser_brand_details {
  label: "Brand"
  sql_table_name: DIM.ADVERTISER_BRAND_DETAILS ;;

  dimension: advertiser_brand_id {
    type: number
    label: "Brand ID"
    description: "The system ID of the Brand."
    sql: ${TABLE}.ADVERTISER_BRAND_ID ;;
    value_format_name: id
  }

  measure: count_of_Brands {
    type: number
    label: "Count of Brands"
    description: "The distinct count of Brands."
    sql: count(distinct ${advertiser_brand_id}) ;;
  }

  dimension: advertiser_createdon {
    type: date
    view_label: "Advertiser"
    label: "Advertiser Created Date"
    description: "The date the advertiser was created in the system."
    sql: ${TABLE}.ADVERTISER_CREATEDON ;;
  }

  dimension: dst_advertiser_createdon {
    type: date
    view_label: "Advertiser"
    label: "[DST] Advertiser Local Created Date"
    description: "The date the advertiser was created in the system in local time accounting DST."
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name} ,${TABLE}.ADVERTISER_CREATEDON)
      else ${TABLE}.ADVERTISER_CREATEDON end ;;
  }

  dimension: advertiser_id {
    type: number
    view_label: "Advertiser"
    label: "Advertiser ID"
    description: "The system ID of the Advertiser"
    sql: ${TABLE}.ADVERTISER_ID ;;
    value_format_name: id
  }

  measure: count_of_advertisers {
    type: number
    view_label: "Advertiser"
    label: "Count of Advertisers"
    description: "The distinct count of Advertisers."
    sql: count(distinct ${advertiser_id}) ;;
  }

  dimension: advertiser_name {
    type: string
    view_label: "Advertiser"
    label: "Advertiser"
    description: "The name of the Advertiser"
    sql: ${TABLE}.ADVERTISER_NAME;;
    drill_fields: [brand_name, campaign_details_base.campaign_name, flight_details.flight_description, flight_media_details_base.media_name, flight_media_details_base.flight_media_id ]
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.advertiser_name
  }

  dimension: brand_active {
    type: yesno
    label: "Brand is Active"
    description: "Yes/No indicator if the Brand is active."
    sql: ${TABLE}.BRAND_ACTIVE ;;
  }

  dimension: dst_brand_createdon {
    type: date
    label: "[DST] Brand Local Created Date"
    description: "The date the Brand was created in the system in local time accounting DST."
    sql: case when ${platform_client.use_daylight_saving} then convert_timezone('UTC', ${timezone.timezone_name} ,${TABLE}.BRAND_CREATEDON)
      else ${TABLE}.BRAND_CREATEDON end ;;
  }

  dimension: brand_createdon {
    type: date
    label: "Brand Created Date"
    description: "The date the Brand was created in the system."
    sql: ${TABLE}.BRAND_CREATEDON ;;
  }

  dimension: brand_name {
    type: string
    label: "Brand"
    description: "The name of the Brand."
    sql: ${TABLE}.BRAND_NAME ;;
    drill_fields: [campaign_details_base.campaign_name, flight_details.flight_description, flight_media_details_base.media_name, flight_media_details_base.flight_media_id ]
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.brand_name
  }

  dimension: changedon {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: createdon {
    type: string
    hidden: yes
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: industry_segment_description {
    type: string
    label: "Industry Segment"
    description: "The industry segement of the brand."
    sql: ${TABLE}.INDUSTRY_SEGMENT_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.industry_segment_description
  }

  dimension: industry_segment_id {
    type: string
    label: "Industry Segment ID"
    description: "ID for the industry segment of the brand"
    sql: ${TABLE}.INDUSTRY_SEGMENT_ID ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.industry_segment_id
  }

  dimension: industry_segment_type_description {
    type: string
    label: "Industry Segment Type"
    description: "The type of the industry segment of the brand."
    sql: ${TABLE}.INDUSTRY_SEGMENT_TYPE_DESCRIPTION ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.industry_segment_type_description
  }

  dimension: industry_segment_type_id {
    type: string
    hidden: yes
    sql: ${TABLE}.INDUSTRY_SEGMENT_TYPE_ID ;;
  }

  measure: count {
    type: count
    drill_fields: [brand_name, advertiser_name]
  }

  dimension: brand_wo_id {
    type: string
    view_label: "Brand"
    label: "Brand WO ID"
    description: "The Wide Orbit ID of the brand."
    sql: ${TABLE}.BRAND_WO_ID ;;
  }

  dimension: advertiser_wo_id {
    type: string
    view_label: "Advertiser"
    label: "Advertiser WO ID"
    description: "The Wide Orbit ID of the advertiser."
    sql: ${TABLE}.ADVERTISER_WO_ID ;;
  }

  dimension: future_advertisers {
    type: yesno
    view_label: "Advertiser"
    label: "Include All Advertisers"
    description: "Include this field as a filter in your Look if you want to include all relevant advertisers in the Look. Without this included in your filter, results will include advertisers with at least one associated campaign only"
    sql: true ;;
  }
}
