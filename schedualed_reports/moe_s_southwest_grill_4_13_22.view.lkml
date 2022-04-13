view: moe_s_southwest_grill_4_13_22 {
  required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT  date::date as "Date",
        TRIM(BOTH '''' FROM dma.dma_name) as "DMA",
        flight_id as "Flight ID",
        creative_id as "Creative ID",
        'CTV + BT (A18-49, QSR Intenders, Mexican Food Enthusiasts) + Zip Targeting' as "Placement Name",
        CASE WHEN creative_id = 8506326 THEN 'Moes_15_SpicyChicken'
           WHEN creative_id = 8506336 THEN ' Moes_30_Brand'
           ELSE 'Catering_30_Approved_' END AS "Creative Name",
        SUM(impressions) as "Impressions",
        SUM(impressions) as "Video Starts",
        SUM(clicks) as "Clicks",
        SUM(completions) as "Completions",
        (SUM(impressions)/1000) * 22.50 as "Spend"
FROM dwh.ad_data_daily add2
  left outer join dwh.dma dma on dma.dma_code = add2.dma
WHERE date >= '2022-04-04'
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  and flight_id = 4277936
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
