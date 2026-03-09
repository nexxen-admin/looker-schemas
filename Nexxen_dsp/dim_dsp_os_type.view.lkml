view: dim_dsp_os_type {
  sql_table_name: BI_DSP.dim_dsp_os_type ;;

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
  dimension: os_type {
    type: string
    label: "OS Type"
    sql: ${TABLE}.os_type ;;
  }
  dimension: os_type_key {
    type: number
    sql: ${TABLE}.os_type_key ;;
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
