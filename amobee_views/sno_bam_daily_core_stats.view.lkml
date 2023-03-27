view: bam_daily_core_stats {
  sql_table_name: FINANCE.BAM_DAILY_CORE_STATS ;;

  dimension: addon_product_cost {
    type: number
    sql: ${TABLE}.ADDON_PRODUCT_COST ;;
  }

  dimension: adserving_cost {
    type: number
    sql: ${TABLE}.ADSERVING_COST ;;
  }

  dimension: adserving_cost_currency {
    type: string
    sql: ${TABLE}.ADSERVING_COST_CURRENCY ;;
  }

  dimension: adserving_cost_markup {
    type: number
    sql: ${TABLE}.ADSERVING_COST_MARKUP ;;
  }

  dimension: agency_fee {
    type: number
    sql: ${TABLE}.AGENCY_FEE ;;
  }

  dimension: as_addon_product_cost {
    type: number
    sql: ${TABLE}.AS_ADDON_PRODUCT_COST ;;
  }

  dimension: bam_adserving_cost {
    type: number
    sql: ${TABLE}.BAM_ADSERVING_COST ;;
  }

  dimension: bam_data_price {
    type: number
    sql: ${TABLE}.BAM_DATA_PRICE ;;
  }

  dimension: bam_media_price {
    type: number
    sql: ${TABLE}.BAM_MEDIA_PRICE ;;
  }

  dimension: bam_platform_fee {
    type: number
    sql: ${TABLE}.BAM_PLATFORM_FEE ;;
  }

  dimension: bam_tracking_cost {
    type: number
    sql: ${TABLE}.BAM_TRACKING_COST ;;
  }

  dimension: billable_impressions {
    type: number
    sql: ${TABLE}.BILLABLE_IMPRESSIONS ;;
  }

  dimension: billable_units {
    type: number
    sql: ${TABLE}.BILLABLE_UNITS ;;
  }

  dimension: bt_cluster_cost {
    type: number
    sql: ${TABLE}.BT_CLUSTER_COST ;;
  }

  dimension: bt_cluster_cost_currency {
    type: string
    sql: ${TABLE}.BT_CLUSTER_COST_CURRENCY ;;
  }

  dimension: bt_cluster_cost_markup {
    type: number
    sql: ${TABLE}.BT_CLUSTER_COST_MARKUP ;;
  }

  dimension: bt_cluster_provider {
    type: number
    sql: ${TABLE}.BT_CLUSTER_PROVIDER ;;
  }

  dimension: bt_cost_markup {
    type: number
    sql: ${TABLE}.BT_COST_MARKUP ;;
  }

  dimension: btcostcurrency {
    type: string
    sql: ${TABLE}.BTCOSTCURRENCY ;;
  }

  dimension: btproviderdatacost {
    type: number
    sql: ${TABLE}.BTPROVIDERDATACOST ;;
  }

  dimension: cost_units {
    type: number
    sql: ${TABLE}.COST_UNITS ;;
  }

  dimension: demand_adserving_cost {
    type: number
    sql: ${TABLE}.DEMAND_ADSERVING_COST ;;
  }

  dimension: demand_bt_cluster_cost {
    type: number
    sql: ${TABLE}.DEMAND_BT_CLUSTER_COST ;;
  }

  dimension: demand_bt_cost {
    type: number
    sql: ${TABLE}.DEMAND_BT_COST ;;
  }

  dimension: demand_currency {
    type: string
    sql: ${TABLE}.DEMAND_CURRENCY ;;
  }

  dimension_group: demand {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DEMAND_DATE ;;
  }

  dimension: demand_demo_cost {
    type: number
    sql: ${TABLE}.DEMAND_DEMO_COST ;;
  }

  dimension: demand_payout {
    type: number
    sql: ${TABLE}.DEMAND_PAYOUT ;;
  }

  dimension: demand_revenue {
    type: number
    sql: ${TABLE}.DEMAND_REVENUE ;;
  }

  dimension: demand_tracking_cost {
    type: number
    sql: ${TABLE}.DEMAND_TRACKING_COST ;;
  }

  dimension: demo_cost_markup {
    type: number
    sql: ${TABLE}.DEMO_COST_MARKUP ;;
  }

  dimension: democostcurrency {
    type: string
    sql: ${TABLE}.DEMOCOSTCURRENCY ;;
  }

  dimension: demoproviderdatacost {
    type: number
    sql: ${TABLE}.DEMOPROVIDERDATACOST ;;
  }

  dimension: effective_impressions {
    type: number
    sql: ${TABLE}.EFFECTIVE_IMPRESSIONS ;;
  }

  dimension: effective_units {
    type: number
    sql: ${TABLE}.EFFECTIVE_UNITS ;;
  }

  dimension_group: est {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.EST_DATE ;;
  }

  dimension: flight_media_id {
    type: number
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
    value_format_name: id
  }

  dimension: gbp_exchange_rate {
    type: number
    sql: ${TABLE}.GBP_EXCHANGE_RATE ;;
  }

  dimension_group: gmt {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.GMT_DATE ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.IMPRESSIONS ;;
  }

  dimension: marketplace_fee {
    type: number
    sql: ${TABLE}.MARKETPLACE_FEE ;;
  }

  dimension: media_markup {
    type: number
    sql: ${TABLE}.MEDIA_MARKUP ;;
  }

  dimension: media_price {
    type: number
    sql: ${TABLE}.MEDIA_PRICE ;;
  }

  dimension: mmp {
    type: number
    sql: ${TABLE}.MMP ;;
  }

  dimension: opt_margin {
    type: number
    sql: ${TABLE}.OPT_MARGIN ;;
  }

  dimension: opt_margin_adjusted {
    type: number
    sql: ${TABLE}.OPT_MARGIN_ADJUSTED ;;
  }

  dimension: payment_processing {
    type: number
    sql: ${TABLE}.PAYMENT_PROCESSING ;;
  }

  dimension: payout {
    type: number
    sql: ${TABLE}.PAYOUT ;;
  }

  dimension: payout_currency {
    type: string
    sql: ${TABLE}.PAYOUT_CURRENCY ;;
  }

  dimension: placement_id {
    type: number
    sql: ${TABLE}.PLACEMENT_ID ;;
    value_format_name: id
  }

  dimension: platform_markup {
    type: number
    sql: ${TABLE}.PLATFORM_MARKUP ;;
  }

  dimension_group: region {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.REGION_DATE ;;
  }

  dimension: region_exchange_rate {
    type: number
    sql: ${TABLE}.REGION_EXCHANGE_RATE ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.REVENUE ;;
  }

  dimension: rpu_currency {
    type: string
    sql: ${TABLE}.RPU_CURRENCY ;;
  }

  dimension: tracking_cost {
    type: number
    sql: ${TABLE}.TRACKING_COST ;;
  }

  dimension: tracking_cost_currency {
    type: string
    sql: ${TABLE}.TRACKING_COST_CURRENCY ;;
  }

  dimension: tracking_cost_markup {
    type: number
    sql: ${TABLE}.TRACKING_COST_MARKUP ;;
  }

  dimension: units {
    type: number
    sql: ${TABLE}.UNITS ;;
  }

  dimension: usd_exchange_rate {
    type: number
    sql: ${TABLE}.USD_EXCHANGE_RATE ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
