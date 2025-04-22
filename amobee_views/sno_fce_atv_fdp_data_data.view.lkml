view: fce_atv_fdp_data_data {
  label: "Pool Data"
  sql_table_name: fce_atv_fdp_data.data ;;

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

  dimension: attribute_type {
    type: string
    label: "Attribute Type"
    sql: ${TABLE}.data_vals:attribute_type::varchar ;;
  }

  dimension: attribute_value {
    type: string
    label: "Attribute Value"
    sql: ${TABLE}.data_vals:attribute_value::varchar ;;
  }

  dimension: cluster_id {
    type: string
    label: "Cluster ID"
    sql: ${TABLE}.data_vals:cluster_id::varchar ;;
  }

  dimension: content_id {
    type: string
    label: "Content ID"
    sql: ${TABLE}.data_vals:content_id::varchar ;;
  }

  dimension: eligible_requests {
    type: number
    hidden: yes
    sql: ${TABLE}.data_vals:eligible_requests ;;
  }

  measure: sum_eligible_requests {
    type: sum
    label: "Eligible Requests"
    sql: ${eligible_requests} ;;
  }

  dimension_group: end_date_time {
    type: time
    label: "End"
    timeframes: [raw, time, date]
    sql: TO_TIMESTAMP_TZ(${TABLE}.data_vals:end_date_time) ;;
  }

  dimension: key {
    type: string
    label: "Key"
    sql: ${TABLE}.data_vals:key::varchar ;;
  }

  dimension: network_id {
    type: string
    label: "Network ID"
    sql: ${TABLE}.data_vals:network_id::varchar ;;
  }

  dimension: pool_id {
    type: string
    label: "Pool ID"
    sql: ${TABLE}.data_vals:pool_id::varchar ;;
  }

  dimension: pool_type {
    type: string
    label: "Pool Type"
    sql: ${TABLE}.data_vals:pool_type::varchar ;;
  }

  dimension: pod_position {
    type: string
    label: "Pod Position"
    sql: ${TABLE}.data_vals:pod_position::varchar ;;
  }

  dimension: property {
    type: string
    label: "Property"
    sql: ${TABLE}.data_vals:property::varchar ;;
  }

  dimension: requests {
    type: number
    hidden: yes
    sql: ${TABLE}.data_vals:requests ;;
  }

  measure: sum_requests {
    type: sum
    label: "Requests"
    sql: ${requests} ;;
  }

  dimension_group: start_date_time {
    type: time
    label: "Start"
    timeframes: [raw, time, date]
    sql: TO_TIMESTAMP_TZ(${TABLE}.data_vals:start_date_time) ;;
  }

  dimension: total_requests {
    type: number
    hidden: yes
    sql: ${TABLE}.data_vals:total_requests ;;
  }

  measure: sum_total_requests {
    type: sum
    label: "Total Requests"
    sql: ${total_requests} ;;
  }

  dimension: value {
    type: string
    label: "Value"
    sql: ${TABLE}.data_vals:value::varchar ;;
  }
}
