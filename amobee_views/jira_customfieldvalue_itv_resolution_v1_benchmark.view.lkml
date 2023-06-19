view: customfieldvalue_itv_resolution_v1_benchmark {
  sql_table_name: public.customfieldvalue ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: issue {
    type: number
    hidden: yes
    sql: ${TABLE}.issue ;;
  }

  dimension: customfield {
    type: number
    hidden: yes
    sql: ${TABLE}.customfield ;;
  }

  dimension: itv_resolution_v1_benchmark {
    type: string
    label: "Raw Data"
    view_label: "ITV Resolution - V1 Benchmark"
    sql: ${TABLE}.textvalue ;;
  }

  dimension: succeeded {
    type: yesno
    label: "Succeeded"
    view_label: "ITV Resolution - V1 Benchmark"
    sql: (${TABLE}.textvalue::json #>> '{completeSLAData, 0, succeeded}')::bool ;;
  }

  dimension: goal_time {
    type: string
    label: "Goal Time"
    view_label: "ITV Resolution - V1 Benchmark"
    sql: (to_timestamp((${TABLE}.textvalue::json #>> '{completeSLAData, 0, goalTime}')::float / 1000) at time zone 'UTC' - '1970-01-01')::text ;;
  }

  dimension: elapsed_time {
    type: string
    label: "Elapsed Time"
    view_label: "ITV Resolution - V1 Benchmark"
    sql: (to_timestamp((${TABLE}.textvalue::json #>> '{completeSLAData, 0, elapsedTime}')::float / 1000) at time zone 'UTC' - '1970-01-01')::text ;;
  }

  dimension: remaining_time {
    type: string
    label: "Remaining Time"
    view_label: "ITV Resolution - V1 Benchmark"
    sql: (to_timestamp((${TABLE}.textvalue::json #>> '{completeSLAData, 0, remainingTime}')::float / 1000) at time zone 'UTC' - '1970-01-01')::text ;;
  }

  dimension: calendar_name {
    type: string
    label: "Calendar Name"
    view_label: "ITV Resolution - V1 Benchmark"
    sql: ${TABLE}.textvalue::json #>> '{completeSLAData, 0, calendarName}' ;;
  }

  dimension_group: start_time {
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
    label: "Start Time"
    view_label: "ITV Resolution - V1 Benchmark"
    sql: to_timestamp((${TABLE}.textvalue::json #>> '{completeSLAData, 0, startTime}')::float / 1000) ;;
  }

  dimension_group: stop_time {
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
    label: "Stop Time"
    view_label: "ITV Resolution - V1 Benchmark"
    sql: to_timestamp((${TABLE}.textvalue::json #>> '{completeSLAData, 0, stopTime}')::float / 1000) ;;
  }
}
