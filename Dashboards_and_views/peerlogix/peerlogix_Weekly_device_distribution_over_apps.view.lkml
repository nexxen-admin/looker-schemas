view: peerlogix_Weekly_device_distribution_over_apps {
    derived_table: {
      sql:


        with count_delimtor as (
        SELECT DATE_TRUNC('week', aa.viewing_start_utc) as week,
               device_id,
               ip,
               replace(platforms_all,'|','cccc') as new_platforms_all,
               REGEXP_COUNT(replace(platforms_all,'|','cccc'), 'cccc')+1  as number_of_char_in_string
        FROM dragon.viewership_content_peerlogix_daily AA

        ),

        split_delimator as (
        select week,device_id,ip,split_part(new_platforms_all, 'cccc', rn) split_into_rows
        from count_delimtor
        cross join (select row_number() over () rn
                    from columns ) foo
        where rn <= regexp_count(new_platforms_all, 'cccc')+1)

select week,split_into_rows,count(distinct device_id) as count_device
from split_delimator
group by week,split_into_rows



         ;;
    }


    dimension: week {
      type: date_week
      sql: ${TABLE}."week" ;;
    }

  dimension: split_into_rows {
    type: string
    sql: ${TABLE}."split_into_rows" ;;
  }



    measure: count_device {
      type: average
      sql: ${TABLE}."count_device" ;;
    }

    set: detail {
      fields: [week, split_into_rows,count_device]
    }
  }
