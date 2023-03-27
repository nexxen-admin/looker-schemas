view: account_full_query_history {
 derived_table: {
  sql:
   SELECT
                                     t1.WAREHOUSE_NAME,
                                     t1.Total_Elapsed_Hours as TOTAL_ELAPSED_HOURS_BY_DAY,
                                     t1.CAPTURE_WEEK,
                                     t1.WAREHOUSE_SIZE,
                                     t2.QUERY_TEXT,
                                     t2.ROLE_NAME,
                                     t2.USER_NAME,
                                     t2.Total_Elapsed_Hours as TOTAL_ELAPSED_HOURS_BY_QUERY,
                                     t2.EXECUTIONS_COUNT,
                                     t3.CREDITS_USED_BY_DAY  as CREDITS_USED_BY_DAY
                                     from (
                                          select
                                          sum(total_elapsed_time)/3600000 Total_Elapsed_Hours,
                                          warehouse_name,
                                          DATE_TRUNC('week', end_time) CAPTURE_WEEK,
                                          WAREHOUSE_SIZE
                                          from "SNOWFLAKE"."ACCOUNT_USAGE"."QUERY_HISTORY"
                                          where WAREHOUSE_SIZE is not null
                                          group by warehouse_name, CAPTURE_WEEK, WAREHOUSE_SIZE) t1
                                      join (
                                          SELECT warehouse_name,
                                                 DATE_TRUNC('week', end_time) CAPTURE_WEEK,
                                                 QUERY_TEXT,
                                                 ROLE_NAME,
                                                 USER_NAME,
                                                 WAREHOUSE_SIZE,
                                                 sum(total_elapsed_time)/3600000 Total_Elapsed_Hours,
                                                 count(*) as executions_count
                                             from "SNOWFLAKE"."ACCOUNT_USAGE"."QUERY_HISTORY"
                                        where WAREHOUSE_SIZE is not null
                                        --and TIMESTAMPDIFF(DAY, (DATE_TRUNC('week',CAPTURE_DATE )), CURRENT_TIMESTAMP())< 21
                                        group by warehouse_name,CAPTURE_WEEK,QUERY_TEXT,ROLE_NAME,USER_NAME,WAREHOUSE_SIZE
                                      ) t2
                                      ON t1.warehouse_name = t2.warehouse_name AND t1.CAPTURE_WEEK = t2.CAPTURE_WEEK
                                         AND t1.WAREHOUSE_SIZE=t2.WAREHOUSE_SIZE
                                      join(
                                        SELECT warehouse_name,
                                           DATE_TRUNC('week', start_time) CAPTURE_WEEK,
                                           SUM(CREDITS_USED) as CREDITS_USED_by_day,
                                           SUM(CREDITS_USED_COMPUTE) as CREDITS_USED_COMPUTE,
                                           SUM(CREDITS_USED_CLOUD_SERVICES) as CREDITS_USED_CLOUD_SERVICES
                                        FROM ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
                                        group by warehouse_name, CAPTURE_WEEK
                                      ) t3
                                      ON t3.warehouse_name = t2.warehouse_name AND t3.CAPTURE_WEEK = t2.CAPTURE_WEEK
    ;;
}

  dimension: WAREHOUSE_NAME {
    type: string
    sql: ${TABLE}."WAREHOUSE_NAME" ;;
  }

  dimension: TOTAL_ELAPSED_HOURS_BY_DAY {
    type: number
    sql: ${TABLE}."TOTAL_ELAPSED_HOURS_BY_DAY" ;;
  }


  dimension_group: CAPTURE {
    type: time
    timeframes: [
      week
    ]
    sql: ${TABLE}."CAPTURE_WEEK" ;;
  }
  dimension: WAREHOUSE_SIZE {
    type: string
    sql: ${TABLE}."WAREHOUSE_SIZE" ;;
  }

  dimension: QUERY_TEXT {
    type: string
    sql: ${TABLE}."QUERY_TEXT" ;;
  }
  dimension: ROLE_NAME {
    type: string
    sql: ${TABLE}."ROLE_NAME" ;;
  }

  dimension: USER_NAME {
    type: string
    sql: ${TABLE}."USER_NAME" ;;
  }

  dimension: TOTAL_ELAPSED_HOURS_BY_QUERY {
    type: number
    sql: ${TABLE}."TOTAL_ELAPSED_HOURS_BY_QUERY" ;;
  }
  dimension: executions_count {
    type: number
    sql: ${TABLE}."EXECUTIONS_COUNT" ;;
  }

  dimension: CREDITS_USED_BY_DAY {
    type: number
    sql: ${TABLE}."CREDITS_USED_BY_DAY" ;;
  }

  measure: CREDITS_USED_by_day_m {
    type: sum
    value_format_name: decimal_1
    sql: ${CREDITS_USED_BY_DAY} ;;
  }

  measure: executions_count_m {
    type: sum
    value_format_name: decimal_1
    sql: ${executions_count} ;;
  }

  measure: Total_Elapsed_Hours_by_query_m {
    type: sum
    value_format_name: decimal_1
    sql: ${TOTAL_ELAPSED_HOURS_BY_QUERY} ;;
  }

  measure: Total_Elapsed_Hours_by_day_m {
    type: sum
    value_format_name: decimal_1
    sql: ${TOTAL_ELAPSED_HOURS_BY_DAY} ;;
  }

  measure: Query_Cost {
    type: number
    value_format_name: decimal_1
    sql: (${CREDITS_USED_by_day_m}/${Total_Elapsed_Hours_by_day_m})*${Total_Elapsed_Hours_by_query_m} ;;
  }

  measure: Query_Cost_in{
    type: string
    sql: concat(
            cast(
              ((${CREDITS_USED_by_day_m}/${Total_Elapsed_Hours_by_day_m}) * ${Total_Elapsed_Hours_by_query_m}) as decimal(10,2)),
              ' of ',
                    cast(${CREDITS_USED_by_day_m} as decimal(10,2)),
                    ' total');;
  }


 }
