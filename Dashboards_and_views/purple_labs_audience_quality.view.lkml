
view: purple_labs_audience_quality {
  derived_table: {
    sql: WITH firstp_data as (
      SELECT TIMESTAMPADD('day', 7 * CAST(FLOOR(TIMESTAMPDIFF('day', DATE '2025-05-01', fnd.date_key) / 7) AS INT),DATE '2025-05-01')::date AS cohort_start_date,
      dda.advertiser_id,
      dda.advertiser_name,
      ddli.line_item_id AS line_item_id,
      ddli.line_item_name as line_item_name,
      SUM(fnd.impressions) as impressions,
      SUM(fnd.cost) as cost
      FROM BI_DSP.fact_nexxen_dsp fnd
        inner join BI_DSP.dim_dsp_advertiser dda on dda.advertiser_id_key = fnd.advertiser_id_key
        inner join BI_DSP.dim_dsp_line_item ddli on ddli.line_item_id_key = fnd.line_item_key
      WHERE fnd.date_key >= '2025-05-01'
        AND fnd.date_key < current_date()
        AND ddli.line_item_id IN (1609876096,1609876102,1609876160,1609876166,1609876168,1609868158,1609988099,1609876169,
                           1609988097,1609951513,1609872634,1609988098,1609951662,1609876164)
        AND (impressions > 0 or cost > 0)
      GROUP BY 1,2,3,4,5
      ORDER BY 1 ASC
      ),

      purplelabs_data as (
      SELECT date::date as date,
      client_id,
      coverage,
      execution_id,
      grouper_value,
      unique_patient_count
      FROM SunFlower.purplelab_audience_quality
      WHERE date >= '2025-05-01'
        AND date < current_date()
        AND grouper_value IN (1609876096,1609876102,1609876160,1609876166,1609876168,1609868158,1609988099,1609876169,
                           1609988097,1609951513,1609872634,1609988098,1609951662,1609876164)
      ORDER BY 1 ASC
      )

      SELECT
      COALESCE(f.cohort_start_date, p.date) as cohort_start_date,
      f.advertiser_id as advertiser_id,
      f.advertiser_name as advertiser_name,
      COALESCE(f.line_item_id, p.grouper_value) as grouper_value,
      f.line_item_name as line_item_name,
      p.client_id as client_id,
      p.execution_id as execution_id,
      SUM(CASE
        WHEN p.coverage = 'Less than 100 patients in CG' THEN NULL
        ELSE CAST(REPLACE(p.coverage, '%', '') AS FLOAT) / 100
        END) AS coverage,
      SUM(CASE
        WHEN p.unique_patient_count = 'Too small to measure' THEN NULL
        ELSE CAST(p.unique_patient_count AS INTEGER)
        END) AS unique_patient_count,
      SUM(f.impressions) as impressions,
      SUM(f.cost) as cost
      FROM firstp_data f
        FULL OUTER JOIN purplelabs_data p on f.cohort_start_date = p.date
                          AND f.line_item_id = p.grouper_value
      GROUP BY 1,2,3,4,5,6,7
      ORDER BY cohort_start_date ASC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    hidden:  yes
  }

  dimension: cohort_start_date {
    type: date
    sql: ${TABLE}.cohort_start_date ;;
  }

  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
  }

  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }

  dimension: grouper_value {
    type: number
    sql: ${TABLE}.grouper_value ;;
  }

  dimension: line_item_name {
    type: string
    sql: ${TABLE}.line_item_name ;;
  }

  dimension: client_id {
    type: number
    sql: ${TABLE}.client_id ;;
  }

  dimension: execution_id {
    type: number
    sql: ${TABLE}.execution_id ;;
  }

  measure: coverage {
    type: sum
    sql: ${TABLE}.coverage ;;
    value_format: "0.00%"
  }

  measure: unique_patient_count {
    type: sum
    sql: ${TABLE}.unique_patient_count ;;
    value_format: "#,##0"
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
  }

  set: detail {
    fields: [
        cohort_start_date,
  advertiser_id,
  advertiser_name,
  grouper_value,
  line_item_name,
  client_id,
  execution_id,
  coverage,
  unique_patient_count,
  impressions,
  cost
    ]
  }
}
