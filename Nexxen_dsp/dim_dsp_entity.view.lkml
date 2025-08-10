view: dim_dsp_entity {
  sql_table_name: BI_DSP.dim_dsp_entity ;;

  dimension: billing_workflow_status_id {
    type: number
    sql: ${TABLE}.billing_workflow_status_id ;;
  }
  dimension: copy_billing_info {
    type: number
    sql: ${TABLE}.copy_billing_info ;;
  }
  dimension_group: created_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.created_date ;;
  }
  dimension: credit_limit {
    type: number
    sql: ${TABLE}.credit_limit ;;
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
    hidden: yes
  }
  dimension: entity_id {
    type: number
    sql: ${TABLE}.entity_id ;;
  }
  dimension: entity_key {
    type: number
    sql: ${TABLE}.entity_key ;;
  }
  dimension: home_market_id {
    type: number
    sql: ${TABLE}.home_market_id ;;
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
  dimension: managed {
    type: number
    sql: ${TABLE}."managed" ;;
  }
  dimension: requires_beacon_validation {
    type: number
    sql: ${TABLE}.requires_beacon_validation ;;
  }
  dimension: ri_info {
    type: string
    sql: ${TABLE}.ri_info ;;
  }
  dimension: sales_force_account_id {
    type: string
    sql: ${TABLE}.sales_force_account_id ;;
  }
  dimension: sales_force_opportunity_id {
    type: string
    sql: ${TABLE}.sales_force_opportunity_id ;;
  }
  dimension: workflow_status_id {
    type: number
    sql: ${TABLE}.workflow_status_id ;;
  }
  measure: count {
    type: count
    hidden: yes
  }
}
