view: daily_publisher_report_pluto {
  derived_table: {
    sql: select add2.event_time,pub_id,
      concat(media_id, concat(' - ', placement_name)) AS Placement,
      CASE WHEN ((add2.dsp_deal_type = 'rx') AND (add2.revenue_type = 'thirdparty' or add2.dsp_display_name = 'Amobee')) THEN 'Unruly Curated PMPs'
      WHEN ((add2.dsp_deal_type = 'pub') AND (add2.platformfee_type = 'pub_initiated')) THEN 'Publisher Initiated Deal'
      WHEN ((add2.dsp_deal_type = 'pub') AND (add2.platformfee_type = 'unruly_initiated')) THEN 'Unruly Initiated Deal'
      WHEN (add2.dsp_deal_type = 'pub') THEN 'Publisher Deal'
      ELSE 'Open Market' END AS buying_channel,
      case when rddb.brand ='Multi-Advertiser' then 'Many to Many'
      when rddb.brand <> 'Multi-Advertiser' and adv_cnt.adv_count =1 then '1 to Many'
      when add2.dsp_deal_type='rx' and rddb.brand is null and adv_cnt.adv_count >1 then 'Many to Many'
      when add2.dsp_deal_type ='pub' and adv_cnt.adv_count =1 then '1 to 1'
      when add2.dsp_deal_type ='pub' and adv_cnt.adv_count >1 then 'Many to 1'
      else null end as deal_type,
      add2.rx_deal_id as deal_id,
      add2.rx_device_type as device_type,
      coalesce(case when instr(rdd.deal_description,'$')>10 then left(rdd.deal_description ,instr(rdd.deal_description,'$')-1 ) else rdd.deal_description end,
      case when instr(rdspd.description ,'$')>1 then left(rdspd.description ,instr(rdspd.description,'$')-1 ) else rdspd.description end) as deal_name,
      add2.dsp_display_name as DSP,
      adv_cnt.adv_count as advertiser_count,
      adomain as advertiser,
      sum(requests) as requests,
      sum(impression_pixel) as impressions,
      sum(cogs) as revenue,
      (sum(cogs)/sum(impression_pixel))*1000 as eCPM,
      (sum(ssp_win_price*impression_pixel)/sum(impression_pixel)) as Bid_CPM

      from Andromeda.ad_data_daily add2
      inner join (select add3.event_time, rx_deal_id, count(distinct adomain) adv_count from Andromeda.ad_data_daily add3
      where-- add3.event_time >= :start_date
      --and add3.event_time < :end_date
      --and
      pub_id in ('78614','104062')
      and add3.rx_deal_id is not null
      and impression_pixel >0
      group by 1,2) as adv_cnt on add2.rx_deal_id = adv_cnt.rx_deal_id and add2.event_time = adv_cnt.event_time
      left outer join Andromeda.rx_dim_deal rdd on add2.rx_deal_id = rdd.deal_id_external
      left outer join Andromeda.rx_dim_supply_publisher_deal rdspd on add2.rx_deal_id =rdspd.external_deal_id
      left outer join Andromeda.rx_dim_deal_brand rddb on rdd.brand_id = rddb.id
      where --add2.event_time >=:start_date
      --and add2.event_time < :end_date
      --and
      pub_id in ('78614','104062')
      and add2.impression_pixel >0
      and add2.dsp_display_name <>'Tremor'
      group by 1,2,3,4,5,6,7,8,9,10,11


      UNION


      select add2.event_time, pub_id, concat(media_id, concat(' - ', placement_name)) AS Placement,
      CASE WHEN ((add2.dsp_deal_type = 'rx') AND (add2.revenue_type = 'thirdparty' or add2.dsp_display_name = 'Amobee')) THEN 'Unruly Curated PMPs'
      WHEN ((add2.dsp_deal_type = 'pub') AND (add2.platformfee_type = 'pub_initiated')) THEN 'Publisher Initiated Deal'
      WHEN ((add2.dsp_deal_type = 'pub') AND (add2.platformfee_type = 'unruly_initiated')) THEN 'Unruly Initiated Deal'
      WHEN (add2.dsp_deal_type = 'pub') THEN 'Publisher Deal'
      ELSE 'Open Market' END AS buying_channel,
      null as deal_type,
      null as deal_id,
      add2.rx_device_type as device_type,
      null as deal_name,
      add2.dsp_display_name as DSP,
      null as advertiser_count,
      adomain as advertiser,
      sum(requests) as requests,
      sum(impression_pixel) as impressions,
      sum(cogs) as revenue,
      (sum(cogs)/sum(impression_pixel))*1000 as eCPM,
      (sum(ssp_win_price*impression_pixel)/sum(impression_pixel)) as Bid_CPM
      from Andromeda.ad_data_daily add2
      where --add2.event_time >=:start_date
      --and add2.event_time < :end_date
      --and
      pub_id in ('78614','104062')
      and add2.impression_pixel >0
      and add2.rx_deal_id is null
      and add2.dsp_display_name <> 'Tremor'
      group by 1,2,3,4,5,6,7,8,9,10,11


      union


      select add2.event_time, pub_id,concat(media_id, concat(' - ', placement_name)) AS Placement,
      CASE WHEN ((add2.dsp_deal_type = 'rx') AND (add2.revenue_type = 'thirdparty' or add2.dsp_display_name = 'Amobee')) THEN 'Unruly Curated PMPs'
      WHEN ((add2.dsp_deal_type = 'pub') AND (add2.platformfee_type = 'pub_initiated')) THEN 'Publisher Initiated Deal'
      WHEN ((add2.dsp_deal_type = 'pub') AND (add2.platformfee_type = 'unruly_initiated')) THEN 'Unruly Initiated Deal'
      WHEN (add2.dsp_deal_type = 'pub') THEN 'Publisher Deal'
      ELSE 'Open Market' END AS buying_channel,
      null as deal_type,
      null as deal_id,
      add2.rx_device_type as device_type,
      null as deal_name,
      add2.dsp_display_name as DSP,
      null as advertiser_count,
      adomain as advertiser,
      sum(requests) as requests,
      sum(impression_pixel) as impressions,
      sum(cogs) as revenue,
      (sum(cogs)/sum(impression_pixel))*1000 as eCPM,
      (sum(ssp_win_price*impression_pixel)/sum(impression_pixel)) as Bid_CPM
      from Andromeda.ad_data_daily add2
      where --add2.event_time >=:start_date
      --and add2.event_time < :end_date
      --and
      pub_id in ('78614','104062')
      and add2.impression_pixel >0
      and add2.dsp_display_name = 'Tremor'
      and (add2.dsp_deal_type <>'pub' or add2.dsp_deal_type is null)
      group by 1,2,3,4,5,6,7,8,9,10,11


      union


      select add2.event_time, pub_id, concat(media_id, concat(' - ', placement_name)) AS Placement,
      CASE WHEN ((add2.dsp_deal_type = 'rx') AND (add2.revenue_type = 'thirdparty' or add2.dsp_display_name = 'Amobee')) THEN 'Unruly Curated PMPs'
      WHEN ((add2.dsp_deal_type = 'pub') AND (add2.platformfee_type = 'pub_initiated')) THEN 'Publisher Initiated Deal'
      WHEN ((add2.dsp_deal_type = 'pub') AND (add2.platformfee_type = 'unruly_initiated')) THEN 'Unruly Initiated Deal'
      WHEN (add2.dsp_deal_type = 'pub') THEN 'Publisher Deal'
      ELSE 'Open Market' END AS buying_channel,
      case when rddb.brand ='Multi-Advertiser' then 'Many to Many'
      when rddb.brand <> 'Multi-Advertiser' and adv_cnt.adv_count =1 then '1 to Many'
      when add2.dsp_deal_type='rx' and rddb.brand is null and adv_cnt.adv_count >1 then 'Many to Many'
      when add2.dsp_deal_type ='pub' and adv_cnt.adv_count =1 then '1 to 1'
      when add2.dsp_deal_type ='pub' and adv_cnt.adv_count >1 then 'Many to 1'
      else null end as deal_type,
      add2.rx_deal_id as deal_id,
      add2.rx_device_type as device_type,
      coalesce(case when instr(rdd.deal_description,'$')>10 then left(rdd.deal_description ,instr(rdd.deal_description,'$')-1 ) else rdd.deal_description end,
      case when instr(rdspd.description ,'$')>1 then left(rdspd.description ,instr(rdspd.description,'$')-1 ) else rdspd.description end) as deal_name,
      add2.dsp_display_name as DSP,
      adv_cnt.adv_count as advertiser_count,
      adomain as advertiser,
      sum(requests) as requests,
      sum(impression_pixel) as impressions,
      sum(cogs) as revenue,
      (sum(cogs)/sum(impression_pixel))*1000 as eCPM,
      (sum(ssp_win_price*impression_pixel)/sum(impression_pixel)) as Bid_CPM
      from Andromeda.ad_data_daily add2
      inner join (select add3.event_time, rx_deal_id, count(distinct adomain) adv_count from Andromeda.ad_data_daily add3
      where --add3.event_time >=:start_date
      --and add3.event_time < :end_date
      --and
      pub_id in ('78614','104062')
      and add3.rx_deal_id is not null
      and impression_pixel >0
      group by 1,2) as adv_cnt on add2.rx_deal_id = adv_cnt.rx_deal_id and add2.event_time = adv_cnt.event_time
      left outer join Andromeda.rx_dim_deal rdd on add2.rx_deal_id = rdd.deal_id_external
      left outer join Andromeda.rx_dim_supply_publisher_deal rdspd on add2.rx_deal_id =rdspd.external_deal_id
      left outer join Andromeda.rx_dim_deal_brand rddb on rdd.brand_id = rddb.id
      where --add2.event_time >=:start_date
      --and add2.event_time < :end_date
      --and
      pub_id in ('78614','104062')
      and add2.impression_pixel >0
      and add2.dsp_display_name = 'Tremor'
      and add2.dsp_deal_type ='pub'
      group by 1,2,3,4,5,6,7,8,9,10,11
      order by 1,2,6,4,8
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: event_time {
    type: time
    sql: ${TABLE}.event_time ;;
  }

  dimension: buying_channel {
    type: string
    sql: ${TABLE}.buying_channel ;;
  }

  dimension: deal_type {
    type: string
    sql: ${TABLE}.deal_type ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: deal_id {
    type: string
    sql: case when ${TABLE}.deal_id is null AND ${TABLE}.deal_name is null AND ${TABLE}.buying_channel='Open Market' then 'Open Market'
      else ${TABLE}.deal_id end ;;
  }

  dimension: pub_id {
    type: string
    sql: ${TABLE}.pub_id ;;
  }

  dimension: deal_name {
    type: string
    sql: case when ${TABLE}.deal_id is null AND ${TABLE}.deal_name is null AND ${TABLE}.buying_channel='Open Market' then 'Open Market'
      else ${TABLE}.deal_name end ;;
  }

  dimension: dsp {
    type: string
    sql: ${TABLE}.DSP ;;
  }

  dimension: Placement {
    type: string
    sql: ${TABLE}.Placement ;;
  }

  dimension: advertiser_count {
    type: number
    sql: ${TABLE}.advertiser_count ;;
  }

  dimension: advertiser {
    type: string
    sql: ${TABLE}.advertiser ;;
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

  measure: e_cpm {
    type: sum
    sql: ${TABLE}.eCPM ;;
  }

  measure: bid_cpm {
    type: sum
    sql: ${TABLE}.Bid_CPM ;;
  }

  set: detail {
    fields: [
      event_time_time,
      pub_id,
      buying_channel,
      deal_type,
      deal_id,
      device_type,
      deal_name,
      dsp,
      advertiser_count,
      advertiser,
      requests,
      impressions,
      revenue,
      e_cpm,
      bid_cpm
    ]

  }
}
