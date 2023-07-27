  view: ACR_weekly_count_ip_device {
    derived_table: {
      sql: SELECT DATE_TRUNC('WEEK',AA.viewing_start_utc) as week_date,
               COUNT(DISTINCT AA.ip) as distinct_ip_count,
              COUNT(DISTINCT AA.device_id) as device_id_count,
              round(COUNT(DISTINCT AA.device_id)/COUNT(DISTINCT AA.ip),2) as device_ip_ratio
        FROM dragon.viewership_content_sessions_combined_daily AA
        GROUP BY 1
         ;;
    }


    dimension: week_date {
      type: date_week
      sql: ${TABLE}."week_date" ;;
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
      fields: [week_date, distinct_ip_count,device_id_count,device_ip_ratio]
    }
  }
