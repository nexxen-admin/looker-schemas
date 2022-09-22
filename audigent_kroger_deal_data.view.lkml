view: audigent_kroger_deal_data {
  derived_table: {
    sql: SELECT
          new_time(dim_date_hourly.datetime_key,'America/New_York','UTC')::date AS "dim_date.date_key_date",
          dim_deal.Deal_ID AS "dim_deal.deal_id",
          dim_deal.Deal_Name  AS "dim_deal.deal_name",
          dim_deal.Deal_demand_margin_pct  AS "dim_deal.deal_demand_margin_pct",
          COALESCE(SUM(fact_ad_hourly_agg.sum_of_impression_pixel ), 0) AS "fact_ad_hourly_agg.impression_pixel",
          COALESCE(SUM(fact_ad_hourly_agg.sum_of_revenue), 0) AS "fact_ad_hourly_agg.revenue",
              COALESCE(SUM(fact_ad_hourly_agg.sum_of_revenue), 0) / NULLIF(COALESCE(SUM(fact_ad_hourly_agg.sum_of_impression_pixel ), 0) / 1000, 0) AS "fact_ad_hourly_agg.ad_ecpm_1"
      FROM BI_New.V_Fact_Ad_Hourly_Agg  AS fact_ad_hourly_agg
      INNER JOIN BI_New.V_Dim_Date_Hourly  AS dim_date_hourly ON dim_date_hourly.DateTime_Key=fact_ad_hourly_agg.DateTime_Key
      INNER JOIN BI_New.V_Dim_Deal  AS dim_deal ON dim_deal.Deal_Key=fact_ad_hourly_agg.Deal_Key
      FULL OUTER JOIN BI_New.V_Dim_Deal_Agency  AS dim_deal_agency ON dim_deal_agency.Deal_Agency_Key=dim_deal.deal_agency_key
      WHERE ((new_time(dim_date_hourly.datetime_key,'America/New_York','UTC')::date >= ((DATE_TRUNC('day', (DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'America/New_York') + (-1 || ' day')::INTERVAL))))
        AND new_time(dim_date_hourly.datetime_key,'America/New_York','UTC')::date < ((DATE_TRUNC('day', ((DATE_TRUNC('day', CURRENT_TIMESTAMP AT TIME ZONE 'America/New_York') + (-1 || ' day')::INTERVAL) + (1 || ' day')::INTERVAL))))))
        AND dim_deal.Deal_Agency_ID = 668
        AND (dim_deal.Deal_Name ) LIKE '%Kroger%'
      GROUP BY
          1,
          2,
          3,
          4
      ORDER BY
          2 DESC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: dim_date_date_key_date {
    type: date
    sql: ${TABLE}."dim_date.date_key_date" ;;
    html: {{ rendered_value | date: "%F" }} ;;
  }

  dimension: dim_deal_deal_id {
    type: string
    sql: ${TABLE}."dim_deal.deal_id" ;;
  }

  dimension: dim_deal_deal_name {
    type: string
    sql: ${TABLE}."dim_deal.deal_name" ;;
  }

  dimension: dim_deal_deal_demand_margin_pct {
    type: number
    sql: ${TABLE}."dim_deal.deal_demand_margin_pct" ;;
  }

  measure: fact_ad_hourly_agg_impression_pixel {
    type: sum
    value_format: "0"
    sql: ${TABLE}."fact_ad_hourly_agg.impression_pixel" ;;
  }

  measure: fact_ad_hourly_agg_revenue {
    type: sum
    value_format: "$#,##0"
    sql: ${TABLE}."fact_ad_hourly_agg.revenue" ;;
  }

  dimension: fact_ad_hourly_agg_ad_ecpm_1 {
    type: number
    sql: ${TABLE}."fact_ad_hourly_agg.ad_ecpm_1" ;;
  }

  set: detail {
    fields: [
      dim_date_date_key_date,
      dim_deal_deal_id,
      dim_deal_deal_name,
      dim_deal_deal_demand_margin_pct,
      fact_ad_hourly_agg_ad_ecpm_1
    ]
  }
}
