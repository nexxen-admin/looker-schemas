view: bid_opti_placement_qa_raw {
    derived_table: {
      sql:
      Select media_id as placement_id,
       CASE WHEN bidfloor_opti_version is null then 'null'
            WHEN bidfloor_opti_version = 'no_opti' then 'no_opti'
            WHEN (bidfloor_opti_version is not null) and (bidfloor_opti_version != 'no_opti') THEN 'opti'
            END bidfloor_opti_version_version,

       CASE WHEN pubcost_opti_version is null then 'null'
            WHEN pubcost_opti_version = 'no_opti' then 'no_opti'
            WHEN (pubcost_opti_version is not null) and (pubcost_opti_version != 'no_opti') THEN 'opti'
            END pubcost_opti_version_version,

       bidfloor_only_pct,
       pubcost_only_pct,
       bidfloor_pubcost_pct,

       SUM(requests) as total_requests

        FROM andromeda.ad_data_daily ad
        INNER JOIN Andromeda.rx_dim_supply_placement_margin_opti_split_override_r op on op.placement_id::varchar = ad.media_id::varchar
              AND ad.rx_ssp_name ILIKE 'rmp%'
        WHERE ad.event_time >= current_date()-3 and ad.event_time < current_date()
        GROUP BY 1,2,3,4,5,6;;

    }



    measure: count {
      type: count
      drill_fields: [detail*]
    }


    dimension: placement_id {
      type: string
      sql: ${TABLE}.placement_id ;;
    }


    dimension: bidfloor_opti_version_version {
      type: string
      sql: ${TABLE}.bidfloor_opti_version_version ;;
      hidden: no
    }

    dimension: pubcost_opti_version_version {
      type: number
      sql: ${TABLE}.pubcost_opti_version_version ;;
    }

    dimension: bidfloor_only_pct {
      type: number
      sql: ${TABLE}.bidfloor_only_pct ;;
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






    measure: total_requests {
      type: sum
      sql: ${TABLE}.total_requests ;;
      value_format: "#,##0"
    }



    set: detail {
      fields: [
        placement_id,
        bidfloor_opti_version_version,
        pubcost_opti_version_version,
        bidfloor_only_pct,
        pubcost_only_pct,
        bidfloor_pubcost_pct,
        total_requests

      ]
    }
  }
