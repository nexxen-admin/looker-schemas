view: job_executions_last_30_days {
  derived_table: {
    sql:
    select
      j.title,
      j.id,
      cast(avg(case when end_date is null then timediff(now(),start_date) else timediff(end_date,start_date) end) as time) as run_time
        from job_executions je
        join jobs j on je.job_id = j.id
       where start_date >= date_add(now(), INTERVAL -30 DAY)
      group by 1,2;;
  }


  measure: 30day_avg_run_time {
    type: date_time
    label: "Avgerage Execution Run Time - Last 30 Days"
    description: "The run time of the Job.  If the job is still running the amount of time from when it start until the report run time."
    view_label: "Jobs"
    sql: ${TABLE}.run_time;;
  }



  dimension: job_id {
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

}
