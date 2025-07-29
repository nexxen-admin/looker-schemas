
view: purple_labs_audience_quality {
  derived_table: {
    sql: WITH firstp_data AS (
  SELECT
    TIMESTAMPADD('day', 7 * CAST(FLOOR(TIMESTAMPDIFF('day', DATE '2025-05-01', fnd.date_key) / 7) AS INT), DATE '2025-05-01')::DATE AS cohort_start_date,
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
  WHERE fnd.date_key >= '2025-05-01'
    AND fnd.date_key < CURRENT_DATE
    AND (fnd.impressions > 0 OR fnd.cost > 0)
  GROUP BY 1,2,3,4,5,6,7
  ORDER BY 1 ASC
),

purplelabs_data AS (
  SELECT
    date::DATE AS date,
    client_id,
    coverage,
    execution_id,
    grouper_value,
    unique_patient_count
  FROM SunFlower.purplelab_audience_quality
  WHERE date >= '2025-05-01'
    AND date < CURRENT_DATE
  ORDER BY 1 ASC
)

SELECT
  p.date AS cohort_start_date,
  p.client_id,
  p.execution_id,
  p.grouper_value,
  p.coverage,
  p.unique_patient_count,

  f.advertiser_id,
  f.advertiser_name,
  f.line_item_id,
  f.line_item_name,
  f.insertion_order_id,
  f.insertion_order_name,
  f.impressions,
  f.cost

FROM purplelabs_data p
  LEFT JOIN firstp_data f
    ON f.cohort_start_date = p.date
    AND f.line_item_id = p.grouper_value
ORDER BY p.date ASC ;;
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

  dimension: insertion_order_id {
    type: string
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
