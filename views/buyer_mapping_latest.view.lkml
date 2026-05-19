view: buyer_mapping_latest {
  sql_table_name: BI_New.v_buyer_mapping_latest ;;

  dimension: buyer_new {
    type: string
    sql: ${TABLE}.buyer_new ;;
  }
  dimension: buyer_new_char_count {
    type: number
    sql: LENGTH(${TABLE}.buyer_new) ;;
  }
  dimension: buyer_original {
    type: string
    sql: ${TABLE}.buyer_original ;;
  }
  dimension: buyer_original_char_count {
    type: number
    sql: LENGTH(${TABLE}.buyer_original) ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: created_by {
    type: string
    sql: ${TABLE}.created_by ;;
  }
}
