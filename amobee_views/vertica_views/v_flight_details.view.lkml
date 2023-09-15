view: v_flight_details {
  label: "Flight"
  sql_table_name: DIM.FLIGHT_DETAILS_VIEW ;;

  dimension: campaign_id {
    type: string
    hidden: yes
    sql: ${TABLE}.CAMPAIGN_ID ;;
  }

  dimension: future_flights {
    type: yesno
    label: "Include All Flights"
    description: "Include this field as a filter in your Look if you want to include all relevant flights in the Look. Without this included in your filter,
    results will include flights with delivery only."
    sql: true ;;
  }

  dimension: checksum_value {
    type: string
    hidden: yes
    sql: ${TABLE}.CHECKSUM_VALUE ;;
  }

  dimension: contract_end_date {
    type: date
    label: "Flight Contract End Date"
    description: "The end date of the flight as stated in the contract."
    sql: ${TABLE}.CONTRACT_END_DATE ;;
  }

  dimension: dst_contract_end_date {
    type: date
    label: "[DST] Flight Local Contract End Date"
    description: "The end date of the flight as stated in the contract in local time accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then ${TABLE}.CONTRACT_END_DATE AT TIME ZONE 'UTC' AT TIME ZONE ${v_timezone.timezone_name}
      else ${TABLE}.CONTRACT_END_DATE end ;;
  }

  dimension: contract_start_date {
    type: date
    label: "Flight Contract Start Date"
    description: "The start date of the flight as stated in the contract."
    sql: ${TABLE}.CONTRACT_START_DATE ;;
  }

  dimension: dst_contract_start_date {
    type: date
    label: "[DST] Flight Local Contract Start Date"
    description: "The start date of the flight as stated in the contract in local time accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then ${TABLE}.CONTRACT_START_DATE AT TIME ZONE 'UTC' AT TIME ZONE ${v_timezone.timezone_name}
      else ${TABLE}.CONTRACT_START_DATE end ;;
  }

  dimension: contracted_budget {
    type: number
    label: "Contracted Budget"
    value_format_name: decimal_2
    description: "The budget of the flight as stated in the contract."
    sql: ${TABLE}.CONTRACTED_BUDGET ;;
  }

  dimension: contracted_cpu {
    type: number
    label: "Contracted CPU"
    value_format_name: decimal_2
    description: "The Cost per unit for units in the flight as stated in the contract."
    sql: ${TABLE}.CONTRACTED_CPU ;;
  }

  dimension: contracted_units {
    type: number
    label: "Contracted Units"
    value_format_name: decimal_0
    description: "The number of units to be delivered in the flight as stated in the contract."
    sql: ${TABLE}.CONTRACTED_UNITS ;;
  }

  measure: max_flight_contracted_units {
    type: max
    label: "Flight Contracted Units"
    value_format_name: decimal_0
    description: "The number of units to be delivered in the flight as stated in the contract."
    sql: ${contracted_units};;
  }

  dimension: units {
    type: number
    label: "Flight Units"
    hidden: yes
    value_format_name: decimal_0
    description: "The number of units delivered in the flight."
    sql: ${TABLE}.UNITS ;;
  }

  measure: sum_units {
    type: sum
    label: "Flight Units"
    value_format_name: decimal_0
    description: "The number of units delivered in the flight."
    sql: ${TABLE}.UNITS ;;
  }

  dimension: cpu {
    type: string
    description: "The CPU for the flight.  This may or may not be the same as the campaign CPU (see override campaign CPU)."
    sql: coalesce(${TABLE}.CPU, ${v_campaign_details_base.cpu}) ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.cpu
  }

  measure: max_cpu {
    type: max
    hidden: yes
    description: "The CPU for the flight.  This may or may not be the same as the campaign CPU (see override campaign CPU)."
    sql: ${TABLE}.CPU ;;
  }

  dimension: flight_description {
    type: string
    label: "Flight Name"
    description: "The name of the flight"
    sql: ${TABLE}.FLIGHT_DESCRIPTION ;;
    drill_fields: [flight_media_details_base.media_name, flight_media_details_base.flight_media_id]
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.flight_description
  }

  dimension: flight_id {
    type: number
    primary_key: yes
    description: "The internal system identifier for the flight"
    sql: ${TABLE}.FLIGHT_ID ;;
    value_format_name: id
  }

  dimension: flight_active {
    type: yesno
    label:  "Flight Active"
    description: "A yes/no indicator if the flight is active."
    sql: ${TABLE}.FLIGHT_ACTIVE ;;
  }

  measure: count_of_flights {
    type: number
    label: "Count of Flights"
    description: "The distinct count of flights."
    sql: count(distinct ${flight_id}) ;;
  }

  dimension: override_campaign_cpu {
    type: yesno
    description: "A yes/no indicator to determine if the flight CPU should override the Campaign CPU.  A yes means that the CPU for this flight
    is based on the CPU at the flight level.  A no means that this flight will use the CPU setup at the campaign level."
    sql: ${TABLE}.OVERRIDE_CAMPAIGN_CPU ;;
  }

  dimension: flight_total_days {
    type: number
    hidden: yes
    description: "The total number of days in the flight."
    label: "Flight Total Days"
    sql: greatest(0, ceil(coalesce(datediff(h, ${TABLE}.BEGIN_DATETIME_LOCAL, ${TABLE}.END_DATETIME_LOCAL),
      datediff(h, ${TABLE}.CONTRACT_START_DATE, ${TABLE}.CONTRACT_END_DATE)) / 24)) ;;
  }

  dimension: flight_remaining_days {
    type: number
    hidden: yes
    description: "The total number of days remaining (end date - yesterday) in the flight."
    label: "Flight Remaining Days"
    sql: greatest(0, ceil(coalesce(datediff(h, greatest(${TABLE}.BEGIN_DATETIME_LOCAL, TIMESTAMPADD(d, 1, ${v_demand_mart_load_tracking.load_through_date})), ${TABLE}.END_DATETIME_LOCAL),
      datediff(h, greatest(${TABLE}.CONTRACT_START_DATE, TIMESTAMPADD(d, 1, ${v_demand_mart_load_tracking.load_through_date})), ${TABLE}.CONTRACT_END_DATE)) / 24)) ;;
  }

  dimension: flight_elapsed_days {
    type: number
    hidden: yes
    description: "The total number of days that have elasped since the beginning of the flight."
    label: "Flight Elapsed Days"
    sql: ${flight_total_days} - ${flight_remaining_days} ;;
  }

  measure: max_flight_total_days {
    type: max
    description: "The total number of days in the flight."
    label: "Flight Total Days"
    sql: ${flight_total_days} ;;
  }

  measure: max_flight_remaining_days {
    type: max
    description: "The total number of days remaining (end date - yesterday) in the flight."
    label: "Flight Remaining Days"
    sql: ${flight_remaining_days};;
  }

  measure: max_flight_elapsed_days {
    type: max
    description: "The total number of days that have elasped since the beginning of the flight."
    label: "Flight Elapsed Days"
    sql: ${flight_elapsed_days} ;;
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
    label: "Flight Begin"
    description: "The start date of the flight in UTC."
    sql: COALESCE(TIMESTAMPADD(HOUR, COALESCE(-${v_timezone.utc_offset}, 0)::INTEGER, ${TABLE}.BEGIN_DATETIME_LOCAL), ${TABLE}.CONTRACT_START_DATE) ;;
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
    label: "[DST] Flight Begin"
    description: "The start date of the flight in local time accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then COALESCE(TIMESTAMPADD(hour, COALESCE(-${v_timezone.utc_offset}, 0), ${TABLE}.BEGIN_DATETIME_LOCAL) AT TIME ZONE 'GMT' AT TIME ZONE ${v_timezone.timezone_name} ,${TABLE}.CONTRACT_START_DATE AT TIME ZONE 'UTC' AT TIME ZONE ${v_timezone.timezone_name} )
      else COALESCE(TIMESTAMPADD(HOUR, COALESCE(-${v_timezone.utc_offset}, 0)::INTEGER, ${TABLE}.BEGIN_DATETIME_LOCAL), ${TABLE}.CONTRACT_START_DATE) end ;;
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
    label: "Flight End"
    description: "The end date of the flight in UTC."
    sql: COALESCE(TIMESTAMPADD(HOUR, COALESCE(-${v_timezone.utc_offset}, 0)::INTEGER, TIMESTAMPADD(minute, -1, ${TABLE}.END_DATETIME_LOCAL)), TIMESTAMPADD(minute, -1, ${TABLE}.CONTRACT_END_DATE)) ;;
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
    label: "[DST] Flight End"
    description: "The end date of the flight in local time accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then  COALESCE(TIMESTAMPADD(HOUR, COALESCE(-${v_timezone.utc_offset}, 0)::INTEGER, TIMESTAMPADD(minute, -1, ${TABLE}.END_DATETIME_LOCAL)) AT TIME ZONE 'GMT' AT TIME ZONE ${v_timezone.timezone_name},TIMESTAMPADD('minute', -1, ${TABLE}.CONTRACT_END_DATE) AT TIME ZONE 'UTC' AT TIME ZONE ${v_timezone.timezone_name})
      else COALESCE(TIMESTAMPADD(HOUR, COALESCE(-${v_timezone.utc_offset}, 0)::INTEGER, TIMESTAMPADD(minute, -1, ${TABLE}.END_DATETIME_LOCAL)), TIMESTAMPADD(minute, -1, ${TABLE}.CONTRACT_END_DATE)) end ;;
  }

  dimension_group: begin_datetm_local {
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
    label: "Flight Local Begin"
    description: "The start date of the flight in local time."
    sql: ${TABLE}.BEGIN_DATETIME_LOCAL ;;
  }

  dimension_group: dst_begin_datetm_local {
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
    label: "[DST] Flight Local Begin"
    description: "The start date of the flight in local time accountin DST."
    sql: case when ${v_platform_client.use_daylight_saving} then convert_timezone('GMT', ${v_timezone.timezone_name}, TIMESTAMPADD(HOUR, COALESCE(-${v_timezone.utc_offset}, 0), ${TABLE}.BEGIN_DATETIME_LOCAL))
      else ${TABLE}.BEGIN_DATETIME_LOCAL end ;;
  }

  dimension_group: end_datetm_local {
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
    label: "Flight Local End"
    description: "The end date of the flight in local time."
    sql: TIMESTAMPADD(minute, -1,${TABLE}.END_DATETIME_LOCAL) ;;
  }

  dimension_group: dst_end_datetm_local {
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
    label: "[DST] Flight Local End"
    description: "The end date of the flight in local time accounting DST."
    sql: case when ${v_platform_client.use_daylight_saving} then convert_timezone('GMT', ${v_timezone.timezone_name}, TIMESTAMPADD(HOUR, COALESCE(-${v_timezone.utc_offset}, 0), TIMESTAMPADD(minute, -1,${TABLE}.END_DATETIME_LOCAL)))
      else TIMESTAMPADD(minute, -1,${TABLE}.END_DATETIME_LOCAL) end ;;
  }

  dimension: flight_status {
    type: string
    label: "Flight Status"
    description: "Text status of the flight based on its date range, one of 'Not started', 'Running' or 'Ended'."
    sql: CASE WHEN ${end_datetm_raw} <= CURRENT_TIMESTAMP THEN 'Ended' WHEN ${begin_datetm_raw} > CURRENT_TIMESTAMP THEN 'Not started' WHEN ${begin_datetm_raw} IS NOT NULL AND ${end_datetm_raw} IS NOT NULL THEN 'Running' ELSE 'Unknown' END ;;
    suggestions: ["Not started", "Running", "Ended", "Unknown"]
  }

  measure: count {
    type: count
    drill_fields: []
  }

  dimension: flight_status_ {
    type: string
    label: "Flight Status (derived)"
    description: "The current status of the flight based on campaign status and flight date range (i.e. planning, running, completed, etc.)"
    sql: case when ${v_campaign_details_base.campaign_status_description} IN ('Planning', 'Reserved', 'Pending' ) THEN 'Pending'
              when ${v_campaign_details_base.campaign_status_description} = 'Running' AND ${begin_datetm_local_raw} >= CURRENT_DATE() THEN 'Pending'
              when ${v_campaign_details_base.campaign_status_description} = 'Running' AND ${end_datetm_local_raw} <= CURRENT_DATE()   THEN 'Completed'
          ELSE ${v_campaign_details_base.campaign_status_description} END ;;
    suggest_explore: suggest_demand_ref
    suggest_dimension: suggest_demand_ref.flight_status_
  }
}
