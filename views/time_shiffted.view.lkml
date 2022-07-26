view: time_shiffted {
  derived_table: {
    sql: SELECT
      d.date_key,
      lag(sum(sum_of_revenue),7,0) OVER (order by d.date_key) sevenDay_Before_Revenue,
      lag(sum(sum_of_revenue),1,0) OVER (order by d.date_key) Day_Before_Revenue
      FROM bi_new.dim_date d  join bi_new.fact_ad_daily_agg  dd on d.date_key = dd.date_key
      group by 1 ORDER by d.date_key
       ;;
  }


  dimension: date_key {
    label: " "
    type: date
    sql: ${TABLE}.Date_Key ;;
  }

  measure: seven_day_before_revenue {
    type: sum
    sql: ${TABLE}.sevenDay_Before_Revenue ;;
  }

  measure: day_before_revenue {
    type: sum
    sql: ${TABLE}.Day_Before_Revenue ;;
  }

  set: detail {
    fields: [date_key, seven_day_before_revenue, day_before_revenue]
  }
}
