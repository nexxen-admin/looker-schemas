view: dim_dsp_region {
  sql_table_name: BI_DSP.dim_dsp_region ;;

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
  dimension: region_id {
    type: number
    sql: ${TABLE}.region_id ;;
    hidden: yes
  }
  dimension: region_key {
    type: number
    sql: ${TABLE}.region_key ;;
    hidden: yes
  }
  dimension: region_name {
    type: string
    sql: ${TABLE}.region_name ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [region_name]
    hidden: yes
  }
}
