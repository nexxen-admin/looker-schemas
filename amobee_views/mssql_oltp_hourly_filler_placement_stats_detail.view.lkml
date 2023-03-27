view: hourly_filler_placement_stats_details {
  sql_table_name: dbo.hourly_filler_placement_stats_detail (NOLOCK) ;;
  label: "Placement Filler Statistics"

  dimension_group: createdon {
    type: time
    hidden: yes
    timeframes: [raw,time,date,week,month]
    sql: ${TABLE}.createdon ;;
  }

  dimension: detail_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.detail_id ;;
  }

  dimension: payout_usd {
    type: number
    hidden: yes
    sql: ${TABLE}.estimated_payout_usd ;;
  }

  dimension_group: keydate {
    type: time
    label: "UTC"
    description: "Time filler impressions were served in UTC"
    timeframes: [raw,time,date,week,month]
    sql: ${TABLE}.keydate ;;
  }

  dimension_group: dst_keydate {
    type: time
    label: "[DST] Local"
    description: "Time filler impressions were served in local timezone (accounting DST - if this option is enabled for the Platform Client)."
    timeframes: [raw,time,date,week,month]
    sql: case when ${mssql_oltp_platform_client_preference_UseDaylightSaving.preference_value} = 'True' then dateadd(hh, ${mssql_oltp_timezone_offset.utc_offset}, ${TABLE}.keydate)
      else ${TABLE}.keydate end ;;
  }

  dimension: placement_id {
    type: number
    sql: ${TABLE}.placement_id ;;
    value_format_name: id
  }

  dimension: total_served {
    type: number
    hidden: yes
    sql: ${TABLE}.total_served ;;
  }

  measure: sum_total_served {
    type: sum
    label: "Filler Impressions"
    description: "Number of house/filler impressions served."
    sql: ${total_served} ;;
  }

  measure: fillers_served_last_24 {
    type: sum
    label: "Filler Impressions - Last 24 Hours"
    description: "Number of house/filler impressions served in the prior 24 hours."
    sql: ${total_served} ;;
    filters: {
      field: keydate_time
      value: "after 23 hours ago"
    }
  }

  measure: fillers_served_yesterday {
    type: sum
    label: "Filler Impressions - Yesterday"
    description: "Number of house/filler impressions served yesterday UTC."
    sql: ${total_served} ;;
    filters: {
      field: keydate_time
      value: "yesterday"
    }
  }

  measure: fillers_served_last_hour {
    type: sum
    label: "Filler Impressions - Last Hour"
    description: "Number of house/filler impressions served in the current hour."
    sql: ${total_served} ;;
    filters: {
      field: keydate_time
      value: "after 0 hours ago"
    }
  }

  measure: fillers_served_2_hours_ago {
    type: sum
    label: "Filler Impressions - Two hours ago"
    description: "Number of house/filler impressions served in the prior hour."
    sql: ${total_served} ;;
    filters: {
      field: keydate_time
      value: "1 hours ago"
    }
  }

  measure: fillers_served_today {
    type: sum
    label: "Filler Impressions - Today"
    description: "Number of house/filler impressions served in the current day UTC."
    sql: ${total_served} ;;
    filters: {
      field: keydate_time
      value: "0 days ago"
    }
  }

  measure: filler_percent {
    type: number
    label: "Filler Rate Today"
    description: "Number of house/filler impressions served / number of units served."
    value_format_name: percent_0
    sql: COALESCE(${fillers_served_today} / NULLIF(${mssql_oltp_fm_pid_statistics.max_units_today},0),0) ;;
  }

  measure: percent_change_last_hour {
    type: number
    value_format_name: percent_0
    label: "Percent Change in the Last Hour"
    description: "Rate of change in fillers served in the current hour vs. the prior hour."
    sql: COALESCE((${fillers_served_last_hour} - ${fillers_served_2_hours_ago}) / NULLIF(${fillers_served_2_hours_ago},0),0) ;;
  }

  measure: sum_payout_usd {
    type: sum
    label: "Filler Payout USD"
    value_format_name: decimal_2
    description: "Estimated payout served from filler/house impressions."
    sql: ${payout_usd} ;;
  }

  measure: sum_payout_usd_last_24 {
    type: sum
    label: "Filler Payout USD - Last 24 Hours"
    value_format_name: decimal_2
    description: "Estimated payout served from filler/house impressions in the past 24 hours."
    sql: ${payout_usd} ;;
    filters: {
      field: keydate_time
      value: "after 23 hours ago"
    }
  }

  measure: sum_payout_usd_last_hour {
    type: sum
    label: "Filler Payout USD - Last Hour"
    description: "Estimated payout served from filler/house impressions in the current hour."
    sql: ${payout_usd} ;;
    filters: {
      field: keydate_time
      value: "after 0 hours ago"
    }
  }

  measure: filler_impression_threshold {
    type: number
    label: "Threshold Check - Filler Impressions"
    description: "Fillers served in the last hour > 499 or fillers served in the last 24 hours > 9999"
    sql: CASE WHEN ${fillers_served_last_hour} > 499
         OR ${fillers_served_last_24} > 9999 THEN 1 ELSE 0 END;;
  }

  measure: filler_payout_threshold {
    type: number
    label: "Threshold Check - Filler Payout"
    description: "Payout served in the last hour > $12.4 or payout served in the last 24 hours > $99.99"
    sql: CASE WHEN ${sum_payout_usd_last_hour} > 12.4
      OR ${sum_payout_usd_last_24} > 99.99 THEN 1 ELSE 0 END;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
