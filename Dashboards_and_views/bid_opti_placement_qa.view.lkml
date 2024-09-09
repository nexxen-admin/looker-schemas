view: bid_opti_placement_qa {
  derived_table: {
    sql:
Select media_id as placement_id,
       bidfloor_only_pct,
       pubcost_only_pct,
       bidfloor_pubcost_pct,

       NULLIF(SUM(CASE WHEN bidfloor_opti_version is not null THEN requests end),0) as tot_requests,

       (round(SUM(CASE WHEN (bidfloor_opti_version != 'no_opti' AND bidfloor_opti_version is not null) THEN requests end)/NULLIF(SUM(CASE WHEN bidfloor_opti_version is not null THEN requests end),0),3))*100 as request_ratio,

      (NULLIF(SUM(CASE WHEN (ad.bidfloor_opti_version = 'no_opti'
             AND (ad.pubcost_opti_version = 'no_opti' OR ad.pubcost_opti_version is null)) THEN 0

             WHEN (ad.bidfloor_opti_version != 'no_opti' AND ad.bidfloor_opti_version is not null
                         AND (ad.pubcost_opti_version = 'no_opti' or ad.pubcost_opti_version is null)
                         ) THEN requests
             ELSE 0 END),0)/
      NULLIF(SUM(CASE WHEN (ad.bidfloor_opti_version = 'no_opti'
             AND (ad.pubcost_opti_version = 'no_opti' OR ad.pubcost_opti_version is null)) THEN requests

             WHEN (ad.bidfloor_opti_version != 'no_opti' AND ad.bidfloor_opti_version is not null
                         AND (ad.pubcost_opti_version = 'no_opti' or ad.pubcost_opti_version is null)
                         ) THEN requests
             ELSE 0 END),0))*100 as bid_floor_opti_ratio,

      (NULLIF(SUM(CASE WHEN (ad.pubcost_opti_version = 'no_opti' AND ad.bidfloor_opti_version = 'no_opti') THEN 0
              WHEN (ad.pubcost_opti_version != 'no_opti' AND ad.bidfloor_opti_version = 'no_opti'
              AND ad.pubcost_opti_version is not null  AND ad.bidfloor_opti_version is not null) THEN requests
              else 0 END),0)/
      NULLIF(SUM(CASE WHEN (ad.pubcost_opti_version = 'no_opti' AND ad.bidfloor_opti_version = 'no_opti') THEN requests
              WHEN (ad.pubcost_opti_version != 'no_opti' AND ad.bidfloor_opti_version = 'no_opti'
              AND ad.pubcost_opti_version is not null  AND ad.bidfloor_opti_version is not null) THEN requests
              else 0 END),0))*100 as pub_cost_opti_ratio



FROM andromeda.ad_data_daily ad
INNER JOIN Andromeda.rx_dim_supply_placement_margin_opti_split_override_r op on op.placement_id::varchar = ad.media_id::varchar
      AND ad.rx_ssp_name ILIKE 'rmp%'
WHERE ad.event_time >= current_date()-3 and ad.event_time < current_date()
GROUP BY 1,2,3,4;;

  }



  measure: count {
    type: count
    drill_fields: [detail*]
  }


  dimension: placement_id {
    type: string
    sql: ${TABLE}.placement_id ;;
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




  # dimension: bidfloor_opti_version {
  #   type: string
  #   sql: ${TABLE}.bidfloor_opti_version ;;
  # }






  measure: tot_requests {
    type: sum
    sql: ${TABLE}.tot_requests ;;
    value_format: "#,##0"
  }

  measure: request_ratio {
    type: sum
    sql: ${TABLE}.request_ratio ;;
    value_format: "#,##0"
  }


  set: detail {
    fields: [
      placement_id,
      bidfloor_only_pct,
      pubcost_only_pct,
      bidfloor_pubcost_pct,
      tot_requests,
      request_ratio

    ]
  }
}
