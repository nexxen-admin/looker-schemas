view: placement_payout_schedule {
  sql_table_name: dbo.placement_payout_schedule (NOLOCK) ;;
  label: "Placement Payout Schedule"

  dimension: placement_payout_schedule_id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.placement_payout_schedule_id ;;
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension_group: begin_datetm {
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
    label: "Start"
    description: "The start date of placement payout schedule in UTC."
    sql: ${TABLE}.begin_datetm ;;
  }

  dimension_group: dst_begin_datetm {
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
    label: "[DST] Local Start"
    description: "The start date of placement payout schedule in local time (accounting DST - if this option is enabled for the Platform Client)."
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset_placement_payout_schedule_start.utc_offset}, ${TABLE}.begin_datetm)
      else ${TABLE}.begin_datetm end ;;
  }

  dimension: cpu {
    type: number
    label: "Payout"
    description: "Placement payout specific to particular placement payout schedule excluding exchange fee."
    value_format_name: decimal_2
    sql: ${TABLE}.cpu ;;
  }

  dimension_group: end_datetm {
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
    label: "End"
    description: "The end date of placement payout schedule in UTC."
    sql: ${TABLE}.end_datetm ;;
  }

  dimension_group: dst_end_datetm {
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
    label: "[DST] Local End"
    description: "The end date of placement payout schedule in local time (accounting DST - if this option is enabled for the Platform Client)."
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset_placement_payout_schedule_end.utc_offset}, ${TABLE}.end_datetm)
      else ${TABLE}.end_datetm end ;;
  }

  dimension: native_currency_id {
    type: number
    hidden: yes
    sql: ${TABLE}.native_currency_id ;;
  }

  dimension: payout_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.payout_type_id ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  measure: count {
    type: count_distinct
    label: "Count of Placement Payout Schedules"
    description: "The distinct count of Placement Payout Schedules."
    sql: ${placement_payout_schedule_id} ;;
  }
}
