view: ops_partners {
  derived_table: {
    sql:
    SELECT PERIOD_NAME,
  DATE_PERIOD,
  CALENDAR_QUARTER,
  CALENDAR_YEAR,
  IMPRESSION_DATE,
  DATA_SOURCE,
  MARKET_ID,
  MARKET_NAME,
  ADVERTISER_ID,
  ADVERTISER_NAME,
  PROVIDER_ID,
  PROVIDER_NAME,
  CONTRACT_ID,
  CONTRACT_NAME,
  MEDIA_CHANNEL_ID,
  MEDIA_CHANNEL_NAME,
  ENVIRONMENT_ID,
  ENVIRONMENT,
  NS_VENDOR_ID,
  VENDOR_NAME,
  NS_CUSTOMER_ID,
  CUSTOMER_NAME,
  SUBSIDIARY_ID,
  SUBSIDIARY,
  FDW_PRODUCT_TYPE,
  DATA_TYPE,
  DATA_USE,
  DATA_PRODUCT_DESCRIPTION,
  DATA_MONETIZATION_TYPE,
  PRODUCT_CATEGORY,
  SOURCE,
  DATA_COST_PRICING_TYPE,
  INSERTION_ORDER_ID,
  INSERTION_ORDER_NAME,
  FORMAT,
  DEVICE_TYPE,
  COUNTRY_ID,
  COUNTRY_NAME,
  CATEGORY_ID,
  CATEGORY,
  PARENT_CATEGORY,
  SALES_REGION,
  SUM(IMPRESSION) AS IMPRESSION,
  SUM(GROSS_REVENUE) AS GROSS_REVENUE,
  SUM(TURN_FEE) AS TURN_FEE,
  SUM(ADJUSTED_NET_REVENUE) AS ADJUSTED_NET_REVENUE
FROM bi_new.decom
GROUP BY
  PERIOD_NAME,
  DATE_PERIOD,
  CALENDAR_QUARTER,
  CALENDAR_YEAR,
  IMPRESSION_DATE,
  DATA_SOURCE,
  MARKET_ID,
  MARKET_NAME,
  ADVERTISER_ID,
  ADVERTISER_NAME,
  PROVIDER_ID,
  PROVIDER_NAME,
  CONTRACT_ID,
  CONTRACT_NAME,
  MEDIA_CHANNEL_ID,
  MEDIA_CHANNEL_NAME,
  ENVIRONMENT_ID,
  ENVIRONMENT,
  NS_VENDOR_ID,
  VENDOR_NAME,
  NS_CUSTOMER_ID,
  CUSTOMER_NAME,
  SUBSIDIARY_ID,
  SUBSIDIARY,
  FDW_PRODUCT_TYPE,
  DATA_TYPE,
  DATA_USE,
  DATA_PRODUCT_DESCRIPTION,
  DATA_MONETIZATION_TYPE,
  PRODUCT_CATEGORY,
  SOURCE,
  DATA_COST_PRICING_TYPE,
  INSERTION_ORDER_ID,
  INSERTION_ORDER_NAME,
  FORMAT,
  DEVICE_TYPE,
  COUNTRY_ID,
  COUNTRY_NAME,
  CATEGORY_ID,
  CATEGORY,
  PARENT_CATEGORY,
  SALES_REGION
    ;;

}


  dimension: period_name {
    type: string
    sql: ${TABLE}.period_name ;;
    label: "Period Name"
  }

  dimension: date_period {
    type: date
    sql: ${TABLE}.date_period ;;
    label: "Date Period"
  }

  dimension: calendar_quarter {
    type: string
    sql: ${TABLE}.calendar_quarter ;;
    label: "Calendar Quarter"
  }

  dimension: calendar_year {
    type: number
    sql: ${TABLE}.calendar_year ;;
    label: "Calendar Year"
  }

  dimension: impression_date {
    type: date
    sql: ${TABLE}.impression_date ;;
    label: "Impression Date"
  }

  dimension: data_source {
    type: string
    sql: ${TABLE}.data_source ;;
    label: "Data Source"
  }

  dimension: market_id {
    type: number
    sql: ${TABLE}.market_id ;;
    label: "Market ID"
  }

  dimension: market_name {
    type: string
    sql: ${TABLE}.market_name ;;
    label: "Market Name"
  }

  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
    label: "Advertiser ID"
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
    label: "Advertiser Name"
  }

  dimension: provider_id {
    type: number
    sql: ${TABLE}.provider_id ;;
    label: "Provider ID"
  }

  dimension: provider_name {
    type: string
    sql: ${TABLE}.provider_name ;;
    label: "Provider Name"
  }

  dimension: contract_id {
    type: number
    sql: ${TABLE}.contract_id ;;
    label: "Contract ID"
  }

  dimension: contract_name {
    type: string
    sql: ${TABLE}.contract_name ;;
    label: "Contract Name"
  }

  dimension: media_channel_id {
    type: number
    sql: ${TABLE}.media_channel_id ;;
    label: "Media Channel ID"
  }

  dimension: media_channel_name {
    type: string
    sql: ${TABLE}.media_channel_name ;;
    label: "Media Channel Name"
  }

  dimension: environment_id {
    type: number
    sql: ${TABLE}.environment_id ;;
    label: "Environment ID"
  }

  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
    label: "Environment"
  }

  dimension: ns_vendor_id {
    type: number
    sql: ${TABLE}.ns_vendor_id ;;
    label: "NS Vendor ID"
  }

  dimension: vendor_name {
    type: string
    sql: ${TABLE}.vendor_name ;;
    label: "Vendor Name"
  }

  dimension: ns_customer_id {
    type: number
    sql: ${TABLE}.ns_customer_id ;;
    label: "NS Customer ID"
  }

  dimension: customer_name {
    type: string
    sql: ${TABLE}.customer_name ;;
    label: "Customer Name"
  }

  dimension: subsidiary_id {
    type: number
    sql: ${TABLE}.subsidiary_id ;;
    label: "Subsidiary ID"
  }

  dimension: subsidiary {
    type: string
    sql: ${TABLE}.subsidiary ;;
    label: "Subsidiary"
  }

  dimension: fdw_product_type {
    type: string
    sql: ${TABLE}.fdw_product_type ;;
    label: "FDW Product Type"
  }

  dimension: data_type {
    type: string
    sql: ${TABLE}.data_type ;;
    label: "Data Type"
  }

  dimension: data_use {
    type: string
    sql: ${TABLE}.data_use ;;
    label: "Data Use"
  }

  dimension: data_product_description {
    type: string
    sql: ${TABLE}.data_product_description ;;
    label: "Data Product Description"
  }

  dimension: data_monetization_type {
    type: string
    sql: ${TABLE}.data_monetization_type ;;
    label: "Data Monetization Type"
  }

  dimension: product_category {
    type: string
    sql: ${TABLE}.product_category ;;
    label: "Product Category"
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
    label: "Source"
  }

  dimension: insertion_order_id {
    type: number
    sql: ${TABLE}.insertion_order_id ;;
    label: "Insertion Order ID"
  }

  dimension: insertion_order_name {
    type: string
    sql: ${TABLE}.insertion_order_name ;;
    label: "Insertion Order Name"
  }

  dimension: format {
    type: string
    sql: ${TABLE}.format ;;
    label: "Format"
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
    label: "Device Type"
  }

  dimension: country_id {
    type: number
    sql: ${TABLE}.country_id ;;
    label: "Country ID"
  }

  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
    label: "Country Name"
  }

  dimension: category_id {
    type: number
    sql: ${TABLE}.category_id ;;
    label: "Category ID"
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    label: "Category"
  }

  dimension: parent_category {
    type: string
    sql: ${TABLE}.parent_category ;;
    label: "Parent Category"
  }

  dimension: sales_region {
    type: string
    sql: ${TABLE}.sales_region ;;
    label: "Sales Region"
  }


