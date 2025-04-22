view: kiolbassa_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT  date::date as "Date",
        TRIM(BOTH '''' FROM dma.dma_name) as "DMA",
        flight_id as "Flight ID",
        creative_id as "Creative ID",
        CASE WHEN flight_id IN (4272266, 4339316, 4409016) THEN 'CTV + BT + GT'
             WHEN flight_id = 4409026 THEN 'CTV Added Value'
             ELSE 'All Screen Video Added Value' END AS "Placement Name",
        CASE WHEN creative_id = 8501336 THEN 'Kiolbassa_Brand_30_Legacy_1280x720'
           ELSE 'Kiolbassa_Brand_30_KeepItSimple_1280x720' END AS "Creative Name",
        st.screen_type_name as "Device Type",
        SUM(impressions) as "Impressions",
        SUM(impressions) as "Video Starts",
        SUM(clicks) as "Clicks",
        SUM(completions) as "Completions",
        SUM(conversions) as "Conversions",
        CASE WHEN flight_id IN (4272266, 4339316, 4409016) THEN (SUM(impressions)/1000) * 21.50 ELSE 0 END AS "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.dma dma on dma.dma_code = add2.dma
  left outer join dwh.screen_type st on add2.screen_type = st.screen_type_code
WHERE date >= CURRENT_DATE()-7
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  and flight_id IN(4272266, 4339316, 4409016, 4409026, 4409036)
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
