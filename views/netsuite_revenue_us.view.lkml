view: netsuite_revenue_us {
  sql_table_name: BI_DSP.netsuite_revenue_us ;;

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }
  dimension: actions {
    type: number
    sql: ${TABLE}.Actions ;;
  }
  dimension: case_safe_opp_line_item_id {
    type: string
    sql: ${TABLE}.Case_Safe_OPP_line_item_ID ;;
  }
  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }
  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }
  dimension_group: date_key {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date_key ;;
  }
  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }
  dimension: netsuite_billing_revenue {
    type: number
    sql: ${TABLE}.netsuite_billing_revenue ;;
  }
  dimension_group: opp_line_item_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opp_line_item_end_date ;;
  }
  dimension: opportunityid {
    type: string
    sql: ${TABLE}.opportunityid ;;
  }
  dimension: partner_account {
    type: string
    sql: ${TABLE}.partner_account ;;
  }
  dimension: po_item_price_fixed_local {
    type: number
    sql: ${TABLE}.po_item_price_fixed_local ;;
  }
  dimension: po_item_price_type {
    type: string
    sql: ${TABLE}.po_item_price_type ;;
  }
  dimension: price_type_name {
    type: string
    sql: ${TABLE}.price_type_name ;;
  }
  dimension: purchase_order {
    type: string
    sql: ${TABLE}.purchase_order ;;
  }
  dimension: rate {
    type: number
    sql: ${TABLE}.rate ;;
  }
  measure: count {
    type: count
    drill_fields: [price_type_name]
    hidden: yes
  }
}
