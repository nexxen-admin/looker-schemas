connection: "mssql-oltp_dbaadmin"

include: "dbaadmin_*.view.lkml"

explore: dbaadmin_IDXStats_log {
  label: "dbaadmin_IDXStats_governer"
  join: dbaadmin_IDXstats_agg {
    relationship: one_to_one
    type: left_outer
    sql_on: ${dbaadmin_IDXstats_agg.ObjectName}=${dbaadmin_IDXStats_log.object_name}
        and ${dbaadmin_IDXstats_agg.DatabaseName} = ${dbaadmin_IDXStats_log.database_name}
        and ${dbaadmin_IDXstats_agg.IndexName} = ${dbaadmin_IDXStats_log.index_name}
        and ${dbaadmin_IDXstats_agg.StartTime} = ${dbaadmin_IDXStats_log.start_time};;
  }
}

explore: dbaadmin_FILES_stats {}

explore: dbaadmin_JOBS_stats {}

explore: dbaadmin_AG_stats {}

explore: dbaadmin_CDC_stats {}

explore: dbaadmin_SysHealth_stats {}

explore: dbaadmin_perfmon_stats {}

explore: dbaadmin_qssize_stats {}

explore: dbaadmin_errorlog_stats {}
