
view: unruly_exco_aniview_ctrl {
  derived_table: {
    sql: SELECT
             (TO_CHAR(DATE_TRUNC('month', MRR_AniView_Data.Activity_Date), 'YYYY-MM')) AS month_year,
             MRR_AniView_Data.Activity_Date AS activity_date,
              to_char(MRR_AniView_Data.Activity_Date, 'mm'::varchar(2)) AS MONTH,
              to_char(MRR_AniView_Data.Activity_Date, 'yyyy'::varchar(2)) AS YEAR,
              NULL AS demand_partner,
              ac.account_name AS seat_name,
              coalesce(p.PUB_ID, 'unknown'::varchar(7)) AS pub_id,
              NULL AS Is_1st_Party_Demand,
              'Aniview'::varchar(7) AS DATABASE,
              'OLV'::varchar(3) AS media_type,
              coalesce(p.OPS_Owner_Key, 1800001) AS employee_key,
              NULL AS origin_domain,
              NULL AS buying_channel,
             p.PUB_Name AS pub_name,
             0 AS requests,
              sum(MRR_AniView_Data.Impression) AS impressions,
              0 AS revenue,
              0 AS cost,
              0 AS net_revenue,
              sum(MRR_AniView_Data.Inventory) AS inventory,
              0 AS IA_SF,
              round(((sum(CASE WHEN ((MRR_AniView_Data.Advertiser_Name <> 'Aniview Marketplace'::varchar(19)) AND (MRR_AniView_Data.Publisher_Name <> 'Unruly'::varchar(6))) THEN MRR_AniView_Data.Impression ELSE NULL::int END) * 0.2) / 1000::numeric(18,0)), 0) AS IS_SF,
              round(((sum(CASE WHEN ((MRR_AniView_Data.Activity_Date >= '2023-06-01'::date) AND (ac.account_name = 'MyCast_Kodigital'::varchar(16)) AND (MRR_AniView_Data.Advertiser_Name <> 'Aniview Marketplace'::varchar(19)) AND (MRR_AniView_Data.Publisher_Name <> 'Unruly'::varchar(6))) THEN MRR_AniView_Data.Impression ELSE NULL::int END) * 0.15) / 1000::numeric(18,0)), 0) AS KO_SF,
              round(((sum(CASE WHEN ((MRR_AniView_Data.Activity_Date >= '2023-06-01'::date) AND (ac.account_name = 'MyCast_Twist'::varchar(12)) AND (MRR_AniView_Data.Advertiser_Name <> 'Aniview Marketplace'::varchar(19)) AND (MRR_AniView_Data.Publisher_Name <> 'Unruly'::varchar(6))) THEN MRR_AniView_Data.Impression ELSE NULL::int END) * 0.15) / 1000::numeric(18,0)), 0) AS TW_SF,
              round(((sum(CASE WHEN ((MRR_AniView_Data.Advertiser_Name <> 'Aniview Marketplace'::varchar(19)) AND (MRR_AniView_Data.Publisher_Name = 'Unruly'::varchar(6))) THEN MRR_AniView_Data.Impression ELSE NULL::int END) * CASE WHEN (MRR_AniView_Data.Activity_Date < '2023-06-01'::date) THEN 0.15 ELSE 0.18 END) / 1000::numeric(18,0)), 0) AS OS_SF,
              (sum(CASE WHEN (MRR_AniView_Data.Advertiser_Name = 'Aniview Marketplace'::varchar(19)) THEN MRR_AniView_Data.Revenue ELSE NULL::float END))::int AS AV_MP_Total_Rev,
              --(sum(CASE WHEN ((MRR_AniView_Data.Activity_Date < '2023-05-01'::date) AND (MRR_AniView_Data.Advertiser_Name = 'Aniview Marketplace'::varchar(19))) THEN round(((MRR_AniView_Data.Revenue / 0.7::float) * 0.1::float), 1) WHEN ((MRR_AniView_Data.Activity_Date >= '2023-05-01'::date) AND (MRR_AniView_Data.Advertiser_Name = 'Aniview Marketplace'::varchar(19))) THEN round(((MRR_AniView_Data.Revenue / 0.5::float) * 0.3::float), 1) ELSE NULL::float END))::int AS AV_MP_Net,
              sum(case when MRR_AniView_Data.Advertiser_Name = 'Aniview Marketplace'::varchar(19) then MRR_AniView_Data.Revenue end) as AV_MP_Net,
              (sum(CASE WHEN ((MRR_AniView_Data.Advertiser_Name <> 'Aniview Marketplace'::varchar(19)) AND (MRR_AniView_Data.Advertiser_Name <> 'Unruly'::varchar(6))) THEN MRR_AniView_Data.Revenue ELSE NULL::float END))::int AS Pub_MP_Total_Rev,
              (sum(CASE WHEN ((MRR_AniView_Data.Advertiser_Name <> 'Aniview Marketplace'::varchar(19)) AND (MRR_AniView_Data.Advertiser_Name <> 'Unruly'::varchar(6))) THEN (MRR_AniView_Data.Revenue * 0.05::float) ELSE NULL::float END))::int AS Pub_MP_Net,
              0 AS Player_Total_Rev,
              0 AS MyCast,
              0 AS Widgets_AI,
              0 AS Wiseroll_LTD_Yeda,
              0 as Streamkey
       FROM ((BI_New.MRR_AniView_Data JOIN BI_New.dim_AniView_Accounts ac ON ((MRR_AniView_Data.Account_ID = ac.account_id))) LEFT  JOIN BI_New.Dim_Publisher p ON ((p.external_publisher_id = MRR_AniView_Data.publisher_id)))
       GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14



                UNION ALL



                SELECT (TO_CHAR(DATE_TRUNC('month', Fact_cedato_demands.day), 'YYYY-MM')) AS month_year,
                Fact_cedato_demands.day AS activity_date,
              to_char(Fact_cedato_demands.day, 'mm'::varchar(2)) AS MONTH,
              to_char(Fact_cedato_demands.day, 'yyyy'::varchar(2)) AS YEAR,
              Fact_cedato_demands.demand_partner,
              Fact_cedato_demands.seat_name,
              'unknown'::varchar(11) AS pub_id,
              NULL AS Is_1st_Party_Demand,
              'Exco'::varchar(4) AS DATABASE,
              'IA'::varchar(2) AS media_type,
              40120000001 AS employee_key,
              NULL AS origin_domain,
              NULL AS buying_channel,
              NULL AS pub_name,
              sum(Fact_cedato_demands.bid_requests) AS requests,
              sum(Fact_cedato_demands.impressions) AS impressions,
              0 AS revenue,
              0 AS cost,
              0 AS net_revenue,
              0 AS inventory,
              (round(((sum(Fact_cedato_demands.impressions) / 1000::numeric(18,0)) * 0.18), 1))::int AS IA_SF,
              0 AS IS_SF,
              0 AS KO_SF,
              0 AS TW_SF,
              0 AS OS_SF,
              NULL AS AV_MP_Total_Rev,
              NULL AS AV_MP_Net,
              CASE WHEN (lower(Fact_cedato_demands.demand_partner) ~~* 'unruly%'::varchar(7)) THEN NULL::numeric(1,0) ELSE sum(Fact_cedato_demands.revenue) END AS Pub_MP_Total_Rev,
              CASE WHEN (lower(Fact_cedato_demands.demand_partner) ~~* 'unruly%'::varchar(7)) THEN NULL::numeric(1,0) ELSE CASE WHEN (Fact_cedato_demands.day < '2023-06-01'::date) THEN (sum(Fact_cedato_demands.revenue) * 0.2) WHEN (Fact_cedato_demands.day >= '2023-06-01'::date) THEN (sum(Fact_cedato_demands.revenue) * 0.15) ELSE NULL::numeric(1,0) END END AS Pub_MP_Net,
              sum(Fact_cedato_demands.revenue) AS Player_Total_Rev,
              --sum(CASE WHEN ((Fact_cedato_demands.day < '2023-06-01'::date) AND (lower(Fact_cedato_demands.demand_partner) !~~* 'unruly%'::varchar(7)) AND (Fact_cedato_demands.seat_name ~~* '%MC%'::varchar(4))) THEN (Fact_cedato_demands.revenue * 0.2) WHEN ((Fact_cedato_demands.day >= '2023-06-01'::date) AND (lower(Fact_cedato_demands.demand_partner) !~~* 'unruly%'::varchar(7)) AND (Fact_cedato_demands.seat_name ~~* '%MC%'::varchar(4))) THEN (Fact_cedato_demands.revenue * 0.15) ELSE NULL::numeric(1,0) END) AS MyCast,
              sum(case when lower(Fact_cedato_demands.demand_partner) != 'unruly mycast' and Fact_cedato_demands.seat_name = 'Unruly_publisher_MC' then Fact_cedato_demands.revenue * 0.15 end) as MyCast,
              0 AS Widgets_AI,
              0 AS Wiseroll_LTD_Yeda,
              0 AS Streamkey
       FROM BI_New.Fact_cedato_demands
       GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14

       union all

       SELECT
       (TO_CHAR(DATE_TRUNC('month', d.date_key), 'YYYY-MM')) AS month_year,
          d.Date_Key                            AS activity_date,
          TO_CHAR(d.Date_Key, 'mm'::varchar(2)) AS MONTH,
          TO_CHAR(d.Date_Key, 'yy'::varchar(2)) AS YEAR,
          NULL                                  AS demand_partner,
          NULL                                  AS seat_name,
          p.PUB_ID                              AS pub_id,
          null as Is_1st_Party_Demand,
          'CTRL'::varchar(4) AS DATABASE,
          CASE
              WHEN (
                      e.employee_name in ('Bar Wolkowiski','Yovel Modlin','Itzik Vaknin','Noa Karako','Shir Elzam','Mikayla Skarzynski', 'Shachar Laufer', 'Rachel Gargett','Hannah Quigley')
                  AND mt.Media_Type = 'site'::varchar(4))
              THEN 'OLV'::varchar(3)
              WHEN (
                     e.employee_name in ('Itamar Bilu','Stav Ezer','Ashleigh Fisher', 'Noa Krashniak', 'Gonni Kern')
                  AND mt.Media_Type = 'app'::varchar(3))
              THEN 'IA'::varchar(2)
              ELSE NULL
          END                                         AS media_type,
          OPS_Owner_Key                               AS employee_key,
              null as origin_domain ,
          null as Buying_Channel ,
          p.pub_name,
          SUM(agg.sum_of_requests)                    AS requests,
          SUM(agg.sum_of_impression_pixel)            AS impressions,
          SUM(agg.sum_of_revenue)                     AS revenue,
          SUM(agg.sum_of_cogs)                        AS cost,
          SUM((agg.sum_of_revenue - agg.sum_of_cogs)) AS net_revenue,
          0                                           AS inventory,
          0                                           AS IA_SF,
          0                                           AS IS_SF,
                  0 AS KO_SF,
              0 AS TW_SF,
          0                                           AS OS_SF,
          0                                           AS AV_MP_Total_Rev,
          0                                           AS AV_MP_Net,
          0                                           AS Pub_MP_Total_Rev,
          0                                           AS Pub_MP_Net,
          0                                           AS Player_Total_Rev,
          0                                           AS MyCast,
          CASE
        WHEN d.date_key >= '2023-06-01'
        AND p.PUB_ID = '105705'
        AND lower(device_type_id) != lower('ctv')
        and lower(imp_type) = 'video'
        THEN
            SUM(agg.sum_of_cogs) * 0.07

    END AS Widgets_AI,
    CASE
        WHEN p.PUB_ID = ANY (ARRAY['105587', '106126'])
        and d.Date_Key >= DATE('2023-04-01')
        and lower(imp_type) = 'video'
        THEN
           SUM(agg.sum_of_cogs) * 0.07

    END         AS Wiseroll_LTD_Yeda,
    CASE
        WHEN p.PUB_ID='106894'
        THEN
            SUM(agg.sum_of_cogs) *0.09
        END AS Streamkey
      FROM
          BI_New.Fact_Ad_Daily_Agg agg
      INNER JOIN
          BI_New.V_Dim_Date d
      ON
          d.Date_Key = agg.Date_Key
      INNER JOIN
          BI_New.Dim_Media_Type mt
      ON
          mt.Media_Type_Key = agg.Media_Type_Key
      INNER JOIN
          BI_New.Dim_Publisher_SSP ssp
      ON
          ssp.PUB_SSP_Key = agg.PUB_SSP_Key
      LEFT JOIN
          BI_New.Dim_Publisher p
      ON
          p.PUB_Key = ssp.PUB_Key
      LEFT JOIN
          BI_New.dim_employee e
      ON
          p.OPS_Owner_Key = e.Employee_Key
      /*LEFT JOIN
          BI_New.V_Dim_DSP_Seat dsp
      ON
          dsp.DSP_Seat_Key = agg.DSP_Seat_Key
      LEFT JOIN
          BI_New.V_Dim_placement plc
      ON
          plc.placement_Key = agg.placement_Key
      LEFT JOIN
          BI_new.Dim_Publisher_Traffic_Source pts
      ON
          pts.PUB_ts_Key=plc.PUB_ts_Key
      LEFT JOIN
          BI_new.Dim_Traffic_Source ts
      ON
          ts.TS_Key=pts.TS_Key
      LEFT JOIN
          BI_new.Dim_Buying_Channel bc
      ON
          bc.Buying_Channel_Key = agg.Buying_Channel_Key
      LEFT JOIN
          bi_new.Dim_O_Domain od
      ON
          od.O_Domain_Key = agg.O_Domain_Key */
      LEFT JOIN
          bi_new.Dim_Device_Type dt
      ON
          agg.Device_Type_key = dt.Device_Type_key
      LEFT JOIN
          bi_new.Dim_Imp_Type it
      ON
          agg.Imp_Type_key = it.Imp_Type_key
      WHERE
          d.Date_Key >='2024-01-01'
      AND
          CASE
              WHEN (
                  e.employee_name in ('Bar Wolkowiski','Yovel Modlin','Itzik Vaknin','Noa Karako','Shir Elzam','Mikayla Skarzynski', 'Shachar Laufer', 'Rachel Gargett','Hannah Quigley')
                  AND mt.Media_Type = 'site'::varchar(4))
              THEN 'OLV'::varchar(3)
              WHEN (
                     e.employee_name in ('Itamar Bilu','Stav Ezer','Ashleigh Fisher', 'Noa Krashniak', 'Gonni Kern')
                  AND mt.Media_Type = 'app'::varchar(3))
              THEN 'IA'::varchar(2)
              ELSE NULL
          END IS NOT NULL
      GROUP BY
          d.Date_Key,
          TO_CHAR(d.Date_Key, 'mm'::varchar(2)),
          TO_CHAR(d.Date_Key, 'yy'::varchar(2)),
          p.PUB_ID,
          Is_1st_Party_demand,
          CASE
              WHEN (
                  e.employee_name in ('Bar Wolkowiski','Yovel Modlin','Itzik Vaknin','Noa Karako','Shir Elzam','Mikayla Skarzynski', 'Shachar Laufer', 'Rachel Gargett','Hannah Quigley')
                  AND mt.Media_Type = 'site'::varchar(4))
              THEN 'OLV'::varchar(3)
              WHEN (
                     e.employee_name in ('Itamar Bilu','Stav Ezer','Ashleigh Fisher', 'Noa Krashniak', 'Gonni Kern')
                  AND mt.Media_Type = 'app'::varchar(3))
              THEN 'IA'::varchar(2)
              ELSE NULL
          END,
          p.OPS_Owner_Key,
          origin_domain,
          Buying_Channel,
          p.pub_name,
          dt.device_type_id,
          it.imp_type;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: month_year {
    type: string
    sql: ${TABLE}.month_year ;;
  }

  dimension_group: activity {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.activity_date ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}."MONTH" ;;
  }

  dimension: year {
    type: string
    sql: ${TABLE}."YEAR" ;;
  }

  dimension: demand_partner {
    type: string
    sql: ${TABLE}.demand_partner ;;
  }

  dimension: seat_name {
    type: string
    sql: ${TABLE}.seat_name ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.pub_id ;;
  }

  dimension: is_1st_party_demand {
    type: string
    sql: ${TABLE}.Is_1st_Party_Demand ;;
    hidden: yes
  }

  dimension: database {
    type: string
    sql: ${TABLE}."DATABASE" ;;
  }

  dimension: media_type {
    type: string
    sql: ${TABLE}.media_type ;;
  }

  dimension: employee_key {
    type: number
    sql: ${TABLE}.employee_key ;;
    hidden: yes
  }

  dimension: origin_domain {
    type: string
    sql: ${TABLE}.origin_domain ;;
    hidden: yes
  }

  dimension: buying_channel {
    type: string
    sql: ${TABLE}.buying_channel ;;
    hidden: yes
  }

  dimension: pub_name {
    type: string
    sql: ${TABLE}.pub_name ;;
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.requests ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.cost ;;
  }

  measure: net_revenue {
    type: sum
    sql: ${TABLE}.net_revenue ;;
  }

  measure: inventory {
    type: sum
    sql: ${TABLE}.inventory ;;
    hidden: yes
  }

  measure: ia_sf {
    type: sum
    sql: ${TABLE}.IA_SF ;;
  }

  measure: is_sf {
    type: sum
    sql: ${TABLE}.IS_SF ;;
  }

  measure: ko_sf {
    type: sum
    sql: ${TABLE}.KO_SF ;;
    hidden: yes
  }

  measure: tw_sf {
    type: sum
    sql: ${TABLE}.TW_SF ;;
    hidden: yes
  }

  measure: os_sf {
    type: sum
    sql: ${TABLE}.OS_SF ;;
  }

  measure: av_mp_total_rev {
    type: sum
    sql: ${TABLE}.AV_MP_Total_Rev ;;
  }

  measure: av_mp_net {
    type: sum
    sql: ${TABLE}.AV_MP_Net ;;
  }

  measure: pub_mp_total_rev {
    type: sum
    sql: ${TABLE}.Pub_MP_Total_Rev ;;
  }

  measure: pub_mp_net {
    type: sum
    sql: ${TABLE}.Pub_MP_Net ;;
  }

  measure: player_total_rev {
    type: sum
    sql: ${TABLE}.Player_Total_Rev ;;
  }

  measure: my_cast {
    type: sum
    sql: ${TABLE}.MyCast ;;
  }

  measure: widgets_ai {
    type: sum
    sql: ${TABLE}.Widgets_AI ;;
  }

  measure: wiseroll_ltd_yeda {
    type: sum
    sql: ${TABLE}.Wiseroll_LTD_Yeda ;;
  }

  measure: streamkey {
    type: sum
    sql: ${TABLE}.Streamkey ;;
  }

  set: detail {
    fields: [
        month_year,
  activity_date,
  month,
  year,
  demand_partner,
  seat_name,
  pub_id,
  is_1st_party_demand,
  database,
  media_type,
  employee_key,
  origin_domain,
  buying_channel,
  pub_name,
  requests,
  impressions,
  revenue,
  cost,
  net_revenue,
  inventory,
  ia_sf,
  is_sf,
  ko_sf,
  tw_sf,
  os_sf,
  av_mp_total_rev,
  av_mp_net,
  pub_mp_total_rev,
  pub_mp_net,
  player_total_rev,
  my_cast,
  widgets_ai,
  wiseroll_ltd_yeda,
  streamkey
    ]
  }
}
