view: revenue_diff_report_etl {
    derived_table: {
      sql: with imp_count as (

                select media_id,
                               sum(case when (opti = 'bidfloor') then requests else 0 end) as marg_1,
                               sum(case when (opti = 'pubcost') then requests else 0 end) as marg_2,
                               sum(case when (opti = 'pubcost_bidfloor') then requests else 0 end) as marg_3,
                               sum(case when (opti = 'no_opti') then requests else 0 end) as marg_4,
                               sum(case when (opti not in ('bidfloor','pubcost','pubcost_bidfloor','no_opti')) then requests else 0 end) as marg_5,
                               sum(revenue) as tot_rev
                from bi.opti_bid_raw_v1
                where date_trunc = '2024-12-25' and (opti in ('bidfloor','pubcost','pubcost_bidfloor','no_opti'))
                      and imp_type in ('banner','video') AND lower(rx_ssp_name) like'%rmp%'
                group by 1),

     by_groups as (
                select media_id,
                       case when marg_1>0 then 'bidfloor' else 'none' end as bidfloor,
                       case when marg_2>0 then 'pubcost' else 'none' end as pubcost,
                       case when marg_3>0 then 'pubcost_bidfloor' else 'none' end as pubcost_bidfloor,
                       case when marg_4>0 then 'no_opti' else 'none' end as no_opti,
                       case when marg_5>0 then 'other' else 'none' end as other,
                       tot_rev
                from imp_count),

      by_list as (
      select media_id,
             concat(concat(concat(concat(concat(CONCAT(CONCAT(CONCAT(bidfloor,'_'),pubcost),'_'),pubcost_bidfloor),'_'),no_opti),'_'),other) as used_group,
             tot_rev
      from by_groups
      ),

      tab_null_events as (
      select opti,sum(revenue) as tot_rev
      from bi.opti_bid_raw_v1
      where date_trunc = '2024-12-25' and (opti not in ('bidfloor','pubcost','pubcost_bidfloor','no_opti'))
              and imp_type in ('banner','video')
      group by 1
      ),

      tab_no_ban_vid as (
      select imp_type,sum(revenue) as tot_rev
      from bi.opti_bid_raw_v1
      where date_trunc = '2024-12-25' and imp_type not in ('banner','video')
      group by 1
      )

select used_group,
       sum(tot_rev) as tot_rev
from by_list
group by 1

union all
select *
from tab_null_events

union all
select *
from tab_no_ban_vid

union all
select 'not rmp' as rand,sum(revenue)
from Andromeda.ad_data_daily add2
where event_time::date = '2024-12-25' and rx_ssp_name not like 'rmp%';;


    }



    dimension: used_group {
      type: string
      sql: ${TABLE}.used_group ;;
    }


# measu

    measure: tot_rev {
      type: sum
      sql: ${TABLE}.tot_rev ;;
      value_format: "#,##0"
    }


    set: detail {
      fields: [
        used_group,

        tot_rev
      ]
    }

  }
