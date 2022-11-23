view: spearad_fifa_view {
  derived_table: {
    sql: With Base_SpearAD_Data as (
      Select --delivery_date::date as event_date,
        bdv.Channel,
        bdv.bid_cfg_id,
        bm.bidder_name,
        bm.bidder_group,
        sum(case when bdv.delivery_date = current_date()-1 then bdv.bids else 0 end) as Requests_Y,
        sum(case when bdv.delivery_date = current_date()-2 then bdv.bids else 0 end) as Requests_YM1,
        sum(case when bdv.delivery_date = current_date()-1 and nbr=1001 then bids else 0 end) + sum(case when bdv.delivery_date = current_date()-1 and nbr=1002 then bids else 0 end) as bids_Y,
        sum(case when bdv.delivery_date = current_date()-2 and nbr=1001 then bids else 0 end) + sum(case when bdv.delivery_date = current_date()-2 and nbr=1002 then bids else 0 end) as bids_YM1,
        sum(case when bdv.delivery_date = current_date()-1 then bdv.impressions else 0 end) as Impressions_Y,
        sum(case when bdv.delivery_date = current_date()-2 then bdv.impressions else 0 end) as Impressions_YM1,
        sum(case when bdv.delivery_date = current_date()-1 then bdv.impression_revenue else 0 end) as Revenue_Y,
        sum(case when bdv.delivery_date = current_date()-2 then bdv.impression_revenue else 0 end) as Revenue_YM1
      From spearad.bidblock_daily_view bdv
        left outer join bi.svc_di_Spearad_Bidder_Mapping bm on bm.bidder_id = bdv.bid_cfg_id
      Where bdv.delivery_date >= current_date()-2
        and bdv.delivery_date < current_date()
        and bdv.channel_id in ('844','845','846','750')
        and bdv.buyer_account_id = 56
        and bdv.bid_cfg_id != 0
      Group by 1, 2, 3, 4),

Agg_data as (
      Select ad.channel,
        ad.bidder_group,
        bm.placement_id,
        max(ad.Requests_Y) as Requests_Y,
        max(ad.Requests_YM1) as Requests_YM1,
        sum(ad.bids_Y) as bids_Y,
        sum(ad.bids_YM1) as bids_YM1,
        sum(ad.Impressions_Y) as Impressions_Y,
        sum(ad.Impressions_YM1) as Impressions_YM1,
        sum(ad.Revenue_Y)/1000000 as Revenue_Y,
        sum(ad.Revenue_YM1)/1000000 as Revenue_YM1
      From Base_SpearAD_Data ad
      left outer join (select bidder_Group, placement_id
                From bi.svc_di_Spearad_Bidder_Mapping
                Group by 1, 2) BM on bm.bidder_group = ad.bidder_group
      Group by 1, 2, 3
      ),

Spearad_Final as (
      Select bidder_group as placement,
        placement_id,
        sum(Requests_Y) as Requests_Y,
        sum(Requests_YM1) as Requests_YM1,
        sum(bids_Y) as Bids_Y,
        sum(bids_YM1) as Bids_YM1,
        sum(Impressions_Y) as Impressions_Y,
        sum(Impressions_YM1) as Impressions_YM1,
        sum(Revenue_Y) as SpearAd_Revenue_Y,
        sum(Revenue_YM1) as SpearAd_Revenue_YM1
      From Agg_data
      Group by 1, 2
      ),

 Unruly_Final as (
      Select   sp.publisher_id,
        sp.publisher_name,
        spl.placement_name,
        spl.placement_id,
        Case when ad.media_id in ('253822','253646','253821','253645') then NULL else ad.rx_device_type end as Device_Type,
        Case when ad.media_id in ('253822','253646','253821','253645') then NULL else ad.rx_imp_type end as Imp_Type,
        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-1
            and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()
            THEN ad.requests else 0 end) as Requests_Y,
      sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-2
            and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()-1
            THEN ad.requests else 0 end) as Requests_YM1,
        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-1
            and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()
            THEN ad.responses else 0 end) as Bids_Y,
        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-2
            and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()-1
            THEN ad.responses else 0 end) as Bids_YM1,
        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-1
           and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()
         THEN ad.impression_pixel else 0 end) as Impressions_Y,
        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-2
           and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()-1
           THEN ad.impression_pixel else 0 end) as Impressions_YM1,
        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-1
           and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()
           THEN ad.revenue else 0 end) as revenue_Y,
        sum(case when NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-2
            and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()-1
            THEN ad.revenue else 0 end) as revenue_YM1
      From andromeda.ad_data_hourly ad
        left outer join andromeda.rx_dim_supply_placement spl on spl.placement_id = ad.media_id
        left outer join andromeda.rx_dim_supply_publisher_traffic_source spts on spts.pub_ts_id = spl.pub_ts_id
        left outer join andromeda.rx_dim_supply_publisher sp on sp.publisher_id = spts.publisher_id
      Where NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-2
        and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()
       and ad.rx_ssp_name ilike 'rmp%'
       and ad.pub_id in ('105254','105362')
       and (ad.rx_request_status in ('nodsp','nodspbids','bidresponse')
         or ad.rx_request_status is NULL)
      Group by 1, 2, 3, 4, 5, 6
      )

      Select u.publisher_id,
        u.publisher_name,
        u.placement_name,
        u.placement_id,
        u.device_type,
        u.imp_type,
        coalesce(sa.requests_y,u.requests_y) as requests_y,
        coalesce(sa.requests_ym1,u.requests_ym1) as requests_ym1,
        coalesce(sa.Bids_Y,u.Bids_Y) as Bids_Y,
        coalesce(sa.Bids_YM1,u.Bids_YM1) as Bids_YM1,
        coalesce(sa.Impressions_Y,u.Impressions_Y) as Impressions_Y,
        coalesce(sa.Impressions_YM1,u.Impressions_YM1) as Impressions_YM1,
        u.revenue_Y,
        u.revenue_YM1
      From Unruly_Final U
        full join spearad_final sa on sa.placement_id::varchar = u.placement_id::varchar
      Where u.placement_id is not NULL
       and (sa.requests_y > 0 or u.requests_y > 0)
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: publisher_id {
    type: string
    label: "Pub ID"
    sql: ${TABLE}.publisher_id ;;
  }

  dimension: publisher_name {
    type: string
    label: "Publisher"
    sql: ${TABLE}.publisher_name ;;
  }

  dimension: placement_name {
    type: string
    label: "Placement"
    sql: ${TABLE}.placement_name ;;
  }

  dimension: placement_id {
    type: string
    label: "Placement ID"
    sql: ${TABLE}.placement_id ;;
  }

  dimension: device_type {
    type: string
    label: "Device Type"
    sql: ${TABLE}.device_type ;;
  }

  dimension: imp_type {
    type: string
    label: "Imp Type"
    sql: ${TABLE}.imp_type ;;
  }

  measure: requests_y {
    type: sum
    label: "Requests Yesterday"
    value_format: "#,##0"
    sql: ${TABLE}.requests_y ;;
  }

  measure: requests_ym1 {
    type: sum
    label: "Requests Previous Day"
    value_format: "#,##0"
    sql: ${TABLE}.requests_ym1 ;;
  }

  measure: bids_y {
    type: sum
    label: "Bids Yesterday"
    value_format: "#,##0"
    sql: ${TABLE}.Bids_Y ;;
  }

  measure: bids_ym1 {
    type: sum
    label: "Bids Previous Day"
    value_format: "#,##0"
    sql: ${TABLE}.Bids_YM1 ;;
  }

  measure: impressions_y {
    type: sum
    label: "Imps Yesterday"
    value_format: "#,##0"
    sql: ${TABLE}.Impressions_Y ;;
  }

  measure: impressions_ym1 {
    type: sum
    label: "Imps Previous Day"
    value_format: "#,##0"
    sql: ${TABLE}.Impressions_YM1 ;;
  }

  measure: revenue_y {
    type: sum
    label: "Revenue Yesterday"
    value_format: "$#,##0"
    sql: ${TABLE}.revenue_Y ;;
  }

  measure: revenue_ym1 {
    type: sum
    label: "Revenue Previous Day"
    value_format: "$#,##0"
    sql: ${TABLE}.revenue_YM1 ;;
  }

  set: detail {
    fields: [
      publisher_id,
      publisher_name,
      placement_name,
      placement_id,
      device_type,
      imp_type
    ]
  }
}
