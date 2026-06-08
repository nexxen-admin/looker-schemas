view: netsuite_revenue_international {
  sql_table_name: BI_DSP.netsuite_revenue_international ;;

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }
  dimension: actions {
    type: number
    sql: ${TABLE}.actions ;;
  }
  dimension: billing_clicks {
    type: number
    sql: ${TABLE}.billing_clicks ;;
  }
  dimension: billing_cost {
    type: number
    sql: ${TABLE}.billing_cost ;;
  }
  dimension: booked_rate {
    type: number
    sql: ${TABLE}.booked_rate ;;
  }
  dimension_group: date_key {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date_key ;;
  }
  dimension: do_not_bill {
    type: string
    sql: ${TABLE}.do_not_bill ;;
  }
  dimension_group: io_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.io_end_date ;;
  }
  dimension: io_id {
    type: string
    sql: ${TABLE}.io_id ;;
  }
  dimension: io_key {
    type: string
    sql: ${TABLE}.io_key ;;
  }
  dimension: io_type {
    type: string
    sql: ${TABLE}.io_type ;;
  }
  dimension: legal_entity {
    type: string
    sql: ${TABLE}.legal_entity ;;
  }
  dimension: line_item_name {
    type: string
    sql: ${TABLE}.line_item_name ;;
  }
  dimension: netsuite_billing_revenue {
    type: number
    sql: ${TABLE}.netsuite_billing_revenue ;;
  }
  dimension: netsuite_final_impressions {
    type: number
    sql: ${TABLE}.netsuite_final_impressions ;;
  }
  dimension: partner_account_for_netsuite_revenue_feed {
    type: string
    sql: ${TABLE}.partner_account_for_netsuite_revenue_feed ;;
  }
  dimension: po_item_price_fixed_local_for_netsuite_revenue_feed {
    type: number
    sql: ${TABLE}.po_item_price_fixed_local_for_netsuite_revenue_feed ;;
  }
  dimension: po_item_price_type_for_netsuite_revenue_feed {
    type: string
    sql: ${TABLE}.po_item_price_type_for_netsuite_revenue_feed ;;
  }
  dimension: po_number_for_netsuite_revenue_feed {
    type: number
    sql: ${TABLE}.po_number_for_netsuite_revenue_feed ;;
  }
  dimension: price_type {
    type: string
    sql: ${TABLE}.price_type ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }
  measure: count {
    type: count
    drill_fields: [line_item_name]
  }
}
