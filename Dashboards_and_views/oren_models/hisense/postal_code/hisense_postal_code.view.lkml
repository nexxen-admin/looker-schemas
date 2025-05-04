view: hisense_postal_code {
    derived_table: {
      sql: SELECT DISTINCT DATE(viewing_start_utc) as date,
                           bb.call_letters as networks,
                           postal_code
          FROM dragon.viewership_content_sessions_combined aa
          LEFT JOIN dragon.station_info bb
          ON aa.station_tremor_id = bb.station_tremor_id
          WHERE  viewing_start_utc > TRUNC(NOW()) - INTERVAL '1 month'
                 AND aa.country = 'gb'
           AND REGEXP_COUNT(postal_code, '^[A-Za-z]{1,2}\d[A-Za-z\d]? ?\d[A-Za-z]{2}$') > 0 -- only valid gb codes
         ;;
    }


    dimension: date {
      type: date
      sql: ${TABLE}."date" ;;
    }

    dimension: networks {
      type: string
      sql: ${TABLE}.networks ;;
    }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.postal_code ;;
  }


    set: detail {
      fields: [date,networks, postal_code]
    }
  }
