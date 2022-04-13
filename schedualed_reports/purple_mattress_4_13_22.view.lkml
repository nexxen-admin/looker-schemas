view: purple_mattress_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT  date::date as "Date",
        TRIM(BOTH '''' FROM dma.dma_name) as "DMA",
        flight_id as "Flight ID",
        creative_id as "Creative ID",
        CASE WHEN creative_id = 8498866 THEN 'CTV + BT + Zip Targeting (CA)'
           WHEN creative_id  = 8498876 THEN 'CTV + BT + Zip Targeting (CA)'
           WHEN creative_id  = 8498886 THEN 'CTV + BT + Zip Targeting (CA)'
           WHEN creative_id  = 8598896 THEN 'CTV + BT + Zip Targeting (CA)'
             ELSE 'CTV + BT + Zip Targeting (MN)' END AS "Placement Name",
        CASE WHEN creative_id  = 8498866 THEN 'CorteMaderaSleepsCool'
           WHEN creative_id  = 8498876 THEN 'CorteMaderaFeelsLike'
           WHEN creative_id  = 8498886 THEN 'CorteMadera_S_S'
           WHEN creative_id  = 8598896 THEN 'CorteMadera_All3'
           WHEN creative_id  = 8506186 THEN '20210916_Sandwich_16x9_HelloPurpleRetail_15s_MallofAmerica_All3'
           WHEN creative_id  = 8506196 THEN '20210916_Sandwich_16x9_HelloPurpleRetail_15s_MallofAmerica_FeelsLike'
           WHEN creative_id  = 8506206 THEN '20210916_Sandwich_16x9_HelloPurpleRetail_15s_MallofAmerica_SleepsCool'
           ELSE '20210916_Sandwich_16x9_HelloPurpleRetail_15s_MallofAmerica_S_S' END AS "Creative Name",
        SUM(impressions) as "Impressions",
        SUM(impressions) as "Video Starts",
        SUM(clicks) as "Clicks",
        SUM(completions) as "Completions",
        CASE WHEN creative_id  IN (8498866, 8498876, 8498886, 8598896) THEN (SUM(impressions)/1000) * 21.50
             ELSE (SUM(impressions)/1000) * 23.25 END AS "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.dma dma on dma.dma_code = add2.dma
WHERE date >= '2022-03-25'
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  and flight_id IN (4266866, 4277686)
    AND (impressions > 0 or completions > 0 or clicks > 0)
GROUP BY 1,2,3,4,5,6
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
      impressions,
      video_starts,
      clicks,
      completions,
      spend
    ]
  }
}
