view: bid_opti_bottom_5_placement_v3_etl {
  derived_table: {
    sql:

       --- 3 days
(
WITH raw_data_4_models as (
      select *
      from bi.opti_bid_raw_v1
      where opti IN ('bidfloor','pubcost','pubcost_bidfloor','no_opti')
            AND lower(ssp_name) like'%rmp%'
      ),

      agg_data_from_vertica as (
      select opti,media_id,placement_name,ssp_name,imp_type,pub_id,publisher_name,
      FLOOR(((select max(date_trunc) from raw_data_4_models)-date_trunc)/3) as period_a_days,

      max(date_trunc) as max_date_trunc,
      min(date_trunc) as min_date_trunc,
      sum(requests) as requests,
      sum(impression) as impression,
      sum(revenue) as revenue,
      sum(margin) as margin,
      sum(demand_margin) as demand_margin,
      sum(cost) as cost,
      sum(supply_margin) as supply_margin
      FROM raw_data_4_models
      group by 1,2,3,4,5,6,7,8
      having (max_date_trunc - min_date_trunc) = 2
      ),

      data_totals as (
      -- Provides the total sum of metrics across all opti buckets
      select media_id,
      imp_type ,
      pub_id,
      period_a_days,
      placement_name,
      publisher_name,
      max_date_trunc,
      min_date_trunc,

      -- measures
      sum(requests) as total_requests,
      sum(revenue)-sum(cost) as total_demand_margin


      from agg_data_from_vertica
      group by 1,2,3,4,5,6,7,8
      ),


      optis_list as (
      -- checks the number of buckets for each placement
      select concat(concat(media_id,imp_type),period_a_days) as media_imp_date,
      count(distinct case when requests>0 then opti else null end) as optis
      from agg_data_from_vertica
      group by 1
      ),

      scaled_margin as (
      -- scales the data, we only take the total metrics to scael up but we dont return total metrics
      select  dt.media_id,
      dt.placement_name,
      dt.imp_type,
      opti.opti,
      dt.period_a_days,
      dt.pub_id as publisher_id,
      dt.publisher_name,
      dt.min_date_trunc,
      dt.max_date_trunc,

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

      (scaled_margin) / NULLIF((SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)),0)-1 as scaled_margin_ratio_to_no_opti,
      (scaled_margin) - (SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)) as scaled_margin_diff_to_no_opti,

      (scaled_supply_margin) / NULLIF((SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)),0)-1 as scaled_supply_margin_ratio_to_no_opti,
      (scaled_supply_margin) - (SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)) as scaled_supply_margin_diff_to_no_opti

      from data_totals as dt
      inner join agg_data_from_vertica as opti
      on opti.media_id = dt.media_id
      and opti.imp_type = dt.imp_type
      and opti.period_a_days = dt.period_a_days
      where concat(concat(dt.media_id,dt.imp_type),dt.period_a_days)  in ( select media_imp_date from optis_list where optis=4)
      order by dt.period_a_days,dt.media_id desc),

      tot_sup_marg as (

      SELECT  media_id,
      imp_type,
      period_a_days,
      sum(scaled_supply_margin_diff_to_no_opti) as tot_rev
      from scaled_margin
      GROUP BY 1,2,3),


      tot_sup_marg_rank as (

      SELECT  media_id,
      imp_type,
      period_a_days,
      rank() over (partition by imp_type,period_a_days order by tot_rev asc) as ranky
      from tot_sup_marg
      )

      select AA.*,
      BB.ranky,
      CASE WHEN opti = 'no_opti' THEN 1
      WHEN opti = 'bidfloor' THEN 2
      WHEN opti = 'pubcost' THEN 3
      WHEN opti = 'pubcost_bidfloor' THEN 4
      ELSE 5 END as rank_model,
      '3 days' as time_range
      from scaled_margin aa
      inner join tot_sup_marg_rank bb
      on aa.media_id = bb.media_id and aa.imp_type = bb.imp_type and aa.period_a_days = bb.period_a_days
      --where ranky<=20
      )

      UNION ALL

      --- 5 days
      (
      WITH raw_data_4_models as (
      select *
      from bi.opti_bid_raw_v1
      where opti IN ('bidfloor','pubcost','pubcost_bidfloor','no_opti')
      AND lower(ssp_name) like'%rmp%'
      ),

      agg_data_from_vertica as (
      select opti,media_id,placement_name,ssp_name,imp_type,pub_id,publisher_name,
      FLOOR(((select max(date_trunc) from raw_data_4_models)-date_trunc)/5) as period_a_days,

      max(date_trunc) as max_date_trunc,
      min(date_trunc) as min_date_trunc,
      sum(requests) as requests,
      sum(impression) as impression,
      sum(revenue) as revenue,
      sum(margin) as margin,
      sum(demand_margin) as demand_margin,
      sum(cost) as cost,
      sum(supply_margin) as supply_margin
      FROM raw_data_4_models
      group by 1,2,3,4,5,6,7,8
      having (max_date_trunc - min_date_trunc) = 4
      ),

      data_totals as (
      -- Provides the total sum of metrics across all opti buckets
      select media_id,
      imp_type ,
      pub_id,
      period_a_days,
      placement_name,
      publisher_name,
      max_date_trunc,
      min_date_trunc,

      -- measures
      sum(requests) as total_requests,
      sum(revenue)-sum(cost) as total_demand_margin


      from agg_data_from_vertica
      group by 1,2,3,4,5,6,7,8
      ),


      optis_list as (
      -- checks the number of buckets for each placement
      select concat(concat(media_id,imp_type),period_a_days) as media_imp_date,
      count(distinct case when requests>0 then opti else null end) as optis
      from agg_data_from_vertica
      group by 1
      ),

      scaled_margin as (
      -- scales the data, we only take the total metrics to scael up but we dont return total metrics
      select  dt.media_id,
      dt.placement_name,
      dt.imp_type,
      opti.opti,
      dt.period_a_days,
      dt.pub_id as publisher_id,
      dt.publisher_name,
      dt.min_date_trunc,
      dt.max_date_trunc,

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

      (scaled_margin) / NULLIF((SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)),0)-1 as scaled_margin_ratio_to_no_opti,
      (scaled_margin) - (SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)) as scaled_margin_diff_to_no_opti,

      (scaled_supply_margin) / NULLIF((SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)),0)-1 as scaled_supply_margin_ratio_to_no_opti,
      (scaled_supply_margin) - (SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)) as scaled_supply_margin_diff_to_no_opti

      from data_totals as dt
      inner join agg_data_from_vertica as opti
      on opti.media_id = dt.media_id
      and opti.imp_type = dt.imp_type
      and opti.period_a_days = dt.period_a_days
      where concat(concat(dt.media_id,dt.imp_type),dt.period_a_days)  in ( select media_imp_date from optis_list where optis=4)
      order by dt.period_a_days,dt.media_id desc),

      tot_sup_marg as (

      SELECT  media_id,
      imp_type,
      period_a_days,
      sum(scaled_supply_margin_diff_to_no_opti) as tot_rev
      from scaled_margin
      GROUP BY 1,2,3),


      tot_sup_marg_rank as (

      SELECT  media_id,
      imp_type,
      period_a_days,
      rank() over (partition by imp_type,period_a_days order by tot_rev asc) as ranky
      from tot_sup_marg
      )

      select AA.*,
      BB.ranky,
      CASE WHEN opti = 'no_opti' THEN 1
      WHEN opti = 'bidfloor' THEN 2
      WHEN opti = 'pubcost' THEN 3
      WHEN opti = 'pubcost_bidfloor' THEN 4
      ELSE 5 END as rank_model,
      '5 days' as time_range
      from scaled_margin aa
      inner join tot_sup_marg_rank bb
      on aa.media_id = bb.media_id and aa.imp_type = bb.imp_type and aa.period_a_days = bb.period_a_days
      --where ranky<=20
      )

      UNION ALL

      --- 7 days
      (
      WITH raw_data_4_models as (
      select *
      from bi.opti_bid_raw_v1
      where opti IN ('bidfloor','pubcost','pubcost_bidfloor','no_opti')
      AND lower(ssp_name) like'%rmp%'
      ),

      agg_data_from_vertica as (
      select opti,media_id,placement_name,ssp_name,imp_type,pub_id,publisher_name,
      FLOOR(((select max(date_trunc) from raw_data_4_models)-date_trunc)/7) as period_a_days,

      max(date_trunc) as max_date_trunc,
      min(date_trunc) as min_date_trunc,
      sum(requests) as requests,
      sum(impression) as impression,
      sum(revenue) as revenue,
      sum(margin) as margin,
      sum(demand_margin) as demand_margin,
      sum(cost) as cost,
      sum(supply_margin) as supply_margin
      FROM raw_data_4_models
      group by 1,2,3,4,5,6,7,8
      having (max_date_trunc - min_date_trunc) = 6
      ),

      data_totals as (
      -- Provides the total sum of metrics across all opti buckets
      select media_id,
      imp_type ,
      pub_id,
      period_a_days,
      placement_name,
      publisher_name,
      max_date_trunc,
      min_date_trunc,

      -- measures
      sum(requests) as total_requests,
      sum(revenue)-sum(cost) as total_demand_margin


      from agg_data_from_vertica
      group by 1,2,3,4,5,6,7,8
      ),


      optis_list as (
      -- checks the number of buckets for each placement
      select concat(concat(media_id,imp_type),period_a_days) as media_imp_date,
      count(distinct case when requests>0 then opti else null end) as optis
      from agg_data_from_vertica
      group by 1
      ),

      scaled_margin as (
      -- scales the data, we only take the total metrics to scael up but we dont return total metrics
      select  dt.media_id,
      dt.placement_name,
      dt.imp_type,
      opti.opti,
      dt.period_a_days,
      dt.pub_id as publisher_id,
      dt.publisher_name,
      dt.min_date_trunc,
      dt.max_date_trunc,

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

      (scaled_margin) / NULLIF((SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)),0)-1 as scaled_margin_ratio_to_no_opti,
      (scaled_margin) - (SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)) as scaled_margin_diff_to_no_opti,

      (scaled_supply_margin) / NULLIF((SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)),0)-1 as scaled_supply_margin_ratio_to_no_opti,
      (scaled_supply_margin) - (SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)) as scaled_supply_margin_diff_to_no_opti

      from data_totals as dt
      inner join agg_data_from_vertica as opti
      on opti.media_id = dt.media_id
      and opti.imp_type = dt.imp_type
      and opti.period_a_days = dt.period_a_days
      where concat(concat(dt.media_id,dt.imp_type),dt.period_a_days)  in ( select media_imp_date from optis_list where optis=4)
      order by dt.period_a_days,dt.media_id desc),

      tot_sup_marg as (

      SELECT  media_id,
      imp_type,
      period_a_days,
      sum(scaled_supply_margin_diff_to_no_opti) as tot_rev
      from scaled_margin
      GROUP BY 1,2,3),


      tot_sup_marg_rank as (

      SELECT  media_id,
      imp_type,
      period_a_days,
      rank() over (partition by imp_type,period_a_days order by tot_rev asc) as ranky
      from tot_sup_marg
      )

      select AA.*,
      BB.ranky,
      CASE WHEN opti = 'no_opti' THEN 1
      WHEN opti = 'bidfloor' THEN 2
      WHEN opti = 'pubcost' THEN 3
      WHEN opti = 'pubcost_bidfloor' THEN 4
      ELSE 5 END as rank_model,
      '7 days' as time_range
      from scaled_margin aa
      inner join tot_sup_marg_rank bb
      on aa.media_id = bb.media_id and aa.imp_type = bb.imp_type and aa.period_a_days = bb.period_a_days
      --where ranky<=20
      )

      UNION ALL

      --- 15 days
      (
      WITH raw_data_4_models as (
      select *
      from bi.opti_bid_raw_v1
      where opti IN ('bidfloor','pubcost','pubcost_bidfloor','no_opti')
      AND lower(ssp_name) like'%rmp%'
      ),

      agg_data_from_vertica as (
      select opti,media_id,placement_name,ssp_name,imp_type,pub_id,publisher_name,
      FLOOR(((select max(date_trunc) from raw_data_4_models)-date_trunc)/15) as period_a_days,

      max(date_trunc) as max_date_trunc,
      min(date_trunc) as min_date_trunc,
      sum(requests) as requests,
      sum(impression) as impression,
      sum(revenue) as revenue,
      sum(margin) as margin,
      sum(demand_margin) as demand_margin,
      sum(cost) as cost,
      sum(supply_margin) as supply_margin
      FROM raw_data_4_models
      group by 1,2,3,4,5,6,7,8
      having (max_date_trunc - min_date_trunc) = 14
      ),

      data_totals as (
      -- Provides the total sum of metrics across all opti buckets
      select media_id,
      imp_type ,
      pub_id,
      period_a_days,
      placement_name,
      publisher_name,
      max_date_trunc,
      min_date_trunc,

      -- measures
      sum(requests) as total_requests,
      sum(revenue)-sum(cost) as total_demand_margin


      from agg_data_from_vertica
      group by 1,2,3,4,5,6,7,8
      ),


      optis_list as (
      -- checks the number of buckets for each placement
      select concat(concat(media_id,imp_type),period_a_days) as media_imp_date,
      count(distinct case when requests>0 then opti else null end) as optis
      from agg_data_from_vertica
      group by 1
      ),

      scaled_margin as (
      -- scales the data, we only take the total metrics to scael up but we dont return total metrics
      select  dt.media_id,
      dt.placement_name,
      dt.imp_type,
      opti.opti,
      dt.period_a_days,
      dt.pub_id as publisher_id,
      dt.publisher_name,
      dt.min_date_trunc,
      dt.max_date_trunc,

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

      (scaled_margin) / NULLIF((SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)),0)-1 as scaled_margin_ratio_to_no_opti,
      (scaled_margin) - (SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)) as scaled_margin_diff_to_no_opti,

      (scaled_supply_margin) / NULLIF((SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)),0)-1 as scaled_supply_margin_ratio_to_no_opti,
      (scaled_supply_margin) - (SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by dt.media_id,dt.imp_type,dt.period_a_days)) as scaled_supply_margin_diff_to_no_opti

      from data_totals as dt
      inner join agg_data_from_vertica as opti
      on opti.media_id = dt.media_id
      and opti.imp_type = dt.imp_type
      and opti.period_a_days = dt.period_a_days
      where concat(concat(dt.media_id,dt.imp_type),dt.period_a_days)  in ( select media_imp_date from optis_list where optis=4)
      order by dt.period_a_days,dt.media_id desc),

      tot_sup_marg as (

      SELECT  media_id,
      imp_type,
      period_a_days,
      sum(scaled_supply_margin_diff_to_no_opti) as tot_rev
      from scaled_margin
      GROUP BY 1,2,3),


      tot_sup_marg_rank as (

      SELECT  media_id,
      imp_type,
      period_a_days,
      rank() over (partition by imp_type,period_a_days order by tot_rev asc) as ranky
      from tot_sup_marg
      )

      select AA.*,
      BB.ranky,
      CASE WHEN opti = 'no_opti' THEN 1
      WHEN opti = 'bidfloor' THEN 2
      WHEN opti = 'pubcost' THEN 3
      WHEN opti = 'pubcost_bidfloor' THEN 4
      ELSE 5 END as rank_model,
      '15 days' as time_range
      from scaled_margin aa
      inner join tot_sup_marg_rank bb
      on aa.media_id = bb.media_id and aa.imp_type = bb.imp_type and aa.period_a_days = bb.period_a_days
      --where ranky<=20
      );;



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




  dimension: publisher_id {
    type: string
    sql: ${TABLE}.publisher_id ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  dimension: min_date_trunc {
    type: string
    sql: ${TABLE}.min_date_trunc ;;
    label: "Min Date"
  }

  dimension: max_date_trunc {
    type: string
    sql: ${TABLE}.max_date_trunc ;;
    label: "Max Date"
  }

  dimension: time_range {
    type: string
    sql: ${TABLE}.time_range ;;
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
    value_format: "$#,##0"
  }

  measure: margin {
    type: sum
    sql: ${TABLE}.margin ;;
    value_format: "$#,##0"
    label: "Total Margin $"
  }


  dimension: ranky {
    type: number
    sql: ${TABLE}.ranky ;;
    label: "Placement Rank"
  }


  dimension: rank_model {
    type: number
    sql: ${TABLE}.rank_model ;;
  }


# scled margins metrics

  measure: scaled_margin {
    type: sum
    sql: ${TABLE}.scaled_margin ;;
    value_format: "$#,##0"
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
    value_format: "$#,##0"
    label: "Scaled Total Margin $ Diff To No Opti"
  }

# scaled supply margin metrcis

  measure: scaled_supply_margin {
    type: sum
    sql: ${TABLE}.scaled_supply_margin ;;
    value_format: "$#,##0"
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
    value_format: "$#,##0"
    label: "Scaled Supply Margin $ Diff To No Opti"
  }



  set: detail {
    fields: [
      media_id,
      placement_name,
      imp_type,
      opti,
      publisher_id,
      publisher_name,
      ranky,
      rank_model,

      min_date_trunc,
      max_date_trunc,
      time_range,

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
