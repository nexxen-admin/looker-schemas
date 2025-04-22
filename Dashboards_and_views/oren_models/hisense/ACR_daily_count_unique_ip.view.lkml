view: ACR_daily_count_unique_ip {
  derived_table: {
    sql: SELECT date,
    country,
       sum(count_of_device_id) as distinct_ip_count
FROM bi_new.ACR_daily_count_unique_ip
where date>current_date - INTERVAL '1 month'
GROUP BY 1,2
 ;;
  }


  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  measure: distinct_ip_count {
    type: average
    sql: ${TABLE}."distinct_ip_count" ;;
  }


  set: detail {
    fields: [date,country, distinct_ip_count]
  }
}
