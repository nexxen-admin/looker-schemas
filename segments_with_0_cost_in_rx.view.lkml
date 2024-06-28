
view: segments_with_0_cost_in_rx {
  derived_table: {
    sql: SELECT date_trunc('month',sud.event_time)::date AS event_month,
             sud.export_name AS segment_id,
             CASE WHEN sud.segment_type = 'comscore' OR sud.segment_type = 'grapeshot' then sud.export_name ELSE dsda.SEGMENT_NAME END AS segment_name,
             sud.segment_type,
             dsda.EXTERNAL_CATEGORY_ID as category_id,
           dsda.FULL_PATH_NAME as category_name,
           CASE WHEN dsda.DATA_PROVIDER_NAME IS NOT Null THEN dsda.DATA_PROVIDER_NAME ELSE 'Comscore/Grapeshot RX Integration' END AS Vendor,
           CASE WHEN dsda.DATA_PROVIDER_NAME ilike '%Liveramp CustomLoad' OR dsda.DATA_PROVIDER_NAME ilike '%Liveramp CustomData' AND dsda.FULL_PATH_NAME ilike '%1P%' OR dsda.FULL_PATH_NAME ilike '%2P%' THEN 'True' ELSE 'FALSE' END AS "IsValid Zero CPM",
           CASE WHEN segment_type = 'grapeshot' OR segment_type = 'comscore' THEN 'N/A' ELSE 'AlwaysOn' END AS is_always_on,
             dsda.ESTIMATED_CPM as rx_segment_cpm,
             dsda.RATE_CPM as DMP_CPM,
             rds.cpm as grapeshot_cpm,
             SUM(sud.impressions) as impressions,
           (SUM(sud.cost) / SUM(sud.impressions))*1000 AS eCPM,
           CASE WHEN sud.segment_type ilike 'grapeshot%' THEN (SUM(sud.impressions)/1000) * rds.CPM
              WHEN sud.segment_type = 'audience' THEN (SUM(sud.impressions)/1000) * dsda.RATE_CPM
              ELSE SUM(sud.cost) END AS Calculated_Cost,
             SUM(sud.cost) AS rx_cost
      FROM andromeda.segment_usage_daily sud
      LEFT OUTER JOIN BI_NEW.dim_segment_data_apprdb dsda on sud.export_name = dsda.SEGMENT_ID
      LEFT OUTER JOIN andromeda.rx_dim_segment rds on sud.export_name = rds.segment_name AND status = 'active'
      WHERE sud.event_time >= '2024-01-01'
        and sud.event_time < CURRENT_DATE()
        AND sud.charged = 1
        AND sud.cost = 0
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
      ORDER BY 1 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_month {
    type: date
    sql: ${TABLE}.event_month ;;
  }

  dimension: segment_id {
    type: string
    sql: ${TABLE}.segment_id ;;
  }

  dimension: segment_name {
    type: string
    sql: ${TABLE}.segment_name ;;
  }

  dimension: segment_type {
    type: string
    sql: ${TABLE}.segment_type ;;
  }

  dimension: category_id {
    type: string
    sql: ${TABLE}.category_id ;;
  }

  dimension: category_name {
    type: string
    sql: ${TABLE}.category_name ;;
  }

  dimension: vendor {
    type: string
    sql: ${TABLE}.Vendor ;;
  }

  dimension: is_valid_zero_cpm {
    type: string
    label: "IsValid Zero CPM"
    sql: ${TABLE}."IsValid Zero CPM" ;;
  }

  dimension: is_always_on {
    type: string
    sql: ${TABLE}.is_always_on ;;
  }

  measure: rx_segment_cpm {
    type: number
    sql: ${TABLE}.rx_segment_cpm ;;
  }

  dimension: dmp_cpm {
    type: number
    sql: ${TABLE}.DMP_CPM ;;
  }

  dimension: grapeshot_cpm {
    type: number
    sql: ${TABLE}.grapeshot_cpm ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  measure: e_cpm {
    type: sum
    sql: ${TABLE}.eCPM ;;
  }

  measure: calculated_cost {
    type: sum
    sql: ${TABLE}.Calculated_Cost ;;
  }

  measure: rx_cost {
    type: sum
    sql: ${TABLE}.rx_cost ;;
  }

  set: detail {
    fields: [
        event_month,
  segment_id,
  segment_name,
  segment_type,
  category_id,
  category_name,
  vendor,
  is_valid_zero_cpm,
  is_always_on,
  rx_segment_cpm,
  dmp_cpm,
  grapeshot_cpm,
  impressions,
  e_cpm,
  calculated_cost,
  rx_cost
    ]
  }
}
