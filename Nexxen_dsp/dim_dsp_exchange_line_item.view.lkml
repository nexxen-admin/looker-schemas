view: dim_dsp_exchange_line_item {
  sql_table_name: BI_DSP.dim_dsp_exchange_line_item ;;

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
  dimension: exchange_line_item_id {
    type: string
    label: "Exchange Line Item ID"
    sql: ${TABLE}.exchange_line_item_id ;;
    hidden: no
  }
  dimension: exchange_line_item_key {
    type: number
    sql: ${TABLE}.exchange_line_item_key ;;
    hidden: yes
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden: yes
  }
  dimension: ssp_publisher_id {
    type: number
    sql: ${TABLE}.ssp_publisher_id ;;
    hidden: yes
  }
  dimension: ssp_publisher_name {
    type: string
    sql: ${TABLE}.ssp_publisher_name ;;
    hidden: yes
  }
  measure: count {
    type: count
    hidden: yes
  }
}
