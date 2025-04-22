view: pmp_stats_hourly {
  derived_table: {
    sql: select event_time,rx_deal_id, sum(REVENUE) as revenue, sum(deal_data_fee) as datafee, sum(COST) as mediacost
from Andromeda.pmp_stats_hourly psh
where event_time >='2023-01-01'
--and rx_deal_id in ('xxxx')
group by 1,2 ;;
  }

  dimension_group: event_time {
    label: " "
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.event_time ;;
  }

dimension: rx_deal_id {
  type: string
  sql: ${TABLE}.rx_deal_id ;;
}

measure: revenue {
  type: sum
  sql: ${TABLE}.revenue ;;
}

measure: datafee {
  type: sum
  sql: ${TABLE}.datafee ;;
}

measure: mediacost {
  type: sum
  sql: ${TABLE}.mediacost ;;
}
}
