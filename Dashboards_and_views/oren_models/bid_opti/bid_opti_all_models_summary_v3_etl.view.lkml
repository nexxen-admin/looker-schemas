view: bid_opti_all_models_summary_v3_etl {
    derived_table: {
      sql:

      --Old Query, switched for new below on 10/9/2025
      /*with raw_data_4_models as (
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

        -- measures
        sum(requests) as total_requests,
        sum(revenue)-sum(cost) as total_demand_margin


        from raw_data_4_models
        group by 1,2,3,4
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
        dt.imp_type,
        opti.opti,
        dt.date_trunc,

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
        opti.supply_margin/split as scaled_supply_margin

        from data_totals as dt
        inner join raw_data_4_models as opti
        on (opti.media_id = dt.media_id and opti.imp_type = dt.imp_type and opti.date_trunc = dt.date_trunc)
        where concat(concat(dt.media_id,dt.imp_type),dt.date_trunc)  in ( select media_imp_date
        from optis_list where optis=4)
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
        scaled_margin / (SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by imp_type,date_trunc))-1 as scaled_margin_ratio_to_no_opti,
        scaled_margin - (SUM(case when opti='no_opti' then scaled_margin else 0 end) over (partition by imp_type,date_trunc)) as scaled_margin_diff_to_no_opti,

        scaled_supply_margin / (SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by imp_type,date_trunc))-1 as scaled_supply_margin_ratio_to_no_opti,
        scaled_supply_margin - (SUM(case when opti='no_opti' then scaled_supply_margin else 0 end) over (partition by imp_type,date_trunc)) as scaled_supply_margin_diff_to_no_opti,

        scaled_demand_margin / (SUM(case when opti='no_opti' then scaled_demand_margin else 0 end) over (partition by imp_type,date_trunc))-1 as scaled_demand_margin_ratio_to_no_opti,
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
        from tot_for_vis
        */

        WITH raw_data_4_models AS (
  SELECT *
  FROM bi.opti_bid_raw_v1
  WHERE opti IN ('bidfloor','pubcost','pubcost_bidfloor','no_opti')
    AND LOWER(ssp_name) LIKE '%rmp%'
),

data_totals AS (
  -- Provides the total sum of metrics across all opti buckets
SELECT
  media_id,
  imp_type,
  pub_id,
  date_trunc,
  -- measures
  SUM(requests) AS total_requests,
  SUM(revenue) - SUM(cost) AS total_demand_margin
FROM
  raw_data_4_models
GROUP BY
  1,
  2,
  3,
  4
),

optis_list AS (
  -- checks the number of buckets for each placement
SELECT
  CONCAT(CONCAT(media_id, imp_type), date_trunc) AS media_imp_date,
  COUNT(DISTINCT CASE WHEN requests > 0 THEN opti ELSE NULL END) AS optis
FROM
  raw_data_4_models
GROUP BY
  1
),

scaled_margin AS (
-- scales the data, guard all divisions (no div-by-zero)
  SELECT
  dt.media_id,
  dt.imp_type,
  opti.opti,
  dt.date_trunc,
  opti.requests,
  opti.impression,
  opti.revenue,
  opti.margin,
  opti.demand_margin,
  opti.supply_margin,
  -- split = requests / total_requests (guard total_requests)
    CASE
    WHEN dt.total_requests > 0 THEN opti.requests::FLOAT / dt.total_requests
    ELSE NULL
  END AS split,
  -- Use NULLIF(split,0) as divisor to avoid div-by-zero
  opti.margin / NULLIF( CASE
    WHEN dt.total_requests > 0 THEN opti.requests::FLOAT / dt.total_requests
  END ,
  0) AS scaled_margin,
  opti.requests / NULLIF( CASE
    WHEN dt.total_requests > 0 THEN opti.requests::FLOAT / dt.total_requests
  END ,
  0) AS scaled_requests,
  opti.impression / NULLIF( CASE
    WHEN dt.total_requests > 0 THEN opti.requests::FLOAT / dt.total_requests
  END ,
  0) AS scaled_impression,
  opti.revenue / NULLIF( CASE
    WHEN dt.total_requests > 0 THEN opti.requests::FLOAT / dt.total_requests
  END ,
  0) AS scaled_revenue,
  opti.demand_margin / NULLIF( CASE
    WHEN dt.total_requests > 0 THEN opti.requests::FLOAT / dt.total_requests
  END ,
  0) AS scaled_demand_margin,
  opti.supply_margin / NULLIF( CASE
    WHEN dt.total_requests > 0 THEN opti.requests::FLOAT / dt.total_requests
  END ,
  0) AS scaled_supply_margin
FROM
  data_totals AS dt
INNER JOIN raw_data_4_models AS opti
    ON
  opti.media_id = dt.media_id
  AND opti.imp_type = dt.imp_type
  AND opti.date_trunc = dt.date_trunc
WHERE
  CONCAT(CONCAT(dt.media_id, dt.imp_type), dt.date_trunc) IN (
  SELECT
    media_imp_date
  FROM
    optis_list
  WHERE
    optis = 4
  )
ORDER BY
  dt.total_demand_margin DESC
),

aggr_tab AS (
SELECT
  imp_type,
  opti,
  date_trunc,
  COUNT(*) AS placment_count,
  SUM(requests) AS requests,
  SUM(impression) AS impression,
  SUM(revenue) AS revenue,
  SUM(margin) AS margin,
  SUM(demand_margin) AS demand_margin,
  SUM(supply_margin) AS supply_margin,
  SUM(scaled_margin) AS scaled_margin,
  SUM(scaled_requests) AS scaled_requests,
  SUM(scaled_impression) AS scaled_impression,
  SUM(scaled_revenue) AS scaled_revenue,
  SUM(scaled_demand_margin) AS scaled_demand_margin,
  SUM(scaled_supply_margin) AS scaled_supply_margin
FROM
  scaled_margin
GROUP BY
  1,
  2,
  3
),

/* adding check to ensure no division by zero errors */
aggr_tab_check AS (
SELECT
  *
FROM
  aggr_tab
WHERE
  demand_margin > 0
  AND supply_margin > 0
  AND margin > 0
),

 fin_tab_before_tot as (
SELECT
  atc.*,

  -- ratios vs no_opti: guard denominators with NULLIF(...,0)
  atc.scaled_margin /
    NULLIF(
      SUM(CASE WHEN atc.opti = 'no_opti' THEN atc.scaled_margin ELSE 0 END)
      OVER (PARTITION BY atc.imp_type, atc.date_trunc),
    0) - 1 AS scaled_margin_ratio_to_no_opti,

  atc.scaled_margin -
    (SUM(CASE WHEN atc.opti = 'no_opti' THEN atc.scaled_margin ELSE 0 END)
     OVER (PARTITION BY atc.imp_type, atc.date_trunc))
    AS scaled_margin_diff_to_no_opti,

  atc.scaled_supply_margin /
    NULLIF(
      SUM(CASE WHEN atc.opti = 'no_opti' THEN atc.scaled_supply_margin ELSE 0 END)
      OVER (PARTITION BY atc.imp_type, atc.date_trunc),
    0) - 1 AS scaled_supply_margin_ratio_to_no_opti,

  atc.scaled_supply_margin -
    (SUM(CASE WHEN atc.opti = 'no_opti' THEN atc.scaled_supply_margin ELSE 0 END)
     OVER (PARTITION BY atc.imp_type, atc.date_trunc))
    AS scaled_supply_margin_diff_to_no_opti,

  atc.scaled_demand_margin /
    NULLIF(
      SUM(CASE WHEN atc.opti = 'no_opti' THEN atc.scaled_demand_margin ELSE 0 END)
      OVER (PARTITION BY atc.imp_type, atc.date_trunc),
    0) - 1 AS scaled_demand_margin_ratio_to_no_opti,

  atc.scaled_demand_margin -
    (SUM(CASE WHEN atc.opti = 'no_opti' THEN atc.scaled_demand_margin ELSE 0 END)
     OVER (PARTITION BY atc.imp_type, atc.date_trunc))
    AS scaled_demand_margin_diff_to_no_opti,

  CASE
    WHEN atc.opti = 'no_opti' THEN 1
    WHEN atc.opti = 'bidfloor' THEN 2
    WHEN atc.opti = 'pubcost' THEN 3
    WHEN atc.opti = 'pubcost_bidfloor' THEN 4
    ELSE 5
  END AS rank_model
FROM aggr_tab_check AS atc),


tot_for_vis as (
select
  imp_type,
  'Total*' as opti,
  date_trunc,
  sum(case when opti = 'no_opti' then placment_count else 0 end) as placment_count,
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
  (sum(margin) - sum(case when opti = 'no_opti' then scaled_margin else 0 end))/(sum(margin)) as scaled_margin_ratio_to_no_opti,
  sum(margin) - sum(case when opti = 'no_opti' then scaled_margin else 0 end) as scaled_margin_diff_to_no_opti,
  (sum(supply_margin) - sum(case when opti = 'no_opti' then scaled_supply_margin else 0 end))/(sum(supply_margin)) as scaled_supply_margin_ratio_to_no_opti,
  sum(supply_margin) - sum(case when opti = 'no_opti' then scaled_supply_margin else 0 end) as scaled_supply_margin_diff_to_no_opti,
  (sum(demand_margin) - sum(case when opti = 'no_opti' then scaled_demand_margin else 0 end))/(sum(demand_margin)) as scaled_demand_margin_ratio_to_no_opti,
  sum(demand_margin) - sum(case when opti = 'no_opti' then scaled_demand_margin else 0 end) as scaled_demand_margin_diff_to_no_opti,
  5 as rank_model
from
  fin_tab_before_tot
group by
  1,
  2,
  3)

    select
  *
from
  fin_tab_before_tot
union all
    select
  *
from
  tot_for_vis;;

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
