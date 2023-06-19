view: dbaadmin_qssize_stats {
  derived_table: {
    sql:    SELECT record_time, DB_NAME, (cast(current_storage_size_mb as decimal(8,2))/max_storage_size_mb) * 100 as prcnt_full,
              case when readonly_reason > 8 then 1 else 0 end as is_alert
            FROM [DBA].[HeartBeatCollector].[tbl_QueryStoreSizeLog]
      ;;
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

  dimension: db_name {
    type: string
    sql: ${TABLE}.DB_NAME ;;
  }

  dimension: is_alert {
    type: yesno
    sql: ${TABLE}.is_alert ;;
  }

  dimension: prcnt_full {
    type: number
    value_format: "0.00"
    sql: ${TABLE}.prcnt_full ;;
  }

  measure: avg_prcnt_full {
    type: average
    sql: ${prcnt_full} ;;
  }


  }
