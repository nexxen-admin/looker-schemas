view: rx_dim_deal {
  sql_table_name: Andromeda.rx_dim_deal ;;

  dimension: active {
    type: string
    sql: ${TABLE}.active ;;
    hidden: yes
  }
  dimension: agency_id {
    type: number
    sql: ${TABLE}.agency_id ;;
    hidden: yes
  }
  dimension: brand_id {
    type: number
    sql: ${TABLE}.brand_id ;;
    hidden: yes
  }
  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
    hidden: yes
  }
  dimension: daily_imp_cap {
    type: number
    sql: ${TABLE}.daily_imp_cap ;;
    hidden: yes
  }
  dimension: deal_auction_type {
    type: string
    sql: ${TABLE}.deal_auction_type ;;
    hidden: yes
  }
  dimension: deal_bid_floor {
    type: number
    sql: ${TABLE}.deal_bid_floor ;;
    hidden: yes
  }
  dimension: deal_data_fee {
    type: number
    sql: ${TABLE}.deal_data_fee ;;
    hidden: yes
  }
  dimension: deal_demand_margin_pct {
    type: number
    sql: ${TABLE}.deal_demand_margin_pct ;;
    hidden: yes
  }
  dimension: deal_description {
    label: "Deal Description (Now)"
    type: string
    sql: ${TABLE}.deal_description ;;
  }
  dimension: deal_end {
    type: string
    sql: ${TABLE}.deal_end ;;
    hidden: yes
  }
  dimension: deal_id_external {
    type: string
    sql: ${TABLE}.deal_id_external ;;
    hidden: yes
  }
  dimension: deal_partner_id {
    type: number
    sql: ${TABLE}.deal_partner_id ;;
    hidden: yes
  }
  dimension: deal_start {
    type: string
    sql: ${TABLE}.deal_start ;;
    hidden: yes
  }
  dimension: deal_supply_margin_pct {
    type: number
    sql: ${TABLE}.deal_supply_margin_pct ;;
    hidden: yes
  }
  dimension: dsp_seat {
    type: string
    sql: ${TABLE}.dsp_seat ;;
    hidden: yes
  }
  dimension: export {
    type: number
    sql: ${TABLE}."export" ;;
    hidden: yes
  }
  dimension: kpi_target_daily_rate {
    type: number
    sql: ${TABLE}.kpi_target_daily_rate ;;
    hidden: yes
  }
  dimension: kpi_target_monthly_rev {
    type: number
    sql: ${TABLE}.kpi_target_monthly_rev ;;
    hidden: yes
  }
  dimension: kpi_target_vcr {
    type: number
    sql: ${TABLE}.kpi_target_vcr ;;
    hidden: yes
  }
  dimension: kpi_target_viewability {
    type: number
    sql: ${TABLE}.kpi_target_viewability ;;
    hidden: yes
  }
  dimension: name {
    label: "Deal Name (Now)"
    type: string
    sql: ${TABLE}."name" ;;
  }
  dimension: office_country {
    type: string
    sql: ${TABLE}.office_country ;;
    hidden: yes
  }
  dimension: overall_imp_cap {
    type: number
    sql: ${TABLE}.overall_imp_cap ;;
    hidden: yes
  }
  dimension: play_through {
    type: number
    sql: ${TABLE}.play_through ;;
    hidden: yes
  }
  dimension: priority_id {
    type: number
    sql: ${TABLE}.priority_id ;;
    hidden: yes
  }
  dimension: rx_deal_filter_ad_size {
    type: string
    sql: ${TABLE}.rx_deal_filter_ad_size ;;
    hidden: yes
  }
  dimension: rx_deal_filter_ad_size_list {
    type: string
    sql: ${TABLE}.rx_deal_filter_ad_size_list ;;
    hidden: yes
  }
  dimension: rx_deal_filter_app {
    type: number
    sql: ${TABLE}.rx_deal_filter_app ;;
    hidden: yes
  }
  dimension: rx_deal_filter_banner {
    type: number
    sql: ${TABLE}.rx_deal_filter_banner ;;
    hidden: yes
  }
  dimension: rx_deal_filter_country {
    type: string
    sql: ${TABLE}.rx_deal_filter_country ;;
    hidden: yes
  }
  dimension: rx_deal_filter_country_list {
    type: string
    sql: ${TABLE}.rx_deal_filter_country_list ;;
    hidden: yes
  }
  dimension: rx_deal_filter_display {
    type: string
    sql: ${TABLE}.rx_deal_filter_display ;;
    hidden: yes
  }
  dimension: rx_deal_filter_in_view {
    type: number
    sql: ${TABLE}.rx_deal_filter_in_view ;;
    hidden: yes
  }
  dimension: rx_deal_filter_mobile {
    type: string
    sql: ${TABLE}.rx_deal_filter_mobile ;;
    hidden: yes
  }
  dimension: rx_deal_filter_native {
    type: number
    sql: ${TABLE}.rx_deal_filter_native ;;
    hidden: yes
  }
  dimension: rx_deal_filter_site {
    type: number
    sql: ${TABLE}.rx_deal_filter_site ;;
    hidden: yes
  }
  dimension: rx_deal_filter_ssp {
    type: string
    sql: ${TABLE}.rx_deal_filter_ssp ;;
    hidden: yes
  }
  dimension: rx_deal_filter_video {
    type: number
    sql: ${TABLE}.rx_deal_filter_video ;;
    hidden: yes
  }
  dimension: rx_deal_filter_video_size {
    type: string
    sql: ${TABLE}.rx_deal_filter_video_size ;;
    hidden: yes
  }
  dimension: rx_deal_filter_video_size_list {
    type: string
    sql: ${TABLE}.rx_deal_filter_video_size_list ;;
    hidden: yes
  }
  dimension: rx_deal_id {
    type: number
    sql: ${TABLE}.rx_deal_id ;;
    hidden: yes
  }
  dimension: rx_deal_type_id {
    type: number
    sql: ${TABLE}.rx_deal_type_id ;;
    hidden: yes
  }
  dimension_group: snapshot_time_utc {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.snapshot_time_utc ;;
    hidden: yes
  }
  dimension: vertical_video {
    type: number
    sql: ${TABLE}.vertical_video ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [name]
  }
}
