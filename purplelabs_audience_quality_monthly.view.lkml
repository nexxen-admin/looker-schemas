
view: purplelabs_audience_quality_monthly {
  derived_table: {
    sql: WITH firstp_data AS (
        SELECT
         date_trunc('month',fnd.date_key)::date as cohort_start_date,
          dda.advertiser_id,
          dda.advertiser_name,
          ddli.line_item_id AS line_item_id,
          ddli.line_item_name AS line_item_name,
          ddio.insertion_order_id AS insertion_order_id,
          ddio.insertion_order_name AS insertion_order_name,
          SUM(fnd.impressions) AS impressions,
          SUM(fnd.cost) AS cost
        FROM BI_DSP.fact_nexxen_dsp fnd
          INNER JOIN BI_DSP.dim_dsp_advertiser dda ON dda.advertiser_id_key = fnd.advertiser_id_key
          INNER JOIN BI_DSP.dim_dsp_line_item ddli ON ddli.line_item_id_key = fnd.line_item_key
          INNER JOIN BI_DSP.dim_dsp_insertion_order ddio ON ddio.insertion_order_id = ddli.insertion_order_id
        WHERE fnd.date_key >= '2025-07-01'
          AND fnd.date_key < CURRENT_DATE
          AND (fnd.impressions > 0 OR fnd.cost > 0)
        GROUP BY 1,2,3,4,5,6,7
      ),

      agg_purplelabs_data AS (
        SELECT
          date_trunc('month',date)::DATE AS date,
          grouper_value,
          MAX(client_id) AS client_id,
          MAX(execution_id) AS execution_id,
          AVG(CASE WHEN coverage = 'Less than 100 patients in CG' THEN NULL
                   ELSE REPLACE(coverage, '%', '')::FLOAT / 100
              END) AS coverage,
          SUM(CASE WHEN unique_patient_count = 'Too small to measure' THEN 0
                   ELSE unique_patient_count::INT
              END) AS unique_patient_count
        FROM SunFlower.purplelab_audience_quality_monthly
        WHERE date >= '2025-07-01'
          AND date < CURRENT_DATE
        GROUP BY 1, 2
      )

      SELECT
        p.date AS cohort_start_date,
        f.advertiser_id,
        f.advertiser_name,
        f.insertion_order_id,
        f.insertion_order_name,
        p.grouper_value,
        f.line_item_name,
        p.client_id,
        p.execution_id,
        p.coverage,
        p.unique_patient_count,
        COALESCE(f.impressions, 0) AS impressions,
        COALESCE(f.cost, 0) AS cost
      FROM agg_purplelabs_data p
      LEFT JOIN firstp_data f
        ON p.date = f.cohort_start_date
       AND p.grouper_value = f.line_item_id
      ORDER BY p.date ASC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
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

  dimension: insertion_order_id {
    type: number
    sql: ${TABLE}.insertion_order_id ;;
  }

  dimension: insertion_order_name {
    type: string
    sql: ${TABLE}.insertion_order_name ;;
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
    value_format: "#,##0"
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
  insertion_order_id,
  insertion_order_name,
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
