view: monthly_device_count {
  derived_table: {
    sql: SELECT date_segment,
       country,
       count_devices,
       count_ip
FROM bi_new.monthly_device_count
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date_segment {
    type: string
    sql: ${TABLE}.date_segment ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }


  measure: count_devices {
    type: average
    sql: ${TABLE}.count_devices ;;
  }

  measure: count_ip {
    type: average
    sql: ${TABLE}.count_ip ;;
  }



  set: detail {
    fields: [date_segment, country,count_devices,count_ip]
  }
}
