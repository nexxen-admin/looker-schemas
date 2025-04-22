view: mssql_oltp_user_activity {
  label: "User Access"
  derived_table: {
    sql: SELECT
          user_login_log_id,
          [user_id],
          login_date,
          dateadd(HH, (select utc_offset from dbo.timezone where timezone_id = 16) ,login_date) login_date_est,
          max(case when login_date = last_login_date then mfa_enabled end) over(partition by user_id) mfa_enabled,
          origin_domain
         FROM (
           SELECT
            ul.user_login_log_id,
            u.id [user_id],
            ul.login_date,
            cast(ul.mfa_enabled as smallint) mfa_enabled,
            max(ul.login_date) over (partition by ul.[user_id]) as last_login_date,
            ul.origin_domain
           FROM dbo.Users u (NOLOCK)
           JOIN dbo.user_login_log ul (NOLOCK) ON u.Id = ul.[user_id]
          ) u ;;
  }

  dimension: pk {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.user_login_log_id ;;
  }

  dimension: user_id {
    type: number
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: login {
    type: time
    description: "User login time in UTC."
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.login_date ;;
  }

  dimension_group: login_est {
    type: time
    description: "User login time in EST."
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.login_date_est ;;
  }

  dimension: origin_domain {
    type: string
    label: "Origin Domain"
    sql: ${TABLE}.origin_domain ;;
  }

  dimension: mfa_enabled {
    type: yesno
    label: "MFA Enabled"
    sql: ${TABLE}.mfa_enabled = 1  ;;
  }

  measure: last_login_date_est {
    type: date_time
    label: "Last Login Date EST"
    description: "Last login date in EST."
    sql: MAX(${login_est_raw}) ;;
  }

  measure: last_login_date {
    type: date_time
    label: "Last Login Date"
    description: "Last login date in UTC."
    sql: MAX(${login_raw}) ;;
  }

  measure: count {
    type: count_distinct
    label: "Number Of Logins"
    sql: ${pk} ;;
  }
}
