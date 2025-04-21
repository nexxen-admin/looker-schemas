view: ops_partners_das {
  derived_table: {
    sql:
    SELECT date(DATE_PERIOD) as DATE_PERIOD,
       NS_VENDOR_ID,
       VENDOR_NAME,
      MARKET_NAME,
      ADVERTISER_NAME,
      ENVIRONMENT,
      PROVIDER_NAME,
      MARKET_ID,
      case when DATA_SOURCE = 'SSP' then 'SSP' else 'DSP' end as source,
        SUM(IMPRESSION) as IMPRESSION,
        SUM(GROSS_REVENUE) as GROSS_REVENUE,
        SUM(ADJUSTED_NET_REVENUE) as ADJUSTED_NET_REVENUE,
        SUM(TURN_FEE) as TURN_FEE
FROM bi_new.decom_condensed
GROUP BY 1,2,3,4,5,6,7,8,9
    ;;

}

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
    sql: ${TABLE}.DATE_PERIOD ;;
    label: "Time Frame"
  }

  dimension: DATE_PERIOD {
    type: date
    sql: ${TABLE}.DATE_PERIOD ;;
    label: "Date"
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
    label: "Market Name"
  }

  dimension: ADVERTISER_NAME {
    type: string
    sql: ${TABLE}.ADVERTISER_NAME ;;
    label: "Advertiser Name"
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
    label: "Source"
  }


measure: IMPRESSION {
  type: sum
  sql: ${TABLE}.IMPRESSION ;;
  value_format: "#,##0"
  label: "Impressions"
}


  measure: GROSS_REVENUE {
    type: sum
    sql: ${TABLE}.GROSS_REVENUE ;;
    value_format: "$#,##0"
    label: "Gross Revenue"
  }

  measure: ADJUSTED_NET_REVENUE {
    type: sum
    sql: ${TABLE}.ADJUSTED_NET_REVENUE ;;
    value_format: "$#,##0"
    label: "Net Revenue"
  }

  measure: TURN_FEE {
    type: sum
    sql: ${TABLE}.TURN_FEE ;;
    value_format: "$#,##0"
    label: "Turn Fee"
  }

  measure: rev_dev_gross_percentage {
    type: number
    sql: SUM(CASE WHEN ${TABLE}.GROSS_REVENUE = 0 THEN 0 ELSE ${TABLE}.ADJUSTED_NET_REVENUE END)
      / NULLIF(SUM(${TABLE}.GROSS_REVENUE), 0) ;;
    value_format: "0.0%"
    label: "Net Revenue / Gross Revenue %"
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

    IMPRESSION,
    GROSS_REVENUE,
    ADJUSTED_NET_REVENUE,
    TURN_FEE,
    rev_dev_gross_percentage
  ]
}
    }
