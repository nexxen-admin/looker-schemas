view: acr_weekly_unique_program_over_networks_linear {
  derived_table: {
    sql: SELECT week_date,
      affiliate_call_sign,
      country,
      distinct_title_count
FROM bi_new.acr_weekly_unique_program_over_networks_linear

 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: week_date {
    type: date_week
    sql: ${TABLE}.week_date ;;
  }

  dimension: affiliate_call_sign {
    type: string
    sql: ${TABLE}.affiliate_call_sign ;;
  }
  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }
  measure: distinct_title_count {
    type: average
    sql: ${TABLE}.distinct_title_count ;;
  }

  set: detail {
    fields: [week_date, affiliate_call_sign,country, distinct_title_count]
  }
}
