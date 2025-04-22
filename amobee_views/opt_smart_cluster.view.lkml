view: opt_smart_cluster {

  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT c.placement_id,c.cluster_id,c.cluster_type_id,c.q_value*m.m_value as forecast_request_volume,ranking
FROM AN_SMART..cluster (nolock)c
JOIN AN_SMART..opt_m_by_day_override (nolock)m
  on m.placement_id=c.placement_id
  and m.day_id=0
  and m.opt_run_type_id IN (2,6,13)
WHERE c.active=1
and c.q_value>0
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: cluster_id {
    description: "cluster_id"
    type: number
    sql: ${TABLE}.cluster_id ;;
    value_format_name: id
  }
  dimension: placement_id {
    description: "placement_id"
    type: number
    sql: ${TABLE}.placement_id ;;
    value_format_name: id
  }
  dimension: cluster_type_id {
    description: "The type of cluster"
    type: number
    sql: ${TABLE}.cluster_type_id ;;
    value_format_name: id
  }
  dimension: forecast_request_volume {
    description: "The forecast daily request volume"
    type: number
    sql: ${TABLE}.forecast_request_volume ;;
  }
  dimension: rank {
    description: "The cluster rank"
    type: number
    sql: ${TABLE}.ranking ;;
  }
  measure: total_request_volume {
    description: "Use this for summing forecast_request_volume"
    type: sum
    sql: ${forecast_request_volume} ;;
  }



}
