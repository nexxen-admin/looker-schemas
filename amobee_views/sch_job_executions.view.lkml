view: job_executions {
  sql_table_name: scheduler.job_executions ;;

  dimension: id {
    primary_key: yes
    type: number
    description: "Unique Identifier for the job execution."
    sql: ${TABLE}.id ;;
    value_format_name: id
  }

  dimension: scheduler_link {
    type: string
    label: "Scheduler Link"
    sql: ${TABLE}.id;;
    link: {
      label: "Link to Scheduler"
      url: "https://scheduler.inf.videologygroup.com/gui/index.html#/jobExecutions/{{ value }}"
      }
  }

  dimension: capability {
    type: string
    description: "The type of job that this execution is capable of (script, oozie, etc.)"
    sql: ${TABLE}.capability ;;
  }

  dimension_group: created {
    type: time
    label: "Execution Created"
    view_label: "Dates"
    description: "The date that the job execution was created."
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
    sql: ${TABLE}.created_date ;;
  }

  dimension_group: end {
    type: time
    label: "Execution End"
    view_label: "Dates"
    description: "The date that the job execution ended."
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

  dimension: instance_number {
    type: number
    description: "Ask Shifty"
    sql: ${TABLE}.instance_number ;;
  }

  dimension: job_execution_status {
    type: string
    description: "The current stats of the job execution (Finished, Failed, Running, etc.)"
    sql: ${TABLE}.job_execution_status ;;
  }

  dimension: job_id {
    type: number
    label: "Job Execution ID"
    description: "Unique identifer for each individual job execution."
    # hidden: yes
    sql: ${TABLE}.job_id ;;
    value_format_name: id
  }

  dimension: job_parameters {
    type: string
    description: "The parameters passed into the job upon execution."
    sql: ${TABLE}.job_parameters ;;
  }

  dimension: job_title {
    type: string
    hidden: yes
    sql: ${TABLE}.job_title ;;
  }

  dimension: output {
    type: string
    description: "Any additional information outputted by the job.  These are typically just informational messages."
    sql: ${TABLE}.output ;;
  }

  dimension_group: ready {
    type: time
    label: "Execution Ready"
    view_label: "Dates"
    description: "The date that the job was marked as ready to execute."
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
    sql: ${TABLE}.ready_date ;;
  }

  dimension: resource_id {
    type: string
    description: "The resource (server) that ran the job execution."
    sql: ${TABLE}.resource_id ;;
  }

  dimension: result {
    type: string
    description: "The output of the utility that runs the job.  This could be error codes or success messages."
    sql: ${TABLE}.result ;;
  }

  dimension: retries {
    type: number
    description: "The number of retries for that job."
    sql: ${TABLE}.retries ;;
  }

  dimension: schedule_id {
    type: number
    hidden: yes
    sql: ${TABLE}.schedule_id ;;
  }

  dimension: sla_alerted {
    type: string
    description: "A yes/no indicator if the job missed its SLA."
    sql: ${TABLE}.sla_alerted ;;
  }

  dimension_group: sla {
    type: time
    label: "SLA Alerted"
    view_label: "Dates"
    description: "The time that the SLA was missed."
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
    sql: ${TABLE}.sla_date ;;
  }

  dimension_group: start {
    type: time
    label: "Execution Start"
    view_label: "Dates"
    description: "The time the job execution started."
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


  measure: run_time {
    type: date_time
    label: "Execution Run Time"
    description: "The run time of the Job.  If the job is still running the amount of time from when it start until the report run time."
    sql: case when end_date is null then timediff(now(),start_date) else timediff(end_date,start_date) end ;;
  }

  measure: avg_run_time {
    type: date_time
    label: "Avgerage Execution Run Time"
    description: "The average run time of the Job.  If the job is still running the amount of time from when it start until the report run time."
    view_label: "Jobs"
    sql:cast(avg(case when end_date is null then timediff(now(),start_date) else timediff(end_date,start_date) end) as time);;
  }


  measure: avg_start_delay {
    type: date_time
    label: "Avgerage Execution Start Delay"
    description: " "
    view_label: "Jobs"
    sql: cast(avg( timediff(${start_date},${ready_date}) ) as time) ;;
  }


  measure: run_time_seconds {
    type: number
    label: "Execution Run Time in Seconds"
    description: "The run time of the Job.  If the job is still running the amount of time from when it start until the report run time."
    sql: case when end_date is null then timestampdiff(second,start_date,now()) else timestampdiff(second,start_date,end_date) end ;;
  }


  dimension: unique_id {
    type: string
    #hidden: yes
    sql: ${TABLE}.unique_id ;;
  }

  dimension: timezone_id {
    type: number
    label: "Timezone ID"
    description: "Timezone ID derived from job execution unique ID"
    sql: substring_index(${unique_id}, '_', -1) ;;
  }

  dimension: timezone_code {
    type: string
    label: "Timezone Code"
    description: "Timezone Code derived from job execution unique ID"
    sql: case ${timezone_id}
           when 1 then 'MIT'
           when 3 then 'HST'
           when 5 then 'AST'
           when 8 then 'PST'
           when 9 then 'MST'
           when 11 then 'PNT'
           when 15 then 'CST'
           when 16 then 'EST'
           when 23 then 'PRT'
           when 24 then 'AST'
           when 29 then 'AGT'
           when 30 then 'BET'
           when 33 then 'CAT'
           when 37 then 'GMT'
           when 39 then 'CET'
           when 48 then 'EET'
           when 50 then 'ART'
           when 51 then 'EAT'
           when 53 then 'NET'
           when 55 then 'PLT'
           when 57 then 'BST'
           when 59 then 'VST'
           when 61 then 'CTT'
           when 64 then 'JST'
           when 67 then 'AET'
           when 70 then 'SST'
           when 73 then 'NST'
         end ;;
  }

  dimension: utc_offset {
    type: string
    label: "UTC Offset"
    description: "Timezone UTC offset derived from job execution unique ID"
    sql: case ${timezone_id}
           when 1 then '-11'
           when 3 then '-10'
           when 5 then '-9'
           when 8 then '-8'
           when 9 then '-7'
           when 11 then '-7'
           when 15 then '-6'
           when 16 then '-5'
           when 23 then '-4'
           when 24 then '-4'
           when 29 then '-3'
           when 30 then '-3'
           when 33 then '-1'
           when 37 then '0'
           when 39 then '1'
           when 48 then '2'
           when 50 then '2'
           when 51 then '3'
           when 53 then '4'
           when 55 then '5'
           when 57 then '6'
           when 59 then '7'
           when 61 then '8'
           when 64 then '9'
           when 67 then '10'
           when 70 then '11'
           when 73 then '12'
         end ;;
  }

  dimension_group: updated {
    type: time
    label: "Execution Update"
    view_label: "Dates"
    description: "The last time the job execution times were updated."
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
    sql: ${TABLE}.updated_date ;;
  }

  measure: count {
    type: count
    drill_fields: [id, schedules.id, jobs.id, job_execution_predecessors.count, job_execution_trackers.count]
  }


  measure: num_of_days {
    type: count_distinct
    label: "Number of Days Included"
    view_label: "Job Executions"
    sql: date(${TABLE}.ready_date) ;;
    }

  dimension: days_in_current_month {
    type: number
    label: "Days in Current Month"
    description: "Number of Days in the current month."
    sql: DAY(LAST_DAY(now())) ;;
    }

  dimension: days_in_select_month {
    type: number
    label: "Days in Selected Month (Execution Ready Date)"
    description: "Number of days in the selected 'Execution Ready Date' month"
    sql: DAY(LAST_DAY(${TABLE}.ready_date)) ;;
  }

}
