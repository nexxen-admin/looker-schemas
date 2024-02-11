view: monthly_ip_stability {
  derived_table: {
    sql:


select '1 Month' as 'Time_period',
       country,
       round(count(distinct case when ip_count=1 then device_id end)/count(device_id),3) as 'ip1',
       round(count(distinct case when ip_count=2 then device_id end)/count(device_id),3) as 'ip2',
       round(count(distinct case when ip_count=3 then device_id end)/count(device_id),3) as 'ip3',
       round(count(distinct case when ip_count=4 then device_id end)/count(device_id),3) as 'ip4',
       round(count(distinct case when ip_count=5 then device_id end)/count(device_id),3) as 'ip5',
       round(count(distinct case when ip_count=6 then device_id end)/count(device_id),3) as 'ip6',
       round(count(distinct case when ip_count=7 then device_id end)/count(device_id),3) as 'ip7',
       round(count(distinct case when ip_count=8 then device_id end)/count(device_id),3) as 'ip8'
from (
      select device_id,country,count(distinct ip) as ip_count
      from dragon.viewership_content_sessions_combined_daily AA
      where AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -1) and ADD_MONTHS(CURRENT_TIMESTAMP,0)
      group by 1,2
      ) BB
group by 1,2
UNION ALL
select '2 Month' as 'Time period',
       country,
       round(count(distinct case when ip_count=1 then device_id end)/count(device_id),3) as 'ip1',
       round(count(distinct case when ip_count=2 then device_id end)/count(device_id),3) as 'ip2',
       round(count(distinct case when ip_count=3 then device_id end)/count(device_id),3) as 'ip3',
       round(count(distinct case when ip_count=4 then device_id end)/count(device_id),3) as 'ip4',
       round(count(distinct case when ip_count=5 then device_id end)/count(device_id),3) as 'ip5',
       round(count(distinct case when ip_count=6 then device_id end)/count(device_id),3) as 'ip6',
       round(count(distinct case when ip_count=7 then device_id end)/count(device_id),3) as 'ip7',
       round(count(distinct case when ip_count=8 then device_id end)/count(device_id),3) as 'ip8'
from (
      select device_id,country,count(distinct ip) as ip_count
      from dragon.viewership_content_sessions_combined_daily AA
      where AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -2) and ADD_MONTHS(CURRENT_TIMESTAMP,0)
      group by 1,2
      ) BB
group by 1,2
UNION ALL
select '3 Month' as 'Time period',
       country,
       round(count(distinct case when ip_count=1 then device_id end)/count(device_id),3) as 'ip1',
       round(count(distinct case when ip_count=2 then device_id end)/count(device_id),3) as 'ip2',
       round(count(distinct case when ip_count=3 then device_id end)/count(device_id),3) as 'ip3',
       round(count(distinct case when ip_count=4 then device_id end)/count(device_id),3) as 'ip4',
       round(count(distinct case when ip_count=5 then device_id end)/count(device_id),3) as 'ip5',
       round(count(distinct case when ip_count=6 then device_id end)/count(device_id),3) as 'ip6',
       round(count(distinct case when ip_count=7 then device_id end)/count(device_id),3) as 'ip7',
       round(count(distinct case when ip_count=8 then device_id end)/count(device_id),3) as 'ip8'
from (
      select device_id,country,count(distinct ip) as ip_count
      from dragon.viewership_content_sessions_combined_daily AA
      where AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -3) and ADD_MONTHS(CURRENT_TIMESTAMP,0)
      group by 1,2
      ) BB
group by 1,2
UNION ALL
select '4 Month' as 'Time period',
       country,
       round(count(distinct case when ip_count=1 then device_id end)/count(device_id),3) as 'ip1',
       round(count(distinct case when ip_count=2 then device_id end)/count(device_id),3) as 'ip2',
       round(count(distinct case when ip_count=3 then device_id end)/count(device_id),3) as 'ip3',
       round(count(distinct case when ip_count=4 then device_id end)/count(device_id),3) as 'ip4',
       round(count(distinct case when ip_count=5 then device_id end)/count(device_id),3) as 'ip5',
       round(count(distinct case when ip_count=6 then device_id end)/count(device_id),3) as 'ip6',
       round(count(distinct case when ip_count=7 then device_id end)/count(device_id),3) as 'ip7',
       round(count(distinct case when ip_count=8 then device_id end)/count(device_id),3) as 'ip8'
from (
      select device_id,country,count(distinct ip) as ip_count
      from dragon.viewership_content_sessions_combined_daily AA
      where AA.viewing_start_utc between ADD_MONTHS(CURRENT_TIMESTAMP, -4) and ADD_MONTHS(CURRENT_TIMESTAMP,0)
      group by 1,2
      ) BB
group by 1,2



      ;;
  }



  dimension: Time_period {
    type: string
    label: "Time range"
    sql: ${TABLE}.Time_period ;;
  }

  dimension: country {
    type: string
    label: "Time range"
    sql: ${TABLE}.country ;;
  }

  measure: ip1 {
    type: average
    label: "Devices (1 IP)"
    sql: ${TABLE}.ip1 ;;
  }

  measure: ip2 {
    type: average
    label: "Devices (2 IP)"
    sql: ${TABLE}.ip2 ;;
  }

  measure: ip3 {
    type: average
    label: "Devices (3 IP)"
    sql: ${TABLE}.ip3 ;;
  }



  measure: ip4 {
    label: "Devices (4 IP)"
    type: average
    sql: ${TABLE}.ip4 ;;
  }

  measure: ip5 {
    label: "Devices (5 IP)"
    type: average
    sql: ${TABLE}.ip5 ;;
  }

  measure: ip6 {
    type: average
    label: "Devices (6 IP)"
    sql: ${TABLE}.ip6 ;;
  }

  measure: ip7 {
    label: "Devices (7 IP)"
    type: average
    sql: ${TABLE}.ip7 ;;
  }

  measure: ip8 {
    label: "Devices (8 IP)"
    type: average
    sql: ${TABLE}.ip8 ;;
  }


  set: detail {
    fields: [
      Time_period,
      country,
      ip1,
      ip2,
      ip3,
      ip4,
      ip5,
      ip6,
      ip7,
      ip8
    ]
  }
}
