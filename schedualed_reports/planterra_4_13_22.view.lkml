view: planterra_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT  date::date as "Date",
        TRIM(BOTH '''' FROM dma.dma_name) as "DMA",
        flight_id as "Flight ID",
        CASE WHEN flight_id IN (4245316, 4275656) THEN 'CTV + BT + Zip Targeting'
           WHEN flight_id IN (4245436, 4275676) THEN 'All Screen Video OTT + BT + Zip Targeting'
           WHEN flight_id = 4245456 THEN 'CTV Added Value'
           WHEN flight_id = 4245446 THEN 'All Screen Video Added Value'
           WHEN flight_id IN (4298766, 4306486, 4334336) THEN 'CTV + Exclusion List + BT + Zip Targeting (Suburban Sam & Suzy)'
           WHEN flight_id IN (4298726, 4307346, 4334346) THEN 'All Screen Video + FEP + BT + Zip Targeting (Suburban Sam & Suzy)'
           WHEN flight_id = 4298786 THEN 'CTV + Exclusion List + BT + Zip Targeting (All In Alicia)'
             ELSE 'All Screen Video + FEP + BT + Zip Targeting (All In Alicia)' END AS "Placement Name",
        'Ozo_Chicken_3009_16x9' as "Creative Name",
        st.screen_type_name as "Device Type",
        SUM(impressions) as "Impressions",
        SUM(impressions) as "Video Starts",
        SUM(clicks) as "Clicks",
        SUM(completions) as "Completions",
        SUM(conversions) as "Conversions",
        CASE WHEN flight_id IN (4245316, 4245436, 4275656, 4275676, 4298766, 4298726, 4298786, 4298806, 4306486, 4307346, 4334336, 4334346) THEN (SUM(impressions)/1000) * 21.50
             ELSE 0 END AS "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.dma dma on dma.dma_code = add2.dma
  left outer join dwh.screen_type st on add2.screen_type = st.screen_type_code
WHERE date >= '2022-03-01'
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  and flight_id IN (4245316, 4245436, 4275656, 4275676, 4298766, 4298726, 4298786, 4298806, 4306486, 4307346, 4245456, 4245446, 4334336, 4334346)
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