measure: impression {
  type: sum
  sql: ${TABLE}.impression ;;
  label: "Total Impression"
}

measure: gross_revenue {
  type: sum
  sql: ${TABLE}.gross_revenue ;;
  value_format: "$#,##0"
  label: "Total Gross Revenue"
}

measure: turn_fee {
  type: sum
  sql: ${TABLE}.turn_fee ;;
  value_format: "$#,##0"
  label: "Total Turn Fee"
}

measure: adjusted_net_revenue {
  type: sum
  sql: ${TABLE}.adjusted_net_revenue ;;
  value_format: "$#,##0"
  label: "Total Adjusted Net Revenue"
}

measure: data_cost_pricing_type {
  type: sum
  sql: ${TABLE}.data_cost_pricing_type ;;
  value_format: "$#,##0"
  label: "Total Data Cost Pricing Type"
}


set: detail {
  fields: [
    period_name,
    date_period,
    calendar_quarter,
    calendar_year,
    impression_date,
    data_source,
    market_id,
    market_name,
    advertiser_id,
    advertiser_name,
    provider_id,
    provider_name,
    contract_id,
    contract_name,
    media_channel_id,
    media_channel_name,
    environment_id,
    environment,
    ns_vendor_id,
    vendor_name,
    ns_customer_id,
    customer_name,
    subsidiary_id,
    subsidiary,
    fdw_product_type,
    data_type,
    data_use,
    data_product_description,
    data_monetization_type,
    product_category,
    source,
    insertion_order_id,
    insertion_order_name,
    format,
    device_type,
    country_id,
    country_name,
    category_id,
    category,
    parent_category,
    sales_region,
    impression,
    gross_revenue,
    turn_fee,
    adjusted_net_revenue,
    data_cost_pricing_type
  ]
}
    }
