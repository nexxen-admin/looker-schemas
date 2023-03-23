view: bid_details_in_app {
  derived_table: {
    sql: Select data.Event_Date,
        data.Pub_ID,
        sp.Publisher_Name,
        data.Placement_ID,
        spl.Placement_Name,
        data.Origin_Domain,
        data.Device_Type,
        data.Imp_Type,
        data.Imp_Subtype,
        data.Bid_Price_Bucket,
        data.Datacenter,
        data.DSP_Name,
        data.Bids_Valid,
        data.Bids_Auction_lost,
        data.Bids_SSP_Filtered,
        data.Wins,
        data.Impressions
      From
      (Select coalesce(imp.event_date,bid.event_date) as Event_Date,
        coalesce(imp.pubid,bid.pubid) as Pub_ID,
        coalesce(imp.placementid,bid.placementid) as Placement_ID,
        coalesce(imp.origdomain,bid.origindomain) as Origin_Domain,
        coalesce(imp.devicetype,bid.devicetype) as Device_Type,
        coalesce(imp.imptype,bid.imptype) as Imp_Type,
        coalesce(imp.impsubtype,bid.impsubtype) as Imp_Subtype,
        coalesce(imp.sspbidpricebucket,bid.bidpricebucket) as Bid_Price_Bucket,
        coalesce(imp.datacenter,bid.datacenter) as Datacenter,
        coalesce(imp.dspid,bid.dspid) as DSP_Name,
        coalesce(bid.Bids_Valid,0) as Bids_Valid,
        coalesce(bid.Bids_Auction_lost,0) as Bids_Auction_lost,
        coalesce(bid.Bids_SSP_Filtered,0) as Bids_SSP_Filtered,
        coalesce(imp.wins,0) as Wins,
        coalesce(imp.pixels,0) as Impressions
      From
        (Select event_time::date as event_date,
          pubid,
          coalesce(siteid,appid) as placementid,
          origdomain,
          case when devicetype = '2' then 'desktop'
            when devicetype = '3' then 'ctv'
            when devicetype in ('4','5','6') then 'mobile'
            else 'other' end as devicetype,
          imptype,
          impsubtype,
          round(sspbidprice,2) as sspbidpricebucket,
          region as datacenter,
          dspid,
          count(distinct case when source = 'impserve' then requestid else NULL End) as wins,
          count(distinct case when source = 'impbeacon' then requestid else NULL End) as pixels
        From andromeda.impression_r
        Where event_time >= current_date()-3
          and event_time < current_date()
          and rgblocked = 'unblocked'
          and mediatype = 'app'
        Group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10) imp
      Full Join
        (Select event_time::date as event_date,
          pubid,
          placementid,
          mediadomain as origindomain,
          devicetype,
          imptype,
          impsubtype,
          round(bidprice,2) as bidpricebucket,
          datacenter,
          dspid,
          sum(Case when responseresult = 'attempt' then samplerate
              else 0 end) as Bids_Valid,
          sum(Case when responseresult = 'auctionloss' then samplerate
              else 0 end) as Bids_Auction_lost,
          sum(Case when responseresult != 'auctionloss'
                and responseresult != 'attempt' then samplerate
              else 0 end) as Bids_SSP_Filtered
         From andromeda.sspbidresponse_r
         Where event_time >= current_date()-3
          and event_time < current_date()
          and mediatype = 'app'
         Group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10) Bid on bid.event_date = imp.event_date
                              and bid.pubid = imp.pubid
                              and bid.placementid = imp.placementid
                              and bid.origindomain = imp.origdomain
                              and bid.devicetype = imp.devicetype
                              and bid.imptype = imp.imptype
                              and bid.impsubtype = imp.impsubtype
                              and bid.bidpricebucket = imp.sspbidpricebucket
                              and bid.datacenter = imp.datacenter
                              and bid.dspid = imp.dspid  ) data
      Inner Join andromeda.rx_dim_supply_placement spl on spl.placement_id = data.Placement_ID
      Left Outer Join Andromeda.rx_dim_supply_publisher_traffic_source spts on spts.pub_ts_id = spl.pub_ts_id
      Left Outer Join Andromeda.rx_dim_supply_publisher sp on sp.publisher_id = spts.publisher_id
       ;;
  }

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
