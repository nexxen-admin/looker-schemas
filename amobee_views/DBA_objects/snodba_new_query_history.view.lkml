view: new_query_history {
  derived_table: {
    sql:
      SELECT
          query_id,
          start_time as interval_start,
          qh.warehouse_name,
          database_name,
          query_type,
          warehouse_size,
          total_elapsed_time/1000 as total_elapsed_time,
          compilation_time/1000 as compilation_time,
          (queued_provisioning_time + queued_repair_time + queued_overload_time)/1000 AS queued_time,
          transaction_blocked_time/1000 as transaction_blocked_time,
          execution_time/1000 as execution_time
      FROM snowflake.account_usage.query_history qh
      WHERE execution_status = 'SUCCESS'
      AND query_type IN ('SELECT','UPDATE','INSERT','MERGE','DELETE')
    ;;
  }

  dimension: primary_key {
    primary_key: yes
    sql: ${TABLE}.query_id ;;
  }


  dimension_group: capture {
    type: time
    timeframes: [
      raw,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.interval_start ;;
    }

  dimension: warehouse_name {
    type: string
    sql: ${TABLE}.warehouse_name ;;
  }

  dimension: warehouse_size {
    type: string
    sql: ${TABLE}.WAREHOUSE_SIZE ;;
  }

  dimension: database_name {
    type: string
    sql: ${TABLE}.database_name ;;
  }

  dimension: query_type {
    type: string
    sql: ${TABLE}.query_type ;;
  }

  measure: sum_total_elapsed_time {
    type: sum
    sql: ${TABLE}.total_elapsed_time ;;
  }

  measure: avg_total_elapsed_time {
    type: average
    sql: ${TABLE}.total_elapsed_time ;;
  }

  measure: sum_compilation_time {
    type: sum
    sql: ${TABLE}.compilation_time ;;
  }

  measure: avg_compilation_time {
    type: average
    sql: ${TABLE}.compilation_time ;;
  }

  measure: sum_queued_time {
    type: sum
    sql: ${TABLE}.queued_time ;;
  }

  measure: avg_queued_time {
    type: average
    sql: ${TABLE}.queued_time ;;
  }

  measure: sum_transaction_blocked_time {
    type: sum
    sql: ${TABLE}.transaction_blocked_time ;;
  }

  measure: avg_transaction_blocked_time {
    type: average
    sql: ${TABLE}.transaction_blocked_time ;;
  }

  measure: sum_execution_time {
    type: sum
    sql: ${TABLE}.execution_time ;;
  }

  measure: avg_execution_time {
    type: average
    sql: ${TABLE}.execution_time ;;
  }

  measure: count {
    type: count
  }


 }
