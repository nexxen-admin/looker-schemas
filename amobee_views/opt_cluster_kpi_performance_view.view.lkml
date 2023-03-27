
view: opt_cluster_kpi_performance_view {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT pv.description as  vendor,kp.description as kpi,dt.description as device_type,country.description as country,p.placement_id,p.placement_name,c.cluster_id,c.cluster_type_id,c.q_value*m.m_value as forecast_request_volume,ckp.performance
FROM AN_MAIN..placement (Nolock) p
JOIN AN_SMART..cluster (nolock)c
  on c.placement_id=p.placement_id
  and c.active=1
  and c.q_value>0
JOIN AN_MAIN..country (nolock)country
  on country.country_id=p.country_id
JOIN AN_MAIN..device_type (nolock)dt
  on dt.device_type_id=p.device_type_id
JOIN AN_SMART..opt_m_by_day_override (nolock)m
  on m.placement_id=p.placement_id
  and m.day_id=0
  and m.opt_run_type_id IN (2,6,13)
JOIN AN_SMART..cluster_kpi_performance (Nolock)ckp
  on ckp.cluster_id=c.cluster_id
JOIN AN_SMART..kpi (Nolock)kp
  on kp.kpi_id=ckp.kpi_id
JOIN AN_MAIN..pricing_vendor (nolock)pv
  on pv.pricing_vendor_id=ckp.vendor_id
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: vendor {
    description: "KPI Vendor"
    type: string
    sql: ${TABLE}.vendor ;;
  }
  dimension: kpi {
    description: "KPI"
    type: string
    sql: ${TABLE}.user_id ;;
  }
  dimension: country {
    description: "country"
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: placement_name {
    description: "placement_name"
    type: string
    sql: ${TABLE}.placement_name ;;
  }


  dimension: placement_id {
    description: "placement_id"
    type: number
    sql: ${TABLE}.placement_id ;;
    value_format_name: id
  }
  dimension: cluster_id {
    description: "cluster_id"
    type: number
    sql: ${TABLE}.cluster_id ;;
    value_format_name: id
  }

  dimension: performance {
    description: "performance"
    type: number
    sql: ${TABLE}.performance ;;
  }

  dimension: forecast_request_volume {
    hidden: yes
    description: "forecast_request_volume"
    type: number
    sql: ${TABLE}.forecast_request_volume ;;
  }

  measure: total_request_volume {
    description: "Request Volume Forecast"
    type: sum
    sql: ${forecast_request_volume} ;;
  }
}
