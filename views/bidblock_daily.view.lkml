# The name of this view in Looker is "Bidblock Daily"
view: bidblock_daily {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: spearad.bidblock_daily ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Advertiser" in Explore.

  dimension: advertiser {
    type: string
    sql: ${TABLE}.advertiser ;;
  }

  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
  }

  dimension: bid_cfg_id {
    type: number
    sql: ${TABLE}.bid_cfg_id ;;
  }

  dimension: bids {
    type: number
    sql: ${TABLE}.bids ;;
  }

  dimension: buyer_account {
    type: string
    sql: ${TABLE}.buyer_account ;;
  }

  dimension: buyer_account_id {
    type: number
    sql: ${TABLE}.buyer_account_id ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: channel_id {
    type: number
    sql: ${TABLE}.channel_id ;;
  }

  dimension: creative {
    type: string
    sql: ${TABLE}.creative ;;
  }

  dimension: creative_id {
    type: number
    sql: ${TABLE}.creative_id ;;
  }

  dimension: deal {
    type: string
    sql: ${TABLE}.deal ;;
  }

  dimension: deal_id {
    type: number
    sql: ${TABLE}.deal_id ;;
  }

  dimension: decision_records {
    type: number
    sql: ${TABLE}.decision_records ;;
  }

  dimension: decision_records_with_bblk {
    type: number
    sql: ${TABLE}.decision_records_with_bblk ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: delivery {
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
    sql: ${TABLE}.delivery_date ;;
  }

  dimension: demand_config_id {
    type: number
    sql: ${TABLE}.demand_config_id ;;
  }

  dimension: demand_type {
    type: string
    sql: ${TABLE}.demand_type ;;
  }

  dimension: demand_vendor {
    type: string
    sql: ${TABLE}.demand_vendor ;;
  }

  dimension: demand_vendor_gvl {
    type: string
    sql: ${TABLE}.demand_vendor_gvl ;;
  }

  dimension: demand_vendor_gvl_id {
    type: number
    sql: ${TABLE}.demand_vendor_gvl_id ;;
  }

  dimension: demand_vendor_id {
    type: number
    sql: ${TABLE}.demand_vendor_id ;;
  }

  dimension: global_advertiser {
    type: string
    sql: ${TABLE}.global_advertiser ;;
  }

  dimension: global_advertiser_id {
    type: number
    sql: ${TABLE}.global_advertiser_id ;;
  }

  dimension: impression_revenue {
    type: number
    sql: ${TABLE}.impression_revenue ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_impression_revenue {
    type: sum
    sql: ${impression_revenue} ;;
  }

  measure: average_impression_revenue {
    type: average
    sql: ${impression_revenue} ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: line_item {
    type: string
    sql: ${TABLE}.line_item ;;
  }

  dimension: line_item_id {
    type: number
    sql: ${TABLE}.line_item_id ;;
  }

  dimension: nbr {
    type: number
    sql: ${TABLE}.nbr ;;
  }

  dimension: nbr_constant {
    type: string
    sql: ${TABLE}.nbr_constant ;;
  }

  dimension: nbr_description {
    type: string
    sql: ${TABLE}.nbr_description ;;
  }

  dimension: open_rtb_connection {
    type: string
    sql: ${TABLE}.open_rtb_connection ;;
  }

  dimension: opportunity {
    type: number
    sql: ${TABLE}.opportunity ;;
  }

  dimension: ortb_id {
    type: number
    sql: ${TABLE}.ortb_id ;;
  }

  dimension: region_id {
    type: number
    sql: ${TABLE}.region_id ;;
  }

  dimension: sa_bid_type {
    type: string
    sql: ${TABLE}.sa_bid_type ;;
  }

  dimension: seller_account {
    type: string
    sql: ${TABLE}.seller_account ;;
  }

  dimension: seller_account_id {
    type: number
    sql: ${TABLE}.seller_account_id ;;
  }

  dimension: tag_based_demand_config {
    type: string
    sql: ${TABLE}.tag_based_demand_config ;;
  }

  dimension: tbd_id {
    type: number
    sql: ${TABLE}.tbd_id ;;
  }

  dimension: vus {
    type: number
    sql: ${TABLE}.vus ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
