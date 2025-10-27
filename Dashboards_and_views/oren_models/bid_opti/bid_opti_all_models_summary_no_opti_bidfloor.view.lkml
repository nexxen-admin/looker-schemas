view: bid_opti_all_models_summary_no_opti_bidfloor  {
  derived_table: {
    sql: with raw_data_4_models as (
              select opti,
        media_id,
        --placement_name,
        imp_type,
        pub_id,
        --publisher_name,
        date_trunc,
        --oeprations_owner_name,
        --bizdev_owner_name,
        sum(requests) as Requests,
        sum(impression) as Impression,
        sum(revenue) as revenue,
        sum(margin) as Margin,
        sum(demand_margin) as demand_margin,
        sum(cost) as Cost,
        sum(supply_margin) as supply_margin
      from bi.opti_bid_raw_v1
      where opti IN ('bidfloor','pubcost','pubcost_bidfloor','no_opti')
            AND lower(ssp_name) like'%rmp%'
      Group by 1, 2, 3, 4, 5
              ),


      data_totals as (
      -- Provides the total sum of metrics across all opti buckets
      select media_id,
      imp_type ,
      pub_id,
      date_trunc,

      -- measures
      sum(requests) as total_requests,
      sum(revenue)-sum(cost) as total_demand_margin


      from raw_data_4_models
      group by 1,2,3,4
      ),

      optis_list as (
      -- checks the number of buckets for each placement
      select concat(concat(media_id,imp_type),date_trunc) as media_imp_date,
      count(DISTINCT CASE when requests>0 AND opti in ('no_opti','bidfloor') THEN opti else null end) as optis,
      count(DISTINCT CASE when requests>0 THEN opti else null end) as optis_all
      from raw_data_4_models
      group by 1
      ),

      scaled_margin as (
      -- scales the data, we only take the total metrics to scael up but we dont return total metrics
      select  dt.media_id,
      dt.imp_type,
      opti.opti,
      dt.date_trunc,

      opti.requests,
      opti.impression,
      opti.revenue,
      opti.margin,
      opti.demand_margin,
      opti.supply_margin,
      opti.requests/nullif(dt.total_requests,0) as split,
      opti.margin/nullif(split,0) as scaled_margin,
      opti.requests/nullif(split,0) as scaled_requests,
      opti.impression/nullif(split,0) as scaled_impression,
      opti.revenue/nullif(split,0) as scaled_revenue,
      opti.demand_margin/nullif(split,0) as scaled_demand_margin,
      opti.supply_margin/nullif(split,0) as scaled_supply_margin

      from data_totals as dt
      inner join raw_data_4_models as opti
      on (opti.media_id = dt.media_id and opti.imp_type = dt.imp_type and opti.date_trunc = dt.date_trunc)
      where concat(concat(dt.media_id,dt.imp_type),dt.date_trunc)  in ( select media_imp_date
      from optis_list where (optis=2 AND optis_all=2))
      order by dt.total_demand_margin desc),

      aggr_tab as (

      SELECT imp_type,
      opti,
      date_trunc,

      COUNT(*) as placment_count,
      SUM(requests) as requests,
      SUM(impression) as impression,
      SUM(revenue) as revenue,
      SUM(margin) as margin,
      SUM(demand_margin) as demand_margin,
      SUM(supply_margin) as supply_margin,
      SUM(scaled_margin) as scaled_margin,
      SUM(scaled_requests) as scaled_requests,
      SUM(scaled_impression) as scaled_impression,
      SUM(scaled_revenue) as scaled_revenue,
      SUM(scaled_demand_margin) as scaled_demand_margin,
      SUM(scaled_supply_margin) as scaled_supply_margin
      from scaled_margin
      GROUP BY 1,2,3),

       -- adding check to ensure no division by zero errors
        aggr_tab_check as (
        select *
        From aggr_tab
        where demand_margin > 0
          and supply_margin > 0
          and margin > 0
        ),

      fin_tab_before_tot as (

      SELECT *,
      scaled_margin / nullif((SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by imp_type,date_trunc)),0)-1 as scaled_margin_ratio_to_no_opti,
      scaled_margin - (SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by imp_type,date_trunc)) as scaled_margin_diff_to_no_opti,

      scaled_supply_margin / nullif((SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by imp_type,date_trunc)),0)-1 as scaled_supply_margin_ratio_to_no_opti,
      scaled_supply_margin - (SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by imp_type,date_trunc)) as scaled_supply_margin_diff_to_no_opti,

      scaled_demand_margin / nullif((SUM(case when opti='no_opti' then scaled_demand_margin else 0 end) over (partition by imp_type,date_trunc)),0)-1 as scaled_demand_margin_ratio_to_no_opti,
      scaled_demand_margin - (SUM(case when opti='no_opti' then scaled_demand_margin else 0 end) over (partition by imp_type,date_trunc)) as scaled_demand_margin_diff_to_no_opti,

      CASE WHEN opti = 'no_opti' THEN 1
      WHEN opti = 'bidfloor' THEN 2
      WHEN opti = 'pubcost' THEN 3
      WHEN opti = 'pubcost_bidfloor' THEN 4
      ELSE 5 END as rank_model

      FROM aggr_tab_check),

      tot_for_vis as (
      select imp_type,
      'Total*' as opti,
      date_trunc,

      sum(case when opti='no_opti' then placment_count else 0 end) as placment_count,
      sum(requests) as requests,
      sum(impression) as impression,
      sum(revenue) as revenue,
      sum(margin) as margin,
      sum(demand_margin) as demand_margin,
      sum(supply_margin) as supply_margin,
      null::FLOAT as scaled_margin,
      null::FLOAT as scaled_requests,
      null::FLOAT as scaled_impression,
      null::FLOAT as scaled_revenue,
      null::FLOAT as scaled_demand_margin,
      null::FLOAT as scaled_supply_margin,

      (sum(margin) - sum(case when opti='no_opti' then scaled_margin else 0 end))/(sum(margin)) as scaled_margin_ratio_to_no_opti,
      sum(margin) - sum(case when opti='no_opti' then scaled_margin else 0 end) as scaled_margin_diff_to_no_opti,

      (sum(supply_margin) - sum(case when opti='no_opti' then scaled_supply_margin else 0 end))/(sum(supply_margin)) as scaled_supply_margin_ratio_to_no_opti,
      sum(supply_margin) - sum(case when opti='no_opti' then scaled_supply_margin else 0 end) as scaled_supply_margin_diff_to_no_opti,

      (sum(demand_margin) - sum(case when opti='no_opti' then scaled_demand_margin else 0 end))/(sum(demand_margin)) as scaled_demand_margin_ratio_to_no_opti,
      sum(demand_margin) - sum(case when opti='no_opti' then scaled_demand_margin else 0 end) as scaled_demand_margin_diff_to_no_opti,

      5 as rank_model
      from fin_tab_before_tot
      group by 1,2,3)

      select *

      from fin_tab_before_tot
      union all
      select *
      from tot_for_vis;;

  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: imp_type {
    type: string
    sql: ${TABLE}.imp_type ;;
  }

