view: acr_count_device_id {
  derived_table: {
    sql:


SELECT date,country,sum(count_of_device_id) as count_of_device_id
FROM bi_new.acr_count_device_id
where date > current_date - INTERVAL '1 month'
group by 1,2

      ;;
  }


  dimension: date {
    type: date
    sql: ${TABLE}."date" ;;
  }


  dimension: country {
    type: string
    sql: ${TABLE}."country" ;;
  }

  measure: count_of_device_id {
    type: sum
    sql: ${TABLE}."count_of_device_id" ;;
  }


  set: detail {
    fields: [date,count_of_device_id,country]
  }
}
