view: bid_opti_bottom_5_placement_v3 {
    derived_table: {
      sql: with opti_base_data  as (
        -- placement level dashboard

        -- takes all raw data and splits into different opti buckets
        select case when bidfloor_opti_version !='no_opti' and (pubcost_opti_enabled = '-4' or pubcost_opti_enabled = '0')  then 'bidfloor'
        when bidfloor_opti_version !='no_opti' and pubcost_opti_enabled = '1' then 'pubcost_bidfloor'
        when bidfloor_opti_version = 'no_opti' and pubcost_opti_enabled = '1' then 'pubcost'
        when bidfloor_opti_version = 'no_opti' and (pubcost_opti_enabled = '-4' or pubcost_opti_enabled = '0')   then 'no_opti'
        when bidfloor_opti_version is null and (pubcost_opti_enabled is null or pubcost_opti_enabled = '0') then 'not enabled'
        when pubcost_opti_enabled in ('-1','-2','-3') then 'inelgible/error'
        else pubcost_opti_enabled::varchar  end as opti,
        -- other dimensions
        rx_imp_type as imp_type,
        media_id,
        placement_name,
        pub_id,
        publisher_name,
        event_time::date as date_trunc,
        -- measures
        sum(case when rx_request_status in ('nodsp','nodspbids','bidresponse') or rx_request_status is NULL then requests else 0 end) as requests,
        sum(impression_pixel) as impression,
        sum(revenue) as revenue,
        sum(revenue)- sum(cogs) as margin,
        sum(revenue)-sum(cost) as demand_margin,
        sum(cost)-sum(cogs) as supply_margin

        from Andromeda.ad_data_daily add2
        where event_time::date >= current_date()-3 and event_time::date < current_date()
        and rx_ssp_name like'rmp%'
        and rx_imp_type in ('banner','video')
        group by 1,2,3,4,5,6,7
        having (demand_margin + supply_margin) >0
        ),

        data_totals as (
        -- Provides the total sum of metrics across all opti buckets
        select media_id,
        placement_name,
        rx_imp_type as imp_type ,
        pub_id,
        publisher_name,
        event_time::date as date_trunc,

        -- measures
        sum(case when rx_request_status in ('nodsp','nodspbids','bidresponse') or rx_request_status is NULL then requests else 0 end) as total_requests,
        sum(impression_pixel) as total_impression,
        sum(revenue) as total_revenue,
        sum(revenue)- sum(cogs) as total_margin,
        sum(revenue)-sum(cost) as total_demand_margin,
        sum(cost)-sum(cogs) as total_supply_margin


        from Andromeda.ad_data_daily add2
        where event_time::date >= current_date()-3 and event_time::date < current_date()
        and rx_ssp_name like'rmp%'
        and rx_imp_type in ('banner','video')
        group by 1,2,3,4,5,6
        having total_margin >0
        ),

        optis_list as (
        -- checks the number of buckets for each placement
        select concat(concat(media_id,imp_type),date_trunc) as media_imp_date,
        count(distinct opti) as optis
        from opti_base_data
        group by 1
        ),

        scaled_margin as (
        -- scales the data, we only take the total metrics to scael up but we dont return total metrics
        select  dt.media_id,
        dt.placement_name,
        dt.imp_type,
        opti.opti,
        dt.date_trunc,
        dt.pub_id as publisher_id,
        dt.publisher_name,

        opti.requests,
        opti.impression,
        opti.revenue,
        opti.margin,
        opti.demand_margin,
        opti.supply_margin,
        opti.requests/dt.total_requests as split,
        opti.margin/split as scaled_margin,
        opti.requests/split as scaled_requests,
        opti.impression/split as scaled_impression,
        opti.revenue/split as scaled_revenue,
        opti.demand_margin/split as scaled_demand_margin,
        opti.supply_margin/split as scaled_supply_margin,

        (scaled_margin) / (SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.date_trunc))-1 as scaled_margin_ratio_to_no_opti,
        (scaled_margin) - (SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.date_trunc)) as scaled_margin_diff_to_no_opti,

        (scaled_supply_margin) / (SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.date_trunc))-1 as scaled_supply_margin_ratio_to_no_opti,
        (scaled_supply_margin) - (SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.date_trunc)) as scaled_supply_margin_diff_to_no_opti

        from data_totals as dt
        inner join opti_base_data as opti
        on opti.media_id = dt.media_id
        and opti.imp_type = dt.imp_type
        and opti.date_trunc = dt.date_trunc
        where dt.total_requests >80000 AND (opti.requests/dt.total_requests>0)
        and concat(concat(dt.media_id,dt.imp_type),dt.date_trunc)  in ( select media_imp_date from optis_list where optis>=4)
        order by dt.date_trunc,dt.media_id desc),

        tot_sup_marg as (

        SELECT  media_id,
        imp_type,
        date_trunc,
        sum(scaled_supply_margin_diff_to_no_opti) as tot_rev
        from scaled_margin
        GROUP BY 1,2,3),


        tot_sup_marg_rank as (

        SELECT  media_id,
        imp_type,
        date_trunc,
        rank() over (partition by imp_type,date_trunc order by tot_rev asc) as ranky
        from tot_sup_marg
        )

        select AA.*,
               BB.ranky,
               CASE WHEN opti = 'no_opti' THEN 1
                    WHEN opti = 'bidfloor' THEN 2
                    WHEN opti = 'pubcost' THEN 3
                    WHEN opti = 'pubcost_bidfloor' THEN 4
                    ELSE 5 END as rank_model
        from scaled_margin aa
        inner join tot_sup_marg_rank bb
        on aa.media_id = bb.media_id and aa.imp_type = bb.imp_type and aa.date_trunc = bb.date_trunc
        where ranky<=20;;


    }


    measure: count {
      type: count
      drill_fields: [detail*]
    }



    dimension: media_id {
      type: string
      sql: ${TABLE}.media_id ;;
      label: "Placement Id"
    }

    dimension: placement_name {
      type: string
      sql: ${TABLE}.placement_name ;;
      label: "Placement Name"
    }


    dimension: imp_type {
      type: string
      sql: ${TABLE}.imp_type ;;
    }

    dimension: opti {
      type: string
      sql: ${TABLE}.opti ;;
    }


    dimension: date_trunc {
      type: string
      sql: ${TABLE}.date_trunc ;;
    }

    dimension: publisher_id {
      type: string
      sql: ${TABLE}.publisher_id ;;
    }

    dimension: publisher_name {
      type: string
      sql: ${TABLE}.publisher_name ;;
    }

  dimension: ranky {
    type: string
    sql: ${TABLE}.ranky ;;
  }


  dimension: rank_model {
    type: string
    sql: ${TABLE}.rank_model ;;
  }

