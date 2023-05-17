view: dbaadmin_AG_stats {
     derived_table: {
      sql:  SELECT record_time,counter_name, value FROM (
              select
              record_time,
              case when counter_name like '%sec%' then trim(REPLACE(counter_name, '/sec','')) else trim(counter_name) end as counter_name,
              case when counter_name <> 'Recovery Queue' then
                case when counter_name like 'Bytes%' then coalesce(cntr_value - LAG(cntr_value) OVER (partition by counter_name ORDER BY record_time),0)/1024/1024/1024
                else coalesce(cntr_value - LAG(cntr_value) OVER (partition by counter_name ORDER BY record_time),0) end
              else cntr_value end as value
              FROM HeartBeatCollector.tbl_PerfMonStatisticsLog
              where trim(object_name) like '%Replica'
            ) ct WHERE value >= 0
      ;;
    }

  dimension: value {
    type: number
    sql: ${TABLE}.value ;;
  }

  dimension: counter_name {
    type: string
    sql: ${TABLE}.counter_name ;;
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

  measure: avg_value {
    type: average
    sql: ${value} ;;
  }

  measure: max_value {
    type: max
    sql: ${value} ;;
  }

  measure: sum_value {
    type: sum
    sql: ${value} ;;
  }
}
