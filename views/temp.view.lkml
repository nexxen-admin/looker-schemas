view: sql_runner_query {
  derived_table: {
    sql: Select c.advertiser_name as "Advertiser Name",
        'Tremor Video' as "Partner Name",
        case when ad.flight_id = '4216686' then '326608812'
           else '325760327' end as "Placement ID",
        date::date as 'Date',
        sum(ad.impressions) as Impressions,
        sum(ad.clicks) as Clicks,
        sum(ad.Revenue) as Cost,
        (sum(ad.revenue) / sum(ad.impressions)) * 1000 as eCPM
      From dwh.ad_data_daily ad
        inner join dwh.campaign c on c.flight_id = ad.flight_id
      Where date >= '2022-01-24'
        and date < least(current_date(),'2022-04-16')
        and ad.data_type = 'AD_DATA'
        and ad.flight_id in ('4216686','4216676')
        and (ad.impressions > 0 or ad.revenue > 0)
      Group by 1, 2, 3, 4
      Order by 1, 2, 3, 4
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

  dimension: impressions {
    type: number
    sql: ${TABLE}.Impressions ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.Clicks ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.Cost ;;
  }

  dimension: e_cpm {
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
