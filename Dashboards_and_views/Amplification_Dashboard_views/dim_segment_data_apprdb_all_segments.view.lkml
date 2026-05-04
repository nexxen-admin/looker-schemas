view: dim_segment_data_apprdb_all_segments {
  sql_table_name: BI_New.dim_segment_data_apprdb_all_segments ;;

  dimension: always_on {
    type: yesno
    sql: ${TABLE}.ALWAYS_ON ;;
  }
  dimension: category_name {
    type: string
    sql: ${TABLE}.CATEGORY_NAME ;;
  }
  dimension: contract_cpm {
    type: number
    sql: ${TABLE}.CONTRACT_CPM ;;
  }
  dimension_group: first_syndicated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.FIRST_SYNDICATION ;;
  }
  dimension: data_contract_id {
    type: number
    sql: ${TABLE}.DATA_CONTRACT_ID ;;
  }
  dimension: data_contract_name {
    type: string
    sql: ${TABLE}.DATA_CONTRACT_NAME ;;
  }
  dimension: data_contract_pricing_type {
    type: string
    sql: ${TABLE}.DATA_CONTRACT_PRICING_TYPE ;;
  }
  dimension: data_contract_pricing_type_id {
    type: number
    sql: ${TABLE}.DATA_CONTRACT_PRICING_TYPE_ID ;;
  }
  dimension: data_provider_id {
    type: number
    sql: ${TABLE}.DATA_PROVIDER_ID ;;
  }
  dimension: data_provider_name {
    type: string
    sql: ${TABLE}.DATA_PROVIDER_NAME ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.DB_UPDATED_DATE ;;
  }
  dimension: estimated_cpm {
    type: number
    sql: ${TABLE}.ESTIMATED_CPM ;;
  }
  dimension: external_category_id {
    type: string
    sql: ${TABLE}.EXTERNAL_CATEGORY_ID ;;
  }
  dimension: full_path_name {
    type: string
    sql: ${TABLE}.FULL_PATH_NAME ;;
  }
  dimension: internal_category_id {
    type: number
    sql: ${TABLE}.INTERNAL_CATEGORY_ID ;;
  }
  dimension: is_active {
    type: yesno
    sql: ${TABLE}.IS_ACTIVE ;;
  }
  dimension: is_unique {
    type: yesno
    sql: ${TABLE}.IS_UNIQUE ;;
  }
  dimension_group: last_syndicated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.LAST_SYNDICATION ;;
  }
  dimension: market_id {
    type: number
    sql: ${TABLE}.MARKET_ID ;;
  }
  dimension: market_name {
    type: string
    sql: ${TABLE}.MARKET_NAME ;;
  }
  dimension: parent_data_provider_id {
    type: number
    sql: ${TABLE}.PARENT_DATA_PROVIDER_ID ;;
  }
  dimension: rate_cpm {
    type: number
    sql: ${TABLE}.RATE_CPM ;;
  }
  dimension: segment_id {
    type: number
    sql: ${TABLE}.SEGMENT_ID ;;
  }
  dimension: segment_name {
    type: string
    sql: ${TABLE}.SEGMENT_NAME ;;
  }
  dimension: segment_type_id {
    type: number
    sql: ${TABLE}.segment_type_id ;;
  }
  dimension: segment_type_name {
    type: string
    sql: ${TABLE}.segment_type_name ;;
  }

  dimension: amplified_segment {
    label: "Amplified Segment"
    type: string
    sql:
      CASE
        WHEN (${segment_type_id} IN (21,23,24,26,27,29,30,31,32,34,36,38,39)
          OR ${segment_type_id} >= 42)
        THEN 'Yes' ELSE 'No'
      END ;;
  }

  dimension: custom_segment {
    label: "Custom Segment"
    type: string
    sql:
      CASE
        WHEN ${segment_type_id} IN (1,34,35,36,37,39,41,58,59,60,61,64,65,66,67,68,69,70,71)
        THEN 'Yes' ELSE 'No'
      END ;;
  }

  dimension: tv_amplified_segment {
    label: "TV Amplified Segment"
    type: string
    sql:
      CASE
        WHEN ${segment_type_id} IN (21,24,32,34,36,38,39,42,43,44,45,56,57,58,59,60,61,62,63,64,65)
        THEN 'Yes' ELSE 'No'
      END ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  market_name,
  full_path_name,
  data_contract_name,
  segment_type_name,
  data_provider_name,
  category_name,
  segment_name
  ]
  }

}
