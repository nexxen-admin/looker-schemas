view: aur_actions_v2_requests {
  sql_table_name: vg_stage.actions_v2_requests ;;
  label: "Actions V2 Requests"

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

  dimension: flight_media_id {
    type: number
    sql: ${TABLE}.flight_media_id ;;
    value_format_name: id
  }

  dimension: is_adserve_pacing_on {
    type: yesno
    sql: ${TABLE}.is_adserve_pacing_on ;;
  }

  dimension_group: keydate_from {
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
    sql: ${TABLE}.keydate_from ;;
  }

  dimension_group: keydate_to {
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
    sql: ${TABLE}.keydate_to ;;
  }

  dimension: placement_id {
    type: number
    sql: ${TABLE}.placement_id ;;
    value_format_name: id
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  measure: requests {
    type: sum
    sql: ${TABLE}.requests ;;
  }
}
