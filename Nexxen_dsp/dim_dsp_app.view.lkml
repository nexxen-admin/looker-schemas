view: dim_dsp_app {
  sql_table_name: BI_DSP.dim_dsp_app ;;

  dimension: app_id {
    type: string
    label: "App ID"
    sql: ${TABLE}.app_id ;;
  }
  dimension: app_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.app_id_key ;;
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
