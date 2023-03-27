view: process_message {
     derived_table: {
    sql: select raw_message:info as info,
raw_message:measurement_eventtime_utc::timestamp as measurement_eventtime_utc,
raw_message:period_from_utc::timestamp as period_from_utc,
raw_message:period_to_utc::timestamp as period_to_utc,
raw_message:process_namespace::varchar as process_namespace,
f.value as measure
from CLARITY.RAW.PROCESS_MESSAGE m, lateral flatten(input=>raw_message:measures) f
      ;;   }


dimension_group: measurement_event_time {
  type: time
  label: "Measurement Event Time"
  timeframes: [
    raw,
    time,
    hour,
    date,
    week,
    month,
    quarter,
    year
  ]
  convert_tz: no
  description: "The date/time of the measurement event"
  sql: ${TABLE}.measurement_eventtime_utc ;;
}

  dimension_group: period_from_utc {
    type: time
    label: "Period Start Time"
    timeframes: [
      raw,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    description: "The date/time the event started in UTC"
    sql: ${TABLE}.period_from_utc ;;
  }

  dimension_group: period_to_utc {
    type: time
    label: "Period End Time"
    timeframes: [
      raw,
      hour,
      date,
      week,
      month,
      quarter,
      year

    ]
    convert_tz: no
    description: "The date/time the event ended in UTC"
    sql: ${TABLE}.period_to_utc ;;
  }

dimension: process_namespace{
    type: string
    label: "Process Namespace"
    sql: ${TABLE}.process_namespace::varchar ;;
}

dimension: metric{
  type: string
  label: "Metric"
  sql: ${TABLE}.measure:metric::varchar ;;
}

  dimension: metric_value {
    type: number
    #hidden: yes
    sql:  ${TABLE}.measure:metricvalue::double;;
  }

  measure: sum_metric_value {
    type: sum
    label: "Total of Metric Value"
    value_format_name: decimal_2
    sql:  ${metric_value};;
  }

  measure: avg_metric_value {
    type: average
    label: "Average Metric Value"
    value_format_name: decimal_2
    sql:  ${metric_value};;
  }

  measure: min_metric_value {
    type: min
    label: "Minimum Metric Value"
    value_format_name: decimal_2
    sql:  ${metric_value};;
  }

  measure: max_metric_value {
    type: max
    label: "Maximum Metric Value"
    value_format_name: decimal_2
    sql:  ${metric_value};;
  }

  measure: count_metric_value {
    type: number
    label: "Count Metric Value "
    value_format_name: decimal_0
    sql:  count(${metric_value});;
  }


  dimension: business_region {
    sql: ${TABLE}.info:business_region_id::varchar ;;
  }

  dimension: application {
    sql: ${TABLE}.info:application::varchar ;;
  }

  dimension: platform {
    sql: ${TABLE}.info:platform::varchar ;;
  }

  dimension: environment {
    sql: ${TABLE}.info:environment::varchar ;;
  }

  dimension: offering {
    label: "Offering"
    sql: ${TABLE}.info:offering::varchar ;;
  }

  dimension: region {
    label: "Region"
    sql: ${TABLE}.info:region::varchar ;;
  }

  dimension: source {
    label: "Source"
    sql: ${TABLE}.info:source::varchar ;;
  }

  dimension: comment {
    label: "Comment"
    sql: ${TABLE}.info:comment::varchar ;;
  }
  dimension: device {
    label: "Device"
    sql: ${TABLE}.info:device::varchar ;;
  }
  dimension: checkpoint {
    label: "Checkpoint"
    sql: ${TABLE}.info:checkpoint::varchar ;;
  }
  dimension: baseline_id {
    label: "Baseline ID"
    sql: ${TABLE}.info:baseline_id::varchar ;;
  }
  dimension: rta_group_id {
    label: "RTA Group Id"
    sql: ${TABLE}.info:rta_group_id::varchar ;;
  }

}
