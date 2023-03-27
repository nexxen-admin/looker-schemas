view: sno_smartmon_event {
  sql_table_name: smartmon.events ;;
  label: "Events"

  dimension: app_version {
    type: string
    label: "App Version"
    sql: ${TABLE}.app_version ;;
  }

  dimension: application {
    type: string
    label: "Application"
    sql: ${TABLE}.application ;;
  }

  dimension: hostname {
    type: string
    label: "Hostname"
    sql: ${TABLE}.hostname ;;
  }

  dimension: id {
    type: number
    label: "ID"
    sql: ${TABLE}.id ;;
  }

  dimension: labels {
    type: string
    label: "Labels"
    sql: ${TABLE}.labels ;;
  }

  dimension: location {
    type: string
    label: "Location"
    sql: ${TABLE}.location ;;
  }

  dimension: mid {
    type: number
    label: "Mid"
    sql: ${TABLE}.mid ;;
  }

  dimension: name {
    type: string
    label: "Name"
    sql: ${TABLE}.name ;;
  }

  dimension: platform {
    type: string
    label: "Platform"
    sql: ${TABLE}.platform ;;
  }

  dimension: value {
    type: number
    label: "Value"
    sql: ${TABLE}.value ;;
  }

  measure: sum_value {
    type: sum
    label: "Value Sum"
    sql: ${TABLE}.value ;;
  }

  dimension: version {
    type: string
    label: "Version"
    sql: ${TABLE}.version ;;
  }

  dimension: partner_id {
    type: number
    label: "Partner ID"
    sql: json_extract_path_text(${TABLE}.labels, 'partner_id') ;;
  }

  dimension: platform_client_id {
    type: number
    hidden:yes
    sql: json_extract_path_text(${TABLE}.labels, 'platform_client_id') ;;
  }

  dimension: metric {
    type: string
    label: "Metric"
    sql: json_extract_path_text(${TABLE}.labels, 'metric') ;;
  }

  dimension_group: createdon {
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
    sql: ${TABLE}.createdon ;;
  }

  dimension_group: time {
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
    sql: ${TABLE}.time ;;
  }
 }
