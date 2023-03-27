view: opt_smart_cluster_kpi_performance {
  # You can specify the table name if it's different from the view name:
  sql_table_name: AN_SMART..cluster_kpi_performance ;;

  # Define your dimensions and measures here, like this:
  dimension: cluster_id {
    description: "cluster_id"
    type: number
    sql: ${TABLE}.cluster_id ;;
    value_format_name: id
  }

  dimension: kpi_id {
    description: "KPI"
    type: number
    sql: ${TABLE}.kpi_id ;;
    value_format_name: id
  }
  dimension: vendor_id {
    description: "vendor_id"
    type: number
    sql: ${TABLE}.vendor_id ;;
    value_format_name: id
  }
  dimension: performance {
    description: "performance"
    type: number
    sql: ${TABLE}.performance ;;
  }

}
