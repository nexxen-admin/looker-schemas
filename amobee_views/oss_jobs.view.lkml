view: oss_jobs {
  sql_table_name: public.jobs ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    value_format_name: id
  }

  dimension_group: job_end {
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
    sql: ${TABLE}.job_end_time ;;
  }

  dimension_group: job_start {
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
    sql: ${TABLE}.job_start_time ;;
  }

  dimension_group: today {
    type: time
    timeframes: [day_of_month, month, month_num, date, raw]
    sql: current_date ;;
  }

  dimension: job_name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: job_status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: count {
    type: count
    drill_fields: [id, job_name]
  }
}
