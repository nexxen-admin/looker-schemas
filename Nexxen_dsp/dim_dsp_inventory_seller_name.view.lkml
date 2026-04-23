view: dim_dsp_inventory_seller_name {
  sql_table_name: BI_DSP.dim_dsp_inventory_seller_name ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
  }
  dimension: exchange_line_item_id {
    type: string
    sql: ${TABLE}.exchange_line_item_id ;;
  }
  dimension: exchange_line_item_key {
    type: number
    sql: ${TABLE}.exchange_line_item_key ;;
  }
  dimension: inventory_source_id {
    type: number
    sql: ${TABLE}.inventory_source_id ;;
  }
  dimension: inventory_source_key {
    type: number
    sql: ${TABLE}.inventory_source_key ;;
  }
  dimension: seller_name {
    type: string
    sql: ${TABLE}.seller_name ;;
  }
  measure: count {
    type: count
    drill_fields: [seller_name]
  }
}
