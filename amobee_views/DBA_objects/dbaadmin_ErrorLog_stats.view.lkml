view: dbaadmin_errorlog_stats {
  derived_table: {
    sql:  SELECT
          LogDate,
          CASE WHEN LogText like 'Buffer Pool scan%' THEN
                SUBSTRING(LogText, 0,18)+DB_NAME(SUBSTRING(LogText,CHARINDEX('database ID ',LogText)+12,CHARINDEX(', command',LogText)-12-CHARINDEX('database ID ',LogText)))
             WHEN LogText like 'Process ID % was killed by hostname%' THEN
                'User session killed by system'
             WHEN LogText like '![INFO!]%' ESCAPE '!' THEN
                'InMem Engine garbage collection action'
                ELSE LogText END as msg
          FROM DBA.[HeartBeatCollector].[tbl_SQLServerErrorLog]
          where LogText not like 'Error: 18456%' and LogText not like 'Error: 18054%' and LogText not like 'DBCC TRACE% 3604%'
          AND LogText NOT LIKE 'Dump request%' AND LogText NOT LIKE 'Stack Signature for the dump%' AND LogText NOT LIKE '0000%'
          AND LogText NOT LIKE '*%'
      ;;
  }

  dimension_group: Log {
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
    sql: ${TABLE}.LogDate ;;
  }

  dimension: LogText {
    type: string
    sql: ${TABLE}.msg ;;
  }


  measure: count {
    type: count
  }

  measure: last_time {
    type: date_minute
    sql: max(${TABLE}.LogDate) ;;
  }

 }
