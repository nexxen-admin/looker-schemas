# The name of this view in Looker is "Bid Details In App"
view: bid_details_in_app {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: BI_New.Bid_Details_in_App ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Bid Price Bucket" in Explore.

  dimension: bid_price_bucket {
    type: number
    sql: ${TABLE}.Bid_Price_Bucket ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_bid_price_bucket {
    type: sum
    sql: ${bid_price_bucket} ;;
  }

  measure: average_bid_price_bucket {
    type: average
    sql: ${bid_price_bucket} ;;
  }

  dimension: bids_auction_lost {
    type: number
    sql: ${TABLE}.Bids_Auction_lost ;;
  }

  dimension: bids_ssp_filtered {
    type: number
    sql: ${TABLE}.Bids_SSP_Filtered ;;
  }

  dimension: bids_valid {
    type: number
    value_format_name: id
    sql: ${TABLE}.Bids_Valid ;;
  }

  dimension: datacenter {
    type: string
    sql: ${TABLE}.Datacenter ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: db_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.db_update_date ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.Device_Type ;;
  }

  dimension: dsp_name {
    type: string
    sql: ${TABLE}.DSP_Name ;;
  }

  dimension: event {
    type: date
    label: "Event Date"
    sql: ${TABLE}.Event_Date ;;
  }

  dimension: imp_subtype {
    type: string
    sql: ${TABLE}.Imp_Subtype ;;
  }

  dimension: imp_type {
    type: string
    sql: ${TABLE}.Imp_Type ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.Impressions ;;
  }

  dimension: origin_domain {
    type: string
    sql: ${TABLE}.Origin_Domain ;;
  }

  dimension: placement_id {
    type: string
    sql: ${TABLE}.Placement_ID ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.Placement_Name ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.Pub_ID ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.Publisher_Name ;;
  }

  dimension: wins {
    type: number
    sql: ${TABLE}.Wins ;;
  }

  measure: count {
    type: count
    drill_fields: [dsp_name, publisher_name, placement_name]
  }
}
