view: ops_partners_das {
  sql_table_name: bi_new.decom ;;

  dimension_group: time_frame {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${DATE_PERIOD} ;;
    label: "Time Frame"
  }

  dimension: DATE_PERIOD {
    type: date
    sql: date(${TABLE}.IMPRESSION_DATE) ;;
    label: "Date"
  }

  dimension: CATEGORY {
    type: string
    sql: ${TABLE}.CATEGORY ;;
    label: "Category"
  }


  dimension: ENVIRONMENT {
    type: string
    sql: ${TABLE}.ENVIRONMENT ;;
    label: "Environment"
  }

  dimension: PROVIDER_NAME {
    type: string
    sql: ${TABLE}.PROVIDER_NAME ;;
    label: "Provider Name"
  }

  dimension: MARKET_ID {
    type: string
    sql: ${TABLE}.MARKET_ID ;;
    label: "Market ID"
  }

  dimension: DATA_TYPE {
    type: string
    sql: ${TABLE}.DATA_TYPE ;;
    label: "Data Type"
  }


  dimension: NS_VENDOR_ID {
    type: string
    sql: ${TABLE}.NS_VENDOR_ID ;;
    label: "Vendor ID"
  }

  dimension: VENDOR_NAME {
    type: string
    sql: ${TABLE}.VENDOR_NAME ;;
    label: "Vendor Name"
  }

  dimension: MARKET_NAME {
    type: string
    sql: ${TABLE}.MARKET_NAME ;;
    label: "Market/Agency Name"
  }

  dimension: ADVERTISER_NAME {
    type: string
    sql: ${TABLE}.ADVERTISER_NAME ;;
    label: "Advertiser/Brand Name"
  }

  dimension: source {
    type: string
    sql: case when ${TABLE}.DATA_SOURCE = 'SSP' then 'SSP' else 'DSP' end ;;
    label: "Source"
  }

  dimension: REGION {
    type: string
    sql: ${TABLE}.REGION ;;
    label: "Region"
  }

  dimension: COUNTRY_ID {
    type: string
    sql: ${TABLE}.COUNTRY_ID ;;
    label: "Country ID"
  }

  dimension: COUNTRY_NAME {
    type: string
    sql: ${TABLE}.COUNTRY_NAME ;;
    label: "Country Name"
  }


measure: IMPRESSION {
  type: sum
  sql: ${TABLE}.IMPRESSION ;;
  value_format: "#,##0"
  label: "Impressions"
}


  measure: GROSS_REVENUE {
    type: sum
    sql: ${TABLE}.GROSS_REVENUE - COALESCE(${TABLE}.CONTRA_REVENUE, 0) ;;
    value_format: "$#,##0"
    label: "Gross Retained Revenue"
    description: "Gross Retained Revenue, calculated as gross revenue less contra revenue (e.g., discounts, returns, or allowances)"
  }

  measure: ADJUSTED_NET_REVENUE {
    type: sum
    sql: ${TABLE}.ADJUSTED_NET_REVENUE ;;
    value_format: "$#,##0"
    label: "Net Retained Revenue"
  }

  measure: TURN_FEE {
    type: sum
    sql: ${TABLE}.TURN_FEE ;;
    value_format: "$#,##0"
    label: "Turn Fee"
  }

  measure: rev_dev_gross_percentage {
    type: number
    sql: CASE
      WHEN
        (SUM(CASE WHEN ${TABLE}.GROSS_REVENUE = 0 THEN 0 ELSE ${TABLE}.ADJUSTED_NET_REVENUE END)
        / NULLIF(SUM(${TABLE}.GROSS_REVENUE), 0)) > 1
      THEN 1
      ELSE
        (SUM(CASE WHEN ${TABLE}.GROSS_REVENUE = 0 THEN 0 ELSE ${TABLE}.ADJUSTED_NET_REVENUE END)
        / NULLIF(SUM(${TABLE}.GROSS_REVENUE), 0))
      END ;;
    value_format: "0.0%"
    label: "Net Retained Revenue / Gross Retained Revenue %"
  }

  measure: CONTRA_REVENUE {
    type: sum
    sql: ${TABLE}.CONTRA_REVENUE ;;
    value_format: "$#,##0"
    label: "Contra Revenue"
    description: "Agreed reductions (credits, bad debt, make-goods) that lower vendor payout, by reducing the revshare base (e.g. Gross Revenue), but don’t change what advertisers are billed."
  }


set: detail {
  fields: [
    DATE_PERIOD,
    time_frame_quarter,
    NS_VENDOR_ID,
    MARKET_NAME,
    ADVERTISER_NAME,
    source,
    ENVIRONMENT,
    PROVIDER_NAME,
    MARKET_ID,
    CATEGORY,
    DATA_TYPE,
    REGION,
    COUNTRY_ID,
    COUNTRY_NAME,
    IMPRESSION,
    GROSS_REVENUE,
    ADJUSTED_NET_REVENUE,
    TURN_FEE,
    rev_dev_gross_percentage
  ]}

}
