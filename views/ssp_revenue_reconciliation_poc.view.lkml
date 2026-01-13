
view: ssp_revenue_reconciliation_poc {
  derived_table: {
    sql: SELECT * FROM bi.DI_Temp_SSP_Validation_POC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_date {
    type: date
    label: "Event Date"
    sql: ${TABLE}.event_date ;;
  }

  dimension: revenue_type {
    type: string
    label: "Demand Source"
    sql: ${TABLE}.revenue_type ;;
  }

  dimension: classification {
    type: string
    label: "DRR Classification"
    sql: ${TABLE}.Classification ;;
  }

  dimension: rx_dsp_account_id {
    type: number
    sql: ${TABLE}.rx_dsp_account_id ;;
    hidden: yes
  }

  dimension: dsp_account {
    type: string
    label: "DSP Account"
    sql: ${TABLE}.DSP_Account ;;
  }

  dimension: rx_dsp_id {
    type: string
    sql: ${TABLE}.rx_dsp_id ;;
    hidden: yes
  }

  dimension: dsp_endpoint {
    type: string
    label: "DSP Endpoint"
    sql: ${TABLE}.DSP_Endpoint ;;
  }

  dimension: rx_ssp_id {
    type: string
    sql: ${TABLE}.rx_ssp_id ;;
    hidden: yes
  }

  dimension: ssp_endpoint {
    type: string
    label: "SSP name"
    sql: ${TABLE}.SSP_Endpoint ;;
  }

  dimension: media_type {
    type: string
    label: "Media Type"
    sql: ${TABLE}.media_type ;;
  }

  dimension: impression_type {
    type: string
    label: "Impression Type"
    sql: ${TABLE}.impression_type ;;
  }

  dimension: device_type {
    type: string
    label: "Device Type"
    sql: ${TABLE}.device_type ;;
  }

  dimension: geo_region {
    type: string
    label: "Geo Region"
    sql: ${TABLE}.Geo_Region ;;
  }

  dimension: dsp_seat {
    type: string
    label: "DSP Seat"
    sql: ${TABLE}.DSP_Seat ;;
  }

  dimension: service_type {
    type: string
    label: "Demand Service Type"
    sql: ${TABLE}.Service_Type ;;
  }

  dimension: campaign_id {
    type: string
    label: "RX Campaign ID"
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: ns_customer_id {
    type: number
    label: "Netsuite Customer ID"
    sql: ${TABLE}.ns_customer_id ;;
  }

  dimension: buyer_original {
    type: string
    label: "Buyer - Original"
    sql: ${TABLE}.Buyer_Original ;;
  }

  dimension: buyer_mapped {
    type: string
    label: "Buyer - Mapped"
    sql: ${TABLE}.Buyer_Mapped ;;
  }

  dimension: advertiser_id {
    type: number
    label: "DSP Advertiser ID"
    sql: ${TABLE}.advertiser_id ;;
  }

  dimension: advertiser_name {
    type: string
    label: "DSP Advertiser Name"
    sql: ${TABLE}.advertiser_name ;;
  }

  dimension: rx_deal_id {
    type: string
    label: "Deal ID - RX"
    sql: ${TABLE}.rx_deal_id ;;
  }

  dimension: platformfee_type {
    type: string
    label: "Platform Fee Type"
    sql: ${TABLE}.platformfee_type ;;
  }

  dimension: dsp_deal_type {
    type: string
    label: "Deal Type - DSP"
    sql: ${TABLE}.dsp_deal_type ;;
  }

  dimension: rx_deal_type_id {
    type: number
    sql: ${TABLE}.rx_deal_type_id ;;
    hidden: yes
  }

  dimension: dd_deal_type {
    type: string
    label: "Deal Type - Deal"
    sql: ${TABLE}.dd_Deal_Type ;;
  }

  dimension: agency_id {
    type: number
    sql: ${TABLE}.agency_id ;;
    hidden: yes
  }

  dimension: deal_agency_then {
    type: string
    label: "Agency (Then)"
    sql: ${TABLE}.Deal_Agency_Then ;;
  }

  dimension: deal_agency_now {
    type: string
    label: "Agency (Now)"
    sql: ${TABLE}.Deal_Agency_Now ;;
  }

  dimension: rebate_agency {
    type: string
    label: "Rebate Agency"
    sql: ${TABLE}.Rebate_Agency ;;
  }

  dimension: agency_rebate_percent {
    type: number
    label: "Agency Rebate % (Config)"
    sql: ${TABLE}.Agency_Rebate_Percent ;;
  }

  dimension: tinuiti_rev_adjustment {
    type: number
    sql: ${TABLE}.Tinuiti_Rev_Adjustment ;;
    hidden: yes
  }

  dimension: deal_barter_percent {
    type: number
    label: "Barter Rebate (Embedded)"
    sql: ${TABLE}.Deal_Barter_Percent ;;

  }

  measure: gross_revenue {
    type: sum
    label: "Gross Revenue"
    sql: ${TABLE}.Gross_Revenue ;;
    value_format: "$#,##0.00"
  }

  measure: cogs {
    type: sum
    label: "COGS"
    sql: ${TABLE}.COGS ;;
    value_format: "$#,##0.00"
  }

  measure: traffic_source_fee {
    type: sum
    label: "Traffic Source Fee"
    sql: ${TABLE}.Traffic_Source_Fee ;;
    value_format: "$#,##0.00"
  }

  measure: pub_platform_fee {
    type: sum
    label: "Pub Platform Fee"
    sql: ${TABLE}.Pub_Platform_Fee ;;
    value_format: "$#,##0.00"
  }

  measure: deal_data_fee {
    type: sum
    label: "Deal Data Fee"
    sql: ${TABLE}.Deal_Data_Fee ;;
    value_format: "$#,##0.00"
    hidden: yes
  }

  measure: currated_marketplace_fee {
    type: sum
    label: "Currated Marketplace Fee"
    sql: ${TABLE}.Currated_Marketplace_Fee ;;
    value_format: "$#,##0.00"
  }

  measure: barter_amount_fact {
    type: sum
    label: "Barter Amount - Fact"
    sql: ${TABLE}.Barter_Amount_Fact ;;
    value_format: "$#,##0.00"
  }

  measure: ssp_platform_fee {
    type: sum
    label: "SSP Platform Fee"
    sql: ${TABLE}.SSP_Platform_Fee ;;
    value_format: "$#,##0.00"
  }

  measure: bidswitch_platform_cost {
    type: sum
    label: "Bidswitch Platform Cost"
    sql: ${TABLE}.Bidswitch_Platform_Cost ;;
    value_format: "$#,##0.00"
  }

  measure: dsp_adj_revenue {
    type: sum
    label: "DSP Revenue Adjustment"
    sql: ${TABLE}.DSP_Adj_Revenue ;;
    value_format: "$#,##0.00"
  }

  measure: dsp_adj_cogs {
    type: sum
    label: "DSP Cost Adjustment"
    sql: ${TABLE}.DSP_Adj_COGS ;;
    value_format: "$#,##0.00"
  }

  measure: barter_rebate_w_ddf {
    type: sum
    label: "Barter Amount - Calc w/ DDF"
    sql: ${TABLE}.Barter_Rebate_W_DDF ;;
    value_format: "$#,##0.00"
  }

  measure: barter_rebate_wout_ddf {
    type: sum
    label: "Barter Amount - Calc w/out DDF"
    sql: ${TABLE}.Barter_Rebate_Wout_DDF ;;
    value_format: "$#,##0.00"
  }

  set: detail {
    fields: [
        event_date,
  revenue_type,
  classification,
  rx_dsp_account_id,
  dsp_account,
  rx_dsp_id,
  dsp_endpoint,
  rx_ssp_id,
  ssp_endpoint,
  media_type,
  impression_type,
  device_type,
  geo_region,
  dsp_seat,
  service_type,
  campaign_id,
  ns_customer_id,
  buyer_original,
  buyer_mapped,
  advertiser_id,
  advertiser_name,
  rx_deal_id,
  platformfee_type,
  dsp_deal_type,
  rx_deal_type_id,
  dd_deal_type,
  agency_id,
  deal_agency_then,
  deal_agency_now,
  rebate_agency,
  agency_rebate_percent,
  tinuiti_rev_adjustment,
  deal_barter_percent,
  gross_revenue,
  cogs,
  traffic_source_fee,
  pub_platform_fee,
  deal_data_fee,
  currated_marketplace_fee,
  barter_amount_fact,
  ssp_platform_fee,
  bidswitch_platform_cost,
  dsp_adj_revenue,
  dsp_adj_cogs,
  barter_rebate_w_ddf,
  barter_rebate_wout_ddf
    ]
  }
}