# measu


    measure: requests {
      type: sum
      sql: ${TABLE}.requests ;;
      value_format: "#,##0"
    }

    measure: impression {
      type: sum
      sql: ${TABLE}.impression ;;
      value_format: "#,##0"
    }

    measure: revenue {
      type: sum
      sql: ${TABLE}.revenue ;;
      value_format: "$#,##0.00"
    }

    measure: margin {
      type: sum
      sql: ${TABLE}.margin ;;
      value_format: "$#,##0.00"
      label: "Total Margin $"
    }

# scled margins metrics

    measure: scaled_margin {
      type: sum
      sql: ${TABLE}.scaled_margin ;;
      value_format: "$#,##0.00"
      label: "Scaled Total Margin $"
    }

    measure: scaled_margin_ratio_to_no_opti {
      type: sum
      sql: ${TABLE}.scaled_margin_ratio_to_no_opti ;;
      value_format:"0.00%"
      label: "Scaled Total Margin % Diff To No Opti"
    }

    measure: scaled_margin_diff_to_no_opti {
      type: sum
      sql: ${TABLE}.scaled_margin_diff_to_no_opti ;;
      value_format: "$#,##0.00"
      label: "Scaled Total Margin $ Diff To No Opti"
    }

# scaled supply margin metrcis

    measure: scaled_supply_margin {
      type: sum
      sql: ${TABLE}.scaled_supply_margin ;;
      value_format: "$#,##0.00"
      label: "Scaled Supply Margin $"
    }


    measure: scaled_supply_margin_ratio_to_no_opti {
      type: sum
      sql: ${TABLE}.scaled_supply_margin_ratio_to_no_opti ;;
      value_format: "0.00%"
      label: "Scaled Supply Margin % Diff To No Opti"
    }

    measure: scaled_supply_margin_diff_to_no_opti {
      type: sum
      sql: ${TABLE}.scaled_supply_margin_diff_to_no_opti ;;
      value_format: "$#,##0.00"
      label: "Scaled Supply Margin $ Diff To No Opti"
    }



    set: detail {
      fields: [
        media_id,
        placement_name,
        imp_type,
        opti,
        date_trunc,
        publisher_id,
        publisher_name,
        ranky,
        rank_model,

        impression,
        revenue,
        margin,
        scaled_supply_margin,
        scaled_margin,
        scaled_margin_ratio_to_no_opti,
        scaled_margin_diff_to_no_opti,
        scaled_supply_margin_ratio_to_no_opti,
        scaled_supply_margin_diff_to_no_opti
      ]
    }

  }
