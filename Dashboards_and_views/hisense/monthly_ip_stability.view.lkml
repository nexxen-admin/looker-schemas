view: monthly_ip_stability {
  derived_table: {
    sql: WITH tempy AS (
                SELECT CASE  WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -1) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN '1_segment (last_30_days)'
                             WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -2) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN '2_segment (last_60_days)'
                             WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -3) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN '3_segment (last_90_days)'
                             WHEN AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -4) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) THEN '4_segment (last_120_days)'
                             ELSE '5_segment (after_120_days)'
                             END AS date_segment,
                        AA.device_id,
                        COUNT(DISTINCT ip) as distinct_ip
                        FROM dragon.viewership_content_sessions_combined_daily AA
                        GROUP BY 1,2)

SELECT date_segment,
        SUM(CASE WHEN distinct_ip=1 THEN 1 else 0 END) as ip_1,
        SUM(CASE WHEN distinct_ip=2 THEN 1 else 0 END) as ip_2,
        SUM(CASE WHEN distinct_ip=3 THEN 1 else 0 END) as ip_3,
        SUM(CASE WHEN distinct_ip=4 THEN 1 else 0 END) as ip_4,
        SUM(CASE WHEN distinct_ip=5 THEN 1 else 0 END) as ip_5,
        SUM(CASE WHEN (distinct_ip>=6 AND distinct_ip<=10) THEN 1 else 0 END) as ip_between_6_and_10,
        SUM(CASE WHEN (distinct_ip>=11 AND distinct_ip<=15) THEN 1 else 0 END) as ip_between_11_and_15,
        SUM(CASE WHEN (distinct_ip>=16 AND distinct_ip<=20) THEN 1 else 0 END) as ip_between_16_and_20,
        SUM(CASE WHEN (distinct_ip>=21) THEN 1 else 0 END) as ip_above_20,
        count(*) as all
FROM tempy
GROUP BY 1
ORDER BY 1 DESC

      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date_segment {
    type: string
    sql: ${TABLE}.date_segment ;;
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

  measure: ip_between_6_and_10 {
    type: average
    sql: ${TABLE}.ip_between_6_and_10 ;;
  }

  measure: ip_between_11_and_15 {
    type: average
    sql: ${TABLE}.ip_between_11_and_15 ;;
  }

  measure: ip_between_16_and_20 {
    type: average
    sql: ${TABLE}.ip_between_16_and_20 ;;
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
      date_segment,
      ip_1,
      ip_2,
      ip_3,
      ip_4,
      ip_5,
      ip_between_6_and_10,
      ip_between_11_and_15,
      ip_between_16_and_20,
      ip_above_20,
      all
    ]
  }
}
