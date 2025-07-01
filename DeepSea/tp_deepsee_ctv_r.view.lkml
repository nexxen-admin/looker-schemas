view: tp_deepsee_ctv_r {
  sql_table_name: Andromeda.tp_deepsee_ctv_r ;;

  dimension: _30_day_download_count_growth {
    type: number
    sql: ${TABLE}._30_day_download_count_growth ;;
  }
  dimension: _30_day_review_count_growth {
    type: number
    sql: ${TABLE}._30_day_review_count_growth ;;
  }
  dimension: _90_day_download_count_growth {
    type: number
    sql: ${TABLE}._90_day_download_count_growth ;;
  }
  dimension: _90_day_review_count_growth {
    type: number
    sql: ${TABLE}._90_day_review_count_growth ;;
  }
  dimension: age_group {
    type: string
    sql: ${TABLE}.age_group ;;
  }
  dimension: compliance_status {
    type: string
    sql:
    CASE
      WHEN ${TABLE}.privacy_policy_url IS NULL
        OR ${TABLE}.has_app_ads_txt = FALSE
        OR ${TABLE}.delisted = TRUE
      THEN 'Rejected'
      ELSE 'OK'
    END ;;
  }

  dimension: rejected_reason {
    type: string
    sql:
    CASE
      WHEN ${TABLE}.privacy_policy_url IS NULL THEN 'No Privacy Policy'
      WHEN ${TABLE}.has_app_ads_txt = FALSE THEN 'No Ads.txt'
      WHEN ${TABLE}.delisted = TRUE THEN 'Delisted in App Store'
      ELSE NULL
    END ;;
  }
  dimension: app_id {
    type: string
    sql: ${TABLE}.app_id ;;
  }
  dimension: brand_safety_risk {
    type: string
    sql: ${TABLE}.brand_safety_risk ;;
  }
  dimension: categories {
    type: string
    sql: ${TABLE}.categories ;;
  }
  dimension_group: crawled {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.crawled_date ;;
  }
  dimension: delisted {
    type: yesno
    sql: ${TABLE}.delisted ;;
  }
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }
  dimension: developer_id {
    type: string
    sql: ${TABLE}.developer_id ;;
  }
  dimension: developer_name {
    type: string
    sql: ${TABLE}.developer_name ;;
  }
  dimension_group: event {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.event_time ;;
  }
  dimension: free_install {
    type: yesno
    sql: ${TABLE}.free_install ;;
  }
  dimension: has_app_ads_txt {
    type: yesno
    sql: ${TABLE}.has_app_ads_txt ;;
  }
  dimension: has_inapp_purchases {
    type: yesno
    sql: ${TABLE}.has_inapp_purchases ;;
  }
  dimension: malicious_sdks_detected {
    type: yesno
    sql: ${TABLE}.malicious_sdks_detected ;;
  }
  dimension: monetization_types {
    type: string
    sql: ${TABLE}.monetization_types ;;
  }
  dimension: offers_free_content {
    type: yesno
    sql: ${TABLE}.offers_free_content ;;
  }
  dimension: privacy_policy_url {
    type: string
    sql: ${TABLE}.privacy_policy_url ;;
  }
  dimension: rating {
    type: number
    sql: ${TABLE}.rating ;;
  }
  dimension: rating_count {
    type: number
    sql: ${TABLE}.rating_count ;;
  }
  dimension_group: release {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.release_date ;;
  }
  dimension: review_sentiment {
    type: number
    sql: ${TABLE}.review_sentiment ;;
  }
  dimension: store_id {
    type: number
    sql: ${TABLE}.store_id ;;
  }
  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }
  dimension_group: update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.update_date ;;
  }
  measure: count {
    type: count
    drill_fields: [developer_name]
  }
}
