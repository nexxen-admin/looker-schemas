view: jobs {
  sql_table_name: scheduler.jobs ;;

  dimension: id {
    primary_key: yes
    type: string
    description: "Unique identifer for the job."
    sql: ${TABLE}.id ;;
    link: {
      label: "Detail Job History"
      url: "/dashboards/38?Job ID={{ value }}"
  }
    link: {
      label: "Manage"
      url: "https://scheduler.inf.videologygroup.com/gui/index.html#/jobs/{{ value }}"
    }
}
  dimension: capability {
    type: string
    description: "The capabilities of this particular job(script, oozie, etc.)."
    sql: ${TABLE}.capability ;;
  }

  dimension: concurrency {
    type: number
    description: "The number of these jobs that can be running at the same time."
    sql: ${TABLE}.concurrency ;;
  }

  dimension_group: created {
    type: time
    description: "The date the Job was created."
    view_label: "Dates"
    label: "Job Created"
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

  dimension: fail_email {
    type: string
    description: "The e-mail address that any failure e-mails will be sent to."
    sql: ${TABLE}.fail_email ;;
  }

  dimension: instance_count {
    type: number
    description: "The number of job executions that will be created when the objective fires."
    sql: ${TABLE}.instance_count ;;
  }

  dimension: job_parameters {
    type: string
    hidden: yes
    sql: ${TABLE}.job_parameters ;;
  }

  dimension: job_size {
    type: number
    hidden: yes
    sql: ${TABLE}.job_size ;;
  }

  dimension: job_size_estimate {
    type: string
    hidden: yes
    sql: ${TABLE}.job_size_estimate ;;
  }

  dimension: max_duration_in_sec {
    type: number
    description: "The max duration a job is allowed to run before it times out."
    sql: ${TABLE}.max_duration_in_sec ;;
  }

  dimension: num_retries {
    type: number
    label: "Job retires"
    description: "The number of times a failed job will retry before it stops running."
    sql: ${TABLE}.num_retries ;;
  }

  dimension: objective_id {
    type: number
    hidden: yes
    sql: ${TABLE}.objective_id ;;
  }

  dimension: paused {
    type: string
    description: "A yes/no indicator if the job is paused."
    sql: ${TABLE}.paused ;;
  }

  dimension: resource_type {
    type: string
    hidden: yes
    sql: ${TABLE}.resource_type ;;
  }

  dimension: retry_wait_time {
    type: number
    description: "The number, in seconds, that the job will wait between retires."
    sql: ${TABLE}.retry_wait_time ;;
  }

  dimension: runbook {
    type: string
    description: "A link to the runbook to fix a failure of the job."
    sql: ${TABLE}.runbook ;;
  }

  dimension: sla_email {
    type: string
    sql: ${TABLE}.sla_email ;;
  }

  dimension: success_email {
    type: string
    description: "The e-mail address that a successful job execution status is sent to."
    sql: ${TABLE}.success_email ;;
  }

  dimension: text {
    type: string
    label: "Job Description"
    description: "The description of the job."
    sql: ${TABLE}.text ;;
  }

  dimension: timeout_on_upstream_delays {
    type: yesno
    hidden: yes
    sql: ${TABLE}.timeout_on_upstream_delays ;;
  }

  dimension: title {
    type: string
    label: "Job Name"
    description: "The name of the job."
    sql: ${TABLE}.title ;;
  }

  dimension_group: updated {
    type: time
    label: "Job Updated"
    view_label: "Dates"
    description: "The date the job was last updated/"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_date ;;
  }

  dimension: value {
    type: number
    hidden: yes
    sql: ${TABLE}.value ;;
  }

  measure: count {
    type: count
    drill_fields: [id, objectives.id, job_executions.count, job_tag_link.count]
  }
}
