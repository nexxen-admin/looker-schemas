view: pilgrim_s_pride_report {
required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: ---Pilgrims Pride Updates 11-08-2022
SELECT  date::date as date,
               TRIM(BOTH '''' FROM dma.dma_name) as DMA,
               flight_id,
               CASE WHEN flight_id IN(4405056, 4405556, 4452336, 4452326) THEN 'CTV + BT + Zip/DMA Targeting (Extension 2)'
                    WHEN flight_id IN(4405066, 4405566, 4452376, 4452356) THEN 'All Screen Video + FEP + BT + Zip/DMA Targeting (Extension 2)'
                    WHEN flight_id IN(4405106, 4405576, 4452466, 4452446) THEN 'CTV 1% Added Value'
                    ELSE 'All Screen 1% AV' END AS placement_name,
                'PILG2201H_Pilgrims_ChickenOps_16x9_30_Streaming' as creative_name,
                SUM(impressions) as total_impressions,
                SUM(impressions) as video_starts,
                SUM(clicks) AS total_clicks,
                SUM(completions) as total_completions,
                CASE WHEN flight_id IN(4405056, 4405066, 4405556, 4405566,4452336, 4452376,4452326,4452356) THEN (SUM(impressions)/1000) * 21.50
                     ELSE 0 END AS spend
FROM dwh.ad_data_daily add2
  left outer join dwh.dma dma on dma.dma_code = add2.dma
WHERE date >= '2022-03-07'
  AND date < CURRENT_DATE()
  AND data_type = 'AD_DATA'
  and flight_id IN (4405056, 4405066, 4405106, 4405116,4405556, 4405566, 4405576, 4405586, 4452336,4452376,4452466,4452406,4452326,4452356,4452446,4452426)
    AND (impressions > 0 or completions > 0 or clicks > 0)
GROUP BY 1,2,3,4,5
ORDER BY 1 DESC
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  dimension: date {
    type: date
    label: "Date"
    sql: ${TABLE}.Date;;
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
    sql: ${TABLE}.flight_id ;;
  }

  dimension: placement_name {
    type: string
    label: "Line Item"
    sql: ${TABLE}.placement_name ;;
  }

  dimension: creative_name {
    type: string
    label: "Creative"
    sql: ${TABLE}.creative_name ;;
  }

  dimension: total_impressions {
    type: number
    label: "Impressions"
    sql: ${TABLE}.total_impressions ;;
  }

  dimension: video_starts {
    type: number
    label: "Video Starts"
    sql: ${TABLE}.video_starts ;;
  }

  dimension: total_clicks {
    type: number
    label: "Clicks"
    sql: ${TABLE}.total_clicks ;;
  }

  dimension: total_completions {
    type: number
    label: "Video Completes"
    sql: ${TABLE}.total_completions ;;
  }

  dimension: spend {
    type: number
    value_format: "#,##0.00"
    label: "Spend"
    sql: ${TABLE}.spend ;;
  }

  set: detail {
    fields: [
      date,
      dma,
      flight_id,
      placement_name,
      creative_name,
      total_impressions,
      video_starts,
      total_clicks,
      total_completions,
      spend
    ]
  }
}
