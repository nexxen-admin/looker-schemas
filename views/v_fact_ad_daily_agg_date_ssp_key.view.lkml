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
  }
  measure: sum_of_pub_platform_fee {
    type: sum
    sql: ${TABLE}.sum_of_pub_platform_fee ;;
  }
  measure: sum_of_revenue {
    type: sum
    sql: ${TABLE}.sum_of_revenue ;;
  }
  measure: count {
    type: count
  }
}
