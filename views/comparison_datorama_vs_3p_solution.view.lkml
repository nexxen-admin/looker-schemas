view: comparison_datorama_vs_3p_solution {
  sql_table_name: BI_DSP.comparison_datorama_vs_3p_solution ;;

  dimension: 3p_ad_engagements {
    type: number
    sql: ${TABLE}."3p_ad_engagements" ;;
  }
  dimension: 3p_avg_video_duration {
    type: number
    sql: ${TABLE}."3p_avg_video_duration" ;;
  }
  dimension: 3p_clicks {
    type: number
    sql: ${TABLE}."3p_clicks" ;;
  }
  dimension: 3p_fraud_sivt_incidents {
    type: number
    sql: ${TABLE}."3p_fraud_sivt_incidents" ;;
  }
  dimension: 3p_impressions {
    type: number
    sql: ${TABLE}."3p_impressions" ;;
  }
  dimension: 3p_in_view_impressions {
    type: number
    sql: ${TABLE}."3p_in_view_impressions" ;;
  }
  dimension: 3p_in_view_measurable {
    type: number
    sql: ${TABLE}."3p_in_view_measurable" ;;
  }
  dimension: 3p_interactions {
    type: number
    sql: ${TABLE}."3p_interactions" ;;
  }
  dimension: 3p_loaded_impressions {
    type: number
    sql: ${TABLE}."3p_loaded_impressions" ;;
  }
  dimension: 3p_media_measured_impressions {
    type: number
    sql: ${TABLE}."3p_media_measured_impressions" ;;
  }
  dimension: 3p_percent25_events {
    type: number
    sql: ${TABLE}."3p_percent25_events" ;;
  }
  dimension: 3p_percent50_events {
    type: number
    sql: ${TABLE}."3p_percent50_events" ;;
  }
  dimension: 3p_percent75_events {
    type: number
    sql: ${TABLE}."3p_percent75_events" ;;
  }
  dimension: 3p_requested_impressions {
    type: number
    sql: ${TABLE}."3p_requested_impressions" ;;
  }
  dimension: 3p_revenue {
    type: number
    sql: ${TABLE}."3p_revenue" ;;
  }
  dimension: 3p_rich_media_impressions {
    type: number
    sql: ${TABLE}."3p_rich_media_impressions" ;;
  }
  dimension: 3p_source_name {
    type: string
    sql: ${TABLE}."3p_source_name" ;;
  }
  dimension: 3p_total_conversions {
    type: number
    sql: ${TABLE}."3p_total_conversions" ;;
  }
  dimension: 3p_tpa_external_id {
    type: string
    sql: ${TABLE}."3p_tpa_external_id" ;;
  }
  dimension: 3p_video_fully_played {
    type: number
    sql: ${TABLE}."3p_video_fully_played" ;;
  }
  dimension: 3p_video_views {
    type: number
    sql: ${TABLE}."3p_video_views" ;;
  }
  dimension_group: date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."date" ;;
  }
  dimension: dato_ad_engagements {
    type: number
    sql: ${TABLE}.dato_ad_engagements ;;
  }
  dimension: dato_avg_video_duration {
    type: number
    sql: ${TABLE}.dato_avg_video_duration ;;
  }
  dimension: dato_clicks {
    type: number
    sql: ${TABLE}.dato_clicks ;;
  }
  dimension: dato_fraud_sivt_incidents {
    type: number
    sql: ${TABLE}.dato_fraud_sivt_incidents ;;
  }
  dimension: dato_impressions {
    type: number
    sql: ${TABLE}.dato_impressions ;;
  }
  dimension: dato_in_view_impressions {
    type: number
    sql: ${TABLE}.dato_in_view_impressions ;;
  }
  dimension: dato_in_view_measurable {
    type: number
    sql: ${TABLE}.dato_in_view_measurable ;;
  }
  dimension: dato_interactions {
    type: number
    sql: ${TABLE}.dato_interactions ;;
  }
  dimension: dato_loaded_impressions {
    type: number
    sql: ${TABLE}.dato_loaded_impressions ;;
  }
  dimension: dato_media_measured_impressions {
    type: number
    sql: ${TABLE}.dato_media_measured_impressions ;;
  }
  dimension: dato_percent25_events {
    type: number
    sql: ${TABLE}.dato_percent25_events ;;
  }
  dimension: dato_percent50_events {
    type: number
    sql: ${TABLE}.dato_percent50_events ;;
  }
  dimension: dato_percent75_events {
    type: number
    sql: ${TABLE}.dato_percent75_events ;;
  }
  dimension: dato_requested_impressions {
    type: number
    sql: ${TABLE}.dato_requested_impressions ;;
  }
  dimension: dato_revenue {
    type: number
    sql: ${TABLE}.dato_revenue ;;
  }
  dimension: dato_rich_media_impressions {
    type: number
    sql: ${TABLE}.dato_rich_media_impressions ;;
  }
  dimension: dato_source_name {
    type: string
    sql: ${TABLE}.dato_source_name ;;
  }
  dimension: dato_total_conversions {
    type: number
    sql: ${TABLE}.dato_total_conversions ;;
  }
  dimension: dato_tpa_external_id {
    type: string
    sql: ${TABLE}.dato_tpa_external_id ;;
  }
  dimension: dato_video_fully_played {
    type: number
    sql: ${TABLE}.dato_video_fully_played ;;
  }
  dimension: dato_video_views {
    type: number
    sql: ${TABLE}.dato_video_views ;;
  }
  dimension: diff_ad_engagements {
    type: number
    sql: ${TABLE}.diff_ad_engagements ;;
  }
  dimension: diff_avg_video_duration {
    type: number
    sql: ${TABLE}.diff_avg_video_duration ;;
  }
  dimension: diff_clicks {
    type: number
    sql: ${TABLE}.diff_clicks ;;
  }
  dimension: diff_fraud_sivt_incidents {
    type: number
    sql: ${TABLE}.diff_fraud_sivt_incidents ;;
  }
  dimension: diff_impressions {
    type: number
    sql: ${TABLE}.diff_impressions ;;
  }
  dimension: diff_in_view_impressions {
    type: number
    sql: ${TABLE}.diff_in_view_impressions ;;
  }
  dimension: diff_in_view_measurable {
    type: number
    sql: ${TABLE}.diff_in_view_measurable ;;
  }
  dimension: diff_interactions {
    type: number
    sql: ${TABLE}.diff_interactions ;;
  }
  dimension: diff_loaded_impressions {
    type: number
    sql: ${TABLE}.diff_loaded_impressions ;;
  }
  dimension: diff_media_measured_impressions {
    type: number
    sql: ${TABLE}.diff_media_measured_impressions ;;
  }
  dimension: diff_percent25_events {
    type: number
    sql: ${TABLE}.diff_percent25_events ;;
  }
  dimension: diff_percent50_events {
    type: number
    sql: ${TABLE}.diff_percent50_events ;;
  }
  dimension: diff_percent75_events {
    type: number
    sql: ${TABLE}.diff_percent75_events ;;
  }
  dimension: diff_requested_impressions {
    type: number
    sql: ${TABLE}.diff_requested_impressions ;;
  }
  dimension: diff_revenue {
    type: number
    sql: ${TABLE}.diff_revenue ;;
  }
  dimension: diff_rich_media_impressions {
    type: number
    sql: ${TABLE}.diff_rich_media_impressions ;;
  }
  dimension: diff_total_conversions {
    type: number
    sql: ${TABLE}.diff_total_conversions ;;
  }
  dimension: diff_video_fully_played {
    type: number
    sql: ${TABLE}.diff_video_fully_played ;;
  }
  dimension: diff_video_views {
    type: number
    sql: ${TABLE}.diff_video_views ;;
  }
  dimension_group: load_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.load_timestamp ;;
  }
  measure: count {
    type: count
    drill_fields: [dato_source_name, 3p_source_name]
  }
}
