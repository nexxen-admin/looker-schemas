view: yearly_consolidated_revenue_by_region_with_amobee_TEST {

  # derived_table: {
  #   sql:
  #     -- ============================================================
  #     -- LOCKED FY2025 AND PRIOR (from locked table)
  #     -- ============================================================
  #     SELECT Year, Quarter, region, category, Revenue, Cost
  #     FROM bi.svc_LOCKED_2025_yearly_consolidated_revenue_by_region_with_amobee

  #     UNION ALL

  #     -- ============================================================
  #     -- LIVE FY2026+ : AMOBEE DSP
  #     -- Cost distributed across regions using Exchange revenue weights
  #     -- ============================================================
  #     (WITH exchange_region_revenue AS (
  #     SELECT
  #     YEAR(event_date) AS year,
  #     QUARTER(event_date) AS quarter,
  #     CASE
  #     WHEN country = 'United States' THEN 'America - US'
  #     WHEN geo_region = 'Americas' THEN 'America - ROW'
  #     WHEN geo_region NOT IN ('Unknown','APAC','EMEA','Americas') THEN 'Other'
  #     ELSE geo_region
  #     END AS region,
  #     SUM(revenue) AS revenue
  #     FROM BI.DRR_Exch_1P_Demand_Offset
  #     WHERE event_date >= '2026-01-01'
  #     AND event_date < current_date()
  #     GROUP BY 1, 2, 3
  #     ),
  #     exchange_distribution AS (
  #     SELECT
  #     year, quarter, region,
  #     revenue / NULLIF(SUM(revenue) OVER (PARTITION BY year, quarter), 0) AS region_pct
  #     FROM exchange_region_revenue
  #     ),
  #     dsp_quarterly AS (
  #     SELECT
  #     YEAR(event_date) AS year,
  #     QUARTER(event_date) AS quarter,
  #     'DSP' AS category,
  #     SUM(0) AS revenue,
  #     SUM(Tremor_Cost * -1) AS cost
  #     FROM BI.DRR_AmobeeDSP_Base_Metrics d
  #     WHERE event_date >= '2026-01-01'
  #     AND event_date < current_date()
  #     AND ABS(tremor_cost) > 0
  #     GROUP BY 1, 2, 3
  #     )
  #     SELECT
  #     d.year,
  #     d.quarter,
  #     x.region,
  #     d.category,
  #     d.revenue,
  #     d.cost * x.region_pct AS cost
  #     FROM dsp_quarterly d
  #     INNER JOIN exchange_distribution x
  #     ON x.year = d.year AND x.quarter = d.quarter
  #     ORDER BY d.quarter, x.region)
  #     ;;
  # }

  derived_table: {
    sql:
    -- ============================================================
    -- LOCKED FY2025 AND PRIOR (from locked table)
    -- ============================================================
    SELECT Year, Quarter, region, category, Revenue, Cost
    FROM bi.svc_LOCKED_2025_yearly_consolidated_revenue_by_region_with_amobee

      UNION ALL

      -- ============================================================
      -- LIVE FY2026+ : AMOBEE DSP
      -- ============================================================
      (WITH exchange_region_revenue AS (
      SELECT
      YEAR(event_date) AS year,
      QUARTER(event_date) AS quarter,
      CASE
      WHEN country = 'United States' THEN 'America - US'
      WHEN geo_region = 'Americas' THEN 'America - ROW'
      WHEN geo_region NOT IN ('Unknown','APAC','EMEA','Americas') THEN 'Other'
      ELSE geo_region
      END AS region,
      SUM(revenue) AS revenue
      FROM BI.DRR_Exch_1P_Demand_Offset
      WHERE event_date >= '2026-01-01'
      AND event_date < current_date()
      GROUP BY 1, 2, 3
      ),
      exchange_distribution AS (
      SELECT
      year, quarter, region,
      revenue / NULLIF(SUM(revenue) OVER (PARTITION BY year, quarter), 0) AS region_pct
      FROM exchange_region_revenue
      ),
      dsp_quarterly AS (
      SELECT
      YEAR(event_date) AS year,
      QUARTER(event_date) AS quarter,
      'DSP' AS category,
      SUM(0) AS revenue,
      SUM(Tremor_Cost * -1) AS cost
      FROM BI.DRR_AmobeeDSP_Base_Metrics d
      WHERE event_date >= '2026-01-01'
      AND event_date < current_date()
      AND ABS(tremor_cost) > 0
      GROUP BY 1, 2, 3
      )
      SELECT
      d.year,
      d.quarter,
      x.region,
      d.category,
      d.revenue,
      d.cost * x.region_pct AS cost
      FROM dsp_quarterly d
      INNER JOIN exchange_distribution x
      ON x.year = d.year AND x.quarter = d.quarter
      ORDER BY d.quarter, x.region)

      UNION ALL

      -- ============================================================
      -- LIVE FY2026+ : COUNTRY CONSOLIDATION
      -- ============================================================
      SELECT
      YEAR(event_date) AS Year,
      QUARTER(event_date) AS Quarter,
      CASE
      WHEN geo_report_region = 'United States' THEN 'America - US'
      WHEN category = 'DSP' AND region = 'Americas' THEN 'America - US'
      WHEN geo_report_region = 'Americas - Other'
      OR region = 'Americas' THEN 'America - ROW'
      WHEN region NOT IN ('Unknown','APAC','EMEA','Americas') THEN 'Other'
      ELSE region
      END AS region,
      category,
      SUM(CASE WHEN event_date >= '2022-01-01' AND record_type = 'Interco' THEN 0
      ELSE revenue END) AS Revenue,
      SUM(CASE WHEN event_date >= '2022-01-01' AND record_type = 'Interco' THEN 0
      ELSE cost END) AS Cost
      FROM BI.DRR_Country_Consolidation
      WHERE event_date >= '2026-01-01'
      AND event_date < current_date()
      AND (File_record = 'Amobee DSP - Base Metrics'
      OR category = 'Exchange')
      GROUP BY 1, 2, 3, 4

      UNION ALL

      -- ============================================================
      -- LIVE FY2026+ : DAILY REVENUE REPORT
      -- Note: Americas → America - US in this block (different from Country Consolidation)
      -- ============================================================
      SELECT
      YEAR(event_date) AS Year,
      QUARTER(event_date) AS Quarter,
      CASE
      WHEN region = 'Americas' THEN 'America - US'
      WHEN region NOT IN ('Unknown','APAC','EMEA','Americas') THEN 'Other'
      ELSE region
      END AS region,
      category,
      SUM(CASE WHEN event_date >= '2022-01-01' AND record_type = 'Interco' THEN 0
      ELSE revenue END) AS Revenue,
      SUM(CASE WHEN event_date >= '2022-01-01' AND record_type = 'Interco' THEN 0
      ELSE cost END) AS Cost
      FROM BI.DRR_Daily_Revenue_Report
      WHERE event_date >= '2026-01-01'
      AND event_date < current_date()
      AND File_record <> 'Amobee DSP - Base Metrics'
      AND category NOT IN ('Exchange','Interco')
      GROUP BY 1, 2, 3, 4

      UNION ALL

    -- ============================================================
    -- LIVE FY2026+ : EXCHANGE INTERCO
    -- ============================================================
    SELECT
        YEAR(event_date) AS Year,
        QUARTER(event_date) AS Quarter,
        CASE
            WHEN country = 'United States' THEN 'America - US'
            WHEN geo_region = 'Americas' THEN 'America - ROW'
            WHEN geo_region NOT IN ('Unknown','APAC','EMEA','Americas') THEN 'Other'
            ELSE geo_region
        END AS region,
        'Exchange' AS category,
        SUM(revenue) AS Revenue,
        SUM(cost) AS Cost
    FROM BI.DRR_Exch_1P_Demand_Offset
    WHERE event_date >= '2026-01-01'
      AND event_date < current_date()
    GROUP BY 1, 2, 3, 4

    UNION ALL

    -- ============================================================
    -- LIVE FY2026+ : GOOGLE SOW
    -- ============================================================
    SELECT
        YEAR(event_date) AS Year,
        QUARTER(event_date) AS Quarter,
        CASE
            WHEN region = 'Americas' THEN 'America - US'
            WHEN region NOT IN ('Unknown','APAC','EMEA','Americas') THEN 'Other'
            ELSE region
        END AS region,
        Subcategory AS category,
        SUM(Revenue) AS Revenue,
        SUM(cost) AS Cost
    FROM BI.SVC_DRR_Google_SOW
    WHERE event_date >= '2026-01-01'
      AND event_date < current_date()
    GROUP BY 1, 2, 3, 4

    UNION ALL

    -- ============================================================
    -- LIVE FY2026+ : DATA ALLOCATION MCvI
    -- ============================================================
    SELECT
        YEAR(event_date) AS Year,
        QUARTER(event_date) AS Quarter,
        CASE
            WHEN region = 'Americas' THEN 'America - US'
            WHEN region NOT IN ('Unknown','APAC','EMEA','Americas') THEN 'Other'
            ELSE region
        END AS region,
        Subcategory AS category,
        SUM(Revenue) AS Revenue,
        SUM(cost) AS Cost
    FROM BI.SVC_DRR_Data_Allocation_MCvI
    WHERE event_date >= '2026-01-01'
      AND event_date < current_date()
    GROUP BY 1, 2, 3, 4
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: year {
    type: number
    label: "Year"
    sql: ${TABLE}.Year ;;
  }

  dimension: quarter {
    type: number
    label: "Quarter"
    sql: ${TABLE}.Quarter ;;
  }

  dimension: region {
    type: string
    label: "Region"
    sql: ${TABLE}.region ;;
  }

  dimension: category {
    type: string
    label: "Category"
    sql: ${TABLE}.category ;;
  }

  measure: revenue {
    type: sum
    value_format: "$#,##0"
    label: "Revenue"
    sql: ${TABLE}.Revenue ;;
  }

  measure: cost {
    type: sum
    value_format: "$#,##0"
    label: "Cost"
    sql: ${TABLE}.Cost ;;
  }

  set: detail {
    fields: [
      year,
      quarter,
      region,
      category,
      revenue,
      cost
    ]
  }
}
