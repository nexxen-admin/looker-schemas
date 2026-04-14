view: purple_labs_audience_quality_nebo {
    derived_table: {
      sql: WITH firstp_data AS (
  Select
      date_trunc('month',amd.event_time)::date as cohort_start_date,
      amd.advertiser_id,
      a.advertiser_name,
      amd.line_item_id as line_item_id,
      li.line_item_name as line_item_name,
      amd.insertion_order_id,
      io.insertion_order_name as insertion_order_name,
      amd.market_id,
      sum(amd.impressions) as impressions,
      sum(amd.cost) as Cost
   From SunFlower.amobee_media_daily_mtz_ui amd
    left outer join SunFlower.dim_advertiser a on a.advertiser_id = amd.advertiser_id
    left outer join SunFlower.dim_lineitem li on li.line_item_id = amd.line_item_id
    left outer join SunFlower.dim_io io on io.insertion_order_id = amd.insertion_order_id
Where amd.event_time >= '2025-07-01'
  and amd.event_time < CURRENT_DATE
  and (amd.impressions > 0 or amd.cost >0)
  and amd.market_id = 1602
Group by 1, 2, 3, 4, 5, 6, 7, 8
),

    agg_purplelabs_data AS (
        SELECT
          period_start,
          period_end,
          period_type,
          grouper_value,
          grouper_name,
          MAX(client_id) AS client_id,
          MAX(execution_id) AS execution_id,
          AVG(CASE WHEN coverage = 'There is not enough unique patients in g' THEN NULL
                   ELSE REPLACE(coverage, '%', '')::FLOAT / 100
              END) AS coverage,
          SUM(CASE WHEN unique_patient_count IN ('Too small to measure', 'There is not enough unique patients to m', 'There is not enough unique patients to measure (min unique patients count: 25)') THEN 0
                   ELSE unique_patient_count::INT
              END) AS unique_patient_count
        FROM SunFlower.purplelab_audience_quality_r
        WHERE period_start >= '2025-07-01'
          AND period_start < CURRENT_DATE
        GROUP BY 1, 2, 3, 4, 5
      )

      SELECT
        p.period_start,
        p.period_end,
        p.period_type,
        f.advertiser_id,
        f.advertiser_name,
        f.insertion_order_id,
        f.insertion_order_name,
        f.market_id,
        p.grouper_name,
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
        ON p.period_start = f.cohort_start_date
       AND (CASE WHEN p.grouper_name='line item id' THEN p.grouper_value END = f.line_item_id OR CASE WHEN p.grouper_name='insertion order id' THEN p.grouper_value END = f.insertion_order_id)
      ORDER BY p.period_start ASC
        ;;
    }

    dimension: period_start {
      type: date
      sql: ${TABLE}.period_start ;;
    }

  dimension: period_end {
    type: date
    sql: ${TABLE}.period_end ;;
  }

  dimension: period_type {
    type: string
    sql: ${TABLE}.period_type ;;
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

  dimension: grouper_name {
    type: string
    sql: ${TABLE}.grouper_name ;;
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

    dimension: market_id {
      type: string
      sql: ${TABLE}.market_id ;;
      hidden: yes
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


}
