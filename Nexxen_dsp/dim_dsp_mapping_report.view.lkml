view: dim_dsp_mapping_report {
  sql_table_name: BI_DSP.dim_dsp_mapping_report ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: data_type {
    type: string
    sql: ${TABLE}.data_type ;;
  }
  dimension: db_columns {
    type: string
    sql: ${TABLE}.db_columns ;;
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
  }
  dimension: file_columns {
    type: string
    sql: ${TABLE}.file_columns ;;
  }
  dimension: process_name {
    type: string
    sql: ${TABLE}.process_name ;;
  }
  measure: count {
    type: count
    drill_fields: [id, process_name]
  }
}
