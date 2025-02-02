view: dim_dsp_dma {
  sql_table_name: BI_DSP.dim_dsp_dma ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden: yes
  }
  dimension: dma_key {
    type: number
    sql: ${TABLE}.dma_key ;;
    hidden: yes
  }
  dimension: dma_name {
    type: string
    sql: ${TABLE}.dma_name ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [dma_name]
    hidden: yes
  }
}
