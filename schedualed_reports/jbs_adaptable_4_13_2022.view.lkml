view: jbs_adaptable_4_13_2022 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT  date::date as "Date",
        TRIM(BOTH '''' FROM dma.dma_name) as "DMA",
        flight_id as "Flight ID",
        CASE WHEN flight_id IN(4206406, 42222036, 4244826, 4267946, 4301536, 4339246, 4371406, 4396786, 4431676, 4457026, 4486216) THEN 'CTV + BT + DMA Targeting'
           WHEN flight_id IN(4206676, 4222046, 4244836, 4268006, 4301546, 4339256, 4371416, 4396796, 4431736, 4457036, 4486426) THEN 'CTV + BT + Zip Targeting'
           WHEN flight_id IN(4206726, 4222056, 4244846, 4268016, 4301556, 4339266, 4371426, 4396806,4431766, 4457046, 4486436) THEN 'All Screen Video OTT + BT + DMA Targeting'
           WHEN flight_id  IN(4206736, 4222066, 4244856, 4268026, 4301566, 4339296, 4371436, 4396816, 4431786, 4457056, 4486456) THEN ' ALL Screen Video OTT + BT + Zip Code Targeting'
             ELSE 'CTV Added Value' END AS "Placement Name",
        'ADAPT-T-1902_Retreat_30_Unslated' as "Creative Name",
        st.screen_type_name as "Device Type",
        SUM(impressions) as "Impressions",
        SUM(impressions) as "Video Starts",
        SUM(clicks) as "Clicks",
        SUM(completions) as "Completions",
        SUM(conversions) as "Conversions",
        CASE WHEN flight_id IN (4206406,
                    42222036,
                    4244826,
                    4267946,
                    4206676,
                    4222046,
                    4244836,
                    4268006,
                    4206726,
                    4222056,
                    4244846,
                    4268016,
                    4206736,
                    4222066,
                    4244856,
                    4268026,
                    4301536,
                    4301546,
                    4301556,
                    4301566,
                    4339296,
                    4339266,
                    4339256,
                    4339246,
                    4371406,
                    4371416,
                    4371426,
                    4371436,
                    4396786,
                    4396796,
                    4396806,
                    4396816,
                    4431786,
                    4431766,
                    4431736,
                    4431676,
                    4457056,
                    4486456,
                    4457046,
                    4486436,
                    4457036,
                    4486426,
                    4457026,
                    4486216) THEN (SUM(impressions)/1000) * 21.50
             ELSE 0 END AS "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.dma dma on dma.dma_code = add2.dma
  left outer join dwh.screen_type st on add2.screen_type = st.screen_type_code
WHERE date >= CURRENT_DATE()-7
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  and flight_id IN (4206406,
                    4222036,
                    4244826,
                    4267946,
                    4206676,
                    4222046,
                    4244836,
                    4268006,
                    4206726,
                    4222056,
                    4244846,
                    4268016,
                    4206736,
                    4222066,
                    4244856,
                    4268026,
                    4206706,
                    4222076,
                    4244866,
                    4268036,
                    4339306,
                    4339296,
                    4339266,
                    4339256,
                    4339246,
                    4371406,
                    4371416,
                    4371426,
                    4371436,
                    4371446,
                    4396826,
                    4396816,
                    4396806,
                    4396796,
                    4396786,
                    4431676,
                    4431736,
                    4431766,
                    4431786,
                    4431806,
                    4457026,
                    4486216,
                    4457036,
                    4486426,
                    4457046,
                    4486436,
                    4457056,
                    4486456,
                    4457066,
                    4486466)
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
