view: dod_partner_ops {
  sql_table_name: druid.dsp_media_and_bids ;;

  dimension_group: __time {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."__time" ;;
  }


  dimension: ad_format_id {
    type: number
    sql: ${TABLE}."ad_format_id" ;;
  }

  dimension: deal_id {
    type: string
    sql: ${TABLE}."deal_id" ;;
  }

  dimension: exchange_line_item_id {
    type: string
    sql: ${TABLE}."exchange_line_item_id" ;;
  }

  dimension: environment {
    type: string
    sql: ${TABLE}."environment" ;;
  }

  measure: impression {
    type: sum
    sql: ${TABLE}."impression" ;;
  }

  measure: inv_cost {
    type: sum
    sql: ${TABLE}."inv_cost" ;;
  }

  dimension: line_item_id {
    type: number
    sql: ${TABLE}."line_item_id" ;;
  }


  dimension: market_id {
    type: number
    sql: ${TABLE}."market_id" ;;
  }

  dimension: tld {
    type: string
    sql: ${TABLE}."tld" ;;
  }

  dimension: inventory_source_id {
    type: string
    sql: LOOKUP(CONCAT(publisher_id,''), 'dsp_media_and_bids_inventory_source_id') ;;
  }

  dimension: inventory_source_name {
    type: string
    sql: LOOKUP(CONCAT(publisher_id,''), 'dsp_media_and_bids_inventory_source_name') ;;
  }

  dimension: deal_name {
    type: string
    sql: LOOKUP(CONCAT(publisher_deal_object_id,''), 'dsp_media_and_bids_deal_name') ;;
  }

  dimension: format {
    type: string
    sql: ${TABLE}."format" ;;
  }
}
