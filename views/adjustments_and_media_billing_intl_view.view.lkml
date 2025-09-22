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
  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
  dimension: modified_case_safe {
    type: string
    sql: ${TABLE}.modified_case_safe ;;
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
  dimension: billing_instructions {
    type: string
    sql: ${TABLE}.billing_instructions ;;
  }
  dimension: booked_budget_total {
    type: number
    sql: ${TABLE}."booked_budget_(total)" ;;
  }
  dimension: booked_rate {
    type: number
    sql: ${TABLE}.booked_rate ;;
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
  dimension: discount_applies_to {
    type: string
    sql: ${TABLE}.discount_applies_to ;;
  }
  dimension: do_not_bill {
    type: string
    sql: ${TABLE}.do_not_bill ;;
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

  measure: 1P_Impressions {
    type: sum
    sql: ${TABLE}."1p_impressions" ;;
  }

  measure: 1P_Clicks {
    type: sum
    sql: ${TABLE}."1p_clicks" ;;
  }

  measure: 1P_Actions {
    type: sum
    sql: ${TABLE}."1p_actions" ;;
  }

  measure: actions {
    type: sum
    sql: ${TABLE}.actions ;;
  }

  measure: adj_actions {
    type: sum
    sql: ${TABLE}.adj_actions ;;
  }

  measure: adj_clicks {
    type: sum
    sql: ${TABLE}.adj_clicks ;;
  }

  measure: adj_cost {
    type: sum
    sql: ${TABLE}.adj_cost ;;
  }

  measure: adj_impressions {
    type: sum
    sql: ${TABLE}.adj_impressions ;;
  }

  measure: adj_revenue {
    type: sum
    sql: ${TABLE}.adj_revenue ;;
  }

  measure: adj_video_completes {
    type: sum
    sql: ${TABLE}.adj_video_completes ;;
  }

  measure: advertiser_invoice {
    type: sum
    sql: ${TABLE}.advertiser_invoice ;;
  }

  measure: billing_cost {
    type: sum
    sql: ${TABLE}.billing_cost ;;
  }

  measure: billing_revenue {
    type: sum
    sql: ${TABLE}.billing_revenue ;;
  }

  measure: booked_budget {
    type: sum
    sql: ${TABLE}.booked_budget ;;
  }

  measure: booked_units {
    type: sum
    sql: ${TABLE}.booked_units ;;
  }

  measure: capped_revenue {
    type: sum
    sql: ${TABLE}.capped_revenue ;;
  }

  measure: complete_events {
    type: sum
    sql: ${TABLE}.complete_events ;;
  }

  measure: discount_amount {
    type: sum
    sql: COALESCE(CAST(NULLIF(${TABLE}.discount_amount, '') AS int), 0)  ;;
  }

  measure: expected_revenue {
    type: sum
    sql: ${TABLE}.expected_revenue ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  measure: netsuite_booked_budget_remaining {
    type: sum
    sql: ${TABLE}.netsuite_booked_budget_remaining ;;
  }

  measure: netsuite_past_billed_amount {
    type: sum
    sql: ${TABLE}.netsuite_past_billed_amount ;;
  }

  measure: percent_25_events {
    type: sum
    sql: ${TABLE}.percent_25_events ;;
  }

  measure: percent_50_events {
    type: sum
    sql: ${TABLE}.percent_50_events ;;
  }

  measure: percent_75_events {
    type: sum
    sql: ${TABLE}.percent_75_events ;;
  }

  measure: uncapped_revenue {
    type: sum
    sql: ${TABLE}.uncapped_revenue ;;
  }

  measure: undiscounted_spend {
    type: sum
    sql: ${TABLE}.undiscounted_spend ;;
  }

}
