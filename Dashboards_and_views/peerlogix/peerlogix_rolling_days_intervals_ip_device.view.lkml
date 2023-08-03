view: peerlogix_rolling_days_intervals_ip_device {
    derived_table: {
      sql: SELECT COUNT(DISTINCT case when date(AA.viewing_start_utc)>=CURRENT_DATE-7 then device_id else null end) as device_7_days,
                  COUNT(DISTINCT case when date(AA.viewing_start_utc)>=CURRENT_DATE-7 then ip else null end) as ip_7_days,
                  COUNT(DISTINCT case when date(AA.viewing_start_utc)>=CURRENT_DATE-30 then device_id else null end) as device_30_days,
                  COUNT(DISTINCT case when date(AA.viewing_start_utc)>=CURRENT_DATE-30 then ip else null end) as ip_30_days
        FROM dragon.viewership_content_peerlogix_daily AA
         ;;
    }




    measure: device_7_days {
      type: average
      sql: ${TABLE}."device_7_days" ;;
    }

    measure: ip_7_days {
      type: average
      sql: ${TABLE}."ip_7_days" ;;
    }

    set: detail {
      fields: [device_7_days, ip_7_days]
    }
  }
