view: etl_check_opti_report_v1 {
  derived_table: {
    sql: WITH dates_chek_list as (
                        SELECT slice_time AS generated_date
                        FROM (
                            SELECT
                                current_date() - interval '30 days' AS sample_date
                            UNION ALL
                            SELECT
                                current_date() - interval '2 days' AS sample_date
                        ) min_max_date
                        TIMESERIES slice_time AS '1 DAY' OVER(ORDER BY sample_date::VARCHAR::TIMESTAMP)
                        )

select AA.generated_date as date,count(*)-1 as record_count
from dates_chek_list AA
LEFT JOIN bi.opti_bid_raw_v1 BB
ON AA.generated_date = BB.date_trunc
group by 1
order by 1 desc
    ;;

  }



  dimension: date {
    type: date
    sql: ${TABLE}.date ;;
  }


# measu

  measure: record_count {
    type: sum
    sql: ${TABLE}.record_count ;;
    value_format: "#,##0"
  }





  set: detail {
    fields: [
      date,
      record_count
    ]
  }

}
