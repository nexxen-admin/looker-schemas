view: report_uid_source {
derived_table: {
    sql: select
    li.event_time as date,
    li.publisher_name,
    li.imp + coalesce(li_un.imp,0) as total_impressions,
    coalesce(li_un.imp,0) as control_impressions,
    li.imp as treated_impressions,
    '' as total_revenue,
    '' as control_revenue,
    '' as treated_revenue,
    round((li.margin-(coalesce(li_un.margin, 0)* 19))* 0.15, 4) as LI_FEE
  FROM
    (
    Select
      event_time as event_time,
      pub_id,
      publisher_name,
      sum(impression_pixel) as imp,
      round(sum(revenue)-sum(cogs)-coalesce(sum(deal_data_fee), 0), 4) as margin
    from
      Andromeda.ad_data_daily add2
    where
      event_time >= current_date()-1
      and event_time < current_date()
      and uid_source = 'liveintent'
      and rx_ssp_name like 'rmp%'
      and impression_pixel >0
    group by
      1,
      2,
      3) as li
  left outer join
  (
    Select
      event_time as event_time,
      pub_id,
      sum(impression_pixel) as imp,
      round(sum(revenue)-sum(cogs)-coalesce(sum(deal_data_fee), 0), 4) as margin
    from
      Andromeda.ad_data_daily add2
    where
      event_time >= current_date()-1
      and event_time < current_date()
      and uid_source = 'liveintent_unused'
      and rx_ssp_name like 'rmp%'
    group by
      1,
      2) as li_un on
    li.event_time = li_un.event_time
    and li.pub_id = li_un.pub_id
  order by
    2,
    1 ;;
}

  dimension: date {
    type: date
    sql: ${TABLE}.date ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }

  measure: total_impressions {
    type: sum
    sql: ${TABLE}.total_impressions ;;
  }

  measure: control_impressions {
    type: sum
    sql: ${TABLE}.control_impressions ;;
  }

  measure: treated_impressions {
    type: sum
    sql: ${TABLE}.treated_impressions ;;
  }

  measure: total_revenue {
    type: min
    sql: ${TABLE}.total_revenue ;;
  }

  measure: control_revenue {
    type: min
    sql: ${TABLE}.control_revenue ;;
  }

  measure: treated_revenue {
    type: min
    sql: ${TABLE}.treated_revenue ;;
  }

  measure: li_fee {
    label: "LI FEE"
    type: sum
    sql: ${TABLE}.LI_FEE ;;
  }
}
