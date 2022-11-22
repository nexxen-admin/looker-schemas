view: rust_oleum_fy23_walmart_video_10_04_16 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT date::date as "Date",
       'Rust Oleum FY23 Walmart Video' AS "Campaign Name",
       'AS0095595' AS "Campaign ID",
       c.flight_name AS "Placement Name",
       c.flight_number AS "Placement ID",
       creative_id AS "Creative ID",
       CASE WHEN creative_id = 8643216 THEN 'RO Studio Color Walmart 15 sec'
            WHEN creative_id = 8662286 THEN ' All Screen Custom Creative'
            WHEN creative_id = 8661626 THEN 'CTV Custom Creative'
           ELSE 'RO Studio Color Walmart 6 sec' END AS "Creative Name",
       CASE WHEN c.flight_number = 'F-302557' THEN (SUM(impressions)/1000)*20
            WHEN c.flight_number = 'F-302559' THEN (SUM(impressions)/1000)*21
            WHEN c.flight_number = 'F-302561' THEN (SUM(impressions)/1000)*18
            WHEN c.flight_number = 'F-302563' THEN (SUM(impressions)/1000)*21
            WHEN c.flight_number = 'F-302565' THEN (SUM(impressions)/1000)*21
            WHEN c.flight_number = 'F-302567' THEN (SUM(impressions)/1000)*31
            WHEN c.flight_number = 'F-306018' THEN (SUM(impressions)/1000)*20
            WHEN c.flight_number = 'F-306019' THEN (SUM(impressions)/1000)*21
            WHEN c.flight_number = 'F-306020' THEN (SUM(impressions)/1000)*18
            ELSE (SUM(impressions)/1000)*31 END AS "Spend",
       SUM(impressions) AS "Impressions",
       SUM(clicks) AS "Clicks",
       SUM(impressions) as "Video Views",
       SUM(completions) AS "Completions"
FROM dwh.ad_data_daily add2
  left outer join dwh.campaign c on add2.flight_id = c.flight_id
  left outer join dwh.dma dma on dma.dma_code = add2.dma
  left outer join dwh.screen_type st on add2.screen_type = st.screen_type_code
  left outer join dwh.creative cr on add2.creative_id = cr.id
WHERE date >= '2022-10-01'
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  AND c.buy_type NOT IN ('Direct', 'Programmatic_Guaranteed')
  and c.flight_number IN ('F-302557', 'F-302559', 'F-302561', 'F-302563', 'F-302565', 'F-302567', 'F-302569', 'F-306018 ', 'F-306019', 'F-306020')
  AND (impressions > 0 or completions > 0 or clicks > 0)
GROUP BY 1,2,3,4,5,6,7
ORDER BY 1
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: date
    label: "Date"
    sql: ${TABLE}."Date" ;;
  }

  dimension: campaign_name {
    type: string
    label: "Campaign Name"
    sql: ${TABLE}."Campaign Name" ;;
  }

  dimension: campaign_id {
    type: string
    label: "Campaign ID"
    sql: ${TABLE}."Campaign ID" ;;
  }

  dimension: placement_name {
    type: string
    label: "Placement Name"
    sql: ${TABLE}."Placement Name" ;;
  }

  dimension: placement_id {
    type: string
    label: "Placement ID"
    sql: ${TABLE}."Placement ID" ;;
  }

  dimension: creative_id {
    type: number
    label: "Creative ID"
    sql: ${TABLE}."Creative ID" ;;
  }

  dimension: creative_name {
    type: string
    label: "Creative Name"
    sql: ${TABLE}."Creative Name" ;;
  }

  dimension: spend {
    type: number
    value_format: "#,##0.00"
    label: "Spend"
    sql: ${TABLE}.Spend ;;
  }

  dimension: impressions {
    type: number
    label: "Impressions"
    sql: ${TABLE}.Impressions ;;
  }

  dimension: clicks {
    type: number
    label: "Clicks"
    sql: ${TABLE}.Clicks ;;
  }

  dimension: video_views {
    type: number
    label: "Video Views"
    sql: ${TABLE}."Video Views" ;;
  }

  dimension: completions {
    type: number
    label: "Completions"
    sql: ${TABLE}.Completions ;;
  }

  set: detail {
    fields: [
      date,
      campaign_name,
      campaign_id,
      placement_name,
      placement_id,
      creative_id,
      creative_name,
      spend,
      impressions,
      clicks,
      video_views,
      completions
    ]
  }
}
