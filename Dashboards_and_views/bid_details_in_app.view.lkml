view: bid_details_in_app {
  sql_table_name: bi_new.Bid_Details_in_App ;;

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_date {
    type: date
    label: "Event Date"
    sql: ${TABLE}.Event_Date ;;
  }

  dimension: pub_id {
    type: string
    label: "Pub ID"
    sql: ${TABLE}.Pub_ID ;;
  }

  dimension: publisher_name {
    type: string
    label: "Publisher Name"
    sql: ${TABLE}.Publisher_Name ;;
  }

  dimension: placement_id {
    type: string
    label: "Placement ID"
    sql: ${TABLE}.Placement_ID ;;
  }

  dimension: placement_name {
    type: string
    label: "Placement Name"
    sql: ${TABLE}.Placement_Name ;;
  }

  dimension: origin_domain {
    type: string
    label: "Origin Domain"
    sql: ${TABLE}.Origin_Domain ;;
  }

  dimension: device_type {
    type: string
    label: "Device Type"
    sql: ${TABLE}.Device_Type ;;
  }

  dimension: imp_type {
    type: string
    label: "Imp Type"
    sql: ${TABLE}.Imp_Type ;;
  }

  dimension: imp_subtype {
    type: string
    label: "Imp_Subtype"
    sql: ${TABLE}.Imp_Subtype ;;
  }

  dimension: bid_price_bucket {
    type: number
    label: "Bid Price Bucket"
    sql: ${TABLE}.Bid_Price_Bucket ;;
  }

  dimension: datacenter {
    type: string
    label: "Datacenter"
    sql: ${TABLE}.Datacenter ;;
  }

  dimension: dsp_name {
    type: string
    label: "DSP Name"
    sql: ${TABLE}.DSP_Name ;;
  }

  measure: bids_valid {
    type: sum
    label: "Bids Valid"
    value_format: "#,##0"
    sql: ${TABLE}.Bids_Valid ;;
  }

  measure: bids_auction_lost {
    type: sum
    label: "Bids Auction Lost"
    value_format: "#,##0"
    sql: ${TABLE}.Bids_Auction_lost ;;
  }

  measure: bids_ssp_filtered {
    type: sum
    label: "Bids SSP Filtered"
    value_format: "#,##0"
    sql: ${TABLE}.Bids_SSP_Filtered ;;
  }

  measure: wins {
    type: sum
    label: "Wins"
    value_format: "#,##0"
    sql: ${TABLE}.Wins ;;
  }

  measure: impressions {
    type: sum
    label: "Impressions"
    value_format: "#,##0"
    sql: ${TABLE}.Impressions ;;
  }

  set: detail {
    fields: [
      event_date,
      pub_id,
      publisher_name,
      placement_id,
      placement_name,
      origin_domain,
      device_type,
      imp_type,
      imp_subtype,
      bid_price_bucket,
      datacenter,
      dsp_name,
      bids_valid,
      bids_auction_lost,
      bids_ssp_filtered,
      wins,
      impressions
    ]
  }
}
