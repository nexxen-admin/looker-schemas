view: dbaadmin_CDC_stats {
    derived_table: {
      sql:  select
            record_time,
            start_time,
            end_time,
            latency,
            coalesce(duration - LAG(duration) OVER (partition by start_time ORDER BY end_time),0) as duration,
            coalesce(error_count - LAG(error_count) OVER (partition by start_time ORDER BY end_time),0) as error_count,
            coalesce(tran_count - LAG(tran_count) OVER (partition by start_time ORDER BY end_time),0) as tran_count,
            coalesce(log_record_count - LAG(log_record_count) OVER (partition by start_time ORDER BY end_time),0) as log_record_count,
            coalesce(schema_change_count - LAG(schema_change_count) OVER (partition by start_time ORDER BY end_time),0) as schema_change_count,
            coalesce(command_count - LAG(command_count) OVER (partition by start_time ORDER BY end_time),0) as command_count,
            coalesce(failed_sessions_count - LAG(failed_sessions_count) OVER (partition by start_time ORDER BY end_time),0) as failed_sessions_count
            FROM HeartBeatCollector.tbl_CDCStatisticsLog
            WHERE DATEDIFF(MINUTE,start_time,end_time)>=5
      ;;
    }

  dimension: command_count {
    type: number
    sql: ${TABLE}.command_count ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension_group: end {
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
    sql: ${TABLE}.end_time ;;
  }

  dimension: error_count {
    type: number
    sql: ${TABLE}.error_count ;;
  }

  dimension: failed_sessions_count {
    type: number
    sql: ${TABLE}.failed_sessions_count ;;
  }

  dimension: latency {
    type: number
    sql: ${TABLE}.latency ;;
  }

  dimension: log_record_count {
    type: number
    sql: ${TABLE}.log_record_count ;;
  }

  dimension_group: record {
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
    sql: ${TABLE}.record_time ;;
  }

  dimension: schema_change_count {
    type: number
    sql: ${TABLE}.schema_change_count ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.start_time ;;
  }

  dimension: tran_count {
    type: number
    sql: ${TABLE}.tran_count ;;
  }

  measure: max_latency {
    type: max
    sql: ${latency} ;;
  }

  measure: avg_performance {
    type: average
    sql: ${command_count}/NULLIF(${duration},0) ;;
  }

  measure: avg_command_count {
    type: average
    sql: ${command_count} ;;
  }



}
