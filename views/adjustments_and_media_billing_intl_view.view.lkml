view: v_adjustments_and_media_billing_intl {
  sql_table_name: BI_DSP.adjustments_and_media_billing_intl_view ;;

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }
  dimension: account_manager {
    type: string
    sql: ${TABLE}.account_manager ;;
  }
  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }
  dimension: actions {
    type: number
    sql: ${TABLE}.actions ;;
  }
  dimension: adj_actions {
    type: number
    sql: ${TABLE}.adj_actions ;;
  }
  dimension: adj_clicks {
    type: number
    sql: ${TABLE}.adj_clicks ;;
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
  dimension: adj_impressions {
    type: number
    sql: ${TABLE}.adj_impressions ;;
  }
  dimension: adj_revenue {
    type: number
    sql: ${TABLE}.adj_revenue ;;
  }
  dimension_group: adj_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.adj_start_date ;;
  }
  dimension: adj_video_completes {
    type: number
    sql: ${TABLE}.adj_video_completes ;;
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
  dimension: booked_budget {
    type: number
    sql: ${TABLE}.booked_budget ;;
  }
  dimension: booked_budget_total {
    type: number
    sql: ${TABLE}."booked_budget_(total)" ;;
  }
  dimension: booked_rate {
    type: number
    sql: ${TABLE}.booked_rate ;;
  }
  dimension: booked_units {
    type: number
    sql: ${TABLE}.booked_units ;;
  }
  dimension: capped_revenue {
    type: number
    sql: ${TABLE}.capped_revenue ;;
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
  dimension: discount_amount {
    type: string
    sql: ${TABLE}.discount_amount ;;
  }
  dimension: discount_applies_to {
    type: string
    sql: ${TABLE}.discount_applies_to ;;
  }
  dimension: do_not_bill {
    type: string
    sql: ${TABLE}.do_not_bill ;;
  }
  dimension: expected_revenue {
    type: number
    sql: ${TABLE}.expected_revenue ;;
  }
  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }
  dimension: IO_Number {
    type: string
    sql: ${TABLE}."io_#" ;;
  }
  dimension: IO_currency {
    type: string
    sql: ${TABLE}.io_currency ;;
  }
  dimension_group: IO_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.io_end_date ;;
  }
  dimension: IO_key {
    type: string
    sql: ${TABLE}.io_key ;;
  }
  dimension_group: IO_Start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.io_start_date ;;
  }
  dimension: legal_entity {
    type: string
    sql: ${TABLE}.legal_entity ;;
  }
  dimension: line_item_name {
    type: string
    sql: ${TABLE}.line_item_name ;;
  }
  dimension: manual_discount {
    type: number
    sql: ${TABLE}.manual_discount ;;
  }
  dimension: netsuite_booked_budget_remaining {
    type: number
    sql: ${TABLE}.netsuite_booked_budget_remaining ;;
  }
  dimension: netsuite_past_billed_amount {
    type: number
    sql: ${TABLE}.netsuite_past_billed_amount ;;
  }
  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.opportunity_name ;;
  }
  dimension: opportunity_owner {
    type: string
    sql: ${TABLE}.opportunity_owner ;;
  }
  dimension: overall_discount {
    type: number
    sql: ${TABLE}.overall_discount ;;
  }
  dimension: PO_number {
    type: string
    sql: ${TABLE}."po_#" ;;
  }
  dimension: PO_Currency {
    type: string
    sql: ${TABLE}.po_currency ;;
  }
  dimension: PO_Name {
    type: string
    sql: ${TABLE}.po_name ;;
  }
  dimension: price_type {
    type: string
    sql: ${TABLE}.price_type ;;
  }
  dimension: product_level_I {
    type: string
    sql: ${TABLE}.product_level_i ;;
  }
  dimension: product_level_II {
    type: string
    sql: ${TABLE}.product_level_ii ;;
  }
  dimension: publisher_account_name {
    type: string
    sql: ${TABLE}.publisher_account_name ;;
  }
  dimension: rate_card_discount {
    type: number
    sql: ${TABLE}.rate_card_discount ;;
  }
  dimension: related_brand {
    type: string
    sql: ${TABLE}.related_brand ;;
  }
  dimension: related_brand_id {
    type: string
    sql: ${TABLE}.related_brand_id ;;
  }
  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }
  dimension: uncapped_revenue {
    type: number
    sql: ${TABLE}.uncapped_revenue ;;
  }
  dimension: undiscounted_spend {
    type: number
    sql: ${TABLE}.undiscounted_spend ;;
  }

  dimension: 1P_Impressions {
    type: number
    sql: ${TABLE}."1p_impressions" ;;
  }

  dimension: 1P_Clicks {
    type: number
    sql: ${TABLE}."1p_clicks" ;;
  }

  dimension: 1P_Actions {
    type: number
    sql: ${TABLE}."1p_actions" ;;
  }

  dimension: complete_events {
    type: number
    sql: ${TABLE}.complete_events ;;
  }

  dimension: advertiser_invoice {
    type: number
    sql: ${TABLE}.advertiser_invoice ;;
  }

  dimension: percent_25_events {
    type: number
    sql: ${TABLE}.percent_25_events ;;
  }

  dimension: percent_50_events {
    type: number
    sql: ${TABLE}.percent_50_events ;;
  }

  dimension: percent_75_events {
    type: number
    sql: ${TABLE}.percent_75_events ;;
  }

  dimension_group: DSP_Start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dsp_start_date ;;
  }

  dimension_group: DSD_End {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dsp_end_date ;;
  }

}
