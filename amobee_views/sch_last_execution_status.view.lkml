view: last_execution_status {
  view_label: "Last Execution Status"
  derived_table: {
    sql: select
      je.job_id,
      j.title,
      je.job_execution_status,
      je.start_date,
      je.end_date
        FROM scheduler.job_executions je
        LEFT JOIN scheduler.jobs j on je.job_id = j.id
        JOIN
        (SELECT
        je.job_id,
        max(start_date) as last_start_date
        FROM scheduler.job_executions je
      where job_execution_status != 'NOT READY'
      group by 1 ) me on me.job_id = je.job_id and me.last_start_date = je.start_date ;;
  }

  dimension: id {
    primary_key: yes
    type: string
    description: "Unique Identifier for the job execution."
    sql: ${TABLE}.job_id ;;
  }

  dimension: last_execution_status {
    type: string
    label: "Last Execution Status"
    description: "The status of the last execution of the job."
    sql: ${TABLE}.job_execution_status ;;
  }

  dimension_group: last_start {
    type: time
    label: "Last Execution Start"
    view_label: "Dates"
    description: "The date of the last execution start."
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
    sql: ${TABLE}.start_date ;;
  }

  dimension_group: last_end {
    type: time
    label: "Last Execution End"
    view_label: "Dates"
    description: "The date of the last execution end (if applicable)."
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
    sql: ${TABLE}.end_date ;;
  }


}
