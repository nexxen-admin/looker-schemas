view: pointsbet_february {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: With CPM_Details as (
      select flight_id,
        case when flight_id in ('4223956','4223936') then 22.5
          else 32 end as CPM
      From dwh.campaign
      Where flight_id in ('4223956','4223936','4223946','4223976')
      ),

      Daily_details as (
      Select ad.date::date as event_date,
        ad.flight_id,
        sf.target_details as 'Campaign',
        'Tremor Video' as Channel,
        '' as Placeholder1,
        '0' as Placeholder2,
        'TPB-Hockey' as Creative,
        concat(cr.duration,'s') as Creative_Duration,
        sum(impressions) as Impressions,
        sum(impressions) as Views,
        sum(progress100) as Completed_Views,
        sum(clicks) as Clicks
      From dwh.ad_data_daily ad
        inner join dwh.campaign c on c.flight_id = ad.flight_id
              and c.flight_id in ('4223956','4223936','4223946','4223976')
        left outer join andromeda.sf_flight sf on sf.flight_number = c.flight_number
        left outer join dwh.creative cr on cr.id = ad.creative_id
        left outer join cpm_details cpm on cpm.flight_id = ad.flight_id
      where date::date >= '2022-02-01'
        and date::date < current_date()
        and data_type = 'AD_DATA'
      Group by 1, 2, 3, 4, 5, 6, 7, 8
      )

      Select dd.event_date as 'Day',
        dd.Campaign,
        dd.Channel,
        dd.Impressions,
        dd.Views,
        dd.Completed_Views as "Completed Views",
        (dd.impressions/1000) * cpm.cpm as Cost,
        case when dd.flight_id in ('4223946','4223976') then ''
          else dd.Clicks::varchar end as Clicks,
        dd.Placeholder1 as "Video Play 100",
        dd.Placeholder2 as ID,
        dd.Creative,
        dd.Creative_Duration as "Size (Length)"
      From Daily_details dd
        left outer join CPM_Details cpm on cpm.flight_id = dd.flight_id
      Order by 1, 2, 12
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: day {
    type: date
    sql: ${TABLE}."Day" ;;
    html: {{ rendered_value | date: "%F" }} ;;
  }

  dimension: campaign {
    type: string
    sql: ${TABLE}.Campaign ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.Channel ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.Impressions ;;
  }

  dimension: views {
    type: number
    sql: ${TABLE}.Views ;;
  }

  dimension: completed_views {
    type: number
    label: "Completed Views"
    sql: ${TABLE}."Completed Views" ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.Cost ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.Clicks ;;
  }

  dimension: video_play_100 {
    type: string
    label: "Video Play 100"
    sql: ${TABLE}."Video Play 100" ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: creative {
    type: string
    sql: ${TABLE}.Creative ;;
  }

  dimension: size_length {
    type: string
    label: "Size (Length)"
    sql: ${TABLE}."Size (Length)" ;;
  }

  set: detail {
    fields: [
      day,
      campaign,
      channel,
      impressions,
      views,
      completed_views,
      cost,
      clicks,
      video_play_100,
      id,
      creative,
      size_length
    ]
  }
}
