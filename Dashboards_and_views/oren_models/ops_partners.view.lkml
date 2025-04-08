view: ops_partners {
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
}


  measure: GROSS_REVENUE {
    type: sum
    sql: ${TABLE}.GROSS_REVENUE ;;
    value_format: "$#,##0.00"
  }

  measure: ADJUSTED_NET_REVENUE {
    type: sum
    sql: ${TABLE}.ADJUSTED_NET_REVENUE ;;
    value_format: "$#,##0.00"
  }

  measure: TURN_FEE {
    type: sum
    sql: ${TABLE}.TURN_FEE ;;
    value_format: "$#,##0.00"
  }


set: detail {
  fields: [
    DATE_PERIOD,
    NS_VENDOR_ID,
    NS_VENDOR_ID,
    IMPRESSION,
    GROSS_REVENUE,
    ADJUSTED_NET_REVENUE,
    TURN_FEE
  ]
}
    }
