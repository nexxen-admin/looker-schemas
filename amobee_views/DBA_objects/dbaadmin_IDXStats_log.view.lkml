view: dbaadmin_IDXStats_log {
  # sql_table_name: IndexStatsGoverner.tbl_CommandLog ;;
  # drill_fields: [id]
  derived_table: {
    sql:  select *
          FROM IndexStatsGoverner.tbl_CommandLog WHERE DATEDIFF(MONTH,StartTime,GETDATE())<=6
      ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: command {
    type: string
    sql: ${TABLE}.Command ;;
  }

  dimension: command_type {
    type: string
    sql: ${TABLE}.CommandType ;;
  }

  dimension: database_name {
    type: string
    sql: ${TABLE}.DatabaseName ;;
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
    sql: ${TABLE}.EndTime ;;
  }

  dimension: error_message {
    type: string
    sql: ${TABLE}.ErrorMessage ;;
  }

  dimension: error_number {
    type: number
    sql: ${TABLE}.ErrorNumber ;;
  }

  dimension: extended_info {
    type: string
    sql: ${TABLE}.ExtendedInfo ;;
  }

  dimension: index_name {
    type: string
    sql: ${TABLE}.IndexName ;;
  }

  dimension: index_type {
    type: number
    sql: ${TABLE}.IndexType ;;
  }

  dimension: object_name {
    type: string
    sql: ${TABLE}.ObjectName ;;
  }

  dimension: object_type {
    type: string
    sql: ${TABLE}.ObjectType ;;
  }

  dimension: partition_number {
    type: number
    sql: ${TABLE}.PartitionNumber ;;
  }

  dimension: schema_name {
    type: string
    sql: ${TABLE}.SchemaName ;;
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
    sql: ${TABLE}.StartTime ;;
  }

  dimension: statistics_name {
    type: string
    sql: ${TABLE}.StatisticsName ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: average_duration_min {
    type: average
    sql: DATEDIFF(second, ${TABLE}.StartTime,${TABLE}.EndTime)/60 ;;
  }

  measure: sum_duration_min {
    type: sum
    sql: DATEDIFF(second, ${TABLE}.StartTime,${TABLE}.EndTime)/60 ;;
  }

  measure: max_duration {
    type: max
    sql: DATEDIFF(second, ${TABLE}.StartTime,${TABLE}.EndTime) ;;
  }


  measure: count_reorganizes {
    type: sum
    sql: CASE WHEN ${command} LIKE '%REORGANIZE%' THEN 1 ELSE 0 END ;;
  }

  measure: count_rebuilds {
    type: sum
    sql: CASE WHEN ${command} LIKE '%REBUILD%' THEN 1 ELSE 0 END ;;
  }






  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      database_name,
      schema_name,
      object_name,
      index_name,
      statistics_name
    ]
  }
}
