view: scope3 {
    derived_table: {
      sql:


      SELECT *
      FROM (
      SELECT DATE_TRUNC('MONTH', AA.event_time)::date as est_datetime,
             'NEXXEN.SSP' as atp,
             country_code as country,
             CASE WHEN rx_ssp_name ilike 'rmp%' THEN sps.seller_id ELSE CC.adstxt_hash::varchar END as seller_id,
             origin_domain as inventory_id, --inventory_id
             CASE WHEN rx_media_type='app' THEN True ELSE False END as is_app, --is_app
             media_id as seller_placement_id,
             MAX(ad_size) as max_placement_size, --max_placement_size !! do you want max or all of them, better if we do a lot of data !!
             CASE WHEN rtb_device_type=1 THEN 'phone'
                  WHEN rtb_device_type=2 THEN 'pc'
                  WHEN rtb_device_type=3 THEN 'tv'
                  WHEN rtb_device_type=4 THEN 'phone'
                  WHEN rtb_device_type=5 THEN 'tablet'
                  WHEN rtb_device_type=6 THEN 'tv'
                  WHEN rtb_device_type=7 THEN 'tv' ELSE '' END
                  as device_type,
             SUM(requests) as ad_opportunities,
             SUM(CASE WHEN (aa.rx_request_status in ('nodsp','nodspbids','bidresponse') or aa.rx_request_status is NULL) THEN requests ELSE 0 END) as ad_opportunities_processed,
             COUNT(DISTINCT DATE_TRUNC('DAY', AA.event_time)) AS distinct_days
      FROM Andromeda.ad_data_daily AA

      LEFT OUTER JOIN andromeda.rx_dim_supply_placement spl
      ON spl.placement_id = AA.media_id AND AA.rx_ssp_name ilike 'rmp%'
      LEFT OUTER JOIN andromeda.rx_dim_supply_publisher_traffic_source spts
      ON spts.pub_ts_id = spl.pub_ts_id
      LEFT OUTER JOIN andromeda.rx_dim_supply_publisher_seller_r sps
      ON sps.pub_seller_id = spts.pub_seller_id
      left outer join andromeda.rx_dim_ssp_r CC
      ON AA.rx_ssp_name = CC.name

      WHERE DATE_TRUNC('MONTH', AA.event_time) = (DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month')
            AND requests>0

      GROUP BY 1,2,3,4,5,6,7,9) AA
      WHERE (ad_opportunities/distinct_days)>10000
        ;;

    }





    dimension: est_datetime {
      type: string
      sql: ${TABLE}."est_datetime" ;;
    }


    dimension: atp {
      type: string
      sql: ${TABLE}."atp" ;;
    }

  dimension: country {
    type: string
    sql: ${TABLE}."country" ;;
  }

  dimension: seller_id {
    type: string
    sql: ${TABLE}."seller_id" ;;
  }

  dimension: inventory_id {
    type: string
    sql: ${TABLE}."inventory_id" ;;
  }

  dimension: is_app {
    type: string
    sql: ${TABLE}."is_app" ;;
  }

  dimension: seller_placement_id {
    type: string
    sql: ${TABLE}."seller_placement_id" ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}."device_type" ;;
  }


  dimension: max_placement_size {
    type: string
    sql: ${TABLE}."max_placement_size" ;;
  }

  dimension: ad_opportunities {
    type: string
    sql: ${TABLE}."ad_opportunities" ;;
  }

  dimension: ad_opportunities_processed {
    type: string
    sql: ${TABLE}."ad_opportunities_processed" ;;
  }




    set: detail {
      fields: [est_datetime,atp,country,seller_id,inventory_id,is_app,seller_placement_id,max_placement_size,ad_opportunities,ad_opportunities_processed,device_type]
    }
  }
