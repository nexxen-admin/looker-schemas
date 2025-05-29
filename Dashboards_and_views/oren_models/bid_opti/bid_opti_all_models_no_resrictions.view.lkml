view: bid_opti_all_models_no_resrictions {
    derived_table: {
      sql: with raw_data_4_models as (
              select *
              from bi.opti_bid_raw_v1
              where opti IN ('bidfloor','pubcost','pubcost_bidfloor','no_opti')
                    AND lower(ssp_name) like'%rmp%'
              ),


        data_totals as (
        -- Provides the total sum of metrics across all opti buckets
        select media_id,
        imp_type ,
        pub_id,
        date_trunc,
        placement_name,
        publisher_name,
        operations_owner_name,

        -- measures
        sum(requests) as total_requests,
        sum(revenue)-sum(cost) as total_demand_margin


        from raw_data_4_models
        group by 1,2,3,4,5,6,7
        ),

        optis_list as (
        -- checks the number of buckets for each placement
        select concat(concat(media_id,imp_type),date_trunc) as media_imp_date,
        count(distinct case when requests>0 then opti else null end) as optis
        from raw_data_4_models
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
        dt.operations_owner_name,

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

        (scaled_margin) / nullif((SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.date_trunc)),0)-1 as scaled_margin_ratio_to_no_opti,
        (scaled_margin) - (SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.date_trunc)) as scaled_margin_diff_to_no_opti,

        (scaled_supply_margin) / nullif((SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.date_trunc)),0)-1 as scaled_supply_margin_ratio_to_no_opti,
        (scaled_supply_margin) - (SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.date_trunc)) as scaled_supply_margin_diff_to_no_opti,

        (scaled_demand_margin) / nullif((SUM(case when opti='no_opti' then scaled_demand_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.date_trunc)),0)-1 as scaled_demand_margin_ratio_to_no_opti,
        (scaled_demand_margin) - (SUM(case when opti='no_opti' then scaled_demand_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.date_trunc)) as scaled_demand_margin_diff_to_no_opti


        from data_totals as dt
        inner join raw_data_4_models as opti
        on opti.media_id = dt.media_id
        and opti.imp_type = dt.imp_type
        and opti.date_trunc = dt.date_trunc
        where concat(concat(dt.media_id,dt.imp_type),dt.date_trunc)  in ( select media_imp_date from optis_list where optis=4)
        order by dt.date_trunc,dt.media_id desc)


        SELECT sm.media_id as media_id,sm.placement_name as placement_name,sm.imp_type as imp_type,
        opti,date_trunc,publisher_id,
        publisher_name,operations_owner_name,requests,impression,
        revenue,margin,scaled_supply_margin,scaled_margin,
        scaled_margin_ratio_to_no_opti,scaled_margin_diff_to_no_opti,
        scaled_supply_margin_ratio_to_no_opti,scaled_supply_margin_diff_to_no_opti,
        scaled_demand_margin_ratio_to_no_opti,scaled_demand_margin_diff_to_no_opti,

        CASE WHEN AD.enabled=1 THEN 'Bidfloor V2 + PubCost V1'
        WHEN AD.enabled=0 THEN 'Bidfloor V1 + PubCost V1'
        ELSE 'Not in Opti Table' END as is_enabled,

        CASE WHEN opti = 'no_opti' THEN 1
        WHEN opti = 'bidfloor' THEN 2
        WHEN opti = 'pubcost' THEN 3
        WHEN opti = 'pubcost_bidfloor' THEN 4
        ELSE 5 END as rank_model

        FROM scaled_margin SM
        LEFT JOIN andromeda.rx_dim_supply_placement_bidfloor_model_opti_r AD
        ON (SM.media_id = AD.placement_id AND SM.imp_type = AD.imp_type)

        ;;


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

      html:
          {% if value == 'no_opti' %}
          <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
          {% else %}
          {{ rendered_value }}
          {% endif %};;

    }


    dimension: date_trunc {
      type: date
      sql: CAST(${TABLE}.date_trunc AS DATE) ;;
      label: "Date"
    }

    dimension: publisher_id {
      type: string
      sql: ${TABLE}.publisher_id ;;
    }

    dimension: publisher_name {
      type: string
      sql: ${TABLE}.publisher_name ;;
    }


    dimension: operations_owner_name {
      type: string
      sql: ${TABLE}.operations_owner_name ;;
    }


    dimension: rank_model {
      type: string
      sql: ${TABLE}.rank_model ;;
    }

    dimension: is_enabled {
      type: string
      sql: ${TABLE}.is_enabled
        ;;
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
      label: "Scaled Margin % Diff To No Opti"
    }

    measure: scaled_margin_diff_to_no_opti {
      type: sum
      sql: ${TABLE}.scaled_margin_diff_to_no_opti ;;
      value_format: "$#,##0.00"
      label: "Scaled Margin $ Diff To No Opti"
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

# scaled supply margin metrcis

    measure: scaled_demand_margin {
      type: sum
      sql: ${TABLE}.scaled_demand_margin ;;
      value_format: "$#,##0.00"
      label: "Scaled Demand Margin $"
    }


    measure: scaled_demand_margin_ratio_to_no_opti {
      type: sum
      sql: ${TABLE}.scaled_demand_margin_ratio_to_no_opti ;;
      value_format: "0.00%"
      label: "Scaled Demand Margin % Diff To No Opti"
    }

    measure: scaled_demand_margin_diff_to_no_opti {
      type: sum
      sql: ${TABLE}.scaled_demand_margin_diff_to_no_opti ;;
      value_format: "$#,##0.00"
      label: "Scaled Demand Margin $ Diff To No Opti"
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
        rank_model,
        operations_owner_name,
        is_enabled,

        impression,
        revenue,
        margin,
        scaled_supply_margin,
        scaled_margin,
        scaled_margin_ratio_to_no_opti,
        scaled_margin_diff_to_no_opti,
        scaled_supply_margin_ratio_to_no_opti,
        scaled_supply_margin_diff_to_no_opti,
        scaled_demand_margin_ratio_to_no_opti,
        scaled_demand_margin_diff_to_no_opti
      ]
    }

  }
