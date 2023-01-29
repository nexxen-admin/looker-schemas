view: acr_weekly_unique_program_over_networks_linear {
  derived_table: {
    sql: SELECT concat(concat(year(viewing_start_utc),'-'),week(viewing_start_utc)) as week_year,
       affiliate_call_sign,
       COUNT(DISTINCT AA.tv_program_tremor_id) AS distinct_program_count
FROM dragon.viewership_content_sessions_combined AA
LEFT JOIN dragon.airing BB
ON AA.airing_tremor_id = BB.airing_tremor_id
where source='linear'
GROUP BY 1,2
ORDER BY 1 DESC
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: week_year {
    type: string
    sql: ${TABLE}.week_year ;;
  }

  dimension: affiliate_call_sign {
    type: string
    sql: ${TABLE}.affiliate_call_sign ;;
  }

  measure: distinct_program_count {
    type: average
    sql: ${TABLE}.distinct_program_count ;;
  }

  set: detail {
    fields: [week_year, affiliate_call_sign, distinct_program_count]
  }
}
