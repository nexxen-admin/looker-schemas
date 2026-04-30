view: dim_dsp_inventory_seller_name {
  sql_table_name: BI_DSP.dim_dsp_inventory_seller_name ;;

  dimension_group: db_created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_date ;;
    hidden: yes
  }
  dimension: exchange_line_item_id {
    type: string
    sql: ${TABLE}.exchange_line_item_id ;;
    hidden: yes
  }
  dimension: exchange_line_item_key {
    type: number
    sql: ${TABLE}.exchange_line_item_key ;;
    hidden: yes
  }
  dimension: inventory_source_id {
    type: number
    sql: ${TABLE}.inventory_source_id ;;
    hidden: yes
  }
  dimension: inventory_source_key {
    type: number
    sql: ${TABLE}.inventory_source_key ;;
    hidden: yes
  }
  dimension: seller_name {
    type: string
    sql: ${TABLE}.seller_name ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [seller_name]
    hidden: yes
  }
}
