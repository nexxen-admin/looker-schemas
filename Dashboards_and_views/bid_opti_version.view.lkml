
view: bid_opti_version {
  derived_table: {
    sql: Select ad.event_time::date as event_date,
        sp.publisher_id,
        sp.publisher_name,
        ad.media_id as placement_id,
        spl.placement_name as placement_name,
        ad.rx_imp_type,
        ad.rx_device_type,
          case when ad.bidfloor_opti_version != 'no_opti'
            then 'opti'
            else ad.bidfloor_opti_version
            end as Opti_Status,
        ad.bidfloor_opti_version,
        sum(case when ad.rx_request_status in ('nodsp','nodspbids','bidresponse') or ad.rx_request_status is NULL then ad.requests else 0 end) as requests,
        sum(ad.slot_requests) as Attempts,
        sum(ad.responses) as Bids,
        sum(ad.impression_pixel) as Impressions,
        sum(ad.revenue) as revenue,
        sum(ad.cogs) as COGS
      From andromeda.ad_data_daily ad
        inner join sandbox.opti_placements op on op.placementid::varchar = ad.media_id::varchar
                            and ad.rx_ssp_name ilike 'rmp%'
        left outer join andromeda.rx_dim_supply_placement spl on spl.placement_id::varchar = ad.media_id
        left outer join andromeda.rx_dim_supply_publisher_traffic_source spts on spts.pub_ts_id = spl.pub_ts_id
        left outer join andromeda.rx_dim_supply_publisher sp on sp.publisher_id = spts.publisher_id
      where ad.event_time >= current_date()-3
        and ad.event_time < current_date()
      Group by 1, 2, 3, 4, 5, 6, 7, 8, 9
      Order by 1, 2, 3, 4, 5, 6, 7, 8, 9 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: event_date {
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
    sql: ${TABLE}.event_date ;;
  }

  dimension: publisher_id {
    type: number
    sql: ${TABLE}.publisher_id ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  dimension: placement_id {
    type: string
    sql: ${TABLE}.placement_id ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.placement_name ;;
  }

  dimension: rx_imp_type {
    type: string
    sql: ${TABLE}.rx_imp_type ;;
  }

  dimension: rx_device_type {
    type: string
    sql: ${TABLE}.rx_device_type ;;
  }

  dimension: opti_status {
    type: string
    sql: ${TABLE}.Opti_Status ;;
  }

  dimension: bidfloor_opti_version {
    type: string
    sql: ${TABLE}.bidfloor_opti_version ;;
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.requests ;;
    value_format: "#,##0"
  }

  measure: attempts {
    type: sum
    sql: ${TABLE}.Attempts ;;
    value_format: "#,##0"
  }

  measure: bids {
    type: sum
    sql: ${TABLE}.Bids ;;
    value_format: "#,##0"
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
    value_format: "#,##0"
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
    value_format: "$#,##0.00"
  }

  measure: cogs {
    type: sum
    sql: ${TABLE}.COGS ;;
    value_format: "$#,##0.00"
  }

  set: detail {
    fields: [
  publisher_id,
  publisher_name,
  placement_id,
  placement_name,
  rx_imp_type,
  rx_device_type,
  opti_status,
  bidfloor_opti_version,
  requests,
  attempts,
  bids,
  impressions,
  revenue,
  cogs
    ]
  }
}
