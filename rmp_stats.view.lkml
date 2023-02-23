view: rmp_stats {
  derived_table: {
    sql: select
        a.event_date::DATE as Event_Date,
        b.publisher_id as PublisherID,
        b.publisher_name as PublisherName,
        a.placement_id as PlacementID,
        b.placement_name PlacementName,
        initcap(b.DevMgr) as DevMgr,
        initcap(b.OpsMgr) as OpsMgr,
        b.cogs_type as COGS,
        b.display_name TrafficSource,
        a.media_type as MediaType,
        a.imp_type as AdType,
        a.device_type as DeviceType,
        a.requests as Requests,
        a.slot_requests as Slot_Requests,
        a.attempts as Attempts,
        a.slot_attempts as Slot_Attempts,
        a.imp_pixels as Impressions,
        a.impwins as Wins,
        a.clicks as Clicks,
        a.revenue as Revenue,
        a.cost as PubCost,
        a.margin_dol as Margin_Dol,
        a.video_starts as Video_Starts,
        a.video_firsts as Video_Firsts,
        a.video_mids as Video_Mids,
        a.video_thirds as Video_Thirds,
        a.video_completes as Video_Completes,
        a.avg_viewability as Avg_Viewability,
        a.avg_ivt as Avg_IVT

      from

      (select
      coalesce(nw.event_date,rx.event_date) as event_date,
      coalesce(nw.placement_id,rx.placement_id) as placement_id,
      coalesce(nw.media_type,rx.media_type) as media_type,
      coalesce(nw.imp_type,rx.imp_type) as imp_type,
      coalesce(nw.device_type,rx.device_type) as device_type,
      nw.rmp_requests as requests,
      nw.slot_requests as slot_requests,
      nw.rmp_attempts as attempts,
      nw.slot_attempts as slot_attempts,
      nw.impressions as imp_pixels,
      nw.impwins as impwins,
      nw.clicks as clicks,
      nw.revenue as revenue,
      nw.cost as cost,
      nw.margin_dol as margin_dol,
      rx.video_starts as video_starts,
      rx.video_firsts as video_firsts,
      rx.video_mids as video_mids,
      rx.video_thirds as video_thirds,
      rx.video_completes as video_completes,
      rx.avg_viewability,
      rx.avg_ivt

      from

      (select supp.event_time as event_date,
      case when lower(supp.rx_imp_type) = 'display' then 'banner'
      when lower(supp.rx_imp_type) = 'video' then 'video'
      when lower(supp.rx_imp_type) = 'unknown' then '-' else lower(supp.rx_imp_type) end as imp_type,
      case when lower(supp.rx_device_type) = 'display' then 'desktop'
      when lower(supp.rx_device_type) = 'unknown' then '-' else lower(supp.rx_device_type) end as device_type,
      case when lower(supp.rx_media_type) = 'unknown' then '-' else lower(supp.rx_media_type) end as media_type,
      cast(supp.placement_id as varchar) as placement_id,
      sum(supp.pub_requests) as rmp_requests,
      sum(supp.slot_requests) as slot_requests,
      sum(supp.attempts) as rmp_attempts,
      sum(supp.slot_attempts) as slot_attempts,
      sum(supp.impressions) as impressions,
      sum(supp.impswins) as impwins,
      sum(supp.clicks) as clicks,
      sum(supp.revenue) as revenue,
      sum(supp.cost) as cost,
      sum(supp.revenue - supp.cost) as margin_dol
      from  Andromeda.supply_stat_summary_daily supp
      where supp.event_time >= timestampadd(mm,-5,current_date())
      and supp.event_time < current_date()
      and (pub_requests > 0
      or slot_requests > 0
      or attempts > 0
      or slot_attempts > 0
      or impressions > 0
      or impswins > 0
      or clicks > 0
      or revenue > 0
      or cost > 0)
      group by 1,2,3,4,5) nw

      full join

      (select event_time as event_date,
      media_id as placement_id,
      rx_imp_type as imp_type,
      rx_device_type as device_type,
      rx_media_type as media_type,
      sum(video_starts) as video_starts,
      sum(video_first_quartiles) as video_firsts,
      sum(video_midpoints) as video_mids,
      sum(video_third_quartiles) as video_thirds,
      sum(video_completes) as video_completes,
      CASE WHEN sum(requests) > 0
      THEN sum(ias_viewability_score * requests)/sum(requests)
      ELSE NULL END as avg_viewability,
      CASE WHEN sum(requests) > 0
      THEN sum(ias_ivt_rate * requests)/sum(requests)
      ELSE NULL END as avg_ivt
      from Andromeda.ad_data_daily rx
      where event_time >= timestampadd(mm,-5,current_date())
      and event_time < current_date()
      and ((RX_SSP_NAME like 'rmp%'
      and RX_ssp_Name not like 'rmpak%'
      and rx_ssp_name is not NULL)
      or RX_SSP_NAME = 'rhythmone')
      and (video_starts > 0
      or video_first_quartiles > 0
      or video_midpoints > 0
      or video_third_quartiles > 0
      or video_completes > 0 or requests > 0)
      group by 1,2,3,4,5) rx
      on  nw.event_date = rx.event_date
      and nw.placement_id = rx.placement_id
      and nw.media_type = rx.media_type
      and nw.imp_type = rx.imp_type
      and nw.device_type = rx.device_type ) a

      left outer join

      (select cast(pl.placement_id as varchar) as placement_id, pl.placement_name,
      cast(pub2.publisher_id as varchar) as publisher_id, pub2.publisher_name,
      info.cogs_type, b.name as DevMgr, o.name as OpsMgr,tr.display_name
      from Andromeda.rx_DIM_SUPPLY_PLACEMENT pl
      left outer join Andromeda.rx_DIM_SUPPLY_PUBLISHER_TRAFFIC_SOURCE spts on spts.pub_ts_id = pl.pub_ts_id
      left outer join Andromeda.rx_DIM_SUPPLY_PUBLISHER pub2 on pub2.PUBLISHER_ID = spts.PUBLISHER_ID
      left outer join Andromeda.rx_DIM_PUBLISHER_INFO info on pub2.PUBLISHER_ID = info.PUBLISHER_ID
      left outer join Andromeda.rx_DIM_SUPPLY_TRAFFIC_SOURCE tr on spts.traffic_source_id = tr.traffic_source_id
      left outer join Andromeda.rx_DIM_PUBLISHER_BIZDEV_OWNER b on info.bizdev_owner_id = b.user_id
      left outer join Andromeda.rx_DIM_PUBLISHER_OPERATIONS_OWNER o on info.operations_owner_id = o.user_id) b
      on a.placement_id = b.placement_id
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_date {
    type: date
    sql: ${TABLE}.Event_Date ;;
  }

  dimension: publisher_id {
    type: string
    sql: ${TABLE}.PublisherID ;;
  }

  dimension: publisher_name {
    type: string
    sql: ${TABLE}.PublisherName ;;
  }

  dimension: placement_id {
    type: string
    sql: ${TABLE}.PlacementID ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.PlacementName ;;
  }

  dimension: dev_mgr {
    type: string
    sql: ${TABLE}.DevMgr ;;
  }

  dimension: ops_mgr {
    type: string
    sql: ${TABLE}.OpsMgr ;;
  }

  measure: cogs {
    type: sum
    sql: ${TABLE}.COGS ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.TrafficSource ;;
  }

  dimension: media_type {
    type: string
    sql: ${TABLE}.MediaType ;;
  }

  dimension: ad_type {
    type: string
    sql: ${TABLE}.AdType ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.DeviceType ;;
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.Requests ;;
  }

  measure: slot_requests {
    type: sum
    sql: ${TABLE}.Slot_Requests ;;
  }

  measure: attempts {
    type: sum
    sql: ${TABLE}.Attempts ;;
  }

  measure: slot_attempts {
    type: sum
    sql: ${TABLE}.Slot_Attempts ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
  }

  measure: wins {
    type: sum
    sql: ${TABLE}.Wins ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.Clicks ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.Revenue ;;
  }

  measure: pub_cost {
    type: sum
    sql: ${TABLE}.PubCost ;;
  }

  measure: margin_dol {
    type: sum
    sql: ${TABLE}.Margin_Dol ;;
  }

  dimension: video_starts {
    type: number
    sql: ${TABLE}.Video_Starts ;;
  }

  dimension: video_firsts {
    type: number
    sql: ${TABLE}.Video_Firsts ;;
  }

  dimension: video_mids {
    type: number
    sql: ${TABLE}.Video_Mids ;;
  }

  dimension: video_thirds {
    type: number
    sql: ${TABLE}.Video_Thirds ;;
  }

  dimension: video_completes {
    type: number
    sql: ${TABLE}.Video_Completes ;;
  }

  measure: avg_viewability {
    type: sum
    sql: ${TABLE}.Avg_Viewability ;;
  }

  measure: avg_ivt {
    type: sum
    sql: ${TABLE}.Avg_IVT ;;
  }

  set: detail {
    fields: [
      event_date,
      publisher_id,
      publisher_name,
      placement_id,
      placement_name,
      dev_mgr,
      ops_mgr,
      cogs,
      traffic_source,
      media_type,
      ad_type,
      device_type,
      requests,
      slot_requests,
      attempts,
      slot_attempts,
      impressions,
      wins,
      clicks,
      revenue,
      pub_cost,
      margin_dol,
      video_starts,
      video_firsts,
      video_mids,
      video_thirds,
      video_completes,
      avg_viewability,
      avg_ivt
    ]
  }
}
