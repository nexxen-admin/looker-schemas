view: tva_tvi {
    derived_table: {
      sql: with segments as (
                -- get all segments that used tva/comscore
                SELECT distinct nexxen_dmp_provider,segment_name
                FROM BI_New.fact_segments_usage_data
                WHERE event_date between current_date()-14 and current_date()-1
                      AND nexxen_dmp_provider in ('Amobee Smart TVA','Comscore AlwaysOn')
                ),
     requestid_picked_seg as (
                -- gives all requests that used tva/comscore segments
                select distinct requestid
                from Andromeda.segmentusage_r
                WHERE event_time >= current_date()::timestamp-14 AND event_time <= current_date()::timestamp-1 and
                      exportname in (select segment_name from segments)
             ),
     imp_table as (
                select country,requestid,winprice/1000 as imp_price
                from Andromeda.impression_r
                WHERE event_time >= current_date()::timestamp-14 AND event_time <= current_date()::timestamp-1 and
                      source='impbeacon' and isbillable=1
                 ),
     requestid_with_tva_counted as (
             -- we take the line items that had tva/comescore and we count how many segments were used for each line item
             select AA.exportname as segment_id,
                    AA.requestid,
                    AA.segmenttype,
                    CC.nexxen_dmp_provider,
                    date(AA.event_time) as day_date,
                    BB.country,
                    BB.imp_price,
                    count(*) over (partition by AA.requestid) as count_seg_per_li
             FROM Andromeda.segmentusage_r AA
             LEFT JOIN imp_table BB
             on AA.requestid = BB.requestid
             left join segments CC
             on AA.exportname = CC.segment_name
             WHERE AA.event_time >= current_date()::timestamp-14 AND AA.event_time <= current_date()::timestamp-1
                   and AA.requestid in (select requestid from requestid_picked_seg)
                )


SELECT segment_id,
       segmenttype,
       day_date,
       nexxen_dmp_provider,
       country,
       sum(imp_price) as imp_price,
       sum(imp_price/count_seg_per_li) as imp_price_adj, -- we divide the price for all the segments used
       count(*) as impressions,
       sum(1/count_seg_per_li) as impressions_adj -- we divide the impressions for all the segments used
FROM requestid_with_tva_counted
group by 1,2,3,4,5
having segment_id in (select distinct segment_name from segments);;

    }



    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: segment_id {
      type: string
      sql: ${TABLE}.segment_id ;;
    }

  dimension: day_date {
    type: string
    sql: ${TABLE}.day_date ;;
  }

  dimension: segmenttype {
    type: string
    sql: ${TABLE}.segmenttype ;;
  }
  dimension: nexxen_dmp_provider {
    type: string
    sql: ${TABLE}.nexxen_dmp_provider ;;
  }
  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }


    measure: imp_price {
      type: sum
      sql: ${TABLE}.imp_price ;;
      value_format: "$#,##0.00"
    }
  measure: imp_price_adj {
    type: sum
    sql: ${TABLE}.imp_price_adj ;;
    value_format: "$#,##0.00"
  }
  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "$#,##0.00"
  }
  measure: impressions_adj {
    type: sum
    sql: ${TABLE}.impressions_adj ;;
    value_format: "$#,##0.00"
  }



    set: detail {
      fields: [



segment_id,
       segmenttype,
       day_date,
       nexxen_dmp_provider,
       country,
       imp_price,
       imp_price_adj,
       impressions,
       impressions_adj
      ]
    }
  }
