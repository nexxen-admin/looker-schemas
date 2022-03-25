view: pilgrim_s_pride_report {
required_access_grants: [can_view_pub_come_looker]
  derived_table: {
    sql: SELECT  to_char("date", 'MM-DD-YYYY') as date,
        date::date as Date2,
               dma.dma_name as DMA,
               flight_id,
               CASE WHEN flight_id = 4250306 THEN 'CTV + BT + Zip'
                         WHEN flight_id = 4250316 THEN 'All Screen OTT + BT + Zip'
                          ELSE 'CTV Added Value' END AS placement_name,
                'SPIL000I024H_Pilgrims_Core4_Pinterest_Autoplay' as creative_name,
                SUM(impressions) as total_impressions,
                SUM(impressions) as video_starts,
                CASE WHEN flight_id = 4250316 THEN SUM(clicks)
                           ELSE 0 END AS total_clicks,
                SUM(completions) as total_completions,
                CASE WHEN flight_id = 4250306 THEN (SUM(impressions)/1000) * 23.25
                          WHEN flight_id = 4250316 THEN (SUM(impressions)/1000) * 23.25
                          ELSE 0 END AS spend
FROM dwh.ad_data_daily add2
  left outer join dwh.dma dma on dma.dma_code = add2.dma
WHERE date >= '2022-03-07'
  AND data_type = 'AD_DATA'
  and flight_id IN (4250306,
                    4250316,
                    4250326)
    AND (impressions > 0 or completions > 0 or clicks > 0)
GROUP BY 1,2,3,4,5
ORDER BY 1
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    type: string
    label: "Date"
    sql: ${TABLE}."date" ;;
  }

  dimension: date2 {
    type: date
    sql: ${TABLE}.Date2
    label: "Date2";;
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
    label: "Spend"
    sql: ${TABLE}.spend ;;
  }

  set: detail {
    fields: [
      date,
      date2,
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
