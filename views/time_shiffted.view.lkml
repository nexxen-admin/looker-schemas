view: time_shiffted {
  derived_table: {
    sql: SELECT
      date_key,
      sum(sum_of_revenue) as revenue,
      lag(sum(sum_of_revenue),7,0) OVER (order by date_key) sevenDay_Before_Revenue,
      lag(sum(sum_of_revenue),1,0) OVER (order by date_key) Day_Before_Revenue
      FROM bi_new.fact_ad_daily_agg
      group by 1 ORDER by date_key
       ;;
  }


  dimension: date_key {
    label: " date"
    type: date
    sql: ${TABLE}.Date_Key ;;
  }

  measure: seven_day_before_revenue {
    type: sum
    sql: ${TABLE}.sevenDay_Before_Revenue ;;
  }

  measure: revenue {
    type: sum
    sql: ${TABLE}.revenue ;;
  }

  measure: day_before_revenue {
    type: sum
    sql: ${TABLE}.Day_Before_Revenue ;;
  }

  set: detail {
    fields: [date_key, seven_day_before_revenue, day_before_revenue]
  }
}
