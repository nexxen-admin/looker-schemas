
view: bid_opti_v1 {
  derived_table: {
    sql: WITH placement_tab as (select distinct placement_id,bidfloor_only_pct,pubcost_only_pct,bidfloor_pubcost_pct,imp_type
                        from(
                                (select distinct placement_id,bidfloor_only_pct,pubcost_only_pct,bidfloor_pubcost_pct,imp_type
                                from Andromeda.rx_dim_supply_placement_margin_opti_split_override_r)
                                UNION ALL
                                (select distinct placement_id,bidfloor_only_pct,pubcost_only_pct,bidfloor_pubcost_pct,imp_type
                                from Andromeda.rx_dim_supply_placement_margin_opti_split_automated_r
                                where placement_id not in (select placement_id from Andromeda.rx_dim_supply_placement_margin_opti_split_override_r)
                                )) AA),

    Base_Data as (
      -- only floor opti
      Select ad.event_time::date as event_date,
        sp.publisher_id,
        sp.publisher_name,
        ad.media_id as placement_id,
        spl.placement_name as placement_name,
        ad.rx_imp_type as imp_type,

      CASE WHEN (ad.pubcost_opti_enabled >= -3 AND ad.pubcost_opti_enabled <= 0 AND ad.bidfloor_opti_version = 'no_opti') THEN 'no opti'
      WHEN (ad.pubcost_opti_enabled >= -3 AND ad.pubcost_opti_enabled <= 0
            AND ad.bidfloor_opti_version != 'no_opti'
            AND ad.bidfloor_opti_version is not null)
            THEN 'opti'
      else 'not use'
      end as Opti_Status,


        bidfloor_only_pct,
        pubcost_only_pct,
        bidfloor_pubcost_pct,
        --ad.bidfloor_opti_version,
        -- measures
        case when sum(ad.impression_pixel) > 0 then
          sum(ad.rx_bid_floor * ad.impression_pixel) / sum(impression_pixel)
          else NULL end as Bid_Floor,
        sum(case when ad.rx_request_status in ('nodsp','nodspbids','bidresponse') or ad.rx_request_status is NULL then ad.requests else 0 end) as requests,
        sum(ad.slot_attempts) as Attempts,
        sum(ad.responses) as Bids,
        sum(ad.impression_pixel) as Impressions,
        sum(ad.cost) as Cost,
        sum(ad.cogs) as COGS,
        sum(ad.revenue) as revenue
      From andromeda.ad_data_daily ad
        inner join placement_tab op on (op.placement_id::varchar = ad.media_id::varchar and rx_imp_type::varchar = imp_type::varchar)
                            and ad.rx_ssp_name ilike 'rmp%'
        left outer join andromeda.rx_dim_supply_placement spl on spl.placement_id::varchar = ad.media_id
        left outer join andromeda.rx_dim_supply_publisher_traffic_source spts on spts.pub_ts_id = spl.pub_ts_id
        left outer join andromeda.rx_dim_supply_publisher sp on sp.publisher_id = spts.publisher_id
      where ad.event_time::date >= current_date()-3
            and ad.event_time::date < current_date()
        and bidfloor_opti_version is not null
        and (bidfloor_only_pct > 0)
        and ( (case when ad.rx_request_status in ('nodsp','nodspbids','bidresponse') or ad.rx_request_status is NULL then ad.requests else 0 end) > 0
            or ad.slot_attempts > 0
            or ad.responses > 0
            or ad.impression_pixel > 0)
      Group by 1, 2, 3, 4, 5, 6, 7,8,9,10),

Placement_Limiter as (
Select event_date,
  placement_id,
  imp_type,
  sum(case when Opti_Status = 'opti' then requests else 0 end) as Opti_Requests,
  sum(case when Opti_Status = 'no opti' then requests else 0 end) as Non_Opti_Requests,
  sum(requests) as Total_Requests,
  sum(case when Opti_Status = 'opti' then requests else 0 end) / sum(requests) as Percent_Opti
From base_Data
Where requests > 0
Group by 1, 2, 3
Having Opti_Requests>0 and Non_Opti_Requests>0

)


      Select bd.event_date,
      bidfloor_only_pct,
      pubcost_only_pct,
      bidfloor_pubcost_pct,
      100-bidfloor_only_pct-pubcost_only_pct-bidfloor_pubcost_pct as no_opti_pct,
      bd.publisher_id,
      bd.publisher_name,
      bd.placement_id,
      bd.placement_name,
      bd.imp_type,
      bd.Opti_Status,
      bd.Bid_Floor,
      bd.Requests,
      bd.Requests/(bd.Requests/(sum(bd.Requests) over (partition by bd.event_date,bd.publisher_id,bd.publisher_name,bd.placement_id,bd.placement_name,bd.imp_type))) as Requests_scaled,
      (bd.Requests/(sum(bd.Requests) over (partition by bd.event_date,bd.publisher_id,bd.publisher_name,bd.placement_id,bd.placement_name,bd.imp_type))) as req_ratio,
      bd.Attempts,
      bd.Attempts/(bd.Requests/(sum(bd.Requests) over (partition by bd.event_date,bd.publisher_id,bd.publisher_name,bd.placement_id,bd.placement_name,bd.imp_type))) as Attempts_scaled,
      bd.Bids,
      bd.Bids/(bd.Requests/(sum(bd.Requests) over (partition by bd.event_date,bd.publisher_id,bd.publisher_name,bd.placement_id,bd.placement_name,bd.imp_type))) as bid_scaled,
      bd.Impressions,
      bd.Impressions/(bd.Requests/(sum(bd.Requests) over (partition by bd.event_date,bd.publisher_id,bd.publisher_name,bd.placement_id,bd.placement_name,bd.imp_type))) as Impressions_scaled,
      bd.Cost,
      bd.Cost/(bd.Requests/(sum(bd.Requests) over (partition by bd.event_date,bd.publisher_id,bd.publisher_name,bd.placement_id,bd.placement_name,bd.imp_type))) as cost_scaled,
      bd.COGS,
      bd.COGS/(bd.Requests/(sum(bd.Requests) over (partition by bd.event_date,bd.publisher_id,bd.publisher_name,bd.placement_id,bd.placement_name,bd.imp_type))) as COGS_scaled,
      bd.Cost- bd.COGS as "Supply Margin $",
      (bd.Cost- bd.COGS)/(bd.Requests/(sum(bd.Requests) over (partition by bd.event_date,bd.publisher_id,bd.publisher_name,bd.placement_id,bd.placement_name,bd.imp_type))) as supply_margin_dollar_scaled,
      bd.Attempts / nullif(bd.Requests,0) as "Attempt Rate",
      bd.Bids / nullif(bd.requests,0) as "Bid Rate",
      bd.Impressions / nullif(bd.Requests,0) as "Fill Rate",
      (bd.Cost / nullif(bd.Impressions,0)) * 1000 as 'eCPM',
      (bd.Cost - bd.COGS)/nullif(bd.Cost,0) as "Supply Margin %",
      (bd.Cost- bd.COGS) / nullif((bd.Requests/1000000),0) as "Supply Margin $ /M Requests",
      bd.Bid_Floor*bd.Impressions as "Bid Floor Imp",
      revenue,
      revenue/(bd.Requests/(sum(bd.Requests) over (partition by bd.event_date,bd.publisher_id,bd.publisher_name,bd.placement_id,bd.placement_name,bd.imp_type))) as revenue_scaled
      From base_data bd
      inner join Placement_Limiter pl on pl.event_date = bd.event_date
                  and pl.placement_id = bd.placement_id
                  and pl.imp_type = bd.imp_type
      where bd.Requests > 0;;

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
    type: string
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

  dimension: imp_type {
    type: string
    sql: ${TABLE}.imp_type ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: opti_status {
    type: string
    sql: ${TABLE}.Opti_Status ;;
  }



  dimension: bidfloor_only_pct {
    type: string
    sql: ${TABLE}.bidfloor_only_pct ;;
    hidden: no
  }

  dimension: pubcost_only_pct {
    type: number
    sql: ${TABLE}.pubcost_only_pct ;;
  }

  dimension: bidfloor_pubcost_pct {
    type: number
    sql: ${TABLE}.bidfloor_pubcost_pct ;;
  }

  dimension: no_opti_pct {
    type: number
    sql: ${TABLE}.no_opti_pct ;;
  }




  # dimension: bidfloor_opti_version {
  #   type: string
  #   sql: ${TABLE}.bidfloor_opti_version ;;
  # }

  measure: bid_floor {
    type: sum
    sql: ${TABLE}.bid_floor ;;
    value_format: "$#,##0.00"
  }

  measure: bid_floor_imp_tmp {
    type: sum
    sql: ${TABLE}."Bid Floor Imp" ;;
    value_format: "$#,##0.00"
  }

  measure: bid_floor_imp {
    type: number
    sql: ${bid_floor_imp_tmp}/${impressions} ;;
    value_format: "$#,##0.00"
  }

  measure: bid_floor_avg {
    type: average
    sql: ${TABLE}.bid_floor ;;
    value_format: "$#,##0.00"
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.requests ;;
    value_format: "#,##0"
  }



  measure: Requests_scaled {
    type: sum
    sql: ${TABLE}.Requests_scaled ;;
    value_format: "#,##0"
  }

  measure: req_ratio {
    type: sum
    sql: ${TABLE}.req_ratio ;;
    value_format:"0.00%"
  }

  measure: attempts {
    type: sum
    sql: ${TABLE}.Attempts ;;
    value_format: "#,##0"
  }

  measure: Attempts_scaled {
    type: sum
    sql: ${TABLE}.Attempts_scaled ;;
    value_format: "#,##0"
  }

  measure: bids {
    type: sum
    sql: ${TABLE}.Bids ;;
    value_format: "#,##0"
  }

  measure: bid_scaled {
    type: sum
    sql: ${TABLE}.bid_scaled ;;
    value_format: "#,##0"
  }




  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
    value_format: "#,##0"
  }

  measure: Impressions_scaled {
    type: sum
    sql: ${TABLE}.Impressions_scaled ;;
    value_format: "#,##0"
  }


  measure: cogs {
    type: sum
    sql: ${TABLE}.COGS ;;
    value_format: "$#,##0.00"
  }


  measure: COGS_scaled {
    type: sum
    sql: ${TABLE}.COGS_scaled ;;
    value_format: "$#,##0.00"
  }


  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
    value_format: "$#,##0.00"
  }

  measure: cost_scaled {
    type: sum
    sql: ${TABLE}.cost_scaled ;;
    value_format: "$#,##0.00"
  }


  measure: supply_margin_dollar {
    type: number
    sql: ${cost}-${cogs} ;;
    value_format: "$#,##0.00"
  }


  measure: supply_margin_dollar_scaled {
    type: sum
    sql: ${TABLE}.supply_margin_dollar_scaled ;;
    value_format: "$#,##0.00"
  }

  measure: supply_margin_dollar_avg {
    type: average
    sql: ${TABLE}."Supply Margin $" ;;
    value_format: "$#,##0.00"
  }

  measure: attempt_rate {
    type: number
    sql: ${attempts}/nullif(${requests},0) ;;
    value_format:"0.00%"
  }

  measure: attempt_rate_avg {
    type: average
    sql: ${TABLE}."Attempt Rate" ;;
  }

  measure: bid_rate {
    type: number
    sql: ${bids}/nullif(${requests},0) ;;
    value_format:"0.00%"
  }

  measure: bid_rate_avg {
    type: average
    sql: ${TABLE}."Bid Rate" ;;
    value_format:"0.00%"
  }

  measure: fill_rate {
    type: number
    sql: ${impressions}/nullif(${requests},0) ;;
    value_format: "0.00%"
  }

  measure: fill_rate_avg {
    type: average
    sql: ${TABLE}."Fill Rate" ;;
    value_format: "0.00%"
  }

  measure: ecpm {
    type: number
    sql: ${cost}/nullif(${impressions},0)*1000 ;;
    value_format: "$#,##0.00"
  }

  measure: ecpm_avg {
    type: average
    sql: ${TABLE}.'eCPM' ;;
    value_format: "$#,##0.00"
  }

  measure: supply_margin_percent {
    type: number
    sql: (${cost}-${cogs})/nullif(${cost},0) ;;
    value_format: "0.00%"
  }

  measure: supply_margin_percent_avg {
    type: average
    sql: ${TABLE}."Supply Margin %" ;;
    value_format: "0.00%"
  }

  measure: supply_margin_dollar_per_M_requests{
    type: number
    sql: (${cost}-${cogs})/nullif((${requests}/1000000),0);;
    value_format: "$#,##0.00"
  }

  measure: supply_margin_dollar_per_M_requests_avg{
    type: average
    sql: ${TABLE}."Supply Margin $ /M Requests" ;;
    value_format: "$#,##0.00"
  }

  measure: revenue{
    type: sum
    sql: ${TABLE}.revenue;;
    value_format: "$#,##0.00"
  }


  measure: revenue_scaled{
    type: sum
    sql: ${TABLE}.revenue_scaled;;
    value_format: "$#,##0.00"
  }

  set: detail {
    fields: [
      publisher_id,
      publisher_name,
      placement_id,
      placement_name,
      imp_type,
      device_type,
      opti_status,

      bidfloor_only_pct,
      pubcost_only_pct,
      bidfloor_pubcost_pct,
      no_opti_pct,

      requests,
      req_ratio,
      attempts,
      bids,
      impressions,
      cogs,
      Attempts_scaled,
      bid_scaled,
      COGS_scaled,
      cost_scaled,
      Impressions_scaled,
      Requests_scaled,
      Requests_scaled,
      supply_margin_dollar_scaled,
      supply_margin_percent_avg,
      revenue,
      revenue_scaled
    ]
  }
}
