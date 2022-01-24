view: sql_runner_query {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
  sql: Select c.advertiser_name as "Advertiser Name",
        'Tremor Video' as "Partner Name",
        case when ad.flight_id = '4216686' then '326608812'
          else '325760327' end as "Placement ID",
        date::date as "Date",
        sum(ad.impressions) as "Impressions",
        sum(ad.clicks) as "Clicks",
        sum(case when c.flight_id = '4216676' then ad.Revenue else 0 end) as Cost,
        case when ad.flight_id = '4216686' then 0
          else 19.5 end as "eCPM"
      From dwh.ad_data_hourly ad
        inner join dwh.campaign c on c.flight_id = ad.flight_id
      Where date >= '2022-01-24'
        and date < least(current_date()+1,'2022-04-16')
        and ad.data_type = 'AD_DATA'
        and ad.flight_id in ('4216686','4216676')
        and (ad.impressions > 0 or ad.revenue > 0)
      Group by c.advertiser_name,
        'Tremor Video',
        case when ad.flight_id = '4216686' then '326608812'
          else '325760327' end,
        date::date,
        case when ad.flight_id = '4216686' then 0
          else 19.5 end
      Order by 4, 1, 2, 3
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: advertiser_name {
    type: string
    label: "Advertiser Name"
    sql: ${TABLE}."Advertiser Name" ;;
  }

  dimension: partner_name {
    type: string
    label: "Partner Name"
    sql: ${TABLE}."Partner Name" ;;
  }

  dimension: placement_id {
    type: string
    label: "Placement ID"
    sql: ${TABLE}."Placement ID" ;;
  }

  dimension: date {
    type: date
    sql: ${TABLE}."Date" ;;
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.Impressions ;;
  }

  measure: clicks {
    type: sum
    sql: ${TABLE}.Clicks ;;
  }

  measure: cost {
    type: sum
    sql: ${TABLE}.Cost ;;
  }

  dimension: e_cpm {
    label: "eCPM"
    type: number
    sql: ${TABLE}.eCPM ;;
  }

  set: detail {
    fields: [
      advertiser_name,
      partner_name,
      placement_id,
      date,
      impressions,
      clicks,
      cost,
      e_cpm
    ]
  }
}
