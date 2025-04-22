view: dim_dsp_city {
  sql_table_name: BI_DSP.dim_dsp_city ;;

  dimension: city_id {
    type: number
    sql: ${TABLE}.city_id ;;
    hidden:  yes
  }
  dimension: city_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.city_id_key ;;
    hidden:  yes
  }
  dimension: city_name {
    type: string
    sql: ${TABLE}.city_name ;;
  }
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
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden:  yes
  }
  measure: count {
    type: count
    drill_fields: [city_name]
    hidden:  yes
  }
}
