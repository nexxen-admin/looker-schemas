
view: segment_syndication {
  derived_table: {
    sql: Select a.*,
        sa.cpm as RX_CPM,
        sa.targeting_type as RX_Targeting_Type,
        case when sa.disabled_at is not NULL
          then 'Disabled'
          else 'Not-Disabled'
          end as RX_Disabled,
        s.status as RX_Status
      From bi_new.dim_segment_data_apprdb a
        left join andromeda.rx_dim_segment_audience_r sa on sa.dmp_audience_id::varchar = a.segment_id
        left join andromeda.rx_dim_segment s on substring(s.segment_name,12,10) = a.segment_id
                            and s.segment_name ilike 'radiumone::132%' ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: segment_id {
    type: string
    sql: ${TABLE}.SEGMENT_ID ;;
  }

  dimension: segment_name {
    type: string
    sql: ${TABLE}.SEGMENT_NAME ;;
    case_sensitive: no
  }

  dimension: market_id {
    type: string
    sql: ${TABLE}.MARKET_ID ;;
  }

  dimension: market_name {
    type: string
    sql: ${TABLE}.MARKET_NAME ;;
  }

  dimension: data_provider_id {
    type: string
    sql: ${TABLE}.DATA_PROVIDER_ID ;;
  }

  dimension: parent_data_provider_id {
    type: string
    sql: ${TABLE}.PARENT_DATA_PROVIDER_ID ;;
  }

  dimension: data_provider_name {
    type: string
    sql: ${TABLE}.DATA_PROVIDER_NAME ;;
  }

  dimension: data_contract_id {
    type: string
    sql: ${TABLE}.DATA_CONTRACT_ID ;;
  }

  dimension: data_contract_name {
    type: string
    sql: ${TABLE}.DATA_CONTRACT_NAME ;;
  }

  dimension: internal_category_id {
    type: string
    sql: ${TABLE}.INTERNAL_CATEGORY_ID ;;
  }

  dimension: external_category_id {
    type: string
    sql: ${TABLE}.EXTERNAL_CATEGORY_ID ;;
  }

  dimension: category_name {
    type: string
    sql: ${TABLE}.CATEGORY_NAME ;;
  }

  dimension: data_contract_pricing_type_id {
    type: string
    sql: ${TABLE}.DATA_CONTRACT_PRICING_TYPE_ID ;;
  }

  dimension: data_contract_pricing_type {
    type: string
    sql: ${TABLE}.DATA_CONTRACT_PRICING_TYPE ;;
  }

  measure: contract_cpm {
    type: sum
    sql: ${TABLE}.contract_cpm ;;
    value_format: "$#,##0.00"
  }

  measure: estimated_cpm {
    type: sum
    sql: ${TABLE}.estimated_cpm ;;
    label: "AVG Est. CPM"
    value_format: "$#,##0.00"
  }

  measure: rate_cpm {
    type: sum
    sql: ${TABLE}.rate_cpm ;;
    value_format: "$#,##0.00"
  }

  dimension: always_on {
    type: string
    sql: ${TABLE}.ALWAYS_ON ;;
  }

  dimension: is_active {
    type: string
    label: "DMP Status"
    sql: case when ${TABLE}.is_active='true' then 'Active' when ${TABLE}.is_active = 'false' then 'Inactive' else 'Null' end;;
  }

  dimension: full_path_name {
    type: string
    sql: ${TABLE}.FULL_PATH_NAME ;;
  }

  dimension: is_unique {
    type: string
    sql: ${TABLE}.IS_UNIQUE ;;
  }

  dimension: first_syndication {
    type: date
    sql: ${TABLE}.first_syndication ;;
  }

  dimension: last_syndication {
    type: date
    sql: ${TABLE}.last_syndication ;;
  }

  dimension_group: db_updated_date {
    type: time
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }

  measure: rx_cpm {
    type: sum
    sql: ${TABLE}.RX_CPM ;;
    value_format: "$#,##0.00"
  }

  dimension: rx_targeting_type {
    type: string
    sql: ${TABLE}.RX_Targeting_Type ;;
  }

  dimension: rx_disabled {
    type: string
    sql: ${TABLE}.RX_Disabled ;;
  }

  dimension: rx_status {
    type: string
    sql: ${TABLE}.RX_Status ;;
  }

  dimension: pricing_discrepancy {
    type: string
    sql: case when ${TABLE}.contract_cpm=${TABLE}.RX_CPM then 'False' else 'True' end;;
  }

  set: detail {
    fields: [
        segment_id,
  segment_name,
  market_id,
  market_name,
  data_provider_id,
  parent_data_provider_id,
  data_provider_name,
  data_contract_id,
  data_contract_name,
  internal_category_id,
  external_category_id,
  category_name,
  data_contract_pricing_type_id,
  data_contract_pricing_type,
  contract_cpm,
  always_on,
  full_path_name,
  is_unique,
  db_updated_date_time,
  rx_cpm,
  rx_targeting_type,
  rx_disabled,
  rx_status
    ]
  }
}
