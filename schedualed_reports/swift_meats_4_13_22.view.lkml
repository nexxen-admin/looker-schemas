view: swift_meats_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT  date::date as "Date",
        TRIM(BOTH '''' FROM dma.dma_name) as "DMA",
        add2.flight_id as "Flight ID",
        creative_id as "Creative ID",
        CASE WHEN flight_id IN (4205796, 4226106, 4243836, 4279686, 4316636, 4431846, 4485696, 4512336) THEN 'CTV + BT'
                            ELSE 'All Screen Video Added Value' END AS "Placement Name",
        CASE WHEN creative_id IN (8455446, 8487166, 8455476, 8487206) THEN '22-SWIFT-0008_Anthem-Resized_30s_1080p'
           WHEN creative_id IN (8481136, 8487146, 8481146, 8487196) THEN 'Swift More'
           WHEN creative_id IN (8552536, 8552546,8638516,8552546) THEN 'SWIF2204H'
           WHEN creative_id IN(8487136, 8638526, 8638516, 8638526) THEN 'Gamer'
           WHEN creative_id IN (8455436, 8455456) THEN 'SWIFT_Anthem2021_15s_1080p'
             ELSE 'SWIFT_Family Future2101_30s_1080p' END AS "Creative Name",
        st.screen_type_name as "Device Type",
        SUM(impressions) as "Impressions",
        SUM(impressions) as "Video Starts",
        SUM(clicks) as "Clicks",
        SUM(completions) as "Completions",
        SUM(conversions) as "Conversions",
        CASE WHEN flight_id IN (4205796, 4226106, 4243836, 4279686, 4316636,4431846, 4485696, 4512336) THEN (SUM(impressions)/1000) * 21.75
                         ELSE 0 END AS "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.dma dma on dma.dma_code = add2.dma
  left outer join dwh.screen_type st on add2.screen_type = st.screen_type_code
WHERE date >= CURRENT_DATE()-7
  AND  date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  and add2.flight_id IN (4205796,4226106,4243836,4279686,
                     4205826,4226126,4243846,4279706,
                     4316636,4316646,4431846,4431856, 4485696, 4485716, 4512336, 4512346)
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
    html: {{ rendered_value | date: "%m-%d-%Y" }} ;;
  }

  dimension: dma {
    type: string
    label: "DMA"
    sql: ${TABLE}.DMA ;;
  }

  dimension: flight_id {
    type: number
    label: "Flight ID"
    sql: ${TABLE}."Flight ID" ;;
  }

  dimension: creative_id {
    type: number
    label: "Creative ID"
    sql: ${TABLE}."Creative ID" ;;
  }

  dimension: placement_name {
    type: string
    label: "Placement Name"
    sql: ${TABLE}."Placement Name" ;;
  }

  dimension: creative_name {
    type: string
    label: "Creative Name"
    sql: ${TABLE}."Creative Name" ;;
  }

  dimension: device_type {
    type: string
    label: "Device Type"
    sql: ${TABLE}."Device Type" ;;
  }

  dimension: impressions {
    type: number
    label: "Impressions"
    sql: ${TABLE}.Impressions ;;
  }

  dimension: video_starts {
    type: number
    label: "Video Starts"
    sql: ${TABLE}."Video Starts" ;;
  }

  dimension: clicks {
    type: number
    label: "Clicks"
    sql: ${TABLE}.Clicks ;;
  }

  dimension: completions {
    type: number
    label: "Completions"
    sql: ${TABLE}.Completions ;;
  }

  dimension: conversions {
    type: number
    label: "Conversions"
    sql: ${TABLE}.Conversions ;;
  }

  dimension: spend {
    type: number
    value_format: "#,##0.00"
    label: "Spend"
    sql: ${TABLE}.Spend ;;
  }

  set: detail {
    fields: [
      date,
      dma,
      flight_id,
      creative_id,
      placement_name,
      creative_name,
      device_type,
      impressions,
      video_starts,
      clicks,
      completions,
      conversions,
      spend
    ]
  }
}
