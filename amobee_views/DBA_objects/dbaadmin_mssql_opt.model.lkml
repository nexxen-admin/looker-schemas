connection: "mssql-opt_dbaadmin"

include: "dbaadmin_*.view.lkml"

access_grant: can_use {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}

explore: dbaadmin_IDXStats_log {
  hidden: yes
  required_access_grants: [can_use]
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

explore: dbaadmin_FILES_stats {required_access_grants: [can_use]
  hidden: yes}

explore: dbaadmin_JOBS_stats {required_access_grants: [can_use]
  hidden: yes}

explore: dbaadmin_AG_stats {required_access_grants: [can_use]
  hidden: yes}

explore: dbaadmin_CDC_stats {required_access_grants: [can_use]
  hidden: yes}

explore: dbaadmin_SysHealth_stats {required_access_grants: [can_use]
  hidden: yes}

explore: dbaadmin_perfmon_stats {required_access_grants: [can_use]
  hidden: yes}

explore: dbaadmin_qssize_stats {required_access_grants: [can_use]
  hidden: yes}

explore: dbaadmin_errorlog_stats {required_access_grants: [can_use]
  hidden: yes}
