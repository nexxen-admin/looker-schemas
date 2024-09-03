view: bid_opti_placement_qa {
  derived_table: {
    sql:
Select media_id as placement_id,
       bidfloor_only_pct,
       pubcost_only_pct,
       bidfloor_pubcost_pct,
       NULLIF(SUM(CASE WHEN bidfloor_opti_version is not null THEN requests end),0) as tot_requests,
       round(SUM(CASE WHEN (bidfloor_opti_version != 'no_opti' AND bidfloor_opti_version is not null) THEN requests end)/NULLIF(SUM(CASE WHEN bidfloor_opti_version is not null THEN requests end),0),3) as request_ratio

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
    value_format:"0.00%"
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