# opti and desgin

  dimension: opti {
    type: string
    sql: ${TABLE}.opti ;;

    html:
          {% if value == 'Total*' %}
          <p style="color: black; font-weight: bold; background-color: lightblue; font-size: 100%; text-align: left;">{{ rendered_value }}</p>
          {% else %}
          {{ rendered_value }}
          {% endif %};;

  }


  dimension: date_trunc {
    type: date
    sql: CAST(${TABLE}.date_trunc AS DATE) ;;
    label: "Date"
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

  measure: placment_count {
    type: sum
    sql: ${TABLE}.placment_count ;;
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
  }

  measure: scaled_margin {
    type: sum
    sql: ${TABLE}.scaled_margin ;;
    value_format: "$#,##0"
    label: "Scaled Total Margin $"
  }

  measure: scaled_supply_margin {
    type: sum
    sql: ${TABLE}.scaled_supply_margin ;;
    value_format: "$#,##0"
    label: "Scaled Supply Margin $"
  }

  measure: scaled_demand_margin {
    type: sum
    sql: ${TABLE}.scaled_demand_margin ;;
    value_format: "$#,##0"
    label: "Scaled Demand Margin $"
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
    value_format: "$#,##0"
    label: "Scaled Margin $ Diff To No Opti"
  }


  measure: scaled_supply_margin_ratio_to_no_opti {
    type: sum
    sql: ${TABLE}.scaled_supply_margin_ratio_to_no_opti ;;
    value_format:"0.00%"
    label: "Scaled Supply Margin % Diff To No Opti"
  }

  measure: scaled_supply_margin_diff_to_no_opti {
    type: sum
    sql: ${TABLE}.scaled_supply_margin_diff_to_no_opti ;;
    value_format: "$#,##0"
    label: "Scaled Supply Margin $ Diff To No Opti"
  }


  measure: scaled_demand_margin_ratio_to_no_opti {
    type: sum
    sql: ${TABLE}.scaled_demand_margin_ratio_to_no_opti ;;
    value_format:"0.00%"
    label: "Scaled Demand Margin % Diff To No Opti"
  }

  measure: scaled_demand_margin_diff_to_no_opti {
    type: sum
    sql: ${TABLE}.scaled_demand_margin_diff_to_no_opti ;;
    value_format: "$#,##0"
    label: "Scaled Demand Margin $ Diff To No Opti"
  }


  set: detail {
    fields: [
      imp_type,
      opti,
      date_trunc,
      rank_model,

      placment_count,
      impression,
      revenue,
      margin,
      scaled_margin,
      scaled_supply_margin,
      scaled_demand_margin,
      scaled_margin_ratio_to_no_opti,
      scaled_margin_diff_to_no_opti,
      scaled_supply_margin_ratio_to_no_opti,
      scaled_supply_margin_diff_to_no_opti,
      scaled_demand_margin_ratio_to_no_opti,
      scaled_demand_margin_diff_to_no_opti
    ]
  }

}
