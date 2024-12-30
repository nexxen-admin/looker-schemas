view: revenue_diff_report_etl {
    derived_table: {
      sql: with imp_count as (
                -- raw data manipulation for next step
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
                -- raw data manipulation for next step
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
      ),

      unioned_table as (
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
      from table_no_banner_video)

      -- final output

      select date_trunc,
             used_group,
             1 as rank,
             tot_req/(sum(tot_req) over (partition by date_trunc)) as req_ratio,
             tot_imp/(sum(tot_imp) over (partition by date_trunc)) as imp_ratio,
             tot_rev/(sum(tot_rev) over (partition by date_trunc)) as rev_ratio,
             tot_req,
             tot_imp,
             tot_rev
      from unioned_table

      union all

      (select date_trunc,
             'Total' as used_group,
             2 as rank,
             1 as req_ratio,
             1 as imp_ratio,
             1 as rev_ratio,
             sum(tot_req),
             sum(tot_imp),
             sum(tot_rev)
      from unioned_table
      group by 1,2,3,4);;


    }



  dimension: used_group {
    type: string
    sql: CASE
        WHEN ${TABLE}.used_group = 'bidfloor_pubcost_pubcost_bidfloor_no_opti_none' THEN 'All Models Used'
        WHEN ${TABLE}.used_group = 'null_bucket' THEN 'Null Events In Opti Model'
        WHEN ${TABLE}.used_group = 'bidfloor_none_none_no_opti_none' THEN 'Only Bidfoor Model Used'
        WHEN ${TABLE}.used_group = 'audio' THEN 'Events From Audio Placements'
        WHEN ${TABLE}.used_group = 'bidfloor_pubcost_pubcost_bidfloor_none_none' THEN 'All Events Were Optimized (no no_opti events)'
        WHEN ${TABLE}.used_group = 'bidfloor_none_pubcost_bidfloor_no_opti_none' THEN 'No PubCost Events'
        WHEN ${TABLE}.used_group = 'bidfloor_pubcost_none_no_opti_none' THEN 'No PubCost_Bidfloor Events'
        WHEN ${TABLE}.used_group = 'none_none_none_no_opti_none' THEN 'All Events Were Non-Optimzed'
        WHEN ${TABLE}.used_group = 'native' THEN 'Events From Native Placements'
        WHEN ${TABLE}.used_group = 'none_pubcost_pubcost_bidfloor_no_opti_none' THEN 'No Bidfloor Events'
        WHEN ${TABLE}.used_group = 'none_none_pubcost_bidfloor_no_opti_none' THEN 'No bidfloor Or Pubcost Events'
        WHEN ${TABLE}.used_group = 'bidfloor_none_pubcost_bidfloor_none_none' THEN 'No Pubcost And Non_opti Events'
        WHEN ${TABLE}.used_group = 'bidfloor_none_none_none_none' THEN 'Only Bidfloor Events'
        WHEN ${TABLE}.used_group = 'none_none_pubcost_bidfloor_none_none' THEN 'Only Pubcost_bidfloor Events'
        WHEN ${TABLE}.used_group = 'none_pubcost_none_none_none' THEN 'Only Pubcost Events'
        WHEN ${TABLE}.used_group = 'bidfloor_pubcost_none_none_none' THEN 'Only Bidfloor And Pubcost Events'
        WHEN ${TABLE}.used_group = 'none_pubcost_pubcost_bidfloor_none_none' THEN 'Only Pubcost And Bidfloor_pubcost Events'
        WHEN ${TABLE}.used_group = 'none_none_none_none_none' THEN 'No Events'
        ELSE ${TABLE}.used_group
       END ;;
  }



  dimension: date_trunc {
    type: date
    sql: ${TABLE}.date_trunc ;;
  }

  dimension: rank {
    type: string
    sql: ${TABLE}.rank ;;
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

  measure: req_ratio {
    type: sum
    sql: ${TABLE}.req_ratio ;;
    value_format: "#,##0"
  }


  measure: imp_ratio {
    type: sum
    sql: ${TABLE}.imp_ratio ;;
    value_format: "#,##0"
  }


  measure: rev_ratio {
    type: sum
    sql: ${TABLE}.rev_ratio ;;
    value_format: "#,##0"
  }



    set: detail {
      fields: [
        used_group,
        date_trunc,

        tot_req,
        tot_imp,
        tot_rev,
        req_ratio,
        imp_ratio,
        rev_ratio

      ]
    }

  }
