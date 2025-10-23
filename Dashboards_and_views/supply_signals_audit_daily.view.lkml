view: supply_signals_audit_daily {
  sql_table_name: Andromeda.supply_signals_audit_daily ;;

  dimension: adapter {
    type: string
    sql: ${TABLE}.adapter ;;
  }
  dimension_group: event {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.event_time ;;
  }
  dimension: pub_id {
    type: string
    sql: ${TABLE}.pub_id ;;
  }
  dimension: publisher_name {
    type: string
    sql: ${TABLE}.publisher_name ;;
  }
  dimension: rx_device_type {
    type: string
    sql: ${TABLE}.rx_device_type ;;
  }
  dimension: rx_imp_type {
    type: string
    sql: ${TABLE}.rx_imp_type ;;
  }
  dimension: rx_media_type {
    type: string
    sql: ${TABLE}.rx_media_type ;;
  }
  measure: total_requests {
    type: sum
    sql: ${TABLE}.total_requests ;;
  }
  measure: with_appbundle {
    type: sum
    sql: ${TABLE}.with_appbundle ;;
  }
  measure: appbundle_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_appbundle) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_appname {
    type: sum
    sql: ${TABLE}.with_appname ;;
  }
  measure: appname_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_appname) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_appstoreurl {
    type: sum
    sql: ${TABLE}.with_appstoreurl ;;
  }
  measure: appstoreurl_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_appstoreurl) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_channel {
    type: sum
    sql: ${TABLE}.with_channel ;;
  }
  measure: channel_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_channel) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_fullip {
    type: sum
    sql: ${TABLE}.with_fullip ;;
  }
  measure: fullip_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_fullip) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_gdpr1 {
    type: sum
    sql: ${TABLE}.with_gdpr1 ;;
  }
  measure: gdpr1_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_gdpr1) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_gdpr1_and_consent {
    type: sum
    sql: ${TABLE}.with_gdpr1_and_consent ;;
  }
  measure: gdpr1_and_consent_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_gdpr1_and_consent) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_genre {
    type: sum
    sql: ${TABLE}.with_genre ;;
  }
  measure: genre_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_genre) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_gpid {
    type: sum
    value_format_name: id
    sql: ${TABLE}.with_gpid ;;
  }
  measure: gpid_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_gpid) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_gpp {
    type: sum
    sql: ${TABLE}.with_gpp ;;
  }
  measure: gpp_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_gpp) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_network {
    type: sum
    sql: ${TABLE}.with_network ;;
  }
  measure: network_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_network) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_nonzero_deviceid {
    type: sum
    value_format_name: id
    sql: ${TABLE}.with_nonzero_deviceid ;;
  }
  measure: nonzero_deviceid_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_nonzero_deviceid) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_page {
    type: sum
    sql: ${TABLE}.with_page ;;
  }
  measure: page_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_page) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_tid {
    type: sum
    value_format_name: id
    sql: ${TABLE}.with_tid ;;
  }
  measure: tid_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_tid) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_valid_usp {
    type: sum
    sql: ${TABLE}.with_valid_usp ;;
  }
  measure: valid_usp_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_valid_usp) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: with_video_plcmt {
    type: sum
    sql: ${TABLE}.with_video_plcmt ;;
  }
  measure: video_plcmt_rate {
    type: number
    value_format_name: "percent_2"
    sql: SUM(${TABLE}.with_video_plcmt) / NULLIF(SUM(${TABLE}.total_requests), 0) ;;
  }
  measure: count {
    type: count
  }
}
