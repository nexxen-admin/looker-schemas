view: snowflake_query_history {
  sql_table_name: DPSYSTEMS.QUERY_HISTORY;;


dimension: query_id {
  sql: ${TABLE}.query_id;;
  drill_fields: [query_text]
}

dimension: query_text {
  type: string
  sql: ${TABLE}.query_text ;;
}

dimension: database_name {
  type: string
  sql: ${TABLE}.database_name ;;
}

dimension: schema_name {
  type: string
  sql: ${TABLE}.schema_name ;;
}

dimension: query_type {
  type: string
  sql: ${TABLE}.query_type ;;
}


  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id;;
  }


  dimension: user_name {
    type: string
    sql: ${TABLE}.user_name ;;
  }


  dimension: role_name {
    type: string
    sql: ${TABLE}.role_name ;;
  }


  dimension: warehouse_name {
    type: string
    sql: ${TABLE}.warehouse_name ;;
  }


  dimension: warehouse_size {
    type: string
    sql: ${TABLE}.warehouse_size ;;
  }


  dimension: warehouse_type {
    type: string
    sql: ${TABLE}.warehouse_type ;;
  }


  dimension: query_tag {
    type: string
    sql: ${TABLE}.query_tag ;;
  }


  dimension: execution_status {
    type: string
    sql: ${TABLE}.execution_status ;;
  }

  dimension: error_code {
    type: string
    sql: ${TABLE}.error_code ;;
  }


  dimension: error_message {
    type: string
    sql: ${TABLE}.error_message ;;
  }

  dimension_group: start {
    type: time
    label: "Start Time"
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

  dimension_group: end {
    type: time
    label: "End Time"
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

  dimension: total_elapsed_time {
    type: number
    hidden: yes
    sql: ${TABLE}.total_elapsed_time ;;
  }

 measure: max_total_elapsed_time {
    type: number
    label: "Max Total Elapsed Time in Seconds"
    sql: max(${total_elapsed_time}) /1000;;
  }

  measure: formatted_max_total_elapsed_time {
    type: string
    label: "Max Total Elapsed Time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(max(${total_elapsed_time}) ,3)) AS STRING);;
  }

  measure: min_total_elapsed_time {
    type: number
    label: "Min Total Elapsed Time in Seconds"
    sql: min(${total_elapsed_time}) / 1000;;
  }

  measure: formatted_min_total_elapsed_time {
    type: string
    label: "Min Total Elapsed Time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(min(${total_elapsed_time}) ,3)) AS STRING);;
  }

  measure: avg_total_elapsed_time {
    type: number
    label: "Average Total Elapsed Time in Seconds"
    sql: avg(${total_elapsed_time}) / 1000;;
  }

  measure: formatted_avg_total_elapsed_time {
    type: string
    label: "Average Total Elapsed Time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(avg(${total_elapsed_time}) ,3)) AS STRING);;
  }

  dimension: compilation_time {
    type: number
    hidden: yes
    sql: ${TABLE}.compilation_time ;;
  }

  measure: max_compilation_time {
    type: number
    label: "Max Total Compilation Time in Seconds"
    sql: max(${compilation_time}) /1000;;
  }

  measure: formatted_max_compilation_time {
    type: string
    label: "Max Total Compilation Time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(max(${compilation_time}) ,3)) AS STRING);;
  }

  measure: min_compilation_time {
    type: number
    label: "Min Total Compilation Time in Seconds"
    sql: min(${compilation_time}) /1000;;
  }

  measure: formatted_min_compilation_time {
    type: string
    label: "Min Total Compilation Time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(min(${compilation_time}) ,3)) AS STRING);;
  }

  measure: avg_compilation_time {
    type: number
    label: "Average Total Compilation Time in Seconds"
    sql: avg(${compilation_time}) /1000;;
  }

  measure: formatted_avg_compilation_time {
    type: string
    label: "Average Total Compilation Time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(avg(${compilation_time}) ,3)) AS STRING);;
  }




  dimension: execution_time {
    type: number
    hidden: yes
    sql: ${TABLE}.execution_time  ;;
  }

  measure: max_execution_time {
    type: number
    label: "Max Total Execution Time in Seconds"
    sql: max(${execution_time}) /1000;;
  }

  measure: formatted_max_execution_time {
    type: string
    label: "Max Total Execution Time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(max(${execution_time}) ,3)) AS STRING);;
  }

  measure: min_execution_time {
    type: number
    label: "Min Total Execution Time in Seconds"
    sql: min(${execution_time}) /1000);;
  }

  measure: formatted_min_execution_time {
    type: string
    label: "Min Total Execution Time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(min(${execution_time}) ,3)) AS STRING);;
  }

  measure: avg_execution_time {
    type: number
    label: "Average Total Execution Time in Seconds"
    sql: avg(${execution_time}) /1000;;
  }

  measure: formatted_avg_execution_time {
    type: string
    label: "Average Total Execution Time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(avg(${execution_time}) ,3)) AS STRING);;
  }


  dimension: queued_provisioning_time {
    type: number
    hidden: yes
    sql: ${TABLE}.queued_provisioning_time   ;;
  }


  measure: max_queued_provisioning_time {
    type: number
    label: "Max queued provisioning time in Seconds"
    sql: max(${queued_provisioning_time})/1000;;
  }

  measure: formatted_max_queued_provisioning_time {
    type: string
    label: "Max queued provisioning time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(max(${queued_provisioning_time}) ,3)) AS STRING);;
  }

  measure: min_queued_provisioning_time {
    type: number
    label: "Min queued provisioning time in Seconds"
    sql: min(${queued_provisioning_time}) /1000;;
  }

  measure: formatted_min_queued_provisioning_time {
    type: string
    label: "Min queued provisioning time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(min(${queued_provisioning_time}) ,3)) AS STRING);;
  }

  measure: avg_queued_provisioning_time {
    type: number
    label: "Average queued provisioning time in Seconds"
    sql: avg(${queued_provisioning_time}) /1000;;
  }

  measure: formatted_avg_queued_provisioning_time {
    type: string
    label: "Average queued provisioning time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(avg(${queued_provisioning_time}) ,3)) AS STRING);;
  }


  dimension: queued_repair_time {
    type: number
    hidden: yes
    sql: ${TABLE}.queued_repair_time  ;;
  }

  measure: max_queued_repair_time {
    type: number
    label: "Max queued repair time in Seconds"
    sql: max(${queued_repair_time}) /1000;;
  }

  measure: formatted_max_queued_repair_time {
    type: string
    label: "Max queued repair time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(max(${queued_repair_time}) ,3)) AS STRING);;
  }

  measure: min_queued_repair_time {
    type: number
    label: "Min queued repair time in Seconds"
    sql: min(${queued_repair_time}) /1000;;
  }

  measure: formatted_min_queued_repair_time {
    type: string
    label: "Min queued repair time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(min(${queued_repair_time}) ,3)) AS STRING);;
  }

  measure: avg_queued_repair_time {
    type: number
    label: "Average queued repair time in Seconds"
    sql: avg(${queued_repair_time}) /1000;;
  }

  measure: formatted_avg_queued_repair_time {
    type: string
    label: "Average queued repair time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(avg(${queued_repair_time}) ,3)) AS STRING);;
  }


  dimension: queued_overload_time {
    type: number
    hidden: yes
    sql: ${TABLE}.queued_overload_time ;;
  }

  measure: max_queued_overload_time {
    type: number
    label: "Max queued overload time in Seconds"
    sql: max(${queued_overload_time}) /1000;;
  }

  measure: formatted_max_queued_overload_time {
    type: string
    label: "Max queued overload time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(max(${queued_overload_time}) ,3)) AS STRING);;
  }

  measure: min_queued_overload_time {
    type: number
    label: "Min queued overload time in Seconds"
    sql: min(${queued_overload_time}) /1000;;
  }

  measure: formatted_min_queued_overload_time {
    type: string
    label: "Min queued overload time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(min(${queued_overload_time}) ,3)) AS STRING);;
  }

  measure: avg_queued_overload_time {
    type: number
    label: "Average queued overload time in Seconds"
    sql: avg(${queued_overload_time}) /1000;;
  }

  measure: formatted_avg_queued_overload_time {
    type: string
    label: "Average queued overload time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(avg(${queued_overload_time}) ,3)) AS STRING);;
  }

  dimension: transaction_blocked_time {
    type: number
    hidden: yes
    sql: ${TABLE}.transaction_blocked_time ;;
  }


  measure: max_transaction_blocked_time {
    type: number
    label: "Max transaction blocked time in Seconds"
    sql: max(${transaction_blocked_time}) /1000;;
  }

  measure: formatted_max_transaction_blocked_time {
    type: string
    label: "Max transaction blocked time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(max(${transaction_blocked_time}) ,3)) AS STRING);;
  }

  measure: min_transaction_blocked_time {
    type: number
    label: "Min transaction blocked time in Seconds"
    sql: min(${transaction_blocked_time}) /1000;;
  }

  measure: formatted_min_transaction_blocked_time {
    type: string
    label: "Min transaction blocked time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(min(${transaction_blocked_time}) ,3)) AS STRING);;
  }

  measure: avg_transaction_blocked_time {
    type: number
    label: "Average transaction blocked time in Seconds"
    sql: avg(${transaction_blocked_time}) /1000;;
  }

  measure: formatted_avg_transaction_blocked_time {
    type: string
    label: "Average transaction blocked time in HH:MM:SS"
    sql:  CAST(to_time(to_timestamp(avg(${transaction_blocked_time}) ,3)) AS STRING);;
  }

  measure: count {
    type: count
  }

}
