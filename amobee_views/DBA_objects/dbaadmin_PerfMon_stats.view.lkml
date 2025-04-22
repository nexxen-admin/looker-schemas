view: dbaadmin_perfmon_stats {
  derived_table: {
    sql:  SELECT record_time,counter_name,instance_name, value FROM (
            select
            record_time,
            case when counter_name like '%sec%' then trim(REPLACE(counter_name, '/sec','')) else trim(counter_name) end as counter_name,
            trim(instance_name) as instance_name,
            coalesce(cntr_value - LAG(cntr_value) OVER (partition by counter_name, instance_name ORDER BY record_time),0) as value
            FROM HeartBeatCollector.tbl_PerfMonStatisticsLog
            where trim(object_name) not like '%Replica'
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

  dimension: instance_name {
    type: string
    sql: ${TABLE}.instance_name ;;
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
