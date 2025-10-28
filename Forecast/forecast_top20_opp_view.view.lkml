view: forecast_top20_opp_view {
  derived_table: {
    sql: WITH base AS(
SELECT
    forecast_data.stage,
    forecast_data.opportunity_name,
    forecast_data.Account_Name,
    forecast_data.related_brand_name,
    forecast_data.IO_Type,
    forecast_data.Probability_level,
     (CASE WHEN (CASE WHEN forecast_data.new_enterprise_team ILIKE '%Enterprise Sales%' THEN forecast_data.new_enterprise_team
              WHEN forecast_data.new_enterprise_team ILIKE '%Enterprise Services - National%' THEN 'Enterprise Sales'
              WHEN  forecast_data.new_enterprise_team ILIKE '%Political%' THEN 'Enterprise Sales - Political'
              WHEN forecast_data.strat_sales_team  ILIKE '%Barter Direct%' THEN forecast_data.strat_sales_team
            WHEN forecast_data.strat_sales_rvp ILIKE '%Strat Sales%' THEN forecast_data.strat_sales_rvp
            ELSE 'Unknown' END) ILIKE '%Enterprise Sales%' THEN 'Enterprise Sales'
              WHEN (CASE WHEN forecast_data.new_enterprise_team ILIKE '%Enterprise Sales%' THEN forecast_data.new_enterprise_team
              WHEN forecast_data.new_enterprise_team ILIKE '%Enterprise Services - National%' THEN 'Enterprise Sales'
              WHEN  forecast_data.new_enterprise_team ILIKE '%Political%' THEN 'Enterprise Sales - Political'
              WHEN forecast_data.strat_sales_team  ILIKE '%Barter Direct%' THEN forecast_data.strat_sales_team
            WHEN forecast_data.strat_sales_rvp ILIKE '%Strat Sales%' THEN forecast_data.strat_sales_rvp
            ELSE 'Unknown' END) ILIKE '%Strat Sales%' THEN 'Strategic Sales'
              WHEN (CASE WHEN forecast_data.new_enterprise_team ILIKE '%Enterprise Sales%' THEN forecast_data.new_enterprise_team
              WHEN forecast_data.new_enterprise_team ILIKE '%Enterprise Services - National%' THEN 'Enterprise Sales'
              WHEN  forecast_data.new_enterprise_team ILIKE '%Political%' THEN 'Enterprise Sales - Political'
              WHEN forecast_data.strat_sales_team  ILIKE '%Barter Direct%' THEN forecast_data.strat_sales_team
            WHEN forecast_data.strat_sales_rvp ILIKE '%Strat Sales%' THEN forecast_data.strat_sales_rvp
            ELSE 'Unknown' END) ILIKE '%Barter Direct%' THEN 'Barter Direct'
              WHEN (CASE WHEN forecast_data.new_enterprise_team ILIKE '%Enterprise Sales%' THEN forecast_data.new_enterprise_team
              WHEN forecast_data.new_enterprise_team ILIKE '%Enterprise Services - National%' THEN 'Enterprise Sales'
              WHEN  forecast_data.new_enterprise_team ILIKE '%Political%' THEN 'Enterprise Sales - Political'
              WHEN forecast_data.strat_sales_team  ILIKE '%Barter Direct%' THEN forecast_data.strat_sales_team
            WHEN forecast_data.strat_sales_rvp ILIKE '%Strat Sales%' THEN forecast_data.strat_sales_rvp
            ELSE 'Unknown' END) ILIKE 'Unknown' THEN 'Unknown'
            END) AS "chance_team",
    CASE
          WHEN forecast_data.opportunity_name IS NULL THEN 'no'
          WHEN forecast_data.opportunity_name ILIKE '%PMP%' THEN 'yes'
          ELSE 'no'
        END  AS "pmp_y_n",
        (DATE(forecast_data.report_month )) AS "report_month",
    forecast_data.revenue_line  AS "revenue_line",
    CASE
          WHEN forecast_data.stage ILIKE '%Closed Won%' THEN 'Booked'
          WHEN forecast_data.stage ILIKE '%Closed Lost%' THEN 'Lost'

          WHEN forecast_data.stage = 'Verbal' THEN 'Committed'
          WHEN forecast_data.stage = 'Final Approval' THEN 'Committed'

      WHEN forecast_data.stage = 'Discovery Meeting' THEN 'Pre-Pipeline'
      WHEN forecast_data.stage = 'Draft' THEN 'Pre-Pipeline'

      ELSE 'Pipeline'
      END  AS "revenue_stage_leadership",
    COALESCE(SUM(COALESCE(forecast_data.schedule_converted_revenue_v2, 0) ), 0) AS "unweighted_gr_pipeline",
    COALESCE(SUM(COALESCE(forecast_data.schedule_converted_revenue_v2  * forecast_data.Probability_level / 100,0) ), 0) AS "weighted_gr_pipeline",
    COALESCE(SUM(forecast_data.GR_Forecast_Full_Credit ), 0) AS "gr_forecast",
    COALESCE(SUM(COALESCE(forecast_data.schedule_converted_revenue_v2 * forecast_data.opportunity_Margin / 100,0) ), 0) AS "unweighted_nr_pipeline",
    COALESCE(SUM(COALESCE(forecast_data.schedule_converted_revenue_v2  * forecast_data.opportunity_Margin / 100)* forecast_data.Probability_level /100), 0) AS "weighted_nr_pipeline",
    COALESCE(SUM(forecast_data.snapshot_NR_Forecast_Full_Credit ), 0) AS "nr_forecast"
FROM BI_DSP.Forecast_Data  AS forecast_data
WHERE
 forecast_data.IO_Super_Region ILIKE '%NAM%'
  AND forecast_data.Snapshot_Forecast_Checkbox = 1
  AND forecast_data.opportunity_record_type NOT ILIKE '%MSA Contract Opportunity%'
  AND forecast_data.opportunity_record_type NOT ILIKE '%Upsell Opportunity%'
  AND (CASE
          WHEN forecast_data.stage ILIKE '%Closed Won%' THEN 'Booked'
          WHEN forecast_data.stage ILIKE '%Closed Lost%' THEN 'Lost'

          WHEN forecast_data.stage = 'Verbal' THEN 'Committed'
          WHEN forecast_data.stage = 'Final Approval' THEN 'Committed'

      WHEN forecast_data.stage = 'Discovery Meeting' THEN 'Pre-Pipeline'
      WHEN forecast_data.stage = 'Draft' THEN 'Pre-Pipeline'

      ELSE 'Pipeline'
      END) = 'Pipeline'
GROUP BY
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10)

SELECT stage,
    opportunity_name,
    Account_Name,
    related_brand_name,
    IO_Type,
    Probability_level,
    SUM(unweighted_gr_pipeline) AS unweighted_gr_pipeline,
    SUM(weighted_gr_pipeline) AS weighted_gr_pipeline,
    SUM(gr_forecast) AS gr_forecast,
    SUM(unweighted_nr_pipeline) AS unweighted_nr_pipeline,
    SUM(weighted_nr_pipeline) AS weighted_nr_pipeline,
    SUM(nr_forecast) AS nr_forecast
FROM base
WHERE 1=1
  AND  {% condition report_month_filter %} report_month {% endcondition %}
  AND  {% condition reveue_line_filter %} revenue_line {% endcondition %}
  AND  {% condition chance_team_filter %} chance_team {% endcondition %}
  AND  {% condition stage_filter %} stage {% endcondition %}
  AND  {% condition io_type_filter %} IO_Type {% endcondition %}
  AND  {% condition pmp_y_n_filter %} pmp_y_n {% endcondition %}
GROUP BY 1,2,3,4,5,6
ORDER BY 7 DESC
LIMIT 20;;
  }

  filter: report_month_filter {
    type: date
  }

  filter: reveue_line_filter {
    type: string
  }

  filter: chance_team_filter {
    type: string
  }

  filter: stage_filter {
    type: string
  }

  filter: io_type_filter {
    type: string
    sql: {% condition io_type_filter %} IO_Type {% endcondition %};;
  }

  filter: pmp_y_n_filter {
    type: string
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.Account_Name ;;
  }
  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }
  dimension: Probability_level {
    type: number
    sql: ${TABLE}.Probability_level ;;
  }
  dimension: related_brand_name {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }
  dimension: io_type {
    type: string
    label: "Type"
    sql: ${TABLE}.IO_Type ;;
  }
  measure: gr_forecast {
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.GR_Forecast ;;
    label: "GR Forecast"
  }

  measure: nr_forecast {
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.NR_Forecast ;;
    label: "NR Forecast"
  }
  measure: unweighted_nr_pipeline {
    label: "Unweighted NR Pipeline"
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.unweighted_nr_pipeline  ;;
  }

  measure: weighted_nr_pipeline {
    label: "Weighted NR Pipeline"
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.weighted_nr_pipeline;;
  }
  measure: unweighted_gr_pipeline {
    label: "Unweighted GR Pipeline"
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.unweighted_gr_pipeline  ;;
  }

  measure: weighted_gr_pipeline {
    label: "Weighted GR Pipeline"
    value_format: "$#,##0"
    type: sum
    sql: ${TABLE}.weighted_gr_pipeline;;
  }

}
