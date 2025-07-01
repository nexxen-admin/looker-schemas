view: tp_deepsee_mobile_r {
  sql_table_name: Andromeda.tp_deepsee_mobile_r ;;

  dimension: 30_day_download_count_growth {
    type: number
    sql: ${TABLE}."30_day_download_count_growth" ;;
  }
  dimension: 30_day_review_count_growth {
    type: number
    sql: ${TABLE}."30_day_review_count_growth" ;;
  }
  dimension: 90_day_download_count_growth {
    type: number
    sql: ${TABLE}."90_day_download_count_growth" ;;
  }
  dimension: 90_day_review_count_growth {
    type: number
    sql: ${TABLE}."90_day_review_count_growth" ;;
  }
  dimension: age_group {
    type: string
    sql: ${TABLE}.age_group ;;
  }
  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundle_id ;;
  }
  dimension: category_array {
    type: string
    sql: ${TABLE}.category_array ;;
  }
  dimension_group: crawl {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.crawl_date ;;
  }
  dimension: declared_brand_safety_advisories {
    type: string
    sql: ${TABLE}.declared_brand_safety_advisories ;;
  }
  dimension: declares_contains_ads {
    type: yesno
    sql: ${TABLE}.declares_contains_ads ;;
  }
  dimension: deepsee_brand_safety_risk {
    type: string
    sql: ${TABLE}.deepsee_brand_safety_risk ;;
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
  dimension: downloads {
    type: number
    sql: ${TABLE}.downloads ;;
  }
  dimension_group: event {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.event_time ;;
  }
  dimension: has_app_ads_txt {
    type: yesno
    sql: ${TABLE}.has_app_ads_txt ;;
  }
  dimension: malicious_sdks_detected {
    type: yesno
    sql: ${TABLE}.malicious_sdks_detected ;;
  }
  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
  }
  dimension: primary_category {
    type: string
    sql: ${TABLE}.primary_category ;;
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
  dimension: store {
    type: string
    sql: ${TABLE}.store ;;
  }
  dimension: store_url {
    type: string
    sql: ${TABLE}.store_url ;;
  }
  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }
  dimension: track_id {
    type: number
    sql: ${TABLE}.track_id ;;
  }
  dimension_group: update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.update_date ;;
  }
  dimension: website {
    type: string
    sql: ${TABLE}.website ;;
  }
  measure: count {
    type: count
    drill_fields: [developer_name]
  }
}
