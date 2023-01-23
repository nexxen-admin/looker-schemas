view: active_inactive_publishers {
  derived_table: {
    sql: Select 'From '||(current_date()-8)::date||' Through '||(current_date()-1)::date as RANGE,
          coalesce(l.pub_count,0) as ACTIVE,
          coalesce(t.pub_count,0) - coalesce(l.pub_count,0) as INACTIVE,
          coalesce(t.pub_count,0) as TOTAL
      From
        (Select current_date() as RUN_DATE,
          count(distinct pub_id) as PUB_COUNT,
          sum(revenue) as REVENUE
        From andromeda.ad_data_daily
        Where event_time >= current_date()-7
          and event_time < current_date()
          and rx_ssp_name like 'rmp%'
            and rx_ssp_name not like 'rmpak%'
            and rx_ssp_name is not NULL
          and revenue > 0
        Group by 1) l
      FULL JOIN
         (Select current_date() as RUN_DATE,
            count(distinct sp.publisher_id) as PUB_COUNT
           From andromeda.rx_dim_supply_publisher sp
            inner join andromeda.rx_dim_supply_publisher_traffic_source spts
                on spts.publisher_id = sp.publisher_id
            Inner join andromeda.rx_dim_supply_traffic_source sts on sts.traffic_source_id = spts.traffic_source_id
            Where sts.rx_ssp_name ilike 'rmp%'
                and sts.rx_ssp_name not ilike 'rmpak%'
                and sts.rx_ssp_name is not NULL
           Group by 1) t on t.run_date = l.run_date
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: range {
    type: string
    sql: ${TABLE}."RANGE" ;;
  }

  dimension: active {
    type: number
    sql: ${TABLE}.ACTIVE ;;
  }

  dimension: inactive {
    type: number
    sql: ${TABLE}.INACTIVE ;;
  }

  measure: total {
    type: sum
    sql: ${TABLE}.TOTAL ;;
  }

  set: detail {
    fields: [range, active, inactive, total]
  }
}
