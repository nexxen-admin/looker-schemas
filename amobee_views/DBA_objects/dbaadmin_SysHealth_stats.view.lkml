view: dbaadmin_SysHealth_stats {
  sql_table_name: HeartBeatCollector.tbl_SystemHealthLog ;;

  dimension: cpu_idle {
    type: number
    value_format_name: id
    sql: ${TABLE}.cpu_idle ;;
  }

  dimension: cpu_sql {
    type: number
    sql: ${TABLE}.cpu_sql ;;
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

  measure: count {
    type: count
    drill_fields: []
  }

  measure: avg_cpu_sql {
    type: average
    sql: ${cpu_sql} ;;
  }

  measure: min_cpu_sql {
    type: min
    sql: ${cpu_sql} ;;
  }

  measure: max_cpu_sql {
    type: max
    sql: ${cpu_sql} ;;
  }

}
