view: acr_weekly_title_device {
  derived_table: {
    sql: SELECT week_date,
       title,
      country,
       count_devices
FROM bi_new.acr_weekly_title_device
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


  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }


  measure: count_devices {
    type: average
    sql: ${TABLE}.count_devices ;;
  }

  set: detail {
    fields: [week_date, title,country, count_devices]
  }
}
