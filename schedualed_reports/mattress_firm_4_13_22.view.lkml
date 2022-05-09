view: mattress_firm_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT  date::date as "Date",
        TRIM(BOTH '''' FROM dma.dma_name) as "DMA",
        flight_id as "Flight ID",
        creative_id as "Creative ID",
        CASE WHEN creative_id IN (8469956, 8449186, 8453386, 8470686,
                      8481696,8481716,8495996, 8481696,
                      8481716,8495996, 8481696, 8481716) THEN 'CTV + BT + GT'
              ELSE 'CTV Added Value' END AS "Placement Name",
        CASE WHEN creative_id = 8469956 THEN 'Presidents Day TempurPedic Save $500'
           WHEN creative_id = 8449186 THEN 'Year End Closeout Sale (WK01SAE15YECLS22)'
           WHEN creative_id = 8453386 THEN 'New Bed New You Sale (MFWK02NBY2022)'
           WHEN creative_id = 8470686 THEN 'Presidents Day Sale'
           WHEN creative_id = 8481696 THEN 'Shop Local for 25 Years'
           WHEN creative_id = 8481716 THEN 'TempurPedcSmartBase'
           WHEN creative_id = 8495996 THEN 'Spring Savings Sale'
           WHEN creative_id = 8481696 THEN 'Shop Local for 25 Years'
           WHEN creative_id = 8481716 THEN 'TempurPedcSmartBase'
           WHEN creative_id = 8495996 THEN 'Spring Savings Sale'
           WHEN creative_id = 8469956 THEN 'Presidents Day TempurPedic Save $500'
           WHEN creative_id = 8449186 THEN 'Year End Closeout Sale (WK01SAE15YECLS22)'
           WHEN creative_id = 8453386 THEN 'New Bed New You Sale (MFWK02NBY2022)'
           WHEN creative_id = 8470686 THEN 'Presidents Day Sale'
           WHEN creative_id = 8481696 THEN 'Shop Local for 25 Years'
           WHEN creative_id = 8481716 THEN 'TempurPedcSmartBase'
           WHEN creative_id = 8495996 THEN 'Spring Savings Sale'
           WHEN creative_id = 8481696 THEN 'Shop Local for 25 Years'
           WHEN creative_id = 8481716 THEN 'TempurPedcSmartBase'
           WHEN creative_id = 8481696 THEN 'Shop Local for 25 Years'
           WHEN creative_id = 8481716 THEN 'TempurPedcSmartBase'
           WHEN creative_id = 8481696 THEN 'Shop Local for 25 Years'
           WHEN creative_id = 8481716 THEN 'TempurPedcSmartBase'
           ELSE 'Spring Savings Sale' END AS "Creative Name",
        st.screen_type_name as "Device Type",
        SUM(impressions) as "Impressions",
        SUM(impressions) as "Video Starts",
        SUM(clicks) as "Clicks",
        SUM(completions) as "Completions",
        SUM(conversions) as "Conversions",
        CASE WHEN flight_id IN (4186096, 4244776, 4272956, 4306516) THEN (SUM(impressions)/1000) * 22.50
                         ELSE 0 END AS "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.dma dma on dma.dma_code = add2.dma
  left outer join dwh.screen_type st on add2.screen_type = st.screen_type_code
WHERE date >= '2021-12-27'
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  and flight_id IN (4186096,
            4244776,
            4272956,
            4186106,
            4244786,
            4272966,
            4306516,
            4306526)
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
