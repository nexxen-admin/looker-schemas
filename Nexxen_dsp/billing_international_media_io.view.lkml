view: billing_international_media_io {
  sql_table_name: BI_DSP.media_IO_billing_international ;;

  dimension: account_id {
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_manager_name {
    type: string
    sql: ${TABLE}.account_manager_name ;;
  }

  dimension: adjustment_billable_clicks {
    label: "Billable Clicks after Finance Adj"
    type: number
    sql: ${TABLE}.adjustment_billable_clicks ;;
  }

  dimension: adjustment_billable_impressions {
    label: "Billable Impressions after Finance Adj"
    type: number
    sql: ${TABLE}.adjustment_billable_impressions ;;
  }

  dimension: adv_invoice {
    type: number
    sql: ${TABLE}.adv_invoice ;;
  }

  dimension: billing_instructions {
    type: string
    sql: ${TABLE}.billing_instructions ;;
  }

  dimension: booked_units {
    type: number
    sql: ${TABLE}.booked_units ;;
  }

  dimension: case_safe_opp_line_item_id {
    type: string
    sql: ${TABLE}.case_safe_opp_line_item_id ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: complete_events {
    type: number
    sql: ${TABLE}.complete_events ;;
  }

  dimension: corp_entity {
    type: string
    sql: ${TABLE}.corp_entity ;;
  }

  dimension: expected_revenue {
    type: number
    sql: ${TABLE}.Expected_Revenue ;;
  }

  dimension: industry {
    type: string
    sql: ${TABLE}.industry ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: io_currency {
    label: "IO Currency"
    type: string
    sql: ${TABLE}.io_currency ;;
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

  dimension: modified_case_safe {
    type: string
    sql: ${TABLE}.modified_case_safe ;;
  }

  dimension: ns_remaining_amount {
    type: number
    sql: ${TABLE}.ns_remaining_amount ;;
  }

  dimension: opportunity_region {
    type: string
    sql: ${TABLE}.region ;;
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

  dimension: opportunity_trader {
    type: string
    sql: ${TABLE}.opportunity_trader ;;
  }

  dimension: overall_discount {
    type: number
    sql: ${TABLE}.overall_discount ;;
  }

  dimension: past_bill_amount {
    type: number
    sql: ${TABLE}.past_bill_amount ;;
  }

  dimension: percent25_events {
    type: number
    sql: ${TABLE}.percent25_events ;;
  }

  dimension: percent50_events {
    type: number
    sql: ${TABLE}.percent50_events ;;
  }

  dimension: percent75_events {
    type: number
    sql: ${TABLE}.percent75_events ;;
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

  dimension: related_brand_name {
    type: string
    sql: ${TABLE}.related_brand_name ;;
  }

  dimension: related_brand_id {
    type: string
    sql: ${TABLE}.related_brand_id ;;
  }

  dimension: sales_team {
    type: string
    sql: ${TABLE}.sales_team ;;
  }

  dimension: server_reporting {
    type: string
    sql: ${TABLE}.server_reporting ;;
  }

  dimension: stage {
    type: string
    sql: ${TABLE}.stage ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.'type' ;;
  }

  dimension: total_booked_budget {
    type: number
    sql: ${TABLE}.total_booked_budget ;;
  }

  dimension: total_billable_units_before_adj_adops_override {
    type: number
    sql: ${TABLE}.total_billable_units_before_adj_adops_override ;;
  }

  dimension: undiscounted_spend {
    type: number
    sql: ${TABLE}.undiscounted_spend ;;
  }

  dimension: unit_ad_ops_override_1p {
    label: "1P Unit after Ad Ops Override"
    type: number
    sql: ${TABLE}.Unit_AdOps_Override_1P ;;
  }

  dimension: units_adj {
    label: "Finance units adj"
    type: number
    sql: ${TABLE}.Units_ADJ ;;
  }

  dimension: units_adj_override {
    label: "Units adj AdOps"
    type: number
    sql: ${TABLE}.units_adj_override ;;
  }

  dimension: units_before_adj_ad_ops_override {
    type: number
    sql: ${TABLE}.units_before_adj_AdOps_override ;;
  }

  dimension_group: date_key {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.date_key ;;
  }

  dimension_group: dsp_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dsp_end_date ;;
  }

  dimension_group: dsp_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.dsp_start_date ;;
  }

  dimension_group: opportunity_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_start_date ;;
  }

  dimension_group: opportunity_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.opportunity_end_date ;;
  }
}
