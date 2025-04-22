view: dim_dsp_creative_size {
  sql_table_name: BI_DSP.dim_dsp_creative_size ;;

  dimension: creative_size {
    type: string
    sql: ${TABLE}.creative_size ;;
  }
  dimension: creative_size_key {
    type: number
    sql: ${TABLE}.creative_size_key ;;
    hidden: yes
  }
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
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }
  measure: count {
    type: count
    hidden: yes
  }
}
