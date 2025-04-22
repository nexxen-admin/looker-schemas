view: mssql_oltp_advertiser_brand {
  sql_table_name: dbo.advertiser_brand (NOLOCK) ;;
  label: "Brand"

  dimension: adveriser_brand_id {
    primary_key: yes
    type: number
    label: "Brand ID"
    description: "The system ID of the Brand."
    sql: ${TABLE}.advertiser_brand_id ;;
    value_format_name: id
  }

  dimension: adveriser_id {
    hidden: yes
    type: number
    sql: ${TABLE}.advertiser_id ;;
  }

  dimension: brand_name {
    type: string
    label: "Brand"
    description: "The name of the Brand."
    sql: ${TABLE}.brand_name ;;
  }

  dimension: active {
    type: yesno
    description: "A yes/no indicator if the Brand is currently active."
    sql: ${TABLE}.active = 1 ;;
  }

  dimension_group: brand_createdon {
    type: time
    label: "Brand Created Date"
    description: "The date the Brand was created in the system."
    timeframes: [raw,time,date,month,year]
    sql: ${TABLE}.createdon ;;
  }

  dimension: industry_segment_id {
    type: number
    label: "Industry Segment ID"
    description: "Industry segment id of the segment selected for targeting in the campaign."
    sql: ${TABLE}.industry_segment_id ;;
    value_format_name: id
  }

  filter: include_all_brands {
    type: yesno
    label: "Include All Brands"
    description: "Include this field as a filter in your Look if you want to include all Brands in the Look. Without this included in your filter, results will include Brands with campaigns only."
  }
}