view: flight_media_placement_imp_stats_log {
  sql_table_name: vg_stage.flight_media_placement_imp_stats_log ;;
  label: "Short Cycle Logging Metrics"

  dimension: billable_units {
    type: number
    hidden: yes
    sql: ${TABLE}.billable_units ;;
  }

  dimension_group: createdon {
    type: time
    hidden: yes
    timeframes: [raw, time,hour, date, week, month,quarter,year]
    sql: ${TABLE}.createdon ;;
  }

  dimension: effective_units {
    type: number
    hidden: yes
    sql: ${TABLE}.effective_units ;;
  }

  dimension: file_name {
    type: string
    view_label: "Short Cycle Logging Facets"
    sql: ${TABLE}.file_name ;;
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.flight_media_id ;;
  }

  dimension_group: keydate {
    type: time
    label: "GMT"
    view_label: "Short Cycle Logging Facets"
    timeframes: [raw, time,hour, date, week, month,quarter,year]
    sql: ${TABLE}.keydate ;;
  }

  dimension_group: lastimp_datetime {
    type: time
    hidden: yes
    timeframes: [raw, time,hour, date, week, month,quarter,year]
    sql: ${TABLE}.lastimp_datetime ;;
  }

  dimension: log_id {
    type: number
    view_label: "Short Cycle Logging Facets"
    sql: ${TABLE}.log_id ;;
    value_format_name: id
  }

  dimension: payout {
    type: number
    hidden: yes
    sql: ${TABLE}.payout ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: units {
    type: number
    hidden: yes
    sql: ${TABLE}.units ;;
  }

  measure: sum_units {
    type: sum
    label: "Units"
    sql: ${units} ;;
  }

  measure: sum_billable_units {
    type: sum
    label: "Billable Units"
    sql: ${billable_units} ;;
  }

  measure: sum_payout {
    type: sum
    label: "Payout"
    sql: ${payout} ;;
  }

}
