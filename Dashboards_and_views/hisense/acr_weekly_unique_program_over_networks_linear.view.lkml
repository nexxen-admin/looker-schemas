view: acr_weekly_unique_program_over_networks_linear {
  derived_table: {
    sql: SELECT DATE_TRUNC('WEEK',AA.viewing_start_utc) as week_date,
       affiliate_call_sign,
      aa.country,
       COUNT(DISTINCT PP.title) AS distinct_title_count
FROM dragon.viewership_content_sessions_combined_daily AA
LEFT JOIN dragon.airing BB
ON AA.airing_tremor_id = BB.airing_tremor_id
LEFT JOIN dragon.program PP
ON AA.tv_program_tremor_id=PP.tv_program_tremor_id
where source='linear' and AA.viewing_start_utc>current_date - INTERVAL '2 month'
GROUP BY 1,2,3
ORDER BY 4 DESC
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: week_date {
    type: date_week
    sql: ${TABLE}.week_date ;;
  }

  dimension: affiliate_call_sign {
    type: string
    sql: ${TABLE}.affiliate_call_sign ;;
  }
  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }
  measure: distinct_title_count {
    type: average
    sql: ${TABLE}.distinct_title_count ;;
  }

  set: detail {
    fields: [week_date, affiliate_call_sign,country, distinct_title_count]
  }
}
