view: sno_ad_content {
  view_label: "Ad Content"
  sql_table_name: VIEWERSHIP.AD_CONTENT ;;

  dimension: ad_content_key {
    primary_key: yes
    type: string
    #hidden: yes
    sql: ${TABLE}.AD_CONTENT_KEY ;;
  }

  dimension: brand_level_4 {
    type: string
    label: "Ultimate Parent Description"
    description: "Use all CAPS and 'contains' while searching"
    sql: ${TABLE}.BRAND_LEVEL_4 ;;
  }

  dimension: brand_level_3 {
    type: string
    description: "Use all CAPS and 'contains' while searching"
    label: "Parent Description"
    sql: ${TABLE}.BRAND_LEVEL_3 ;;
  }

  dimension: brand_level_2 {
    type: string
    description: "Use all CAPS and 'contains' while searching"
    label: "Brand Description"
    sql: ${TABLE}.BRAND_LEVEL_2 ;;
  }

  dimension: brand_level_1 {
    type: string
    description: "Use all CAPS and 'contains' while searching"
    label: "Brand Variant Description"
    sql: ${TABLE}.BRAND_LEVEL_1 ;;
  }

  dimension: creative_name {
    type: string
    description: "Use all CAPS and 'contains' while searching"
    label: "Creative Description"
    sql: ${TABLE}.CREATIVE_NAME ;;
  }

  dimension: duration_secs {
    type: string
    label: "Ad Duration Seconds"
    sql: ${TABLE}.DURATION_SECS ;;
  }

  dimension: format_ad_content_key {
    type: string
    hidden: yes
    sql: CONCAT(${ad_content_key},',' );;
  }

  dimension: brand_level_5 {
    type: string
    hidden: yes
    sql: ${TABLE}.BRAND_LEVEL_5 ;;
  }

  #measure: Number_of_ads {
  #  type: count
  #  label: "Number of Ads"
  #}
}
