view: mssql_oltp_flight {
  sql_table_name: dbo.flight (NOLOCK) ;;
  label: "Flight"

  dimension: contract_flight_id {
    type: number
    hidden: yes
    sql: ${TABLE}.contract_flight_id ;;
  }

  dimension: active {
    type: yesno
    label: "Flight Active"
    sql: ${TABLE}.active = 1 ;;
  }

  dimension_group: begin_datetime_local {
    type: time
    #hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.begin_datetime_local ;;
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
    sql: ${TABLE}.begin_datetm ;;
  }

  dimension_group: yj_begin_datetm {
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
    description: "The begin date of the flight media in the demand timezone for YJ reporting."
    sql: ISNULL(${TABLE}.begin_datetm, '1/1/1900') ;;
  }

  dimension: campaign_id {
    type: number
     hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: change_source {
    type: string
    hidden: yes
    sql: ${TABLE}.change_source ;;
  }

  dimension: changedby {
    type: string
    hidden: yes
    sql: ${TABLE}.changedby ;;
  }

  dimension_group: changedon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.changedon ;;
  }

  dimension_group: contract_end {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.contract_end_date ;;
  }

  dimension_group: contract_start {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.contract_start_date ;;
  }

  dimension: contracted_budget {
    type: number
    hidden: yes
    sql: ${TABLE}.contracted_budget ;;
  }

  dimension: contracted_cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.contracted_cpu ;;
  }

  dimension: contracted_units {
    type: number
    hidden: yes
    sql: ${TABLE}.contracted_units ;;
  }

  dimension: cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.cpu ;;
  }

  dimension: createdby {
    type: string
    hidden: yes
    sql: ${TABLE}.createdby ;;
  }

  dimension_group: createdon {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createdon ;;
  }

  dimension: curve_valid {
    type: string
    hidden: yes
    sql: ${TABLE}.curve_valid ;;
  }

  dimension: delivery_units {
    type: number
    hidden: yes
    sql: ${TABLE}.delivery_units ;;
  }

  dimension: description {
    type: string
    label: "Flight Name"
    sql: ${TABLE}.description ;;
  }

  dimension: desired_spend {
    type: number
    hidden: yes
    sql: ${TABLE}.desired_spend ;;
  }

  dimension: enable_sequential_targeting {
    type: string
    hidden: yes
    sql: ${TABLE}.enable_sequential_targeting ;;
  }

  dimension_group: end_datetime_local {
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
    sql: dateadd(minute, -1, ${TABLE}.end_datetime_local) ;;
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
    sql: ${TABLE}.end_datetm ;;
  }

  dimension_group: yj_end_datetm {
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
    description: "The end date of the flight media in the demand timezone for YJ reporting."
    sql: ISNULL(${TABLE}.end_datetm, '1/1/1900') ;;
  }

  dimension: endtimezone_id {
    type: number
    hidden: yes
    sql: ${TABLE}.endtimezone_id ;;
  }

  dimension: flight_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.flight_id ;;
    value_format_name: id
  }

  dimension: forecast_max_spend {
    type: number
    hidden: yes
    sql: ${TABLE}.forecast_max_spend ;;
  }

  dimension: freq_cap {
    type: number
    hidden: yes
    sql: ${TABLE}.freq_cap ;;
  }

  dimension: freq_cap_hours {
    type: number
    hidden: yes
    sql: ${TABLE}.freq_cap_hours ;;
  }

  dimension: frequency {
    type: number
    hidden: yes
    sql: ${TABLE}.frequency ;;
  }

  dimension: hostname {
    type: string
    hidden: yes
    sql: ${TABLE}.hostname ;;
  }

  dimension: inside_feasible_set {
    type: string
    hidden: yes
    sql: ${TABLE}.inside_feasible_set ;;
  }

  dimension: inventory_medium_type_id {
    type: number
    hidden: yes
    sql: ${TABLE}.inventory_medium_type_id ;;
  }

  dimension: is_added_value {
    type: string
    hidden: yes
    sql: ${TABLE}.is_added_value ;;
  }

  dimension: is_slate {
    type: string
    hidden: yes
    sql: ${TABLE}.is_slate ;;
  }

  dimension: last_calculated_field_planned {
    type: number
    hidden: yes
    sql: ${TABLE}.last_calculated_field_planned ;;
  }

  dimension: last_lookup_mode {
    type: number
    hidden: yes
    sql: ${TABLE}.last_lookup_mode ;;
  }

  dimension: last_lookup_mode_planned {
    type: number
    hidden: yes
    sql: ${TABLE}.last_lookup_mode_planned ;;
  }

  dimension: max_volume {
    type: number
    hidden: yes
    sql: ${TABLE}.max_volume ;;
  }

  dimension: override_campaign_cpu {
    type: string
    hidden: yes
    sql: ${TABLE}.override_campaign_cpu ;;
  }

  dimension: override_campaign_units {
    type: string
    hidden: yes
    sql: ${TABLE}.override_campaign_units ;;
  }

  dimension: pi_demo_value {
    type: number
    hidden: yes
    sql: ${TABLE}.pi_demo_value ;;
  }

  dimension: pi_value {
    type: number
    hidden: yes
    sql: ${TABLE}.pi_value ;;
  }

  dimension: pl_campaign_flight_id {
    type: number
    hidden: yes
    sql: ${TABLE}.pl_campaign_flight_id ;;
  }

  dimension: planned_cpu {
    type: number
    hidden: yes
    sql: ${TABLE}.planned_cpu ;;
  }

  dimension: planned_impressions {
    type: number
    hidden: yes
    sql: ${TABLE}.planned_impressions ;;
  }

  dimension: planned_spend {
    type: number
    hidden: yes
    sql: ${TABLE}.planned_spend ;;
  }

  dimension: planned_volume {
    type: number
    hidden: yes
    sql: ${TABLE}.planned_volume ;;
  }

  dimension: proposal_flight_id {
    type: number
    hidden: yes
    sql: ${TABLE}.proposal_flight_id ;;
  }

  dimension: quality_score {
    type: number
    hidden: yes
    sql: ${TABLE}.quality_score ;;
  }

  dimension: reach {
    type: number
    hidden: yes
    sql: ${TABLE}.reach ;;
  }

  dimension: starttimezone_id {
    type: number
    hidden: yes
    sql: ${TABLE}.starttimezone_id ;;
  }

  dimension: unit_override_display {
    type: string
    hidden: yes
    sql: ${TABLE}.unit_override_display ;;
  }

  dimension: units {
    type: number
    hidden: yes
    sql: ${TABLE}.units ;;
  }

  dimension: updatedby {
    type: string
    hidden: yes
    sql: ${TABLE}.updatedby ;;
  }

  dimension: weight_display {
    type: number
    hidden: yes
    sql: ${TABLE}.weight_display ;;
  }

  measure: max_planned_volume {
    type: max
    label: "Planned Volume"
    sql: ${planned_volume} ;;
  }

  dimension: flight_status {
    type: string
    label: "Flight Status"
    sql: case
           when ${mssql_oltp_campaign_status.description} in ('Planning', 'Reserved', 'Pending') then 'Pending'
           when ${mssql_oltp_campaign_status.description} = 'Running' and ${begin_datetime_local_raw} >= getdate() then 'Pending'
           when ${mssql_oltp_campaign_status.description} = 'Running' and ${end_datetime_local_raw} <= getdate() then 'Completed'
           else ${mssql_oltp_campaign_status.description}
         end ;;
  }



#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }

  # ----- Sets of fields for drilling ------
#   set: detail {
#     fields: [
#       contract_flight_id,
#       hostname,
#       flight.contract_flight_id,
#       flight.hostname,
#       campaign.campaign_name,
#       campaign.pl_campaign_id,
#       campaign.tag_default_ftp_username,
#       campaign.hostname,
#       flight.count
#     ]
#   }
}
