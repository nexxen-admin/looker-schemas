view: dbaadmin_FILES_stats {

  derived_table: {
    sql:  select
          CheckDate,
          DatabaseName,
          SUM(SizeOnDiskMB)/1024 as SizeOnDiskGB,
          SUM(num_of_reads) as num_of_reads,
          SUM(num_of_writes) as num_of_writes,
          SUM(bytes_read/1024/1024) as MB_read,
          SUM(bytes_written/1024/1024) as MB_written
          FROM [HeartBeatCollector].[tbl_FilesStatisticsLog]
          group by CheckDate, DatabaseName
      ;;
  }

  dimension_group: check {
    type: time
    timeframes: [
      raw,
      hour,
      minute30,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.CheckDate ;;
  }

  dimension: database_name {
    type: string
    sql: ${TABLE}.DatabaseName ;;
  }


  dimension: MB_read {
    type: number
    sql: ${TABLE}.MB_read ;;
  }

  dimension: MB_written {
    type: number
    sql: ${TABLE}.MB_written ;;
  }

  dimension: num_of_reads {
    type: number
    sql: ${TABLE}.num_of_reads ;;
  }

  dimension: num_of_writes {
    type: number
    sql: ${TABLE}.num_of_writes ;;
  }

  dimension: size_on_disk_gb {
    type: number
    sql: ${TABLE}.SizeOnDiskGB ;;
  }


  # measures


  measure: avg_MB_read {
    type: average
    sql: ${TABLE}.MB_read ;;
  }

  measure: avg_MB_written {
    type: average
    sql: ${TABLE}.MB_written ;;
  }

  measure: avg_num_of_reads {
    type: average
    sql: ${TABLE}.num_of_reads ;;
  }

  measure: avg_num_of_writes {
    type: average
    sql: ${TABLE}.num_of_writes ;;
  }

  measure: avg_size_on_disk_gb {
    type: average
    sql: ${TABLE}.SizeOnDiskGB ;;
  }


  measure: max_MB_read {
    type: max
    sql: ${TABLE}.MB_read ;;
  }

  measure: max_MB_written {
    type: max
    sql: ${TABLE}.MB_written ;;
  }

  measure: max_num_of_reads {
    type: max
    sql: ${TABLE}.num_of_reads ;;
  }

  measure: max_num_of_writes {
    type: max
    sql: ${TABLE}.num_of_writes ;;
  }

  measure: max_size_on_disk_gb {
    type: max
    sql: ${TABLE}.SizeOnDiskGB ;;
  }


}
