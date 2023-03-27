view: job_execution_trackers {
  sql_table_name: scheduler.job_execution_trackers ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    label: "Execution History Created Date"
    view_label: "Dates"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_date ;;
  }

  dimension: job_execution_id {
    type: number
    hidden: yes
    sql: ${TABLE}.job_execution_id ;;
  }

  dimension: job_execution_status {
    type: string
    label: "Job History Execution Status"
    view_label: "Job Executions"
    description: "The history of the job excutions, not just the current state."
    sql: ${TABLE}.job_execution_status ;;
  }

  dimension: text {
    type: string
    hidden: yes
    sql: ${TABLE}.text ;;
  }

  measure: job_misery_index {
    type: number
    value_format_name: decimal_4
    label: "Job Misery Index"
    view_label: "Job Executions"
    description: "An indicator of how noisy a job is.
    The number of times a job execution history error or failed
    divided by the number of times the job error, failed or finished."
    sql: sum(case when ${job_execution_status} in ('error', 'failed') then 1 else 0 end)
          / sum(case when ${job_execution_status} in ('error', 'failed', 'finished') then 1 else 0 end);;
  }

  measure: weighted_job_misery_index {
    type: number
    value_format_name: decimal_4
    label: "Weighted Job Misery Index"
    view_label: "Job Executions"
    description: "A weighted indicator of how noisy a job is.
    The number of times a job execution history error or failed
    divided by the number of times the job error, failed or finished.
    Errors are weighted as .1 and failures as 1"
    sql: (sum(case when ${job_execution_status} ='error' then .1 else 0 end)
        +  sum(case when ${job_execution_status} ='failed' then 1 else 0 end))
      / (sum(case when ${job_execution_status} ='error' then .1 else 0 end)
        + sum(case when ${job_execution_status} in ('failed', 'finished') then 1 else 0 end));;
  }

  measure: weighted_misery_factor {
    type: number
    value_format_name: decimal_0
    label: "Weighted Misery Factor"
    view_label: "Job Executions"
    description: "A weighted number where timeout counts as 1, error 5, failed is 20,
    and if the failure email contains pagerduty, then failed counts as 100."
    sql: sum(CASE when ${job_execution_status} = 'timeout' then 1 else 0 end)
          + sum(CASE when ${job_execution_status} = 'error' then 5 else 0 end)
          + sum(CASE when ${job_execution_status} = 'failed' and ${jobs.fail_email}
              not like '%pagerduty%' then 20 else 0 end)
          + sum(CASE when ${job_execution_status} = 'failed' and ${jobs.fail_email}
              like '%pagerduty%' then 100 else 0 end)
        ;;
  }

  measure: count {
    type: count
    label: "Count of Job History Executions"
    view_label: "Job Executions"
    drill_fields: [id]
  }
}
