view: dim_dsp_environment {
  sql_table_name: BI_DSP.dim_dsp_environment ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }
  dimension: environment {
    type: string
    sql: ${TABLE}.environment ;;
  }
  dimension: environment_id {
    type: number
    sql: ${TABLE}.environment_id ;;
  }
  dimension: environment_key {
    type: number
    sql: ${TABLE}.environment_key ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
  }
  measure: count {
    type: count
  }
}
