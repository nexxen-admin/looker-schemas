  view: ACR_weekly_count_ip_device {
    derived_table: {
      sql: SELECT date(AA.viewing_start_utc) as date,
               COUNT(DISTINCT AA.ip) as distinct_ip_count,
              COUNT(DISTINCT AA.device_id) as device_id_count,
              round(COUNT(DISTINCT AA.device_id/COUNT(DISTINCT AA.ip),2) as device_ip_ratio
        FROM dragon.viewership_content_sessions_combined_daily AA
        GROUP BY 1
         ;;
    }


    dimension: date {
      type: date
      sql: ${TABLE}."date" ;;
    }


    measure: distinct_ip_count {
      type: average
      sql: ${TABLE}."distinct_ip_count" ;;
    }


    set: detail {
      fields: [date, distinct_ip_count]
    }
  }
