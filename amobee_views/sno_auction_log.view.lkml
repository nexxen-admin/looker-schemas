view: auction_log {
  sql_table_name: RAWDB.AUCTION_LOG ;;
  label: "Auction Metrics"

  dimension: version {
    type: string
    label: "Version Number"
    view_label: "Supplemental Facets"
    description: "The version of the Adserver or Logger that captured the impression."
    sql: ${TABLE}.VERSION ;;
  }

  dimension: aws_region {
    type: number
    label: "AWS Region"
    view_label: "Supplemental Facets"
    description: "The ad request was captured in this AWS adserver region."
    sql: ${TABLE}.AWS_REGION ;;
  }

  dimension_group: event_time {
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
    label: "Event"
    hidden: no
    view_label: "Dates"
    sql: ${TABLE}.EVENT_TIME ;;
  }

  dimension_group: supplytime {
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
    label: "Supply Event"
    hidden: no
    view_label: "Dates"
    sql: dateadd('hour', ${placement_details_base.placement_utc_offset},${event_time_raw}) ;;
  }

  dimension: transaction_id {
    type: string
    label: "Transaction Id"
    description: "The Adserver transaction id"
    sql: ${TABLE}.TRANSACTION_ID ;;
  }

  dimension: placement_id {
    type: number
    label: "Placement ID"
    sql: ${TABLE}.PLACEMENT_ID ;;
    value_format_name: id
  }

  dimension: cluster_id {
    type: number
    label: "Cluster Id"
    description: "Assigned cluster for the user"
    sql: ${TABLE}.CLUSTER_ID ;;
    value_format_name: id
  }

  dimension: bidder_id {
    type: number
    label: "Bidder Id"
    description: "Id of the entity bidding in the auction"
    sql: ${TABLE}.BIDDER_ID ;;
    value_format_name: id
  }

  dimension: bidder_description {
    type: string
    label: "Bidder Description"
    description: "Description of the entity bidding in the auction"
    sql: case when ${bidder_id} = 1 then 'Videology'
          when ${bidder_id} in (2,4) then 'TubeMogul'
          when ${bidder_id} = 3 then 'DataXu'
          when ${bidder_id} = 5 then 'ScaleOut'
          when ${bidder_id} = 6 then 'PlatformOne'
          when ${bidder_id} = 7 then 'Amobee'
          when ${bidder_id} = 8 then 'BroAd'
          when ${bidder_id} = 9 then 'Porto'
          when ${bidder_id} = 10 then 'AmobeeDSP'
          else 'Unknown Bidder' end ;;
  }

  dimension: deal_id {
    type: number
    label: "Deal Id"
    description: "Id of the deal for the auction"
    sql: ${TABLE}.DEAL_ID ;;
    value_format_name: id
  }

  dimension: buyer_creative_id {
    type: string
    label: "Buyer Creative Id"
    description: "Id of the creative up for action"
    sql: ${TABLE}.BUYER_CREATIVE_ID ;;
  }

  dimension: bid {
    type: number
    description: "The bid price of a auction opportunity"
    hidden: no
    sql: ${TABLE}.BID_AMOUNT ;;
    value_format_name: decimal_2
  }

  dimension: bid_currency {
    type: string
    description: "The native currency of the bid"
    sql: ${TABLE}.BID_CURRENCY ;;
  }

  dimension: bid_fate_code {
    type: string
    hidden: yes
    description: "The code for the result of the bid"
    sql:${TABLE}.BID_FATE ;;
  }

  dimension: bid_fate {
    type: string
    description: "The result of the bid"
    sql: CASE when ${TABLE}.BID_FATE = 'T' then 'Timeout'
          when ${TABLE}.BID_FATE = 'E' then 'Error'
          when ${TABLE}.BID_FATE = 'N' then 'No Bid'
          when ${TABLE}.BID_FATE = 'I' then 'Invalid Bid'
          when ${TABLE}.BID_FATE = 'A' then 'Unapproved Creative'
          when ${TABLE}.BID_FATE = 'D' then 'Timeout'
          when ${TABLE}.BID_FATE = 'F' then 'Floor Price'
          when ${TABLE}.BID_FATE = 'V' then 'Industry Vertical'
          when ${TABLE}.BID_FATE = 'S' then 'Competitive Separation'
          when ${TABLE}.BID_FATE = 'R' then 'Duration Mismatch'
          when ${TABLE}.BID_FATE = 'U' then 'Duplicate Ad'
          when ${TABLE}.BID_FATE = 'O' then 'Outbid'
          when ${TABLE}.BID_FATE = 'W' then 'Won'
          else 'Unknown'
          END;;
  }

  dimension: bid_fate_description {
    type: string
    description: "The description of the fate of the bid"
    sql: CASE when ${TABLE}.BID_FATE = 'T' then 'The bidder failed to respond within the allotted time.'
          when ${TABLE}.BID_FATE = 'E' then 'The bidder responded with a non 200-series HTTP response.'
          when ${TABLE}.BID_FATE = 'N' then 'The bidder declined to place a bid.'
          when ${TABLE}.BID_FATE = 'I' then 'The bid received was not parseable.'
          when ${TABLE}.BID_FATE = 'A' then 'Post-filtered due to using an unapproved creative.'
          when ${TABLE}.BID_FATE = 'D' then 'Post-filtered due to an unapproved advertiser domain.'
          when ${TABLE}.BID_FATE = 'F' then 'Bid was below the floor price.'
          when ${TABLE}.BID_FATE = 'V' then 'Post-filtered because the bidder used an unapproved industry vertical.'
          when ${TABLE}.BID_FATE = 'S' then 'Post-filtered due to competitive separation rules.'
          when ${TABLE}.BID_FATE = 'R' then 'Post-filtered ad in an adpod due to video ad duration rule.'
          when ${TABLE}.BID_FATE = 'U' then 'For ad pod responses only. Post-filtered because the ad returned by the deal has already been included in the ad-pod.'
          when ${TABLE}.BID_FATE = 'O' then 'The bid was valid, but was outbid by another bidder.'
          when ${TABLE}.BID_FATE = 'W' then 'The bidder won the internal auction.'
          else 'The fate is unknown.  Either not logged or not mapped.'
          END;;
  }

  dimension: clearing_price {
    type: number
    description: "The clearing price of a winning bid"
    hidden: no
    sql: ${TABLE}.CLEARING_PRICE ;;
    value_format_name: decimal_2
  }

  measure: count {
    type: count
    description: "The total number of records in the log.  If a single request results in 5 bid opportunities, count will equal 5"
    drill_fields: []
  }

  measure: requests {
    type: count_distinct
    description: "The distinct number of requests.  If a single request results in 5 bid opportunities, requests will equal 1"
    sql: ${TABLE}.TRANSACTION_ID ;;
  }

  dimension: dt {
    type: number
    label: "dt"
    view_label: "Supplemental Facets"
    description: "Auction log partition key having YYYYMMDDHH format"
    sql: ${TABLE}.PROCESSING_ID ;;
  }
}
