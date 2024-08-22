view: bid_opti_find_placements {
  derived_table: {
    sql: with include_list as (
                SELECT media_id,
                       sum(requests)
                FROM andromeda.ad_data_daily ad
                WHERE event_time >= current_date()-3 AND event_time < current_date() and bidfloor_opti_version != 'no_opti'
                GROUP BY 1
                HAVING sum(requests)>0
                )
SELECT media_id,
       round(SUM(case when ad.bidfloor_opti_version != 'no_opti' then requests else 0 end)/(sum(requests)),3) as ratio_req,
       sum(requests) as req
FROM andromeda.ad_data_daily ad
WHERE event_time >= current_date()-3 AND event_time < current_date() and media_id in (select media_id from include_list)
GROUP BY 1
having sum(requests) is not null
order by req desc;; }



 measure: count {
  type: count
  drill_fields: [detail*]
}



dimension: media_id {
  type: string
  sql: ${TABLE}.media_id ;;
}



measure: ratio_req {
  type: sum
  sql: ${TABLE}.ratio_req ;;
  value_format:"0.00%"
}



measure: req {
  type: sum
  sql: ${TABLE}.req ;;
  value_format: "#,##0"
}



set: detail {
  fields: [
    media_id,
    ratio_req,
    req
  ]}

}
