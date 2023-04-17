view: tpm_metrics {
  sql_table_name: TPMM.TPM_METRICS ;;

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: changedby {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGEDBY ;;
  }

  dimension: changedon {
    type: string
    hidden: yes
    sql: ${TABLE}.CHANGEDON ;;
  }

  dimension: cost {
    type: number
    hidden: yes
    sql: ${TABLE}.COST ;;
  }

  measure: sum_cost {
    type: sum
    label: "Cost"
    view_label: "TPM Metrics"
    description: "The sum of all costs as provided by the third party."
    value_format_name: decimal_2
    sql: ${cost};;
  }

  dimension: createdon {
    type: string
    hidden: yes
    sql: ${TABLE}.CREATEDON ;;
  }

  dimension: creative_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CREATIVE_ID ;;
  }

  dimension: eventid {
    type: string
    hidden: yes
    sql: ${TABLE}.EVENTID ;;
  }

  dimension: facets {
    type: string
    hidden: yes
    sql: ${TABLE}.FACETS ;;
  }

  dimension: daypart {
    type: string
    label: "Daypart"
    view_label: "TPM Facets"
    sql: ${facets}:daypart::varchar ;;
  }

  dimension: deal_number {
    type: string
    label: "Deal Number"
    description: "The Deal Number provided by the third party."
    view_label: "TPM Facets"
    sql: ${facets}:dealnumber::varchar ;;
  }

  dimension: network_code {
    type: string
    label: "Network Code"
    view_label: "TPM Facets"
    description: "The Network Code provided by the third party."
    sql: ${facets}:networkcode::varchar ;;
  }
  dimension: selling_title_name {
    type: string
    label: "Selling Title"
    view_label: "TPM Facets"
    description: "The Selling Title Name as provided by the third party."
    sql: ${facets}:sellingtitlename::varchar ;;
  }
  dimension: selling_title_number {
    type: string
    label: "Selling Title Number"
    view_label: "TPM Facets"
    description: "The Selling Title Number as provided by the third party."
    sql: ${facets}:sellingtitlenumber::varchar ;;
  }
  dimension: usn {
    type: string
    label: "Unique Spot Number"
    view_label: "TPM Facets"
    description: "The unique spot number as provided by the thrid party"
    sql: ${facets}:usn::varchar ;;
  }
  dimension: aired_program_name {
    type: string
    label: "Aired Program"
    view_label: "TPM Facets"
    description: "The Aired Program Name as provided by the third party."
    sql: ${facets}:airedprogramname::varchar ;;
  }
  dimension: aired_program_number {
    type: string
    label: "Aired Program Number"
    view_label: "TPM Facets"
    description: "The Aired Program Number as provided by the third party."
    sql: ${facets}:airedprogramnumber::varchar ;;
  }

  dimension: flight_id {
    type: string
    hidden: yes
    sql: ${TABLE}.FLIGHT_ID ;;
  }

  dimension: flight_media_id {
    type: string
    hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension: metric_type {
    type: number
    hidden: yes
    sql: ${TABLE}.METRIC_TYPE ;;
  }

  dimension: metric_value {
    type: number
    hidden: yes
    sql: ${TABLE}.METRIC_VALUE ;;
  }


  measure: impressions {
    type: sum
    label: "Impressions"
    view_label: "TPM Metrics"
    description: "The sum of all impressions as provided by the third party."
    value_format_name: decimal_0
    sql: Case when ${metric_type} = 1 then ${metric_value} else 0 end ;;
  }

  measure: clicks {
    type: sum
    label: "Clicks"
    view_label: "TPM Metrics"
    description: "The sum of all clicks as provided by the third party."
    value_format_name: decimal_0
    sql: Case when ${metric_type} = 2 then ${metric_value} else 0 end ;;
  }

  measure: CTR {
    type: number
    label: "CTR"
    view_label: "TPM Metrics"
    description: "Click Thru Rate calculated as the sum of clicks divided by total impressions."
    value_format_name: percent_2
    sql: COALESCE(1.0*${clicks}/nullif(${impressions},0),0);;
  }

  measure: completed_25 {
    type: sum
    label: "Completed 25"
    view_label: "TPM Metrics"
    description: "The sum of impressions that were completed through 25% as provided by the third party."
    value_format_name: decimal_0
    sql: Case when ${metric_type} = 3 then ${metric_value} else 0 end ;;
  }

  measure: completed_25_pct {
    type: number
    label: "Completed 25%"
    view_label: "TPM Metrics"
    description: "Completed 25% calculated as the sum of impressions that were completed through 25% divided by total impressions."
    value_format_name: percent_2
    sql: COALESCE(1.0*${completed_25}/nullif(${impressions},0),0);;
  }

  measure: completed_50 {
    type: sum
    label: "Completed 50"
    view_label: "TPM Metrics"
    description: "The sum of impressions that were completed through 50% as provided by the third party."
    value_format_name: decimal_0
    sql: Case when ${metric_type} = 4 then ${metric_value} else 0 end ;;
  }

  measure: completed_50_pct {
    type: number
    label: "Completed 50%"
    view_label: "TPM Metrics"
    description: "Completed 50% calculated as the sum of impressions that were completed through 50% divided by total impressions."
    value_format_name: percent_2
    sql: COALESCE(1.0*${completed_50}/nullif(${impressions},0),0);;
  }

  measure: completed_75 {
    type: sum
    label: "Completed 75"
    view_label: "TPM Metrics"
    description: "The sum of impressions that were completed through 75% as provided by the third party."
    value_format_name: decimal_0
    sql: Case when ${metric_type} = 5 then ${metric_value} else 0 end ;;
  }

  measure: completed_75_pct {
    type: number
    label: "Completed 75%"
    view_label: "TPM Metrics"
    description: "Completed 75% calculated as the sum of impressions that were completed through 75% divided by total impressions."
    value_format_name: percent_2
    sql: COALESCE(1.0*${completed_75}/nullif(${impressions},0),0);;
  }

  measure: completed_100 {
    type: sum
    label: "Completes"
    view_label: "TPM Metrics"
    description: "The sum of impressions that were completed as provided by the third party."
    value_format_name: decimal_0
    sql: Case when ${metric_type} = 6 then ${metric_value} else 0 end ;;
  }

  measure: VTR {
    type: number
    label: "VTR"
    view_label: "TPM Metrics"
    description: "Video Thru Rate calculated as the sum of impressions that were completed divided by total impressions."
    value_format_name: percent_2
    sql: COALESCE(1.0*${completed_25}/nullif(${impressions},0),0);;
  }

  measure: swipes {
    type: sum
    label: "Swipes"
    view_label: "TPM Metrics"
    description: "The sum of all swipes as provided by the third party."
    value_format_name: decimal_0
    sql: Case when ${metric_type} = 8 then ${metric_value} else 0 end ;;
  }
  measure: avg_view_time {
    type: average
    label: "Avg View Time"
    view_label: "TPM Metrics"
    description: "The average view time as provided by the third party."
    sql: Case when ${metric_type} = 9 then ${metric_value} else 0 end ;;
  }


  dimension: period_end {
    type: date_time
    hidden: yes
    sql: ${TABLE}.PERIOD_END ;;
  }

  dimension_group: period_end_date {
      type: time
      label: "End Date"
      view_label: "Dates"
      timeframes: [time,hour,date,month,quarter,year,raw]
      description: "The date/time of the impression in UTC"
      sql: ${period_end} ;;
  }

  dimension: period_start {
    type: date_time
    hidden: yes
    sql: ${TABLE}.PERIOD_START ;;
  }

  dimension_group: period_start_date {
    type: time
    label: "Start Date"
    view_label: "Dates"
    timeframes: [time,hour,date,month,quarter,year,raw]
    description: "The date/time of the impression in UTC"
    sql: ${period_start} ;;
  }

  dimension: placement_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PLACEMENT_ID ;;
  }

  dimension: plan_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PLAN_ID ;;
  }

  dimension: provenance_tracking {
    type: string
    hidden: yes
    sql: ${TABLE}.PROVENANCE_TRACKING ;;
  }

  dimension: publisher_id {
    type: string
    hidden: yes
    sql: ${TABLE}.PUBLISHER_ID ;;
  }

  dimension: spend {
    type: number
    hidden: yes
    sql: ${TABLE}.SPEND ;;
  }

  measure: sum_spend {
    type: sum
    label: "Spend"
    view_label: "TPM Metrics"
    description: "The sum of all spend as provided by the third party."
    value_format_name: decimal_2
    sql: ${spend};;
  }

  dimension: tppid {
    type: string
    label: "Provider Id"
    view_label: "TPM Facets"
    description: "The source ID (typically platform client) that provides the metrics."
    sql: ${TABLE}.TPPID ;;
  }

  dimension: tz_offset {
    type: string
    hidden: yes
    sql: ${TABLE}.TZ_OFFSET ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
