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
           WHEN flight_id = 4343046 THEN 'CTV + Exclusion List + BT (AIA) + Zip Targeting - Bacon'
           WHEN flight_id = 4343066 THEN 'CTV + Exclusion List + BT (S&S) + Zip Targeting - BACON'
           WHEN flight_id = 4343086 THEN 'CTV 1% Added Value - BACON'
           WHEN flight_id = 4344686 THEN 'CTV + Exclusion List + BT (AIA) + Zip Targeting'
           WHEN flight_id = 4344076 THEN 'All Screen Video + FEP + BT (S&S) + Zip Targeting - BACON'
           WHEN flight_id = 4343056 THEN 'All Screen Video + FEP + BT (AIA) + Zip Targeting - BACON'
           WHEN flight_id = 4343096 THEN 'All Screen Video 1% Added Value - BACON'
           WHEN flight_id = 4344706 THEN 'All Screen Video + FEP + BT (AIA) + Zip Targeting'
           WHEN flight_id = 4361906 THEN 'CTV + Exclusion List + BT + Zip Targeting (All in Alicia)'
           WHEN flight_id = 4361946 THEN 'All Screen Video + FEP + BT + Zip Targeting (All in Alicia)'
           WHEN flight_id = 4361896 THEN 'CTV + Exclusion List + BT + Zip Targeting (Suburban Sam & Suzy)'
           WHEN flight_id = 4361936 THEN 'All Screen Video + FEP + BT + Zip Targeting (Suburban Sam & Suzy)'
           WHEN flight_id = 4361916 THEN 'CTV + Exclusion List + BT (AIA) + Zip Targeting - BACON'
           WHEN flight_id = 4361926 THEN 'CTV + Exclusion List + BT (S&S) + Zip Targeting - BACON'
           WHEN flight_id = 4361966 THEN 'All Screen Video + FEP + BT (S&S) + Zip Targeting - BACON'
           WHEN flight_id = 4361956 THEN 'All Screen Video + FEP + BT (AIA) + Zip Targeting - BACON'
           WHEN flight_id = 4428396 THEN 'CTV + Exclusion List + BT + Zip Targeting (All in Alicia)'
           WHEN flight_id = 4428406 THEN 'All Screen Video + FEP + BT + Zip Targeting (All in Alicia)'
           WHEN flight_id = 4428376 THEN 'CTV + Exclusion List + BT + Zip Targeting (Suburban Sam & Suzy)'
           WHEN flight_id = 4428386 THEN 'All Screen Video + FEP + BT + Zip Targeting (Suburban Sam & Suzy)'
           WHEN flight_id = 4428416 THEN 'CTV + Exclusion List + BT (AIA) + Zip Targeting - BACON'
           WHEN flight_id = 4428436 THEN 'CTV + Exclusion List + BT (S&S) + Zip Targeting - BACON'
           WHEN flight_id = 4428446 THEN 'All Screen Video + FEP + BT (S&S) + Zip Targeting - BACON'
           WHEN flight_id = 4428426 THEN 'All Screen Video + FEP + BT (AIA) + Zip Targeting - BACON'
           WHEN flight_id = 4428366 THEN 'CTV 1% Added Value - BACON'
           WHEN flight_id = 4428336 THEN 'All Screen Video 1% Added Value - BACON'
           WHEN flight_id = 4428356 THEN 'CTV Added Value'
           WHEN flight_id = 4428346 THEN 'All Screen Video Added Value'
           WHEN flight_id = 4431146 THEN 'CTV Added Value'
           WHEN flight_id = 4431156 THEN 'All Screen Video Added Value'
             ELSE 'All Screen Video + FEP + BT + Zip Targeting (All In Alicia)' END AS "Placement Name",
        CASE WHEN flight_id IN (4428416, 4428436,4428446,4428426,4428366,4428336,4343046, 4343066, 4343086, 4344686, 4343076, 4343056, 4343096, 4344706, 4361916, 4361926, 4361966, 4361956, 4431146, 4431156) THEN 'Ozo_Bacon_3015_16x9'
          ELSE 'Ozo_Chicken_3009_16x9' END as "Creative Name",
        st.screen_type_name as "Device Type",
        SUM(impressions) as "Impressions",
        SUM(impressions) as "Video Starts",
        SUM(clicks) as "Clicks",
        SUM(completions) as "Completions",
        SUM(conversions) as "Conversions",
        CASE WHEN flight_id IN (4428396,4428406,4428376,4428386,4428416,4428436,4428446,4428426, 4245316, 4245436, 4275656, 4275676, 4298766, 4298726, 4298786, 4298806, 4306486, 4307346, 4334336, 4334346, 4343046, 4343066, 4344686, 4343076, 4343056, 4344706, 4361906, 4361946,4361896,4361936,4361916,4361926,4361966,4361956) THEN (SUM(impressions)/1000) * 21.50
             ELSE 0 END AS "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.dma dma on dma.dma_code = add2.dma
  left outer join dwh.screen_type st on add2.screen_type = st.screen_type_code
WHERE date >= CURRENT_DATE()-7
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  and flight_id IN (4245316, 4245436, 4275656, 4275676, 4298766, 4298726, 4298786, 4298806, 4306486, 4307346, 4245456, 4245446, 4334336, 4334346, 4343046, 4343066, 4343086, 4344686, 4343076, 4343056, 4343096, 4344706, 4361906, 4361946,4361896,4361936,4361916,4361926,4361966,4361956, 4428396, 4428406, 4428376, 4428386, 4428416, 4428436, 4428446, 4428426, 4428366, 4428336, 4428356, 4428346, 4431146, 4431156)
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
