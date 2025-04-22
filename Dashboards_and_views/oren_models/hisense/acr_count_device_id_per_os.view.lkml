view: acr_count_device_id_per_os {
  derived_table: {
    sql:


SELECT date,
      country,
      os,
      sum(count_of_device_id) as count_of_device_id
FROM bi_new.acr_count_device_id_per_os
where date > current_date - INTERVAL '1 month'
GROUP BY 1,2,3


 ;;
  }


  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }

  dimension: os {
    type: string
    sql: ${TABLE}."os" ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }


  measure: count_of_device_id {
    type: sum
    sql: ${TABLE}."count_of_device_id" ;;
  }


  set: detail {
    fields: [date, os,count_of_device_id,country]
  }
}
