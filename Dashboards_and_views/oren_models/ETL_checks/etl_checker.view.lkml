view: etl_checker {
  derived_table: {
  sql: WITH year_calander as (
                        SELECT slice_time AS generated_date
                        FROM (
                            SELECT
                                current_date() - interval '1 month' AS sample_date
                            UNION
                            SELECT
                                -- gives the last tuseday date
                                -- CURRENT_DATE - ((EXTRACT(DOW FROM CURRENT_DATE) + 5) % 7 + 1) AS sample_date
                                current_date() - interval '2 days' AS sample_date
                        ) min_max_date
                        TIMESERIES slice_time AS '1 DAY' OVER(ORDER BY sample_date::VARCHAR::TIMESTAMP)),

     check_tvi as (
     select day_date,
       sum(impressions) as impressions,
       sum(imp_price_adj) as price_adj
       from bi.tvi_report
       where day_date >= current_date() - interval '1 month'
       group by 1
       order by 1 DESC
     )

      select generated_date,
             check_tvi.impressions,
             check_tvi.price_adj,
             check_tvi.impressions/(avg(impressions) over ())-1 as ave_imp_diff,
             check_tvi.price_adj/(avg(price_adj) over ())-1 as ave_price_adj_diff
      from year_calander
      LEFT JOIN check_tvi
      ON year_calander.generated_date = check_tvi.day_date
      ORDER BY 1 DESC;;

  }



  dimension: generated_date {
    type: date
    sql: ${TABLE}.generated_date ;;
  }


# measu

  measure: price_adj {
    type: sum
    sql: ${TABLE}.price_adj ;;
    value_format: "#,##0"
  }

  measure: impressions {
    type: sum
    sql: ${TABLE}.impressions ;;
    value_format: "#,##0"
  }

  measure: ave_imp_diff {
    type: sum
    sql: ${TABLE}.ave_imp_diff ;;
    value_format:"0.00%"
  }

  measure: ave_price_adj_diff {
    type: sum
    sql: ${TABLE}.ave_price_adj_diff ;;
    value_format:"0.00%"
  }




  set: detail {
    fields: [
      generated_date,

      price_adj,
      impressions,
      ave_imp_diff,
      ave_price_adj_diff
    ]
  }

}
