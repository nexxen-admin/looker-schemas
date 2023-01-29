view: min_date_revenue {
  derived_table: {
    sql: SELECT
          dim_publisher.PUB_Name  AS "dim_publisher.pub_name",
          dim_publisher.PUB_id  AS "dim_publisher.id",
          COALESCE(SUM(fact_ad_daily_agg.sum_of_revenue), 0) AS "fact_ad_daily_agg.revenue",
              (DATE(min(fact_ad_daily_agg.Date_Key) )) AS "fact_ad_daily_agg.min_date_key"
      FROM BI_New.V_Fact_Ad_Daily_Agg  AS fact_ad_daily_agg
      INNER JOIN BI_New.V_Dim_Publisher_SSP  AS dim_publisher_ssp ON dim_publisher_ssp.PUB_SSP_Key=fact_ad_daily_agg.PUB_SSP_Key
      INNER JOIN BI_New.V_Dim_Publisher  AS dim_publisher ON dim_publisher.PUB_Key=dim_publisher_ssp.PUB_Key
      INNER JOIN BI_New.V_Dim_SSP  AS dim_ssp ON dim_ssp.SSP_Key=dim_publisher_ssp.SSP_Key
      WHERE (dim_ssp.Is_1st_Party )
      GROUP BY
          1
      HAVING ((( min(fact_ad_daily_agg.Date_Key)  ) >= ((DATE_TRUNC('year', DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'EST')))) AND ( min(fact_ad_daily_agg.Date_Key)  ) < (((ADD_MONTHS(DATE_TRUNC('year', DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'EST')), 1 * 12) + (MIDNIGHT_SECONDS(DATE_TRUNC('year', DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'EST'))) || ' second')::INTERVAL))))) AND COALESCE(SUM(fact_ad_daily_agg.sum_of_revenue), 0) > 0
      ORDER BY
          3 DESC
      LIMIT 5000
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: dim_publisher_pub_name {
    type: string
    sql: ${TABLE}."dim_publisher.pub_name" ;;
  }

  measure: fact_ad_daily_agg_revenue {
    type: number
    sql: ${TABLE}."fact_ad_daily_agg.revenue" ;;
  }

  dimension: fact_ad_daily_agg_min_date_key {
    type: date
    sql: ${TABLE}."fact_ad_daily_agg.min_date_key" ;;
  }

  set: detail {
    fields: [dim_publisher_pub_name, fact_ad_daily_agg_revenue]
  }
}
