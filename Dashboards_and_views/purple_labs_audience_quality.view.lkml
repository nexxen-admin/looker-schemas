
view: purple_labs_audience_quality {
  derived_table: {
    sql: WITH firstp_data AS (
  Select
      TIMESTAMPADD('day', 7 * CAST(FLOOR(TIMESTAMPDIFF('day', DATE '2025-05-01', amd.event_time) / 7) AS INT), DATE '2025-05-01')::DATE AS cohort_start_date,
      amd.advertiser_id,
      a.advertiser_name,
      amd.line_item_id as line_item_id,
      li.line_item_name as line_item_name,
      amd.insertion_order_id,
      io.insertion_order_name as insertion_order_name,
      sum(amd.impressions) as impressions,
      sum(amd.cost) as Cost
   From SunFlower.amobee_media_daily_mtz_ui amd
    left outer join SunFlower.dim_advertiser a on a.advertiser_id = amd.advertiser_id
    left outer join SunFlower.dim_lineitem li on li.line_item_id = amd.line_item_id
    left outer join SunFlower.dim_io io on io.insertion_order_id = amd.insertion_order_id
Where amd.event_time >= '2025-05-01'
  and amd.event_time < CURRENT_DATE
  and (amd.impressions > 0 or amd.cost >0)
  and amd.market_id = 2139
Group by 1, 2, 3, 4, 5, 6, 7
),

agg_purplelabs_data AS (
  SELECT
    date::DATE AS date,
    grouper_value,
    MAX(client_id) AS client_id,
    MAX(execution_id) AS execution_id,
    AVG(CASE WHEN coverage = 'Less than 100 patients in CG' THEN NULL
             ELSE REPLACE(coverage, '%', '')::FLOAT / 100
        END) AS coverage,
    SUM(CASE WHEN unique_patient_count = 'Too small to measure' THEN 0
             ELSE unique_patient_count::INT
        END) AS unique_patient_count
  FROM SunFlower.purplelab_audience_quality
  WHERE date >= '2025-05-01'
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
;;
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
