view: monthly_ip_stability {
  derived_table: {
    sql: WITH tempy AS (
                with device_ip_count as (
                select device_id,
                       count(distinct case when AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -1) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) then ip else null end) as ip_count_1_month,
                       count(distinct case when AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -2) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) then ip else null end) as ip_count_2_month,
                       count(distinct case when AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -3) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) then ip else null end) as ip_count_3_month,
                       count(distinct case when AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -4) and ADD_MONTHS(CURRENT_TIMESTAMP, 0) then ip else null end) as ip_count_4_month
                from dragon.viewership_content_sessions_combined_daily aa
                group by 1)


select ip_count_1_month,count(*) as count
from device_ip_count
group by 1
having count(*)>0
order by 1 desc



      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ip_count_1_month {
    type: string
    sql: ${TABLE}.ip_count_1_month ;;
  }



  measure: all {
    type: number
    sql: ${TABLE}."all" ;;
  }

  set: detail {
    fields: [
      ip_count_1_month,
      count

    ]
  }
}
