view: dim_dsp_target_deal {
  sql_table_name: BI_DSP.dim_dsp_target_deal ;;

  dimension: always_on {
    type: yesno
    sql: ${TABLE}.always_on ;;
  }
  dimension: bid_price {
    type: number
    sql: ${TABLE}.bid_price ;;
  }
  dimension: bid_price_local {
    type: number
    sql: ${TABLE}.bid_price_local ;;
  }
  dimension_group: created_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_date ;;
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
    hidden:  yes
  }
  dimension: deal_id {
    type: string
    sql: ${TABLE}.deal_id ;;
  }
  dimension: is_deleted {
    type: number
    sql: ${TABLE}.is_deleted ;;
  }
  dimension_group: last_modified {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_modified_date ;;
  }
  dimension: line_item_id {
    type: number
    sql: ${TABLE}.line_item_id ;;
  }
  dimension: manual_deal {
    type: yesno
    sql: ${TABLE}.manual_deal ;;
  }
  dimension: publisher_deal_id {
    type: number
    sql: ${TABLE}.publisher_deal_id ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
    hidden:  yes
  }
  dimension: target_deal_id {
    type: number
    sql: ${TABLE}.target_deal_id ;;
  }
  dimension: target_deal_key {
    type: number
    sql: ${TABLE}.target_deal_key ;;
    hidden:  yes
  }
  measure: count {
    type: count
    hidden:  yes
  }
}
