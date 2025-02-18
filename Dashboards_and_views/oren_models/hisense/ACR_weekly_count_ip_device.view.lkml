  view: ACR_weekly_count_ip_device {
    derived_table: {
      sql: SELECT week_date,
              country,
              distinct_ip_count,
              device_id_count,
              device_ip_ratio
        FROM bi_new.ACR_weekly_count_ip_device
         ;;
    }


    dimension: week_date {
      type: date_week
      sql: ${TABLE}."week_date" ;;
    }


    dimension: country {
      type: string
      sql: ${TABLE}.country ;;
    }

    measure: distinct_ip_count {
      type: average
      sql: ${TABLE}."distinct_ip_count" ;;
    }

    measure: device_id_count {
      type: average
      sql: ${TABLE}."device_id_count" ;;
    }

    measure: device_ip_ratio {
      type: average
      sql: ${TABLE}."device_ip_ratio" ;;
    }


    set: detail {
      fields: [week_date, country,distinct_ip_count,device_id_count,device_ip_ratio]
    }
  }
