view: v_fact_ad_daily_agg_date_ssp_key {
  sql_table_name: BI_New.v_Fact_Ad_Daily_Agg_Date_SSP_Key ;;

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date_Key ;;
  }
  dimension: pub_ssp_key {
    type: number
    sql: ${TABLE}.PUB_SSP_Key ;;
  }
  measure: sum_of_cogs {
    type: sum
    sql: ${TABLE}.sum_of_cogs ;;
    value_format: "$#,##0.00"
  }
  measure: sum_of_pub_platform_fee {
    type: sum
    sql: ${TABLE}.sum_of_pub_platform_fee ;;
    value_format: "$#,##0.00"
  }
  measure: sum_of_revenue {
    type: sum
    sql: ${TABLE}.sum_of_revenue ;;
    value_format: "$#,##0.00"
  }
  measure: sum_of_net_revenue {
    type: sum
    sql: ${TABLE}.sum_of_revenue - ${TABLE}.sum_of_cogs + ${TABLE}.sum_of_pub_platform_fee ;;
    value_format: "$#,##0.00"
  }
  measure: count {
    type: count
  }
}
