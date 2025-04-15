view: dim_dsp_device_manufacturer {
  sql_table_name: BI_DSP.dim_dsp_device_manufacturer ;;

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
  dimension: device_manufacturer {
    type: string
    sql: ${TABLE}.device_manufacturer ;;
  }
  dimension: device_manufacturer_key {
    type: number
    sql: ${TABLE}.device_manufacturer_key ;;
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
