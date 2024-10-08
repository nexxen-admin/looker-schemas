view: bid_opti_all_models_v3 {
    derived_table: {
      sql: with opti_base_data  as (


select case when bidfloor_opti_version !='no_opti' and (pubcost_opti_enabled = '-4' or pubcost_opti_enabled = '0')  then 'bidfloor'
when bidfloor_opti_version !='no_opti' and pubcost_opti_enabled = '1' then 'pubcost_bidfloor'
when bidfloor_opti_version = 'no_opti' and pubcost_opti_enabled = '1' then 'pubcost'
when bidfloor_opti_version = 'no_opti' and (pubcost_opti_enabled = '-4' or pubcost_opti_enabled = '0')   then 'no_opti'
when bidfloor_opti_version is null and (pubcost_opti_enabled is null or pubcost_opti_enabled = '0') then 'not enabled'
when pubcost_opti_enabled in ('-1','-2','-3') then 'inelgible/error'
else pubcost_opti_enabled::varchar  end as opti,
media_id, rx_imp_type as imp_type , pub_id,
 sum(requests) as requests, sum(revenue)- sum(cogs) as margin, sum(revenue)-sum(cost) as demand_margin, sum(cost)-sum(cogs) as supply_margin
from Andromeda.ad_data_daily add2
where event_time ='2024-10-05'
and rx_ssp_name like'rmp%'
and rx_imp_type in ('banner','video')
group by 1,2,3,4
having (demand_margin + supply_margin) >0
),


data_totals as (
select media_id, rx_imp_type as imp_type , pub_id, publisher_name,
 sum(requests) as total_requests, sum(revenue)-sum(cogs) as total_margin, sum(revenue)-sum(cost) as total_demand_margin, sum(cost)-sum(cogs) as total_supply_margin
from Andromeda.ad_data_daily add2
where event_time ='2024-10-05'
  and rx_ssp_name like'rmp%'
  and rx_imp_type in ('banner','video')
group by 1,2,3,4
having total_margin >0
),

optis_list as (
select concat(media_id,imp_type) as media_imp,count(distinct opti) as optis
from opti_base_data
group by 1
),

scaled_margin as (
(select dt.media_id, dt.imp_type,opti.opti, opti.requests,opti.margin,opti.demand_margin,opti.supply_margin,
  opti.requests/dt.total_requests as split,
  opti.margin/split as scaled_margin,
  opti.demand_margin/split as scaled_demand_margin,
  opti.supply_margin/split as scaled_supply_margin
from data_totals as dt
inner join opti_base_data as opti on opti.media_id = dt.media_id and opti.imp_type = dt.imp_type
where dt.total_requests >80000
and concat(dt.media_id,dt.imp_type)  in ( select media_imp from optis_list where optis>=4)
order by dt.total_demand_margin desc)
),


opti_bucket_data as (

select sm.*, sm_no.scaled_margin as no_opti_scaled, (sm.scaled_margin-sm_no.scaled_margin)/sm_no.scaled_margin as scaled_margin_pct,
(sm.scaled_margin-sm_no.scaled_margin)*sm.split as actual_margin_impact,
(sm.scaled_demand_margin-sm_no.scaled_demand_margin)/sm_no.scaled_demand_margin as scaled_demand_margin_pct,  (sm.scaled_demand_margin-sm_no.scaled_demand_margin)*sm.split as actual_demand_margin_impact,
(sm.scaled_supply_margin-sm_no.scaled_supply_margin)/sm_no.scaled_supply_margin as scaled_supply_margin_pct,  (sm.scaled_supply_margin-sm_no.scaled_supply_margin)*sm.split as actual_supply_margin_impact
from  scaled_margin sm
inner join scaled_margin sm_no on sm.media_id =sm_no.media_id and sm.imp_type = sm_no.imp_type and sm_no.opti= 'no_opti'
)


select dt.pub_id,
       dt.publisher_name,
       dt.imp_type,
      dt.media_id,
      dt.total_requests,
      dt.total_margin,
      dt.total_demand_margin,
      dt.total_supply_margin,
      no_opti.requests as no_opti_requests,
      bf.requests as bidfloor_requests,
      pc.requests as pubcost_requests,
      pcbf.requests as pubcost_bidfloor_requests,
      no_opti.split as no_opti_split,
      bf.split as bidfloor_split,
      pc.split as pubcost_split,
      pcbf.split as pubcost_bidfloor_split,
      inelgible.margin as inelgible_margin,
      no_opti.margin as no_opti_margin,
      bf.margin as bidfloor_margin,
      pc.margin as pubcost_margin,
      pcbf.margin as pubcost_bidfloor_margin,
      no_opti.scaled_margin as no_opti_scaled_margin,
      bf.scaled_margin as bidfloor_split,
      pc.scaled_margin as pubcost_split,
      pcbf.scaled_margin as pubcost_bidfloor_split,
      bf.scaled_margin_pct as bidfloor_scaled_margin_pct,
      pc.scaled_margin_pct as pubcost_scaled_margin_pct,
      pcbf.scaled_margin_pct as pubcost_bidfloor_scaled_margin_pct,
      bf.actual_margin_impact as bidfloor_actual_margin_impact,
      pc.actual_margin_impact as pubcost_actual_margin_impact,
      pcbf.actual_margin_impact as pubcost_bidfloor_actual_margin_impact,
      bf.actual_margin_impact + pc.actual_margin_impact + pcbf.actual_margin_impact as total_actual_margin_impact,
      bf.actual_supply_margin_impact as bidfloor_actual_supply_margin_impact,
      pc.actual_supply_margin_impact as pubcost_actual_supply_margin_impact,
      pcbf.actual_supply_margin_impact as pubcost_bidfloor_actual_supply_margin_impact,
      bf.actual_supply_margin_impact + pc.actual_supply_margin_impact + pcbf.actual_supply_margin_impact as total_actual_supply_margin_impact
from data_totals dt
inner join opti_bucket_data no_opti on dt.media_id = no_opti.media_id  and dt.imp_Type = no_opti.imp_Type and no_opti.opti = 'no_opti'
left outer join opti_bucket_data bf on dt.media_id = bf.media_id  and dt.imp_Type = bf.imp_Type and bf.opti = 'bidfloor'
left outer join opti_bucket_data pc on dt.media_id = pc.media_id  and dt.imp_Type = pc.imp_Type and pc.opti = 'pubcost'
left outer join opti_bucket_data pcbf on dt.media_id = pcbf.media_id  and dt.imp_Type = pcbf.imp_Type and pcbf.opti = 'pubcost_bidfloor'
left outer join opti_bucket_data inelgible on dt.media_id = inelgible.media_id  and dt.imp_Type = inelgible.imp_Type and inelgible.opti = 'inelgible/error'
order by imp_type desc, total_margin desc;;


    }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: event_date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.event_date ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.pub_id ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  dimension: media_id {
    type: string
    sql: ${TABLE}.media_id ;;
  }

  dimension: imp_type {
    type: string
    sql: ${TABLE}.imp_type ;;
  }

  measure: total_requests {
    type: sum
    sql: ${TABLE}.total_requests ;;
    value_format: "#,##0"
  }

  measure: total_margin {
    type: sum
    sql: ${TABLE}.total_margin ;;
    value_format: "$#,##0.00"
  }

  measure: total_demand_margin {
    type: sum
    sql: ${TABLE}.total_demand_margin ;;
    value_format: "$#,##0.00"
  }

  measure: total_supply_margin {
    type: sum
    sql: ${TABLE}.total_supply_margin ;;
    value_format: "$#,##0.00"
  }

  measure: no_opti_requests {
    type: sum
    sql: ${TABLE}.no_opti_requests ;;
    value_format: "#,##0"
  }

  measure: bidfloor_requests {
    type: sum
    sql: ${TABLE}.bidfloor_requests ;;
    value_format: "#,##0"
  }

  measure: pubcost_requests {
    type: sum
    sql: ${TABLE}.pubcost_requests ;;
    value_format: "#,##0"
  }

  measure: pubcost_bidfloor_requests {
    type: sum
    sql: ${TABLE}.pubcost_bidfloor_requests ;;
    value_format: "#,##0"
  }

  measure: no_opti_split {
    type: number
    sql: ${TABLE}.no_opti_split ;;
    value_format: "0.00%"
  }

  measure: bidfloor_split {
    type: number
    sql: ${TABLE}.bidfloor_split ;;
    value_format: "0.00%"
  }

  measure: pubcost_split {
    type: number
    sql: ${TABLE}.pubcost_split ;;
    value_format: "0.00%"
  }

  measure: pubcost_bidfloor_split {
    type: number
    sql: ${TABLE}.pubcost_bidfloor_split ;;
    value_format: "0.00%"
  }

  measure: inelgible_margin {
    type: sum
    sql: ${TABLE}.inelgible_margin ;;
    value_format: "$#,##0.00"
  }

  measure: no_opti_margin {
    type: sum
    sql: ${TABLE}.no_opti_margin ;;
    value_format: "$#,##0.00"
  }

  measure: bidfloor_margin {
    type: sum
    sql: ${TABLE}.bidfloor_margin ;;
    value_format: "$#,##0.00"
  }

  measure: pubcost_margin {
    type: sum
    sql: ${TABLE}.pubcost_margin ;;
    value_format: "$#,##0.00"
  }

  measure: pubcost_bidfloor_margin {
    type: sum
    sql: ${TABLE}.pubcost_bidfloor_margin ;;
    value_format: "$#,##0.00"
  }

  measure: no_opti_scaled_margin {
    type: number
    sql: ${TABLE}.no_opti_scaled_margin ;;
    value_format: "$#,##0.00"
  }

  measure: bidfloor_scaled_margin {
    type: number
    sql: ${TABLE}.bidfloor_scaled_margin ;;
    value_format: "$#,##0.00"
  }

  measure: pubcost_scaled_margin {
    type: number
    sql: ${TABLE}.pubcost_scaled_margin ;;
    value_format: "$#,##0.00"
  }

  measure: pubcost_bidfloor_scaled_margin {
    type: number
    sql: ${TABLE}.pubcost_bidfloor_scaled_margin ;;
    value_format: "$#,##0.00"
  }

  measure: bidfloor_scaled_margin_pct {
    type: number
    sql: ${TABLE}.bidfloor_scaled_margin_pct ;;
    value_format: "0.00%"
  }

  measure: pubcost_scaled_margin_pct {
    type: number
    sql: ${TABLE}.pubcost_scaled_margin_pct ;;
    value_format: "0.00%"
  }

  measure: pubcost_bidfloor_scaled_margin_pct {
    type: number
    sql: ${TABLE}.pubcost_bidfloor_scaled_margin_pct ;;
    value_format: "0.00%"
  }

  measure: bidfloor_actual_margin_impact {
    type: number
    sql: ${TABLE}.bidfloor_actual_margin_impact ;;
    value_format: "$#,##0.00"
  }

  measure: pubcost_actual_margin_impact {
    type: number
    sql: ${TABLE}.pubcost_actual_margin_impact ;;
    value_format: "$#,##0.00"
  }

  measure: pubcost_bidfloor_actual_margin_impact {
    type: number
    sql: ${TABLE}.pubcost_bidfloor_actual_margin_impact ;;
    value_format: "$#,##0.00"
  }

  measure: total_actual_margin_impact {
    type: number
    sql: ${bidfloor_actual_margin_impact} + ${pubcost_actual_margin_impact} + ${pubcost_bidfloor_actual_margin_impact} ;;
    value_format: "$#,##0.00"
  }

  measure: bidfloor_actual_supply_margin_impact {
    type: number
    sql: ${TABLE}.bidfloor_actual_supply_margin_impact ;;
    value_format: "$#,##0.00"
  }

  measure: pubcost_actual_supply_margin_impact {
    type: number
    sql: ${TABLE}.pubcost_actual_supply_margin_impact ;;
    value_format: "$#,##0.00"
  }

  measure: pubcost_bidfloor_actual_supply_margin_impact {
    type: number
    sql: ${TABLE}.pubcost_bidfloor_actual_supply_margin_impact ;;
    value_format: "$#,##0.00"
  }

  measure: total_actual_supply_margin_impact {
    type: number
    sql: ${bidfloor_actual_supply_margin_impact} + ${pubcost_actual_supply_margin_impact} + ${pubcost_bidfloor_actual_supply_margin_impact} ;;
    value_format: "$#,##0.00"
  }

  set: detail {
    fields: [
      pub_id,
      publisher_name,
      imp_type,
      media_id,
      total_requests,
      total_margin,
      total_demand_margin,
      total_supply_margin,
      no_opti_requests,
      bidfloor_requests,
      pubcost_requests,
      pubcost_bidfloor_requests,
      no_opti_split,
      bidfloor_split,
      pubcost_split,
      pubcost_bidfloor_split,
      inelgible_margin,
      no_opti_margin,
      bidfloor_margin,
      pubcost_margin,
      pubcost_bidfloor_margin,
      no_opti_scaled_margin,
      bidfloor_scaled_margin,
      pubcost_scaled_margin,
      pubcost_bidfloor_scaled_margin,
      bidfloor_scaled_margin_pct,
      pubcost_scaled_margin_pct,
      pubcost_bidfloor_scaled_margin_pct,
      bidfloor_actual_margin_impact,
      pubcost_actual_margin_impact,
      pubcost_bidfloor_actual_margin_impact,
      total_actual_margin_impact,
      bidfloor_actual_supply_margin_impact,
      pubcost_actual_supply_margin_impact,
      pubcost_bidfloor_actual_supply_margin_impact,
      total_actual_supply_margin_impact
    ]
  }

  }
