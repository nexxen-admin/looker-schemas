view: acr_count_device_id {
  derived_table: {
    sql:


    SELECT date(AA.viewing_start_utc) as date,
          aa.country,
          COUNT(DISTINCT aa.device_id) AS "count_of_device_id"
    FROM dragon.viewership_content_sessions_combined_daily AA
    LEFT JOIN dragon.device_info_r BB
    ON AA.device_id = BB.device_id
    where AA.viewing_start_utc>current_date - INTERVAL '1 month'
    GROUP BY 1,2


      ;;
  }

  dimension: count {
    type: number
    drill_fields: [detail*]
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
