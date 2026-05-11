view: dim_sdk_fixed_fees {

  derived_table: {
    sql:
      WITH quarterly AS (
    SELECT
        dim_traffic_source.TS_Display_Name  AS "traffic_source",
        DATEDIFF('day', TRUNC(CURRENT_DATE(), 'Q'), CURRENT_DATE()) AS "days_passed_in_quarter",
        CASE WHEN MONTH(dim_date.Date_Key) IN (1,2, 3) THEN 90
            WHEN MONTH(dim_date.Date_Key) IN (4, 5, 6) THEN 91
            ELSE 92 END AS "quarter_length",
        dim_date.Quarter_Number  AS "quarter_number",
        dim_date.Year_Number  AS "year_number",
        MAX(dim_date.Date_Key) AS "max_date",
        COALESCE(SUM(fact_ad_daily_agg.sum_of_cogs ), 0) AS "quarter_cogs",
        COALESCE(SUM(fact_ad_daily_agg.sum_of_revenue),0) AS "quarter_revenue",
        COALESCE(SUM(fact_ad_daily_agg.sum_of_revenue), 0) + COALESCE(SUM(fact_ad_daily_agg.sum_of_platform_fee ), 0) - COALESCE(SUM(fact_ad_daily_agg.sum_of_Traffic_Source_Fee ), 0) + COALESCE(SUM(fact_ad_daily_agg.sum_of_platform_cost  ), 0) + COALESCE(SUM(fact_ad_daily_agg.sum_of_pub_platform_fee ), 0) - COALESCE(SUM(CASE
        WHEN  dim_date.Date_Key   >= DATE '2026-01-01' THEN  (CASE
        WHEN dim_date.Date_Key >= DATE '2026-01-01' THEN COALESCE(fact_ad_daily_agg.sum_of_barter_fee_amount, 0)
        ELSE
          CASE
            WHEN dim_dsp_deal_type.DSP_Deal_Type = 'pub' AND (
              dim_dsp_seat.Seat_ID = '2147' OR (CASE WHEN (LOWER(rx_dim_supply_publisher_deal_r.description) LIKE '%tinuiti%' OR
          LOWER(rx_dim_supply_publisher_deal_r.description) LIKE '%tnt%' OR
          LOWER(rx_dim_supply_publisher_deal_r.description) LIKE '%bpm%') THEN rx_dim_supply_publisher_deal_r.external_deal_id END) is not NULL
            ) THEN 0.02
            WHEN dim_date.Date_Key >= DATE '2025-04-01' AND dim_date.Date_Key < DATE '2025-04-18'
              AND (dim_dsp_seat.Seat_ID = '2147' OR dim_deal_agency.Deal_Agency_Name ILIKE '%Icon Tinuiti%')
              AND dim_dsp_deal_type.DSP_Deal_Type != 'pub' AND dim_revenue_type.revenue_type_name = 'firstparty' THEN 0.075
            ELSE
              CASE
                WHEN dim_deal_partner.deal_partner_id = '2' AND dim_deal_type.Deal_Type_ID = 12 THEN 0.30
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Involved%' AND dim_deal_brand.Deal_Brand_ID = '1036' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.20
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Involved%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.50
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%ICON%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%T-Mobile%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.25
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%ICON%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%lovesac%'AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.25
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%ICON%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.20
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Orion%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.24
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Agyle%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.15
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Evergreen%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.20
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Anchor%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.15
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%NYIAX%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.10
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Tingley Lane%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.15
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%UM Technologies%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.10
                ELSE 0
              END
          END
      END
)
        ELSE
          (
            (
              COALESCE(fact_ad_daily_agg.sum_of_revenue / (1 + CASE
                  WHEN  dim_revenue_type.revenue_type_name   = 'firstparty' THEN
                    CASE
                      WHEN  dim_dsp_deal_type.DSP_Deal_Type   = 'rx' AND ( dim_dsp_seat.Seat_ID   = '2147' OR  dim_deal_agency.Deal_Agency_Name   ILIKE '%Icon Tinuiti%') THEN
                        CASE
                          WHEN  dim_date.Date_Key   >= DATE '2025-03-01' THEN -0.051742
                          WHEN  dim_date.Date_Key   >= DATE '2025-02-01' THEN -0.041740
                          WHEN  dim_date.Date_Key   >= DATE '2025-01-01' THEN -0.042947
                          ELSE 0
                        END
                      WHEN  dim_dsp_deal_type.DSP_Deal_Type   = 'pub' AND  dim_dsp_seat.Seat_ID   = '2147' THEN
                        CASE
                          WHEN  dim_date.Date_Key   >= DATE '2025-03-01' THEN -0.008615
                          WHEN  dim_date.Date_Key   >= DATE '2025-02-01' THEN -0.034746
                          WHEN  dim_date.Date_Key   >= DATE '2025-01-01' THEN -0.034567
                          ELSE 0
                        END
                      ELSE 0
                    END
                  ELSE 0
                END
              ), 0)
              - COALESCE(
                  CASE WHEN  dim_date.Date_Key   >= DATE '2025-04-01' THEN COALESCE(fact_ad_daily_agg.sum_of_deal_data_fee, 0) ELSE 0 END,
                  0
                )
            ) *  (CASE
        WHEN dim_date.Date_Key >= DATE '2026-01-01' THEN COALESCE(fact_ad_daily_agg.sum_of_barter_fee_amount, 0)
        ELSE
          CASE
            WHEN dim_dsp_deal_type.DSP_Deal_Type = 'pub' AND (
              dim_dsp_seat.Seat_ID = '2147' OR (CASE WHEN (LOWER(rx_dim_supply_publisher_deal_r.description) LIKE '%tinuiti%' OR
          LOWER(rx_dim_supply_publisher_deal_r.description) LIKE '%tnt%' OR
          LOWER(rx_dim_supply_publisher_deal_r.description) LIKE '%bpm%') THEN rx_dim_supply_publisher_deal_r.external_deal_id END) is not NULL
            ) THEN 0.02
            WHEN dim_date.Date_Key >= DATE '2025-04-01' AND dim_date.Date_Key < DATE '2025-04-18'
              AND (dim_dsp_seat.Seat_ID = '2147' OR dim_deal_agency.Deal_Agency_Name ILIKE '%Icon Tinuiti%')
              AND dim_dsp_deal_type.DSP_Deal_Type != 'pub' AND dim_revenue_type.revenue_type_name = 'firstparty' THEN 0.075
            ELSE
              CASE
                WHEN dim_deal_partner.deal_partner_id = '2' AND dim_deal_type.Deal_Type_ID = 12 THEN 0.30
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Involved%' AND dim_deal_brand.Deal_Brand_ID = '1036' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.20
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Involved%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.50
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%ICON%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%T-Mobile%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.25
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%ICON%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%lovesac%'AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.25
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%ICON%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.20
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Orion%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.24
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Agyle%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.15
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Evergreen%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.20
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Anchor%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.15
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%NYIAX%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.10
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%Tingley Lane%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.15
                WHEN dim_deal_agency.Deal_Agency_Name ILIKE '%UM Technologies%' AND dim_deal_agency.Deal_Agency_Name ILIKE '%barter%' THEN 0.10
                ELSE 0
              END
          END
      END
)
          )
      END ), 0) - COALESCE(SUM(CASE
        WHEN  dim_date.Date_Key   >= DATE '2026-01-01'
      AND  dim_dsp_deal_type.DSP_Deal_Type   = 'pub'
      AND (
       dim_dsp_seat.Seat_ID   = '2147'
      OR
      LOWER( rx_dim_supply_publisher_deal_r.description  ) LIKE '%tinuiti%'
      OR
      LOWER( rx_dim_supply_publisher_deal_r.description  ) LIKE '%tnt%'
      OR
      LOWER( rx_dim_supply_publisher_deal_r.description  ) LIKE '%bpm%'
      )
      THEN (COALESCE(fact_ad_daily_agg.sum_of_revenue,0) - COALESCE(fact_ad_daily_agg.sum_of_deal_data_fee,0)) * 0.02
      ELSE 0
      END ), 0) + COALESCE(SUM(fact_ad_daily_agg.sum_of_revenue_adjustment  ), 0) + COALESCE(SUM(fact_ad_daily_agg.sum_of_cogs_adjustment ), 0) + COALESCE(SUM(fact_ad_daily_agg.sum_of_cm_fee ), 0) - COALESCE(SUM(fact_ad_daily_agg.sum_of_cogs ), 0) AS "quarter_net_revenue_post_fees"
    FROM BI_New.V_Fact_Ad_Daily_Agg  AS fact_ad_daily_agg
    INNER JOIN BI_New.V_Dim_Date  AS dim_date ON dim_date.Date_Key=fact_ad_daily_agg.Date_Key
    INNER JOIN BI_New.V_Dim_Deal  AS dim_deal ON dim_deal.Deal_Key=fact_ad_daily_agg.Deal_Key
    INNER JOIN BI_New.V_Dim_DSP_Deal_Type  AS dim_dsp_deal_type ON dim_dsp_deal_type.DSP_Deal_Type_Key=fact_ad_daily_agg.DSP_Deal_Type_Key
    INNER JOIN BI_New.V_Dim_DSP_Seat  AS dim_dsp_seat ON dim_dsp_seat.DSP_Seat_Key=fact_ad_daily_agg.DSP_Seat_Key
    LEFT JOIN Andromeda.rx_dim_supply_publisher_deal_r  AS rx_dim_supply_publisher_deal_r ON rx_dim_supply_publisher_deal_r.external_deal_id=dim_deal.Deal_ID
    INNER JOIN BI_New.V_Dim_Deal_Agency  AS dim_deal_agency ON dim_deal_agency.Deal_Agency_Key=dim_deal.deal_agency_key
    LEFT JOIN BI_New.dim_revenue_type  AS dim_revenue_type ON dim_revenue_type.revenue_type_key=fact_ad_daily_agg.revenue_type_key
    INNER JOIN BI_New.dim_deal_partner  AS dim_deal_partner ON dim_deal.deal_partner_id=dim_deal_partner.deal_partner_id
    INNER JOIN BI_New.V_Dim_Deal_Type  AS dim_deal_type ON dim_deal_type.Deal_Type_Key=dim_deal.Deal_Type_Key
    INNER JOIN BI_New.V_Dim_Deal_Brand  AS dim_deal_brand ON dim_deal_brand.Deal_Brand_Key=dim_deal.deal_brand_key
    INNER JOIN BI_New.v_Dim_Placement  AS dim_placement ON dim_placement.Placement_Key=fact_ad_daily_agg.Placement_Key
    INNER JOIN BI_New.V_Dim_Publisher_Traffic_Source  AS dim_publisher_traffic_source ON dim_publisher_traffic_source.PUB_TS_Key=dim_placement.PUB_TS_Key
    INNER JOIN BI_New.V_Dim_Traffic_Source  AS dim_traffic_source ON dim_traffic_source.Ts_Key=dim_publisher_traffic_source.TS_Key
    INNER JOIN BI_New.V_Dim_Publisher_SSP  AS dim_publisher_ssp ON dim_publisher_ssp.PUB_SSP_Key=fact_ad_daily_agg.PUB_SSP_Key
    INNER JOIN BI_New.V_Dim_Publisher  AS dim_publisher ON dim_publisher.PUB_Key=dim_publisher_ssp.PUB_Key
    WHERE YEAR(dim_date.Date_Key)=YEAR(CURRENT_DATE())
      AND (dim_traffic_source.TS_Display_Name ) IN ('BidMachine',  'Unity SSP', 'Verve ORTB')
      AND ((dim_publisher.PUB_Name) <> 'verve group europe gmbh'
          AND (dim_publisher.PUB_Name) <> 'smaato, inc ortb'
          AND (dim_publisher.PUB_Name) <> 'bidmachine inc' OR (dim_publisher.PUB_Name) IS NULL)
    GROUP BY
        1, 2, 3, 4, 5),
 yearly AS (
SELECT
    dim_traffic_source.TS_Display_Name  AS "traffic_source",
    dim_date.Year_Number  AS "year_number",
    COALESCE(SUM(fact_ad_daily_agg.sum_of_cogs ), 0) AS "year_cogs"
FROM BI_New.V_Fact_Ad_Daily_Agg  AS fact_ad_daily_agg
INNER JOIN BI_New.V_Dim_Date  AS dim_date ON dim_date.Date_Key=fact_ad_daily_agg.Date_Key
INNER JOIN BI_New.v_Dim_Placement  AS dim_placement ON dim_placement.Placement_Key=fact_ad_daily_agg.Placement_Key
INNER JOIN BI_New.V_Dim_Publisher_Traffic_Source  AS dim_publisher_traffic_source ON dim_publisher_traffic_source.PUB_TS_Key=dim_placement.PUB_TS_Key
INNER JOIN BI_New.V_Dim_Traffic_Source  AS dim_traffic_source ON dim_traffic_source.Ts_Key=dim_publisher_traffic_source.TS_Key
INNER JOIN BI_New.V_Dim_Publisher_SSP  AS dim_publisher_ssp ON dim_publisher_ssp.PUB_SSP_Key=fact_ad_daily_agg.PUB_SSP_Key
INNER JOIN BI_New.V_Dim_Publisher  AS dim_publisher ON dim_publisher.PUB_Key=dim_publisher_ssp.PUB_Key
WHERE YEAR(dim_date.Date_Key)=YEAR(CURRENT_DATE())
  AND (dim_traffic_source.TS_Display_Name ) = 'Verve ORTB'
  AND ((dim_publisher.PUB_Name) <> 'verve group europe gmbh'
      AND (dim_publisher.PUB_Name) <> 'smaato, inc ortb'
      AND (dim_publisher.PUB_Name) <> 'bidmachine inc' OR (dim_publisher.PUB_Name) IS NULL)
GROUP BY
    1, 2)

SELECT quarterly.traffic_source,
        quarterly.quarter_number,
        quarterly.quarter_length,
        quarterly.days_passed_in_quarter,
        quarterly.year_number,
        quarterly.max_date,
        CURRENT_DATE() AS "current_date",
        CASE WHEN  quarterly.traffic_source='Unity SSP' AND  quarterly.quarter_number=2 THEN 300000
            WHEN  quarterly.traffic_source='Unity SSP' AND  quarterly.quarter_number=3 THEN 900000
            WHEN  quarterly.traffic_source='Unity SSP' AND  quarterly.quarter_number=4 THEN 1500000
            WHEN  quarterly.traffic_source='BidMachine' THEN 450000
            WHEN  quarterly.traffic_source='Verve ORTB' THEN 255000
        ELSE 0 END  AS "sdk_fixed_monthly_fee",
        quarter_cogs,
        quarter_revenue,
        quarter_net_revenue_post_fees,
        year_cogs
FROM quarterly LEFT JOIN yearly ON quarterly.traffic_source=yearly.traffic_source AND quarterly.year_number=yearly.year_number;;
  }

  dimension: max_date {
    type: date
    sql: ${TABLE}.max_date ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  # dimension: month_number {
  #   type: number
  #   sql: ${TABLE}.month_number ;;
  # }

  # dimension: quarter_number {
  #   type: number
  #   sql: ${TABLE}.quarter_number ;;
  # }

  # dimension: year_number {
  #   type: number
  #   sql: ${TABLE}.year_number ;;
  # }

  dimension: quarter_length {
    type: number
    sql: ${TABLE}.quarter_length ;;
  }

  dimension: days_passed_in_current_quarter {
    type: number
    sql: ${TABLE}.days_passed_in_quarter ;;
  }

  measure: quarter_cogs {
    type: sum
    value_format: "$#,##0.00"
    label: "Cogs"
    description: "A number of cogs for the current quarter"
    sql: ${TABLE}.quarter_cogs ;;
  }

  measure: year_cogs {
    type: sum
    value_format: "$#,##0.00"
    label: "Cogs (full year)"
    description: "A number of cogs for the whole current year"
    sql: ${TABLE}.year_cogs ;;
  }

  measure: quarter_revenue {
    type: sum
    value_format: "$#,##0.00"
    label: "Revenue"
    sql: ${TABLE}.quarter_revenue ;;
  }

  measure: quarter_net_revenue_post_fees {
    type: sum
    value_format: "$#,##0.00"
    label: "Net Revenue (Post Fees)"
    sql: ${TABLE}.quarter_net_revenue_post_fees ;;
  }

  measure: sdk_fixed_monthly_fee {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.sdk_fixed_monthly_fee ;;
  }

  measure: sdk_fixed_quarterly_fee {
    type: sum
    value_format: "$#,##0.00"
    sql: CASE WHEN ${TABLE}.traffic_source='BidMachine' AND quarter_cogs< 1000000 THEN -200000
             WHEN ${TABLE}.traffic_source='BidMachine' AND quarter_cogs>=3000000 THEN 225000
             WHEN ${TABLE}.traffic_source='BidMachine' AND quarter_cogs>=2500000 THEN 100000
             WHEN ${TABLE}.traffic_source='Unity SSP' AND ${TABLE}.quarter_number=2 AND ${TABLE}.quarter_cogs<1250000 THEN -225000
             WHEN ${TABLE}.traffic_source='Unity SSP' AND ${TABLE}.quarter_number=2 AND ${TABLE}.quarter_cogs<2500000 THEN -150000
             WHEN ${TABLE}.traffic_source='Unity SSP' AND ${TABLE}.quarter_number=2 AND ${TABLE}.quarter_cogs>=4500000 THEN 375000
             WHEN ${TABLE}.traffic_source='Unity SSP' AND ${TABLE}.quarter_number=2 AND ${TABLE}.quarter_cogs>=3000000 THEN 150000

             WHEN ${TABLE}.traffic_source='Unity SSP' AND ${TABLE}.quarter_number=3 AND ${TABLE}.quarter_cogs<3750000 THEN -675000
             WHEN ${TABLE}.traffic_source='Unity SSP' AND ${TABLE}.quarter_number=3 AND ${TABLE}.quarter_cogs<7500000 THEN -450000
             WHEN ${TABLE}.traffic_source='Unity SSP' AND ${TABLE}.quarter_number=3 AND ${TABLE}.quarter_cogs>=13500000 THEN 1125000
             WHEN ${TABLE}.traffic_source='Unity SSP' AND ${TABLE}.quarter_number=3 AND ${TABLE}.quarter_cogs>=9000000 THEN 450000

             WHEN ${TABLE}.traffic_source='Unity SSP' AND ${TABLE}.quarter_number=4 AND ${TABLE}.quarter_cogs<6500000 THEN -1125000
             WHEN ${TABLE}.traffic_source='Unity SSP' AND ${TABLE}.quarter_number=4 AND ${TABLE}.quarter_cogs<13000000 THEN -750000
             WHEN ${TABLE}.traffic_source='Unity SSP' AND ${TABLE}.quarter_number=4 AND ${TABLE}.quarter_cogs>=22500000 THEN 1875000
             WHEN ${TABLE}.traffic_source='Unity SSP' AND ${TABLE}.quarter_number=4 AND ${TABLE}.quarter_cogs>=1500000 THEN 750000
          ELSE 0 END ;;
  }

  measure: sdk_fixed_annual_fee {
    type: sum
    value_format: "$#,##0.00"
    sql: CASE WHEN  ${TABLE}.traffic_source='Verve ORTB' AND ${TABLE}.year_number=2026 AND ${TABLE}.year_cogs>=35500000 THEN 1000000
             WHEN  ${TABLE}.traffic_source='Verve ORTB' AND ${TABLE}.year_number=2026 AND ${TABLE}.year_cogs>=32500000 THEN 500000
        ELSE 0 END ;;
  }


}
