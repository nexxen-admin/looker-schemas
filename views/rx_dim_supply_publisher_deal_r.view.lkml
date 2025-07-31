view: rx_dim_supply_publisher_deal_r {
  sql_table_name: Andromeda.rx_dim_supply_publisher_deal_r ;;

  dimension: adpod_slot_target {
    type: string
    sql: ${TABLE}.adpod_slot_target ;;
  }
  dimension: auction_type {
    type: string
    sql: ${TABLE}.auction_type ;;
  }
  dimension: checksum {
    type: string
    sql: ${TABLE}.checksum ;;
  }
  dimension: config_type {
    type: string
    sql: ${TABLE}.config_type ;;
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: daily_imp_cap {
    type: number
    sql: ${TABLE}.daily_imp_cap ;;
  }
  dimension: daily_req_cap {
    type: number
    sql: ${TABLE}.daily_req_cap ;;
  }
  dimension: day_parting {
    type: string
    sql: ${TABLE}.day_parting ;;
  }
  dimension_group: deal_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.deal_end ;;
  }
  dimension_group: deal_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.deal_start ;;
  }
  dimension: deal_type {
    type: string
    sql: ${TABLE}.deal_type ;;
  }
  dimension_group: deleted {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.deleted_at ;;
  }
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }
  dimension: external_deal_id {
    type: string
    sql: ${TABLE}.external_deal_id ;;
  }
  dimension: imp_cap_adjusted {
    type: number
    sql: ${TABLE}.imp_cap_adjusted ;;
  }
  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }
  dimension: overall_imp_cap {
    type: number
    sql: ${TABLE}.overall_imp_cap ;;
  }
  dimension: pace_reqs {
    type: number
    sql: ${TABLE}.pace_reqs ;;
  }
  dimension: package_id {
    type: number
    sql: ${TABLE}.package_id ;;
  }
  dimension: platformfee_type {
    type: string
    sql: ${TABLE}.platformfee_type ;;
  }
  dimension: pub_deal_id {
    type: number
    sql: ${TABLE}.pub_deal_id ;;
  }
  dimension_group: published {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.published_at ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  measure: count {
    type: count
  }
}
