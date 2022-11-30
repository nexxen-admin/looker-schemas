view: spearad_fifa_view {
  derived_table: {
    sql: With Base_SpearAD_Data as (
  Select
        sa.Channel,
        sa.bidder,
        bm.bidder_name,
        bm.bidder_group,
        sgm.country_code,
        dig.country_name,
        dig.sales_region as geo_region,
        sum(case when sa.event_date = current_date()-1 then sa.bidrequests else 0 end) as Requests_Y,
        sum(case when sa.event_date = current_date()-2 then sa.bidrequests else 0 end) as Requests_YM1,
        sum(case when sa.event_date = current_date()-1 then sa.bidresponses else 0 end) as bids_Y,
        sum(case when sa.event_date = current_date()-2 then sa.bidresponses else 0 end) as bids_YM1,
        sum(case when sa.event_date = current_date()-1 then sa.impressions else 0 end) as Impressions_Y,
        sum(case when sa.event_date = current_date()-2 then sa.impressions else 0 end) as Impressions_YM1,
        sum(case when sa.event_date = current_date()-1 then sa.revenue else 0 end) as Revenue_Y,
        sum(case when sa.event_date = current_date()-2 then sa.revenue else 0 end) as Revenue_YM1
  From bi.svc_di_spearad_FIFA sa
    left outer join bi.svc_di_Spearad_Bidder_Mapping bm on bm.bidder_name = sa.bidder
    left outer join bi.svc_di_spearad_geo_mapping sgm on sgm.country = sa.country
    left outer join bi.svc_di_geo_classification dig on dig.country_code = sgm.country_code
  Where sa.event_date >= current_date()-2
    and sa.event_date < current_date()
 Group  by  1, 2, 3, 4, 5, 6, 7
 ),

 Agg_data as (
      Select ad.channel,
        ad.bidder_group,
        ad.country_code,
        ad.country_name,
        ad.geo_region,
        bm.placement_id,
        max(ad.Requests_Y) as Requests_Y,
        max(ad.Requests_YM1) as Requests_YM1,
        sum(ad.bids_Y) as bids_Y,
        sum(ad.bids_YM1) as bids_YM1,
        sum(ad.Impressions_Y) as Impressions_Y,
        sum(ad.Impressions_YM1) as Impressions_YM1,
        sum(ad.Revenue_Y) as Revenue_Y,
        sum(ad.Revenue_YM1) as Revenue_YM1
      From Base_SpearAD_Data ad
      left outer join (select bidder_Group, placement_id
                From bi.svc_di_Spearad_Bidder_Mapping
                Group by 1, 2) BM on bm.bidder_group = ad.bidder_group
      Group by 1, 2, 3, 4, 5, 6
      ),

Spearad_Final as (
      Select bidder_group as placement,
        placement_id,
        country_code,
        country_name,
        geo_region,
        sum(Requests_Y) as Requests_Y,
        sum(Requests_YM1) as Requests_YM1,
        sum(bids_Y) as Bids_Y,
        sum(bids_YM1) as Bids_YM1,
        sum(Impressions_Y) as Impressions_Y,
        sum(Impressions_YM1) as Impressions_YM1,
        sum(Revenue_Y) as SpearAd_Revenue_Y,
        sum(Revenue_YM1) as SpearAd_Revenue_YM1
      From Agg_data
      Group by 1, 2, 3, 4, 5
),

 Unruly_Base as (
      Select   sp.publisher_id,
        sp.publisher_name,
        spl.placement_name as Placement_Name_OG,
        spl.placement_id as Placement_ID_OG,
        case when spl.placement_id = '251457' then 'FIFA SpearAds App'
          when spl.placement_id = '253414' then 'FIFA SpearAds Site'
          else spl.placement_name end as placement_name,  --Changing Vast placement so that it can align with SpearAd
        Case when ad.media_id = '251457' then '253646'
          when ad.media_id = '253414' then '253646'
          else spl.placement_id end as placement_id,      --Changing Vast placement so that it can align with SpearAd
        ad.country_code,
        dig.country_name,
        dig.sales_region as geo_region,
        Case when ad.pub_id = '105362' then ad.rx_device_type
          when ad.media_id in ('253821','253822') then 'ctv' else 'non-ctv' end as Device_Type,
        Case when ad.pub_id = '105362' then ad.rx_imp_type else 'video' end as Imp_Type,
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
        left outer join bi.svc_di_geo_classification dig on dig.country_code = ad.country_code
      Where NEW_TIME(ad.event_time, 'America/New_York', 'UTC') >= current_date()-2
        and NEW_TIME(ad.event_time, 'America/New_York', 'UTC') < current_date()
       and ad.rx_ssp_name ilike 'rmp%'
       and ad.pub_id in ('105254','105362')
       and (ad.rx_request_status in ('nodsp','nodspbids','bidresponse')
         or ad.rx_request_status is NULL)
      Group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
      ),

Unruly_Final as (
      Select publisher_id,
        publisher_name,
        placement_name,
        placement_id,
        country_code,
        country_name,
        geo_region,
        device_type,
        imp_type,
        sum(case when publisher_id = '105362' Then Requests_Y else 0 end) as Requests_Y,
        sum(case when publisher_id = '105362' Then Requests_YM1 else 0 end) as Requests_YM1,
        sum(case when publisher_id = '105362' or placement_id_og in ('251457','253414') Then Bids_Y else 0 end) as Bids_Y,
        sum(case when publisher_id = '105362' or placement_id_og in ('251457','253414') Then Bids_YM1 else 0 end) as Bids_YM1,
        sum(case when publisher_id = '105362' or placement_id_og in ('251457','253414') Then Impressions_Y else 0 end) as Impressions_Y,
        sum(case when publisher_id = '105362' or placement_id_og in ('251457','253414') Then Impressions_YM1 else 0 end) as Impressions_YM1,
        sum(revenue_Y) as revenue_Y,
        sum(revenue_YM1) as revenue_YM1
From Unruly_Base
  Group by 1, 2, 3, 4, 5, 6, 7, 8, 9

)

      Select u.publisher_id,
        u.publisher_name,
        u.placement_name,
        u.placement_id,
        u.device_type,
        u.imp_type,
        coalesce(u.country_name,sa.country_name) as Country,
        coalesce(u.geo_region,sa.geo_region) as Geo_Region,
        sum(coalesce(sa.requests_y,0)) + sum(coalesce(u.requests_y,0)) as requests_y,
        sum(coalesce(sa.requests_ym1,0)) + sum(coalesce(u.requests_ym1,0)) as requests_ym1,
        sum(coalesce(sa.Bids_Y,0)) + sum(coalesce(u.Bids_Y,0)) as Bids_Y,
        sum(coalesce(sa.Bids_YM1,0)) + sum(coalesce(u.Bids_YM1,0)) as Bids_YM1,
        sum(coalesce(sa.Impressions_Y,0)) + sum(coalesce(u.Impressions_Y,0)) as Impressions_Y,
        sum(coalesce(sa.Impressions_YM1,0)) + sum(coalesce(u.Impressions_YM1,0)) as Impressions_YM1,
       sum(u.revenue_Y) as revenue_Y,
       sum(u.revenue_YM1) as revenue_YM1
      From Unruly_Final U
        full join spearad_final sa on sa.placement_id::varchar = u.placement_id::varchar
                    and sa.country_code = u.country_code
      Where u.placement_id is not NULL
       and (sa.requests_y > 0 or u.requests_y > 0)
      Group by 1, 2, 3, 4, 5, 6, 7, 8
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

  dimension: Country {
    type: string
    label: "Country"
    sql: ${TABLE}.Country ;;
  }

  dimension: Geo_Region {
    type: string
    label: "Geo Region"
    sql: ${TABLE}.Geo_Region ;;
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
      imp_type,
      Country,
      Geo_Region
    ]
  }
}
