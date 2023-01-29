view: monthly_ip_stability {
  derived_table: {
    sql: WITH tempy AS (
                SELECT concat(concat(year(viewership_content_sessions_combined.viewing_start_utc),'-'),month(viewership_content_sessions_combined.viewing_start_utc)) as year_month,
                       viewership_content_sessions_combined.device_id,
                       count(DISTINCT ip) as distinct_ip
                FROM dragon.viewership_content_sessions_combined
                GROUP BY 1,2)

      SELECT year_month,
      SUM(CASE WHEN distinct_ip=1 THEN 1 else 0 END) as ip_1,
      SUM(CASE WHEN distinct_ip=2 THEN 1 else 0 END) as ip_2,
      SUM(CASE WHEN distinct_ip=3 THEN 1 else 0 END) as ip_3,
      SUM(CASE WHEN distinct_ip=4 THEN 1 else 0 END) as ip_4,
      SUM(CASE WHEN distinct_ip=5 THEN 1 else 0 END) as ip_5,
      SUM(CASE WHEN (distinct_ip>=6 AND distinct_ip<=10) THEN 1 else 0 END) as ip_6_10,
      SUM(CASE WHEN (distinct_ip>=11 AND distinct_ip<=15) THEN 1 else 0 END) as ip_11_15,
      SUM(CASE WHEN (distinct_ip>=16 AND distinct_ip<=20) THEN 1 else 0 END) as ip_16_20,
      SUM(CASE WHEN (distinct_ip>=21) THEN 1 else 0 END) as ip_above_20,
      count(*) as all
      FROM tempy
      GROUP BY 1
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: year_month {
    type: string
    sql: ${TABLE}.year_month ;;
  }

  measure: ip_1 {
    type: average
    sql: ${TABLE}.ip_1 ;;
  }

  measure: ip_2 {
    type: average
    sql: ${TABLE}.ip_2 ;;
  }

  measure: ip_3 {
    type: average
    sql: ${TABLE}.ip_3 ;;
  }

  measure: ip_4 {
    type: average
    sql: ${TABLE}.ip_4 ;;
  }

  measure: ip_5 {
    type: average
    sql: ${TABLE}.ip_5 ;;
  }

  measure: ip_6_10 {
    type: average
    sql: ${TABLE}.ip_6_10 ;;
  }

  measure: ip_11_15 {
    type: average
    sql: ${TABLE}.ip_11_15 ;;
  }

  measure: ip_16_20 {
    type: average
    sql: ${TABLE}.ip_16_20 ;;
  }

  measure: ip_above_20 {
    type: average
    sql: ${TABLE}.ip_above_20 ;;
  }

  measure: all {
    type: number
    sql: ${TABLE}."all" ;;
  }

  set: detail {
    fields: [
      year_month,
      ip_1,
      ip_2,
      ip_3,
      ip_4,
      ip_5,
      ip_6_10,
      ip_11_15,
      ip_16_20,
      ip_above_20,
      all
    ]
  }
}
