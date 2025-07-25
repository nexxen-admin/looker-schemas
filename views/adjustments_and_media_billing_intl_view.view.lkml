view: v_adjustments_and_media_billing_intl {
  sql_table_name: BI_DSP.adjustments_and_media_billing_intl_view ;;

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }
  dimension: account_manager_name {
    type: string
    sql: ${TABLE}.account_manager_name ;;
  }
  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }
  dimension: actions {
    type: number
    sql: ${TABLE}.actions ;;
  }
  dimension: adj_cost {
    type: number
    sql: ${TABLE}.adj_cost ;;
  }
  dimension_group: adj_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.adj_end_date ;;
  }
  dimension_group: adj_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.adj_start_date ;;
  }
  dimension: adjustment_billable_actions {
    type: number
    sql: ${TABLE}.adjustment_billable_actions ;;
  }
  dimension: adjustment_billable_clicks {
    type: number
    sql: ${TABLE}.adjustment_billable_clicks ;;
  }
  dimension: adjustment_billable_impressions {
    type: number
    sql: ${TABLE}.adjustment_billable_impressions ;;
  }
  dimension: adjustment_billable_revenue {
    type: number
    sql: ${TABLE}.adjustment_billable_revenue ;;
  }
  dimension: adjustment_billable_video_completes {
    type: number
    sql: ${TABLE}.adjustment_billable_video_completes ;;
  }
  dimension: billing_cost {
    type: number
    sql: ${TABLE}.billing_cost ;;
  }
  dimension: billing_instructions {
    type: string
    sql: ${TABLE}.billing_instructions ;;
  }
  dimension: billing_revenue {
    type: number
    sql: ${TABLE}.billing_revenue ;;
  }
  dimension: booked_units {
    type: number
    sql: ${TABLE}.booked_units ;;
  }
  dimension: capped_revenue_before_adj_with_override {
    type: number
    sql: ${TABLE}.capped_revenue_before_adj_with_override ;;
  }
  dimension: corp_entity {
    type: string
    sql: ${TABLE}.corp_entity ;;
  }
  dimension_group: date_key {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date_key ;;
  }
  dimension: expected_revenue {
    type: number
    sql: ${TABLE}.expected_revenue ;;
  }
  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }
  dimension: io_currency {
    type: string
    sql: ${TABLE}.io_currency ;;
  }
  dimension: io_key {
    type: string
    sql: ${TABLE}.io_key ;;
  }
  dimension: legal_entity {
    type: string
    sql: ${TABLE}.legal_entity ;;
  }
  dimension: line_item_name {
    type: string
    sql: ${TABLE}.line_item_name ;;
  }
  dimension: line_item_status {
    type: string
    sql: ${TABLE}.line_item_status ;;
  }
  dimension: manual_discount {
    type: number
    sql: ${TABLE}.manual_discount ;;
  }
  dimension: ns_remaining_amount {
    type: number
    sql: ${TABLE}.ns_remaining_amount ;;
  }
  dimension_group: opportunity_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_end_date ;;
  }
  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }
  dimension: opportunity_number {
    type: string
    sql: ${TABLE}.opportunity_number ;;
  }
  dimension: opportunity_owner_name {
    type: string
    sql: ${TABLE}.opportunity_owner_name ;;
  }
  dimension_group: opportunity_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_start_date ;;
  }
  dimension: overall_discount {
    type: number
    sql: ${TABLE}.overall_discount ;;
  }
  dimension: passed_bill_amount {
    type: number
    sql: ${TABLE}.passed_bill_amount ;;
  }
  dimension: po_currency {
    type: string
    sql: ${TABLE}.po_currency ;;
  }
  dimension: po_name {
    type: string
    sql: ${TABLE}.po_name ;;
  }
  dimension: po_number {
    type: string
    sql: ${TABLE}.po_number ;;
  }
  dimension: price_type_name {
    type: string
    sql: ${TABLE}.price_type_name ;;
  }
  dimension: product_level_1 {
    type: string
    sql: ${TABLE}.product_level_1 ;;
  }
  dimension: product_level_2 {
    type: string
    sql: ${TABLE}.product_level_2 ;;
  }
  dimension: rate {
    type: number
    sql: ${TABLE}.rate ;;
  }
  dimension: rate_card_discount {
    type: number
    sql: ${TABLE}.rate_card_discount ;;
  }
  dimension: related_brand_id {
    type: string
    sql: ${TABLE}.related_brand_id ;;
  }
  dimension: related_brand_name {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }
  dimension: total_booked_budget {
    type: number
    sql: ${TABLE}.total_booked_budget ;;
  }
  dimension: uncapped_revenue_after_adops_override {
    type: number
    sql: ${TABLE}.uncapped_revenue_after_adops_override ;;
  }
  dimension: undiscounted_spend {
    type: number
    sql: ${TABLE}.undiscounted_spend ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  opportunity_owner_name,
  po_name,
  account_name,
  related_brand_name,
  opportunity_name,
  price_type_name,
  line_item_name,
  account_manager_name
  ]
  }

}
