view: fce_atv_fdp_forecasts_data {
  label: "Forecasts Data"
  sql_table_name: fce_atv_fdp_forecasts.data ;;

  dimension: did {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.did ;;
  }

  dimension: iid {
    type: number
    hidden: yes
    sql: ${TABLE}.iid ;;
  }

  dimension_group: active_end {
    type: time
    label: "Active End"
    timeframes: [raw, time, date]
    sql: TO_TIMESTAMP_NTZ(${TABLE}.data_vals:active_end) ;;
  }

  dimension_group: active_start {
    type: time
    label: "Active Start"
    timeframes: [raw, time, date]
    sql: TO_TIMESTAMP_NTZ(${TABLE}.data_vals:active_start) ;;
  }

  dimension_group: end_datetime {
    type: time
    label: "End"
    timeframes: [raw, time, date]
    sql: TO_TIMESTAMP_NTZ(${TABLE}.data_vals:end_datetime) ;;
  }

  dimension: entity_id {
    type: string
    label: "Entity ID"
    sql: ${TABLE}.data_vals:entity_id::varchar ;;
  }

  dimension: entity_type {
    type: string
    label: "Entity Type"
    sql: ${TABLE}.data_vals:entity_type::varchar ;;
  }

  dimension: inventory_volume {
    type: number
    hidden: yes
    sql: ${TABLE}.data_vals:inventory_volume ;;
  }

  measure: sum_inventory_volume {
    type: sum
    label: "Inventory Volume"
    value_format_name: decimal_2
    sql: ${inventory_volume} ;;
  }

  dimension: m_override_id {
    type: number
    label: "M Override ID"
    value_format_name: id
    sql: ${TABLE}.data_vals:m_override_id ;;
  }

  dimension: opt_run_type_id {
    type: number
    label: "Opt Run Type ID"
    value_format_name: id
    sql: ${TABLE}.data_vals:opt_run_type_id ;;
  }

  dimension: placement_id {
    type: number
    label: "Placement ID"
    value_format_name: id
    sql: ${TABLE}.data_vals:placement_id ;;
  }

  dimension: pool_id {
    type: string
    label: "Pool ID"
    sql: ${TABLE}.data_vals:pool_id::varchar ;;
  }

  dimension: prk {
    type: number
    hidden: yes
    sql: ${TABLE}.data_vals:prk ;;
  }

  measure: sum_prk {
    type: sum
    label: "Prk"
    sql: ${prk} ;;
  }

  dimension_group: start_datetime {
    type: time
    label: "Start"
    timeframes: [raw, time, date]
    sql: TO_TIMESTAMP_NTZ(${TABLE}.data_vals:start_datetime) ;;
  }
}
