view: monthly_ip_stability {
  derived_table: {
    sql:


select '1 month interval' as 'Time_period',
       round(count(distinct case when ip_count=1 then device_id end)/count(device_id),3) as '1_IP',
       round(count(distinct case when ip_count=2 then device_id end)/count(device_id),3) as '2_IP',
       round(count(distinct case when ip_count=3 then device_id end)/count(device_id),3) as '3_IP',
       round(count(distinct case when ip_count=4 then device_id end)/count(device_id),3) as '4_IP',
       round(count(distinct case when ip_count=5 then device_id end)/count(device_id),3) as '5_IP',
       round(count(distinct case when ip_count=6 then device_id end)/count(device_id),3) as '6_IP',
       round(count(distinct case when ip_count=7 then device_id end)/count(device_id),3) as '7_IP',
       round(count(distinct case when ip_count=8 then device_id end)/count(device_id),3) as '8_IP',
       round(count(distinct case when ip_count=9 then device_id end)/count(device_id),3) as '9_IP',
       round(count(distinct case when ip_count=10 then device_id end)/count(device_id),3) as '10_IP'
from (
      select device_id,count(distinct ip) as ip_count
      from dragon.viewership_content_sessions_combined_daily AA
      where AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -1) and ADD_MONTHS(CURRENT_TIMESTAMP,0)
      group by 1
      ) BB

UNION ALL
select '2 month interval' as 'Time period',
       round(count(distinct case when ip_count=1 then device_id end)/count(device_id),3) as '1_IP',
       round(count(distinct case when ip_count=2 then device_id end)/count(device_id),3) as '2_IP',
       round(count(distinct case when ip_count=3 then device_id end)/count(device_id),3) as '3_IP',
       round(count(distinct case when ip_count=4 then device_id end)/count(device_id),3) as '4_IP',
       round(count(distinct case when ip_count=5 then device_id end)/count(device_id),3) as '5_IP',
       round(count(distinct case when ip_count=6 then device_id end)/count(device_id),3) as '6_IP',
       round(count(distinct case when ip_count=7 then device_id end)/count(device_id),3) as '7_IP',
       round(count(distinct case when ip_count=8 then device_id end)/count(device_id),3) as '8_IP',
       round(count(distinct case when ip_count=9 then device_id end)/count(device_id),3) as '9_IP',
       round(count(distinct case when ip_count=10 then device_id end)/count(device_id),3) as '10_IP'
from (
      select device_id,count(distinct ip) as ip_count
      from dragon.viewership_content_sessions_combined_daily AA
      where AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -2) and ADD_MONTHS(CURRENT_TIMESTAMP,0)
      group by 1
      ) BB

UNION ALL
select '3 month interval' as 'Time period',
       round(count(distinct case when ip_count=1 then device_id end)/count(device_id),3) as '1_IP',
       round(count(distinct case when ip_count=2 then device_id end)/count(device_id),3) as '2_IP',
       round(count(distinct case when ip_count=3 then device_id end)/count(device_id),3) as '3_IP',
       round(count(distinct case when ip_count=4 then device_id end)/count(device_id),3) as '4_IP',
       round(count(distinct case when ip_count=5 then device_id end)/count(device_id),3) as '5_IP',
       round(count(distinct case when ip_count=6 then device_id end)/count(device_id),3) as '6_IP',
       round(count(distinct case when ip_count=7 then device_id end)/count(device_id),3) as '7_IP',
       round(count(distinct case when ip_count=8 then device_id end)/count(device_id),3) as '8_IP',
       round(count(distinct case when ip_count=9 then device_id end)/count(device_id),3) as '9_IP',
       round(count(distinct case when ip_count=10 then device_id end)/count(device_id),3) as '10_IP'
from (
      select device_id,count(distinct ip) as ip_count
      from dragon.viewership_content_sessions_combined_daily AA
      where AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -3) and ADD_MONTHS(CURRENT_TIMESTAMP,0)
      group by 1
      ) BB

UNION ALL
select '4 month interval' as 'Time period',
       round(count(distinct case when ip_count=1 then device_id end)/count(device_id),3) as '1_IP',
       round(count(distinct case when ip_count=2 then device_id end)/count(device_id),3) as '2_IP',
       round(count(distinct case when ip_count=3 then device_id end)/count(device_id),3) as '3_IP',
       round(count(distinct case when ip_count=4 then device_id end)/count(device_id),3) as '4_IP',
       round(count(distinct case when ip_count=5 then device_id end)/count(device_id),3) as '5_IP',
       round(count(distinct case when ip_count=6 then device_id end)/count(device_id),3) as '6_IP',
       round(count(distinct case when ip_count=7 then device_id end)/count(device_id),3) as '7_IP',
       round(count(distinct case when ip_count=8 then device_id end)/count(device_id),3) as '8_IP',
       round(count(distinct case when ip_count=9 then device_id end)/count(device_id),3) as '9_IP',
       round(count(distinct case when ip_count=10 then device_id end)/count(device_id),3) as '10_IP'
from (
      select device_id,count(distinct ip) as ip_count
      from dragon.viewership_content_sessions_combined_daily AA
      where AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -4) and ADD_MONTHS(CURRENT_TIMESTAMP,0)
      group by 1
      ) BB



      ;;
  }



  dimension: Time_period {
    type: string
    sql: ${TABLE}.Time_period ;;
  }

  measure: one_IP {
    type: average
    sql: ${TABLE}.1_IP ;;
  }

  measure: two_IP {
    type: average
    sql: ${TABLE}.2_IP ;;
  }

  measure: three_IP {
    type: average
    sql: ${TABLE}.3_IP ;;
  }

  set: detail {
    fields: [
      Time_period,
      one_IP,
      two_IP,
      three_IP
    ]
  }
}
