view: dim_dsp_mobile_app {
  sql_table_name: BI_DSP.dim_dsp_mobile_app ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden:  yes
  }
  dimension_group: db_updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_updated_date ;;
    hidden:  yes
  }
  dimension: mobile_app_key {
    type: number
    sql: ${TABLE}.mobile_app_key ;;
    hidden:  yes
  }
  dimension: mobile_app_name {
    type: string
    sql: ${TABLE}.mobile_app_name ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden:  yes
  }
  measure: count {
    type: count
    drill_fields: [mobile_app_name]
    hidden:  yes
  }
}
