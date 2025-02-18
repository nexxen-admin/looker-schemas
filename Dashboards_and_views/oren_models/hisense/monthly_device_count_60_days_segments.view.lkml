view: monthly_device_count_60_days_segments {
  derived_table: {
    sql: SELECT
    country,
    between_0_to_30_days,
    between_0_to_60_days,
    between_0_to_90_days,
    ip_between_0_to_30_days,
    ip_between_0_to_60_days,
    ip_between_0_to_90_days
FROM bi_new.monthly_device_count_60_days_segments
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  measure: between_0_to_30_days {
    type: average
    sql: ${TABLE}.between_0_to_30_days ;;
  }

  measure: between_0_to_60_days {
    type: average
    sql: ${TABLE}.between_0_to_60_days ;;
  }

  measure: between_0_to_90_days {
    type: average
    sql: ${TABLE}.between_0_to_90_days ;;
  }

  measure: ip_between_0_to_30_days {
    type: average
    sql: ${TABLE}.ip_between_0_to_30_days ;;
  }

  measure: ip_between_0_to_60_days {
    type: average
    sql: ${TABLE}.ip_between_0_to_60_days ;;
  }

  measure: ip_between_0_to_90_days {
    type: average
    sql: ${TABLE}.ip_between_0_to_90_days ;;
  }


  set: detail {
    fields: [country,between_0_to_30_days, between_0_to_60_days, between_0_to_90_days,ip_between_0_to_30_days, ip_between_0_to_60_days, ip_between_0_to_90_days]
  }
}
