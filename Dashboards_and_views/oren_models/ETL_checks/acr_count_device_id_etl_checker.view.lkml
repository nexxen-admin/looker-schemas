view: acr_count_device_id_etl_checker {
    derived_table: {
      sql: WITH dates_chek_list as (
                        SELECT slice_time AS generated_date
                        FROM (
                            SELECT
                                current_date() - interval '30 days' AS sample_date
                            UNION ALL
                            SELECT
                                current_date() - interval '1 days' AS sample_date
                        ) min_max_date
                        TIMESERIES slice_time AS '1 DAY' OVER(ORDER BY sample_date::VARCHAR::TIMESTAMP)
                        )

select AA.generated_date as date,sum(count_of_device_id) as count_of_device_id
from dates_chek_list AA
LEFT JOIN bi_new.acr_count_device_id BB
ON AA.generated_date = BB.date
group by 1
order by 1 desc
    ;;



    }


    dimension: date {
      type: date
      sql: ${TABLE}."date" ;;
    }



    measure: count_of_device_id {
      type: sum
      sql: ${TABLE}."count_of_device_id" ;;
    }


    set: detail {
      fields: [date,count_of_device_id]
    }
  }
