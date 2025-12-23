view: pmp_stats_daily {
  sql_table_name: Andromeda.pmp_stats_daily ;;

  dimension: agency_id {
    type: string
    sql: ${TABLE}.agency_id ;;
  }
  dimension: agency_name {
    type: string
    sql: ${TABLE}.agency_name ;;
  }
  dimension: auction_type {
    type: string
    sql: ${TABLE}.auction_type ;;
  }
  dimension: brand_id {
    type: number
    sql: ${TABLE}.brand_id ;;
  }
  dimension: brand_name {
    type: string
    sql: ${TABLE}.brand_name ;;
  }
  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension: country_code {
    type: string
    sql: ${TABLE}.country_code ;;
  }
  dimension: ctr {
    type: number
    sql: ${TABLE}.CTR ;;
    hidden: yes
  }
  dimension_group: deal_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.DEAL_END ;;
  }
  dimension: deal_partner_id {
    type: number
    sql: ${TABLE}.deal_partner_id ;;
  }
  dimension: deal_partner_name {
    type: string
    sql: ${TABLE}.deal_partner_name ;;
  }
  dimension_group: deal_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.DEAL_START ;;
  }
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }
  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }
  dimension: dsp_display_name {
    type: string
    sql: ${TABLE}.dsp_display_name ;;
  }
  dimension_group: event {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.event_time ;;
  }
  dimension: external_name {
    type: string
    sql: ${TABLE}.external_name ;;
  }
  dimension: ias_ivt_rate {
    type: number
    sql: ${TABLE}.IAS_IVT_RATE ;;
    hidden: yes
  }
  dimension: ias_viewability {
    type: number
    sql: ${TABLE}.IAS_VIEWABILITY ;;
    hidden: yes
  }
  dimension: kpi_target_daily_rate {
    type: number
    sql: ${TABLE}.kpi_target_daily_rate ;;
  }
  dimension: kpi_target_monthly_rev {
    type: number
    sql: ${TABLE}.kpi_target_monthly_rev ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}."name" ;;
  }
  dimension: office_country {
    type: string
    sql: ${TABLE}.office_country ;;
  }
  dimension: origin_domain {
    type: string
    sql: ${TABLE}.origin_domain ;;
  }
  dimension: personnel_name {
    type: string
    sql: ${TABLE}.personnel_name ;;
  }
  dimension: pub_id {
    type: string
    sql: ${TABLE}.pub_id ;;
  }
  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }
  dimension: quartile_1_st_rate {
    type: number
    sql: ${TABLE}.QUARTILE_1ST_RATE ;;
    hidden: yes
  }
  dimension: quartile_2_nd_rate {
    type: number
    sql: ${TABLE}.QUARTILE_2ND_RATE ;;
    hidden: yes
  }
  dimension: quartile_3_rd_rate {
    type: number
    sql: ${TABLE}.QUARTILE_3RD_RATE ;;
    hidden: yes
  }
  dimension: rx_deal_id {
    type: string
    sql: ${TABLE}.rx_deal_id ;;
  }
  dimension: rx_device_type {
    type: string
    sql: ${TABLE}.rx_device_type ;;
  }
  dimension: rx_dsp_name {
    type: string
    sql: ${TABLE}.rx_dsp_name ;;
  }
  dimension: rx_imp_type {
    type: string
    sql: ${TABLE}.rx_imp_type ;;
  }
  dimension: rx_media_type {
    type: string
    sql: ${TABLE}.rx_media_type ;;
  }
  dimension: rx_ssp_name {
    type: string
    sql: ${TABLE}.rx_ssp_name ;;
  }
  dimension: type {
    type: string
    sql: ${TABLE}."type" ;;
  }
  dimension: type_id {
    type: number
    sql: ${TABLE}.type_id ;;
  }
  dimension: vcr {
    type: number
    sql: ${TABLE}.VCR ;;
    hidden: yes
  }
  dimension: video_completion_rate {
    type: number
    sql: ${TABLE}.VIDEO_COMPLETION_RATE ;;
  }
  dimension: video_error_rate {
    type: number
    sql: ${TABLE}.VIDEO_ERROR_RATE ;;
    hidden: yes
  }
  dimension: video_start_rate {
    type: number
    sql: ${TABLE}.VIDEO_START_RATE ;;
    hidden: yes
  }
  dimension: vtr {
    type: number
    sql: ${TABLE}.VTR ;;
    hidden: yes
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }


  measure: barter_fee_amount {
    type: sum
    sql: ${TABLE}.barter_fee_amount ;;
  }
  measure: clicks {
    type: sum
    sql: ${TABLE}.CLICKS ;;
  }
  measure: cm_fee {
    type: sum
    sql: ${TABLE}.cm_fee ;;
  }
  measure: cost {
    type: sum
    sql: ${TABLE}.COST ;;
  }
  measure: ctr_calculated {
    label: "CTR"
    type: average
    value_format: "0.00%"
    sql: ${TABLE}.CLICKS / NULLIF(${TABLE}.PIXEL_IMPRESSIONS, 0) ;;
  }
  measure: currency_aud {
    type: average
    sql: ${TABLE}.currency_AUD ;;
    value_format: "#,##0.00"
  }
  measure: currency_cad {
    type: average
    sql: ${TABLE}.currency_CAD ;;
    value_format: "#,##0.00"
  }
  measure: currency_eur {
    type: average
    sql: ${TABLE}.currency_EUR ;;
    value_format: "#,##0.00"
  }
  measure: currency_gbp {
    type: average
    sql: ${TABLE}.currency_GBP ;;
    value_format: "#,##0.00"
  }
  measure: currency_hkd {
    type: average
    sql: ${TABLE}.currency_HKD ;;
    value_format: "#,##0.00"
  }
  measure: currency_inr {
    type: average
    sql: ${TABLE}.currency_INR ;;
    value_format: "#,##0.00"
  }
  measure: currency_jpy {
    type: average
    sql: ${TABLE}.currency_JPY ;;
    value_format: "#,##0.00"
  }
  measure: currency_myr {
    type: average
    sql: ${TABLE}.currency_MYR ;;
    value_format: "#,##0.00"
  }
  measure: currency_nzd {
    type: average
    sql: ${TABLE}.currency_NZD ;;
    value_format: "#,##0.00"
  }
  measure: currency_php {
    type: average
    sql: ${TABLE}.currency_PHP ;;
    value_format: "#,##0.00"
  }
  measure: currency_sgd {
    type: average
    sql: ${TABLE}.currency_SGD ;;
    value_format: "#,##0.00"
  }
  measure: currency_try {
    type: average
    sql: ${TABLE}.currency_TRY ;;
    value_format: "#,##0.00"
  }
  measure: deal_data_fee {
    type: sum
    sql: ${TABLE}.deal_data_fee ;;
  }
  measure: demand_margin {
    type: sum
    sql: ${TABLE}.demand_margin ;;
  }
  measure: dsp_bids {
    type: sum
    sql: ${TABLE}.DSP_BIDS ;;
  }
  measure: dsp_fee {
    type: sum
    sql: ${TABLE}.dsp_fee ;;
  }
  measure: ias_ivt_impression {
    type: sum
    sql: ${TABLE}.IAS_IVT_IMPRESSION ;;
  }
  measure: ias_ivt_rate_calculated {
    label: "IAS IVT Rate"
    type: average
    value_format: "0.00%"
    sql: ${TABLE}.IAS_IVT_IMPRESSION / NULLIF(${TABLE}.IAS_MEASURABLE_IMPRESSION, 0) ;;
  }
  measure: ias_measurable_impression {
    type: sum
    sql: ${TABLE}.IAS_MEASURABLE_IMPRESSION ;;
  }
  measure: ias_total_impression {
    type: sum
    sql: ${TABLE}.IAS_TOTAL_IMPRESSION ;;
  }
  measure: ias_viewable_impression {
    type: sum
    sql: ${TABLE}.IAS_VIEWABLE_IMPRESSION ;;
  }
  measure: ias_ivt_viewability_calculated {
    label: "IAS Viewability"
    type: average
    value_format: "0.00%"
    sql: ${TABLE}.IAS_VIEWABLE_IMPRESSION / NULLIF(${TABLE}.IAS_MEASURABLE_IMPRESSION, 0) ;;
  }
  measure: impression_video_events {
    type: sum
    sql: ${TABLE}.impression_video_events ;;
  }
  measure: pad_amount {
    type: sum
    sql: ${TABLE}.pad_amount ;;
  }
  measure: pixel_impressions {
    type: sum
    sql: ${TABLE}.PIXEL_IMPRESSIONS ;;
  }
  measure: revenue {
    type: sum
    sql: ${TABLE}.REVENUE ;;
  }
  measure: ssp_cost {
    type: sum
    sql: ${TABLE}.SSP_COST ;;
  }
  measure: ssp_requests {
    type: sum
    sql: ${TABLE}.SSP_REQUESTS ;;
  }
  measure: traffic_source_fee {
    type: sum
    sql: ${TABLE}.traffic_source_fee ;;
  }
  measure: quartile_1st_rate {
    type: average
    value_format: "0.00%"
    sql: ${TABLE}.video_first_quartiles / NULLIF(${TABLE}.VIDEO_STARTS, 0) ;;
  }
  measure: quartile_2nd_rate {
    type: average
    value_format: "0.00%"
    sql: ${TABLE}.video_midpoints / NULLIF(${TABLE}.VIDEO_STARTS, 0) ;;
  }
  measure: quartile_3rd_rate {
    type: average
    value_format: "0.00%"
    sql: ${TABLE}.video_third_quartiles / NULLIF(${TABLE}.VIDEO_STARTS, 0);;
  }
  measure: vcr_calculated {
    label: "VCR"
    type: average
    value_format: "0.00%"
    sql: ${TABLE}.VIDEO_COMPLETES / NULLIF(${TABLE}.VIDEO_STARTS, 0) ;;
  }
  measure: video_completes {
    type: sum
    sql: ${TABLE}.VIDEO_COMPLETES ;;
  }
  measure: video_errors {
    type: sum
    sql: ${TABLE}.video_errors ;;
  }
  measure: video_first_quartiles {
    type: sum
    sql: ${TABLE}.video_first_quartiles ;;
  }
  measure: video_midpoints {
    type: sum
    sql: ${TABLE}.video_midpoints ;;
  }
  measure: video_starts {
    type: sum
    sql: ${TABLE}.VIDEO_STARTS ;;
  }
  measure: video_start_rate_calculated {
    label: "Video Start Rate"
    type: average
    value_format: "0.00%"
    sql: ${TABLE}.VIDEO_STARTS / NULLIF(${TABLE}.PIXEL_IMPRESSIONS, 0) ;;
  }
  measure: video_error_rate_calculated {
    label: "Video Error Rate"
    type: average
    value_format: "0.00%"
    sql: ${TABLE}.VIDEO_ERRORS / NULLIF(${TABLE}.VIDEO_STARTS, 0) ;;
  }
  measure: video_third_quartiles {
    type: sum
    sql: ${TABLE}.video_third_quartiles ;;
  }
  measure: vtr_calculated {
    label: "VTR"
    type: average
    value_format: "0.00%"
    sql: ${TABLE}.VIDEO_COMPLETES / NULLIF(${TABLE}.PIXEL_IMPRESSIONS, 0) ;;
  }
  measure: wins {
    type: sum
    sql: ${TABLE}.WINS ;;
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      rx_dsp_name,
      rx_ssp_name,
      external_name,
      name,
      deal_partner_name,
      publisher_name,
      personnel_name,
      display_name,
      agency_name,
      dsp_display_name,
      brand_name
    ]
  }

}
