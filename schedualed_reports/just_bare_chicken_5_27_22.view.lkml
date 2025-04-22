view: just_bare_chicken_5_27_22 {
  derived_table: {
    sql: SELECT  date::date as "Date",
        TRIM(BOTH '''' FROM dma.dma_name) as "DMA",
        flight_id as "Flight ID",
        CASE WHEN flight_id IN (4408216, 4408226, 4408236, 4489126) THEN 'All Screen 1% AV (Case Ready)'
             WHEN flight_id IN (4455096, 4455126) THEN 'All Screen 1% AV (Prepared Foods)'
             WHEN flight_id IN (4320346, 4408146, 4408166, 4408186, 4489116) THEN 'All Screen OTT + BT + Zip Targeting (Case Ready)'
             WHEN flight_id IN (4455066, 4455076) THEN 'All Screen OTT + BT + Zip Targeting (Prepared Foods)'
             WHEN flight_id = 4494706 THEN 'All Screen Video Added Value Impressions (Case Ready)'
             WHEN flight_id IN (4320336, 4408076, 4408086, 4408096, 4489096) THEN 'CTV + BT + Zip Targeting (Case Ready)'
             WHEN flight_id IN (4454156, 4454226) THEN 'CTV + BT + Zip Targeting (Prepared Foods)'
             WHEN flight_id IN (4408246, 4408256, 4408266, 4489106) THEN 'CTV 1% Added Value (Case Ready)'
              ELSE 'CTV 1% Added Value (Prepared Foods)' END AS "Placement Name",
        CASE WHEN flight_id IN (4320336, 4320346, 4408076, 4408146, 4408246, 4408216, 4408086, 4408166, 4408256,
                      4408226, 4408096, 4408186, 4408266, 4408236, 4494706, 4489096, 4489116, 4489106, 4489126) THEN 'BARE2202_TheQuestion_30'
             WHEN flight_id IN (4454156, 4455066, 4455176, 4455096, 4454226, 4455076, 4455356, 4455126) THEN 'BARE2203_RealityCheck_30_HD_Streaming'
              ELSE 'SPIL000I009H_FRESH_CB' END as "Creative Name",
        st.screen_type_name as "Device Type",
        SUM(impressions) as "Impressions",
        SUM(impressions) as "Video Starts",
        SUM(clicks) as "Clicks",
        SUM(completions) as "Completions",
        SUM(conversions) as "Conversions",
        CASE WHEN flight_id IN(4320336, 4320346, 4408076, 4408146, 4408086, 4408166, 4408096, 4408186, 4454156, 4455066, 4454226, 4455076, 4489096, 4489116) THEN (SUM(impressions)/1000) * 21.75
          ELSE 0 END AS "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.dma dma on dma.dma_code = add2.dma
  left outer join dwh.screen_type st on add2.screen_type = st.screen_type_code
WHERE date >= CURRENT_DATE()-7
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  and flight_id IN (4408076,4408146,4408246,4408216,4408086,4408166,4408256,4408226,4408096,4408186,4408266,4408236,4454156,4455066,4455176,4455096,
          4454226,4455076,4455356,4455126,4494706,4489096,4489116,4489106,4489126,4320346,4320336)
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
    html: {{ rendered_value | date: "%m-%d-%Y" }};;
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
