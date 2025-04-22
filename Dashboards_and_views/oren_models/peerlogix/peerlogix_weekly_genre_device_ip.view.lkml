  view: peerlogix_weekly_genre_device_ip {
    derived_table: {
      sql: select DATE_TRUNC('WEEK',AA.viewing_start_utc) as week_date,
               genre.name as genre_name,
              count(distinct device_id) as device_id,
              count(distinct ip) as ip
        FROM dragon.viewership_content_peerlogix_daily AA
        LEFT JOIN dragon.program_genre
        ON AA.tv_program_tremor_id=program_genre.tv_program_tremor_id
        left JOIN dragon.genre
        ON genre.genre_tremor_id=program_genre.genre_tremor_id
        group by week_date,genre_name
                 ;;
    }



    dimension: week_date {
      type: date_week
      sql: ${TABLE}."week_date" ;;
    }


    dimension: genre_name {
      type: string
      sql: ${TABLE}."genre_name" ;;
    }

    measure: device_id {
      type: average
      sql: ${TABLE}."device_id" ;;
    }

    measure: ip {
      type: average
      sql: ${TABLE}."ip" ;;
    }


    set: detail {
      fields: [week_date, genre_name,device_id,ip]
    }
}
