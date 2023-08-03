view: peerlogix_rolling_days_intervals_ip_device {
    derived_table: {
      sql: SELECT COUNT(DISTINCT case when date(AA.viewing_start_utc)>=CURRENT_DATE-7 then device_id else null end) as "segment 1: device_7_days",
                  COUNT(DISTINCT case when date(AA.viewing_start_utc)>=CURRENT_DATE-7 then ip else null end) as "segment 1: ip_7_days",
                  COUNT(DISTINCT case when date(AA.viewing_start_utc)>=CURRENT_DATE-30 then device_id else null end) as "segment 2: device_30_days",
                  COUNT(DISTINCT case when date(AA.viewing_start_utc)>=CURRENT_DATE-30 then ip else null end) as "segment 2: ip_30_days",
                  COUNT(DISTINCT case when date(AA.viewing_start_utc)>=CURRENT_DATE-60 then device_id else null end) as "segment 3: device_60_days",
                  COUNT(DISTINCT case when date(AA.viewing_start_utc)>=CURRENT_DATE-60 then ip else null end) as "segment 3: ip_60_days",
                  COUNT(DISTINCT case when date(AA.viewing_start_utc)>=CURRENT_DATE-90 then device_id else null end) as "segment 4: device_90_days",
                  COUNT(DISTINCT case when date(AA.viewing_start_utc)>=CURRENT_DATE-90 then ip else null end) as "segment 4: ip_90_days"
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

  measure: device_30_days {
    type: average
    sql: ${TABLE}."device_30_days" ;;
  }

  measure: ip_30_days {
    type: average
    sql: ${TABLE}."ip_30_days" ;;
  }


  measure: device_60_days {
    type: average
    sql: ${TABLE}."device_60_days" ;;
  }

  measure: ip_60_days {
    type: average
    sql: ${TABLE}."ip_60_days" ;;
  }

  measure: device_90_days {
    type: average
    sql: ${TABLE}."device_90_days" ;;
  }

  measure: ip_90_days {
    type: average
    sql: ${TABLE}."ip_90_days" ;;
  }



    set: detail {
      fields: [device_7_days, ip_7_days, device_30_days, ip_30_days, device_60_days, ip_60_days, device_90_days, ip_90_days]
    }
  }
