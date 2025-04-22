view: peerlogix_weekly_title_device_ip {
    derived_table: {
      sql: select DATE_TRUNC('WEEK',AA.viewing_start_utc) as week_date,
       title,
      count(distinct device_id) as device_id,
      count(distinct ip) as ip
FROM dragon.viewership_content_peerlogix_daily AA
LEFT JOIN dragon.program PP
ON AA.tv_program_tremor_id=PP.tv_program_tremor_id
group by week_date,title
         ;;
    }


    dimension: week_date {
      type: date_week
      sql: ${TABLE}."week_date" ;;
    }


    dimension: title {
      type: string
      sql: ${TABLE}."title" ;;
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
      fields: [week_date, title,device_id,ip]
    }
  }
