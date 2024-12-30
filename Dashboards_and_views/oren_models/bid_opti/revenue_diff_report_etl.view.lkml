view: revenue_diff_report_etl {
    derived_table: {
      sql: with imp_count as (
                -- raw data maniplation for next step
                select date_trunc,
                       media_id,
                       sum(case when (opti = 'bidfloor') then requests else 0 end) as marg_1,
                       sum(case when (opti = 'pubcost') then requests else 0 end) as marg_2,
                       sum(case when (opti = 'pubcost_bidfloor') then requests else 0 end) as marg_3,
                       sum(case when (opti = 'no_opti') then requests else 0 end) as marg_4,
                       sum(case when (opti not in ('bidfloor','pubcost','pubcost_bidfloor','no_opti')) then requests else 0 end) as marg_5,
                       sum(requests) as tot_req,
                       sum(impression) as tot_imp,
                       sum(revenue) as tot_rev

                from bi.opti_bid_raw_v1
                where date_trunc >= current_date()-7 and date_trunc < current_date()
                      and opti != 'null_bucket'
                      and imp_type in ('banner','video')
                group by 1,2),

     by_groups as (
                -- raw data maniplation for next step
                select date_trunc,
                       media_id,
                       case when marg_1>0 then 'bidfloor' else 'none' end as bidfloor,
                       case when marg_2>0 then 'pubcost' else 'none' end as pubcost,
                       case when marg_3>0 then 'pubcost_bidfloor' else 'none' end as pubcost_bidfloor,
                       case when marg_4>0 then 'no_opti' else 'none' end as no_opti,
                       case when marg_5>0 then 'other' else 'none' end as other,
                       tot_req,
                       tot_imp,
                       tot_rev
                from imp_count),

      by_list as (
      -- checks what group each media_id is part
      select date_trunc,
             media_id,
             concat(concat(concat(concat(concat(CONCAT(CONCAT(CONCAT(bidfloor,'_'),pubcost),'_'),pubcost_bidfloor),'_'),no_opti),'_'),other) as used_group,
             tot_req,
             tot_imp,
             tot_rev
      from by_groups
      ),

      tab_null_events as (
      select date_trunc,
             opti,
             sum(requests) as tot_req,
             sum(impression) as tot_imp,
             sum(revenue) as tot_rev

      from bi.opti_bid_raw_v1
      where date_trunc >= current_date()-7 and date_trunc < current_date()
            and opti = 'null_bucket'
            and imp_type in ('banner','video')
      group by 1,2
      ),

      table_no_banner_video as (
      select date_trunc,
             imp_type,
             sum(requests) as tot_req,
             sum(impression) as tot_imp,
             sum(revenue) as tot_rev
      from bi.opti_bid_raw_v1
      where date_trunc >= current_date()-7 and date_trunc < current_date()
            and imp_type not in ('banner','video')
      group by 1,2
      )

select date_trunc,
       used_group,
       sum(tot_req) as tot_req,
       sum(tot_imp) as tot_imp,
       sum(tot_rev) as tot_rev
from by_list
group by 1,2

union all
select *
from tab_null_events

union all
select *
from table_no_banner_video;;


    }



    dimension: used_group {
      type: string
      sql: ${TABLE}.used_group ;;
    }

  dimension: date_trunc {
    type: date
    sql: ${TABLE}.date_trunc ;;
  }

# measu

    measure: tot_req {
      type: sum
      sql: ${TABLE}.tot_req ;;
      value_format: "#,##0"
    }

  measure: tot_imp {
    type: sum
    sql: ${TABLE}.tot_imp ;;
    value_format: "#,##0"
  }

  measure: tot_rev {
    type: sum
    sql: ${TABLE}.tot_rev ;;
    value_format: "#,##0"
  }


    set: detail {
      fields: [
        used_group,
        date_trunc,

        tot_req,
        tot_imp,
        tot_rev

      ]
    }

  }
