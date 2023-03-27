view: publisher_approval {
  sql_table_name: dbo.publisher_approval (NOLOCK) ;;

  dimension: publisher_approval_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.publisher_approval_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: advertiser_brand_id {
    type: number
    hidden: yes
    sql: ${TABLE}.advertiser_brand_id ;;
  }

  dimension: advertiser_id {
    type: number
    hidden: yes
    sql: ${TABLE}.advertiser_id ;;
  }

  dimension: advertiser_name {
    type: string
    hidden: yes
    sql: ${TABLE}.advertiser_name ;;
  }

  dimension: approval_api_call_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.approval_api_call_status_id ;;
  }

  dimension: approval_review_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.approval_review_type_id ;;
  }

  dimension: approval_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.approval_status_id ;;
  }

  dimension: approval_type_description {
    type: string
    hidden: yes
    sql: ${TABLE}.approval_type_description ;;
  }

  dimension: approval_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.approval_type_id ;;
  }

  dimension: bitrate {
    type: number
    hidden: yes
    sql: ${TABLE}.bitrate ;;
  }

  dimension: brand_name {
    type: string
    hidden: yes
    sql: ${TABLE}.brand_name ;;
  }

  dimension: buying_market_alias {
    type: string
    hidden: yes
    sql: ${TABLE}.buying_market_alias ;;
  }

  dimension: buying_market_id {
    type: number
    hidden: yes
    sql: ${TABLE}.buying_market_id ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    hidden: yes
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: category {
    type: string
    hidden: yes
    sql: ${TABLE}.category ;;
  }

  dimension: cdn_file_loc {
    type: string
    hidden: yes
    sql: ${TABLE}.cdn_file_loc ;;
  }

  dimension: clearcast_approval_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.clearcast_approval_status_id ;;
  }

  dimension: creative_format_type {
    type: string
    hidden: yes
    sql: ${TABLE}.creative_format_type ;;
  }

  dimension: creative_name {
    type: string
    hidden: yes
    sql: ${TABLE}.creative_name ;;
  }

  dimension: customer_name {
    type: string
    hidden: yes
    sql: ${TABLE}.customer_name ;;
  }

  dimension: delivery {
    type: string
    hidden: yes
    sql: ${TABLE}.delivery ;;
  }

  dimension: description {
    type: string
    hidden: yes
    sql: ${TABLE}.description ;;
  }

  dimension: duration {
    type: number
    hidden: yes
    sql: ${TABLE}.duration ;;
  }

  dimension: expiration_date {
    type: string
    hidden: yes
    sql: ${TABLE}.expiration_date ;;
  }

  dimension: external_id {
    type: string
    hidden: yes
    sql: ${TABLE}.external_id ;;
  }

  dimension_group: f_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    hidden: yes
    sql: ${TABLE}.f_end_date ;;
  }

  dimension_group: f_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    hidden: yes
    sql: ${TABLE}.f_start_date ;;
  }

  dimension: file_size {
    type: number
    hidden: yes
    sql: ${TABLE}.file_size ;;
  }

  dimension: has_blocked_duration {
    type: string
    hidden: yes
    sql: ${TABLE}.has_blocked_duration ;;
  }

  dimension: has_xml_preview {
    type: string
    hidden: yes
    sql: ${TABLE}.has_xml_preview ;;
  }

  dimension: industry_segment_id {
    type: number
    hidden: yes
    sql: ${TABLE}.industry_segment_id ;;
  }

  dimension: lookup_locale_id {
    type: string
    hidden: yes
    sql: ${TABLE}.lookup_locale_id ;;
  }

  dimension: media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.media_id ;;
  }

  dimension: mimetype {
    type: string
    hidden: yes
    sql: ${TABLE}.mimetype ;;
  }

  dimension: notes {
    type: string
    hidden: yes
    sql: ${TABLE}.notes ;;
  }

  dimension: partner_id {
    type: number
    hidden: yes
    sql: ${TABLE}.partner_id ;;
  }

  dimension: partner_name {
    type: string
    hidden: yes
    sql: ${TABLE}.partner_name ;;
  }

  dimension: partner_office_id {
    type: number
    hidden: yes
    sql: ${TABLE}.partner_office_id ;;
  }

  dimension: publisher_approval_level_id {
    type: number
    hidden: yes
    sql: ${TABLE}.publisher_approval_level_id ;;
  }

  dimension: watershed_timing_id {
    type: number
    hidden: yes
    sql: ${TABLE}.watershed_timing_id ;;
  }
}
