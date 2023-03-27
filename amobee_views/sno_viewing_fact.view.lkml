view: viewing_fact {
  view_label: "Viewing Metrics"
  sql_table_name: VIEWERSHIP.VIEWING_FACT ;;

  dimension: ad_content_key {
    type: string
    description: "Get the keys from Ad Finder Tool. Enter one or multiple to check exposure"
    #hidden: yes
    sql: ${TABLE}.AD_CONTENT_KEY ;;
  }

  measure: dcount_ad_content_key {
    type: count_distinct
    hidden: yes
    view_label: "Viewing Metrics"
    label: "Brand Ad Exposure"
    sql: ${TABLE}.AD_CONTENT_KEY ;;
  }

  dimension: age {
    type: number
    hidden: yes
    sql: ${TABLE}.AGE ;;
  }

  dimension_group: event {
    type: time
    hidden: yes
    label: "Viewing Event Date"
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.EVENT_DATE ;;
  }

  dimension: event_duration {
    hidden: yes
    type: number
    sql: ${TABLE}.EVENT_DURATION ;;
  }

  dimension: event_end {
    hidden: yes
    type: number
    sql: ${TABLE}.EVENT_END ;;
  }

  dimension: event_end_datetime {
    hidden: yes
    type: string
    sql: ${TABLE}.EVENT_END_DATETIME ;;
  }

  dimension: event_epoch {
    type: number
    hidden: yes
    sql: ${TABLE}.EVENT_EPOCH ;;
  }

  dimension: event_start {
    type: number
    hidden: yes
    sql: ${TABLE}.EVENT_START ;;
  }

  dimension: event_start_datetime {
    view_label: "Ad Content"
    label: "Event Time"
    type: string
    hidden: no
    sql: ${TABLE}.EVENT_START_DATETIME ;;
  }

  dimension: gender {
    type: string
    hidden: yes
    sql: ${TABLE}.GENDER ;;
  }

  dimension: media_content_key {
    type: string
    hidden: yes
    sql: ${TABLE}.MEDIA_CONTENT_KEY ;;
  }

  dimension: metric_type {
    type: string
    view_label: "Viewing Metrics"
    label: "Viewing Type"
    description: "For TV live+7 ad Impressions, type 'AED7'"
    #hidden: yes
    sql: ${TABLE}.METRIC_TYPE ;;
  }

  dimension: metric_value {
    type: number
    hidden: yes
    sql: ${TABLE}.METRIC_VALUE ;;
  }

  measure: sum_metric_value {
    type: sum
    hidden: yes
    label: "Impressions"
    sql: ${metric_value} ;;
  }

  dimension: metric_value_tier {
    type: tier
    hidden: yes
    label: "Impression tiers (small)"
    style: integer
    tiers: [0,1000,5000,10000,50000]
  }

  dimension: livesd {
    type: number
    hidden: yes
    sql: CASE when ${metric_type} = 'LIVE+SD' then ${TABLE}.METRIC_VALUE end ;;
  }

  measure: sum_livesd {
    type: sum
    hidden: yes
    label: "Live program + Same Day program viewing"
    sql: ${livesd} ;;
  }

  dimension: live3 {
    type: number
    hidden: yes
    sql: CASE when ${metric_type} = 'LIVE+3' then ${TABLE}.METRIC_VALUE end ;;
  }

  measure: sum_live3 {
    type: sum
    hidden: yes
    label: "Live program to 3 day delay"
    sql: ${live3} ;;
  }

  dimension: live7 {
    type: number
    hidden: yes
    sql: CASE when ${metric_type} = 'LIVE+7' then ${TABLE}.METRIC_VALUE end ;;
  }

  measure: sum_live7 {
    type: sum
    hidden: yes
    label: "Live program to 7 day delay"
    sql: ${live7} ;;
  }

  dimension: c3 {
    type: number
    hidden: yes
    sql: CASE when ${metric_type} = 'c3' then ${TABLE}.METRIC_VALUE end ;;
  }

  measure: sum_c3 {
    type: sum
    hidden: yes
    label: "Commercial+3 "
    sql: ${c3} ;;
  }

  dimension: c7 {
    type: number
    hidden: yes
    sql: CASE when ${metric_type} = 'C7' then ${TABLE}.METRIC_VALUE end ;;
  }

  measure: sum_c7 {
    type: sum
    hidden: yes
    label: "Commercial+7 "
    sql: ${c7} ;;
  }

  dimension: aed3 {
    type: number
    hidden: yes
    sql: CASE when ${metric_type} = 'AED3' then ${TABLE}.METRIC_VALUE end ;;
  }

  measure: sum_aed3 {
    type: sum
    label: "AED+3"
    hidden: yes
    sql: ${aed3} ;;
  }

  dimension: aed7 {
    type: number
    hidden: yes
    sql: CASE when ${metric_type} = 'AED7' then ${TABLE}.METRIC_VALUE end ;;
  }

  measure: sum_aed7 {
    type: sum
    hidden: yes
    label: "AED+7"
    sql: ${aed7} ;;
  }

  dimension: misc_data {
    type: string
    hidden: yes
    sql: ${TABLE}.MISC_DATA ;;
  }

  dimension: reach_key {
    type: string
    hidden: yes
    sql: ${TABLE}.REACH_KEY ;;
  }

  dimension: timeperiod_month_key {
    type: number
    hidden: no
    view_label: "Choose Timeperiod"
    label: "Month"
    description: "Select the month to filter. Eg. May 2017 is 201705"
    sql: ${TABLE}.TIMEPERIOD_MONTH_KEY ;;
  }

  dimension: timeperiod_quarter_key {
    type: number
    #hidden: yes
    view_label: "Choose Timeperiod"
    label: "Quarter"
    description: "Select the quarter to filter. Eg. 2017Q2 is 201702"
    sql: ${TABLE}.TIMEPERIOD_QUARTER_KEY ;;
  }

  #dimension: timeperiod_week_key {
  #  type: number
  #  #hidden: yes
  #  view_label: "Weekly"
  #  label: "Weekly Viewing Timeperiod"
  #  sql: ${TABLE}.TIMEPERIOD_WEEK_KEY ;;
  #}

  dimension: viewer_key {
    type: string
    view_label: "Viewer"
    hidden: yes
    sql: ${TABLE}.VIEWER_KEY ;;
  }

  dimension: viewer_type {
    type: string
    hidden: yes
    sql: ${TABLE}.VIEWER_TYPE ;;
  }

  #measure: count {
  #   type: count
  #  drill_fields: []
  # }

  #measure: ad_exposure_frequency {
  #  type: count
  #  drill_fields: []
  #}

  #measure: ad_impressions {
  #  type: number
  #  sql: ${sno_viewer_exposure_quarterly_facts.ad_exposure_frequency} * ${sno_viewer_exposure_quarterly_facts.effective_weight} ;;
  #}

  measure: ad_reach_by_freq {
    type: sum
    sql: ${sno_viewer_exposure_quarterly_facts.effective_weight} ;;
  }

  measure: ad_imps_by_freq {
    type: sum
    sql: ${sno_viewer_exposure_quarterly_facts.ad_impressions} ;;
  }
}
