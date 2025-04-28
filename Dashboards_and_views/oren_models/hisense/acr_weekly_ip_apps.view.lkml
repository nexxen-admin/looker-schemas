view: acr_weekly_ip_apps {
  derived_table: {
    sql:

SELECT week_date,
       tv_app_name,
       country,
       sum(distinct_ip_count) as distinct_ip_count
FROM bi_new.acr_weekly_ip_apps
group by 1,2,3


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


  measure: distinct_ip_count {
    type: average
    sql: ${TABLE}.distinct_ip_count ;;
  }

  set: detail {
    fields: [week_date, tv_app_name,country, distinct_ip_count]
  }
}
