view: daily_core_user_sample {
  sql_table_name: DEMAND_MART.DAILY_CORE_USER_SAMPLE ;;

  dimension: primary_key {
    type: number
    label: "Primary Key - User Sample"
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.PK_ID;;
  }

  dimension: agency_fee {
    hidden: yes
    type: number
    sql: ${TABLE}.AGENCY_FEE ;;
  }

  dimension: autoplay {
    hidden: yes
    type: number
    sql: ${TABLE}.AUTOPLAY ;;
  }

  dimension: billable_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.BILLABLE_IMPRESSIONS ;;
  }

  dimension: billable_units {
    hidden: yes
    type: number
    sql: ${TABLE}.BILLABLE_UNITS ;;
  }

  dimension: click_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.CLICK_IMPRESSIONS ;;
  }

  dimension: clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.CLICKS ;;
  }

  dimension: clicktoplay {
    hidden: yes
    type: number
    sql: ${TABLE}.CLICKTOPLAY ;;
  }

  dimension: companions {
    hidden: yes
    type: number
    sql: ${TABLE}.COMPANIONS ;;
  }

  dimension: completed_100 {
    hidden: yes
    type: number
    sql: ${TABLE}.COMPLETED_100 ;;
  }

  dimension: completed_25 {
    hidden: yes
    type: number
    sql: ${TABLE}.COMPLETED_25 ;;
  }

  dimension: completed_50 {
    hidden: yes
    type: number
    sql: ${TABLE}.COMPLETED_50 ;;
  }

  dimension: completed_75 {
    hidden: yes
    type: number
    sql: ${TABLE}.COMPLETED_75 ;;
  }

  dimension: completed_pct_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.COMPLETED_PCT_IMPRESSIONS ;;
  }

  dimension: completion_pct_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.COMPLETION_PCT_IMPRESSIONS ;;
  }

  dimension: cost_units {
    hidden: yes
    type: number
    sql: ${TABLE}.COST_UNITS ;;
  }

  dimension_group: demand {
    type: time
    hidden: yes
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.DEMAND_DATE ;;
  }

  dimension: distinct_clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.DISTINCT_CLICKS ;;
  }

  dimension: duplicates {
    hidden: yes
    type: number
    sql: ${TABLE}.DUPLICATES ;;
  }

  dimension: effective_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.EFFECTIVE_IMPRESSIONS ;;
  }

  dimension: effective_units {
    hidden: yes
    type: number
    sql: ${TABLE}.EFFECTIVE_UNITS ;;
  }

  dimension_group: est {
    type: time
    hidden: yes
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.EST_DATE ;;
  }

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension_group: gmt {
    type: time
    hidden: yes
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.GMT_DATE ;;
  }

  dimension: import_config_id {
    hidden: yes
    type: number
    sql: ${TABLE}.IMPORT_CONFIG_ID ;;
  }

  dimension: impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.IMPRESSIONS ;;
  }

  dimension: isselected {
    hidden: yes
    type: number
    sql: ${TABLE}.ISSELECTED ;;
  }

  dimension: muted {
    hidden: yes
    type: number
    sql: ${TABLE}.MUTED ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLACEMENT_ID ;;
  }

  dimension: primary_clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.PRIMARY_CLICKS ;;
  }

  dimension: processingid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.PROCESSINGID ;;
  }

  dimension_group: region {
    type: time
    hidden: yes
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.REGION_DATE ;;
  }

  dimension: skipped {
    hidden: yes
    type: number
    sql: ${TABLE}.SKIPPED ;;
  }

  dimension: units {
    hidden: yes
    type: number
    sql: ${TABLE}.UNITS ;;
  }

  dimension: userid {
    type: string
    hidden: yes
    sql: ${TABLE}.USERID ;;
  }

  measure: count_distinct_users {
    type: count_distinct
    hidden: yes
    sql: ${userid} ;;
    drill_fields: []
  }

  measure: sum_impressions {
    type: sum
    hidden: yes
    sql: ${impressions} ;;
    value_format_name: decimal_0
  }

  measure: average_frequency {
    type: number
    label: "Average Frequency"
    view_label: "Impression Metrics"
    description: "The average number of times any indvidual user saw a given flight media."
    value_format_name: decimal_2
    sql: coalesce(${sum_impressions} * 1.0 /nullif(${count_distinct_users},0),0) ;;
  }

  measure: reach {
    type: number
    label: "Reach"
    view_label: "Impression Metrics"
    description: "The distinct number of viewers that saw a give flight media across the level that the report is aggregate at.
    For example, if the view is for 3 days for a single campaign, then the reach is the number of distinct viewers that saw an
    impression for that campaign for those 3 days.  This number is not summative at different levels."
    value_format_name: decimal_0
    sql: coalesce(${daily_core_stats.sum_impressions} * 1.0 / nullif(${average_frequency},0),0) ;;
  }
}
