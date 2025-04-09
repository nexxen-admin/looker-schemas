view: ops_partners_das {
  derived_table: {
    sql:
    SELECT date(DATE_PERIOD) as DATE_PERIOD,
       NS_VENDOR_ID,
       VENDOR_NAME,
        SUM(IMPRESSION) as IMPRESSION,
        SUM(GROSS_REVENUE) as GROSS_REVENUE,
        SUM(ADJUSTED_NET_REVENUE) as ADJUSTED_NET_REVENUE,
        SUM(TURN_FEE) as TURN_FEE
FROM bi_new.decom_condensed
GROUP BY
DATE_PERIOD,
NS_VENDOR_ID,
VENDOR_NAME
    ;;

}


  dimension: DATE_PERIOD {
    type: date
    sql: ${TABLE}.DATE_PERIOD ;;
    label: "Date"
  }

  dimension: NS_VENDOR_ID {
    type: date
    sql: ${TABLE}.NS_VENDOR_ID ;;
  }

  dimension: VENDOR_NAME {
    type: string
    sql: ${TABLE}.VENDOR_NAME ;;
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
    value_format: "$#,##0.00"
    label: "Gross Revenue"
  }

  measure: ADJUSTED_NET_REVENUE {
    type: sum
    sql: ${TABLE}.ADJUSTED_NET_REVENUE ;;
    value_format: "$#,##0.00"
    label: "Net Revenue"
  }

  measure: TURN_FEE {
    type: sum
    sql: ${TABLE}.TURN_FEE ;;
    value_format: "$#,##0.00"
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
    NS_VENDOR_ID,
    IMPRESSION,
    GROSS_REVENUE,
    ADJUSTED_NET_REVENUE,
    TURN_FEE,
    rev_dev_gross_percentage
  ]
}
    }
