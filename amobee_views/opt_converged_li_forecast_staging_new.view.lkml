view: converged_li_forecast_staging_new {
  sql_table_name: AN_SMART..converged_li_forecast_staging_new (NOLOCK) ;;
  label: "Demo Forecast"

  dimension_group: begin_datetime {
    type: time
    label: "Begin"
    timeframes: [time, date, month]
    sql: ${TABLE}.begin_datetime ;;
  }

  dimension: cluster_id {
    type: number
    label: "Cluster ID"
    hidden: yes
    value_format_name: id
    sql: ${TABLE}.cluster_id ;;
  }

  dimension_group: createdon {
    type: time
    hidden: yes
    timeframes: [time, date, month]
    sql: ${TABLE}.createdon ;;
  }

  dimension: eligible_impressions {
    type: number
    label: "Eligible Impressions"
    sql: ${TABLE}.eligible_impressions ;;
  }

  dimension_group: end_datetime {
    type: time
    label: "End"
    timeframes: [time, date, month]
    sql: ${TABLE}.end_datetime ;;
  }

  dimension: equiv_units {
    type: number
    hidden: yes
    sql: ${TABLE}.equiv_units ;;
  }

  dimension: json_params {
    type: string
    label: "Open Parameter"
    sql: ${TABLE}.json_params ;;
  }

  dimension: li_forecast_staging_id {
    type: number
    hidden: yes
    sql: ${TABLE}.li_forecast_staging_id ;;
  }

  dimension: rta_group_id {
    type: number
    view_label: "Retargeting Attribute"
    label: "RTA Group ID"
    sql: ${TABLE}.rta_group_id ;;
    value_format_name: id
  }

  dimension: source_id {
    type: number
    hidden: yes
    sql: ${TABLE}.source_id ;;
  }

  dimension: total_impressions {
    type: number
    label: "Total Impressions"
    sql: ${TABLE}.total_impressions ;;
  }

  dimension: unsmoothed_elg_imps {
    type: number
    hidden: yes
    sql: ${TABLE}.unsmoothed_elg_imps ;;
  }

  dimension: unsmoothed_tot_imps {
    type: number
    hidden: yes
    sql: ${TABLE}.unsmoothed_tot_imps ;;
  }

}
