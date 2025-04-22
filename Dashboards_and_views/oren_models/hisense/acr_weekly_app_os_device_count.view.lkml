view: acr_weekly_app_os_device_count {
  derived_table: {
    sql: SELECT week_date,
                 os,
                 country,
                 tv_app_name,
                 sum(distinct_ip_count) as distinct_ip_count
          from bi_new.acr_weekly_app_os_device_count
          group by 1,2,3,4
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

  dimension: os {
    type: string
    sql: ${TABLE}.os ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: tv_app_name {
    type: string
    sql: ${TABLE}.tv_app_name ;;
  }

  measure: distinct_ip_count {
    type: average
    sql: ${TABLE}.distinct_ip_count ;;
  }

  set: detail {
    fields: [week_date, os,country, tv_app_name, distinct_ip_count]
  }
}
