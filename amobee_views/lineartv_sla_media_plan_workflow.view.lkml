view: media_plan_workflow {

  derived_table: {
    sql:
      select *
      from sla.raw_metric_minute
      where metric_id = 'atv.mediaplan.job.planning_workflow' and check_json(metric_tag) is NULL ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}."CREATED_TIME" AS TIMESTAMP_NTZ) ;;
  }

  dimension: platform_client_id {
    type: string
    sql: ${TABLE}.platform_client_id ;;
  }

  # dimensions from metric_tag json object

  dimension: platform_client_id_mtag {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'platformClientId');;
  }

  dimension: platform_client_name {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'platformClientName');;
  }

  dimension: campaign_id {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'campaignId');;
  }

  dimension: campaign_name {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'campaignName');;
  }

  dimension: workflow_id {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'workflowId');;
  }

  dimension: workflow_status {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'workflowStatus');;
  }

  dimension: workflow_reason_for_incompletion {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'workflowReasonForIncompletion');;
  }

  dimension: workflow_duration {
    type: number
    # Convert from ms to min
    sql: case when try_to_double(json_extract_path_text(${TABLE}."METRIC_TAG", 'workflowDuration')) is null
      then 0 else round(to_double(json_extract_path_text(${TABLE}."METRIC_TAG", 'workflowDuration')) / 60000, 2) end ;;
  }

  dimension_group: workflow_start_time {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: try_to_timestamp_tz(json_extract_path_text(${TABLE}."METRIC_TAG", 'workflowStartTime'), 'YYYY-MM-DDTHH24:MI:SS.FF3 TZHTZM');;
  }

  dimension_group: workflow_end_time {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: try_to_timestamp_tz(json_extract_path_text(${TABLE}."METRIC_TAG", 'workflowEndTime'), 'YYYY-MM-DDTHH24:MI:SS.FF3 TZHTZM');;
  }

  dimension: task_status {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'taskStatus');;
  }

  dimension: task_reason_for_incompletion {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'taskReasonForIncompletion');;
  }

  dimension: task_duration {
    type: number
    # Convert from ms to min
    sql: case when try_to_double(json_extract_path_text(${TABLE}."METRIC_TAG", 'taskDuration')) is null
      then 0 else round(to_double(json_extract_path_text(${TABLE}."METRIC_TAG", 'taskDuration')) / 60000, 2) end ;;
  }

  dimension: user_name {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'userName');;
  }

  dimension: task_id {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'taskId');;
  }

  dimension: task_name {
    type: string
    sql: json_extract_path_text(${TABLE}."METRIC_TAG", 'taskName');;
  }

  dimension_group: task_start_time {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: try_to_timestamp_tz(json_extract_path_text(${TABLE}."METRIC_TAG", 'taskStartTime'), 'YYYY-MM-DDTHH24:MI:SS.FF3 TZHTZM');;
  }

  dimension_group: task_end_time {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: try_to_timestamp_tz(json_extract_path_text(${TABLE}."METRIC_TAG", 'taskEndTime'), 'YYYY-MM-DDTHH24:MI:SS.FF3 TZHTZM');;
  }

  # end of dimensions from metric_tag


  dimension: metric_id {
    type: string
    sql: ${TABLE}."METRIC_ID" ;;
  }

  dimension: metric_tag {
    type: string
    sql: ${TABLE}."METRIC_TAG" ;;
  }

  dimension_group: metric {
    type: time
    timeframes: [
      raw,
      time,
      date,
      day_of_week,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."METRIC_TIME" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."REGION" ;;
  }

  # Task duration measures

  measure: min_task_duration {
    type:  min
    value_format: "0.##"
    sql: ${task_duration}  ;;
  }

  measure: median_task_duration {
    type:  median
    value_format: "0.##"
    sql: ${task_duration}  ;;
  }

  measure: max_task_duration {
    type:  max
    value_format: "0.##"
    sql: ${task_duration}  ;;
  }

  measure: avg_task_duration {
    type:  average
    value_format: "0.##"
    sql: ${task_duration}  ;;
  }

  measure: 25th_percentile_task_duration {
    type:  percentile
    percentile: 25
    value_format: "0.##"
    sql: ${task_duration}  ;;
  }

  measure: 75th_percentile_task_duration {
    type:  percentile
    percentile: 75
    value_format: "0.##"
    sql: ${task_duration}  ;;
  }

  # Workflow duration measures

  measure: min_workflow_duration {
    type:  min
    value_format: "0.##"
    sql: ${workflow_duration}  ;;
  }

  measure: median_workflow_duration {
    type:  median
    value_format: "0.##"
    sql: ${workflow_duration}  ;;
  }

  measure: max_workflow_duration {
    type:  max
    value_format: "0.##"
    sql: ${workflow_duration}  ;;
  }

  measure: avg_workflow_duration {
    type:  average
    value_format: "0.##"
    sql: ${workflow_duration}  ;;
  }

  measure: 25th_percentile_workflow_duration {
    type:  percentile
    percentile: 25
    value_format: "0.##"
    sql: ${workflow_duration}  ;;
  }

  measure: 75th_percentile_workflow_duration {
    type:  percentile
    percentile: 75
    value_format: "0.##"
    sql: ${workflow_duration}  ;;
  }

  measure: 98th_percentile_workflow_duration {
    type:  percentile
    percentile: 98
    value_format: "0.##"
    sql: ${workflow_duration}  ;;
  }

  measure: count {
    type:  count
  }

}
