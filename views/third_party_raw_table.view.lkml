view: third_party_raw_table {
  sql_table_name: BI_DSP.third_party_raw_table ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: ad_engagements {
    type: number
    sql: ${TABLE}.ad_engagements ;;
  }
  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
  }
  dimension: advertiser_name {
    type: string
    sql: ${TABLE}.advertiser_name ;;
  }
  dimension: authentic_ads {
    type: number
    sql: ${TABLE}.authentic_ads ;;
  }
  dimension: authentic_viewable_impressions {
    type: number
    sql: ${TABLE}.authentic_viewable_impressions ;;
  }
  dimension: avg_video_duration {
    type: number
    sql: ${TABLE}.avg_video_duration ;;
  }
  dimension: blocks {
    type: number
    sql: ${TABLE}.blocks ;;
  }
  dimension: brand_suitability_blocks {
    type: number
    sql: ${TABLE}.brand_suitability_blocks ;;
  }
  dimension: brand_suitable_impressions {
    type: number
    sql: ${TABLE}.brand_suitable_impressions ;;
  }
  dimension: creative_id {
    type: number
    sql: ${TABLE}.creative_id ;;
  }
  dimension: creative_name {
    type: string
    sql: ${TABLE}.creative_name ;;
  }
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."date" ;;
  }

  # dimension: my_date {
  #   type: date
  #   sql: "${TABLE}"."date" ;;
  # }

  # measure: max_date {
  #   type: date  # Change the type from 'max' to 'date'
  #   sql: MAX(${date_raw}) ;; # Explicitly use the SQL MAX function
  #   # value_format: "YYYY-MM-DD" # Add a format if you want a specific display
  # }


  dimension_group: db_inserted {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_inserted_at ;;
  }
  dimension_group: email_datetime {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.email_datetime ;;
  }
  dimension: external_app_id {
    type: string
    sql: ${TABLE}.external_app_id ;;
  }
  dimension: external_site_id {
    type: string
    sql: ${TABLE}.external_site_id ;;
  }
  dimension: fraud_sivt_blocks {
    type: number
    sql: ${TABLE}.fraud_sivt_blocks ;;
  }
  dimension: in_view_impressions {
    type: number
    sql: ${TABLE}.in_view_impressions ;;
  }
  dimension: in_view_measurable_impressions {
    type: number
    sql: ${TABLE}.in_view_measurable_impressions ;;
  }
  dimension: insertion_order_id {
    type: number
    sql: ${TABLE}.insertion_order_id ;;
  }
  dimension: insertion_order_name {
    type: string
    sql: ${TABLE}.insertion_order_name ;;
  }
  dimension: interactions {
    type: number
    sql: ${TABLE}.interactions ;;
  }
  dimension: loaded_impressions {
    type: number
    sql: ${TABLE}.loaded_impressions ;;
  }
  dimension: media_cost {
    type: number
    sql: ${TABLE}.media_cost ;;
  }
  dimension: message_id {
    type: string
    sql: ${TABLE}.message_id ;;
  }
  dimension: monitored_ads {
    type: number
    sql: ${TABLE}.monitored_ads ;;
  }
  dimension: out_geo_blocks {
    type: number
    sql: ${TABLE}.out_geo_blocks ;;
  }
  dimension: out_geo_incidents {
    type: number
    sql: ${TABLE}.out_geo_incidents ;;
  }
  dimension: percent100_events {
    type: number
    sql: ${TABLE}.percent100_events ;;
  }
  dimension: percent25_events {
    type: number
    sql: ${TABLE}.percent25_events ;;
  }
  dimension: percent50_events {
    type: number
    sql: ${TABLE}.percent50_events ;;
  }
  dimension: percent75_events {
    type: number
    sql: ${TABLE}.percent75_events ;;
  }
  dimension: placement_name {
    type: string
    sql: ${TABLE}.placement_name ;;
  }
  dimension: post_click_conversions {
    type: number
    sql: ${TABLE}.post_click_conversions ;;
  }
  dimension: post_view_conversions {
    type: number
    sql: ${TABLE}.post_view_conversions ;;
  }
  dimension: rendered_impressions {
    type: number
    sql: ${TABLE}.rendered_impressions ;;
  }
  dimension: requested_impressions {
    type: number
    sql: ${TABLE}.requested_impressions ;;
  }
  dimension: requests {
    type: number
    sql: ${TABLE}.requests ;;
  }
  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }
  dimension: source_name {
    type: string
    sql: ${TABLE}.source_name ;;
  }
  dimension: third_party_clicks {
    type: number
    sql: ${TABLE}.third_party_clicks ;;
  }
  dimension: third_party_complete_events {
    type: number
    sql: ${TABLE}.third_party_complete_events ;;
  }
  dimension: third_party_fraud_sivt_incidents {
    type: number
    sql: ${TABLE}.third_party_fraud_sivt_incidents ;;
  }
  dimension: third_party_impressions {
    type: number
    sql: ${TABLE}.third_party_impressions ;;
  }
  dimension: third_party_media_measured_impressions {
    type: number
    sql: ${TABLE}.third_party_media_measured_impressions ;;
  }
  dimension: total_conversions {
    type: number
    sql: ${TABLE}.total_conversions ;;
  }
  dimension: tpa_external_id {
    type: string
    sql: ${TABLE}.tpa_external_id ;;
  }
  dimension: video_start {
    type: number
    sql: ${TABLE}.video_start ;;
  }
  dimension: video_views {
    type: number
    sql: ${TABLE}.video_views ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  advertiser_name,
  source_name,
  creative_name,
  placement_name,
  insertion_order_name
  ]
  }



}
