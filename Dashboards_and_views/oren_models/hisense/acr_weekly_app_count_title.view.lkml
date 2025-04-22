view: acr_weekly_app_count_title {
  derived_table: {
    sql: SELECT week_date,
                tv_app_name,
                country,
                distinct_program_count
FROM bi_new.acr_weekly_app_count_title

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

  dimension: tv_app_name {
    type: string
    sql: ${TABLE}.tv_app_name ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  measure: distinct_title_count {
    type: average
    sql: ${TABLE}.distinct_program_count ;;
  }

  set: detail {
    fields: [week_date, tv_app_name, country,distinct_title_count]
  }
}
