view: mssql_oltp_m_override {
  label: "Placement Volume Forecast Override"
  sql_table_name: dbo.m_override (NOLOCK) ;;

  dimension: m_override_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.m_override_id ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: start_datetm {
    type: date_minute
    label: "Override Start Date (UTC)"
    sql: ${TABLE}.start_datetm ;;
  }

  dimension: dst_start_datetm {
    type: date_minute
    label: "[DST] Local Override Start Date"
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset_start_datetm.utc_offset}, ${TABLE}.start_datetm)
      else ${TABLE}.start_datetm end ;;
  }

  dimension: end_datetm {
    type: date_minute
    label: "Override End Date (UTC)"
    sql: ${TABLE}.end_datetm ;;
  }

  dimension: dst_end_datetm {
    type: date_minute
    label: "[DST] Local Override End Date"
    sql:  case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset_end_datetm.utc_offset}, ${TABLE}.end_datetm)
      else ${TABLE}.end_datetm end;;
  }

  dimension: expiration_date {
    type: date_minute
    label: "Override Expiration Date (UTC)"
    sql: ${TABLE}.expiration_date ;;
  }

  dimension: dst_expiration_date {
    type: date_minute
    label: "[DST] Local Override Expiration Date"
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset_expiration_date.utc_offset}, ${TABLE}.expiration_date)
      else ${TABLE}.expiration_date end ;;
  }

  dimension: media_run_type {
    type: string
    label: "Override Run Type"
    sql: ${TABLE}.media_run_type ;;
  }

  dimension: m_value {
    type: number
    label: "Override Total Request Volume"
    sql: ${TABLE}.m_value ;;
  }

  dimension: volume_by_day {
    type: number
    label: "Override Requested Volume by Day"
    sql: CASE WHEN ${start_datetm} IS NULL OR ${end_datetm} IS NULL THEN NULL
              WHEN DATEDIFF(hour, ${start_datetm}, ${end_datetm}) > 0 THEN ROUND((${m_value} * 24) / DATEDIFF(hour, ${start_datetm}, ${end_datetm}), 0)
              ELSE 0 END;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: is_this_override_currently_applied {
    type: yesno
    label: "Override Currently Applied"
    description: "Is override applied in the moment of report generation"
    sql: GETDATE() BETWEEN ${start_datetm} AND ${end_datetm} ;;
  }
}
