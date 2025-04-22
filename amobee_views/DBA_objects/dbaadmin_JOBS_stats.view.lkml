view: dbaadmin_JOBS_stats {

  derived_table: {
    sql: select instance_id, name, step_name, run_status, date_executed=msdb.dbo.agent_datetime(run_date, run_time),
          secs_duration=cast(run_duration/10000*3600
                                +run_duration%10000/100*60
                                +run_duration%100 as bigint)
          FROM msdb.dbo.sysjobhistory jh
          join msdb.dbo.sysjobs j
          on jh.job_id = j.job_id
      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: instance_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.instance_id ;;
  }

  dimension: job_name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: step_name {
    type: string
    sql: ${TABLE}.step_name ;;
  }

  dimension: run_status {
    type: number
    sql: ${TABLE}.run_status ;;
  }

  dimension: secs_duration {
    type: number
    sql: ${TABLE}.secs_duration ;;
  }

  dimension_group:  executed{
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_executed ;;
  }

  measure: avg_secs_duration {
    type: average
    sql: ${secs_duration} ;;
  }
  measure: max_secs_duration {
    type: max
    sql: ${secs_duration} ;;
  }
  measure: min_secs_duration {
    type: min
    sql: ${secs_duration} ;;
  }

  measure: executions_count {
    type: sum
    sql: case when ${step_name} = '(Job outcome)' THEN 1 else 0 end;;
  }

  measure: total_hours_duration {
    type: number
    value_format: "0.00"
    sql: cast(${avg_secs_duration} as decimal(20,4))*${executions_count}/60/60 ;;
  }


}
