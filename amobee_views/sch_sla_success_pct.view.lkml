view: sla_success_pct {
  derived_table: {
    sql:
      select
        j.id as job_id,
        je.id as job_execution_id,
        substring_index(max(je.unique_id), '_', -1) as timezone_id,
        max(je.start_date > je.sla_date) as is_sla_missed
      from
        jobs j
          join job_executions je
            on j.id = je.job_id
      where
        je.sla_date is not null and
        {% condition job_executions.ready_hour %} je.ready_date {% endcondition %} and
        {% condition job_executions.ready_date %} je.ready_date {% endcondition %} and
        {% condition job_executions.ready_month %} je.ready_date {% endcondition %}
      group by
        j.id,
        je.id ;;
  }

  dimension: job_id {
    type: number
    hidden: yes
    sql: ${TABLE}.job_id ;;
  }

  dimension: job_execution_id {
    type: number
    hidden: yes
    sql: ${TABLE}.job_execution_id ;;
  }

  measure: num_of_timezones {
    type: count_distinct
    label: "Number of Timezones"
    view_label: "Job Executions"
    sql: ${TABLE}.timezone_id ;;
  }

  measure: num_of_executions_misses{
    type: sum
    label: "Number of Executions Missed"
    view_label: "Job Executions"
    sql: ${TABLE}.is_sla_missed ;;
  }

  measure: pct_success {
    type: number
    label: "Percent SLA Success"
    description: "The percentage of job executions that completed successfully within the SLA."
    view_label: "Job Executions"
    value_format_name: percent_2
    sql: (((${num_of_timezones})*${job_executions.num_of_days}) - ${num_of_executions_misses}) / ((${num_of_timezones}) * ${job_executions.num_of_days});;
  }
}
