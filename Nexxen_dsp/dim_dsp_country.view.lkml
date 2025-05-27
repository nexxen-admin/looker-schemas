view: dim_dsp_country {
  sql_table_name: BI_DSP.dim_dsp_country ;;

  dimension: country_id {
    type: number
    sql: ${TABLE}.country_id ;;
    hidden:  yes
  }
  dimension: country_key {
    type: number
    sql: ${TABLE}.country_key ;;
    hidden:  yes
  }
  dimension: country_name {
    type: string
    sql: ${TABLE}.country_name ;;
    map_layer_name: countries
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
    drill_fields: [country_name]
    hidden:  yes
  }
}
