view: publisher_90_day_revenue {
  derived_table: {
    sql: Select pub_id,
        sp.publisher_name,
        oo.user_name,
        case when oo.manager_type = 'sam' then 'SAM' else 'LT' end as manager_type,
        max(ad.event_time)::date as Last_Rev_Date,
        count(distinct event_time::date) as Active_Rev_Days,
        sum(revenue) as Revenue,
        sum(revenue) / count(distinct event_time::date) as Avg_Rev
      From andromeda.ad_data_daily ad
        left outer join andromeda.rx_dim_supply_publisher sp on sp.publisher_id::varchar = ad.pub_id::varchar
        left outer join andromeda.rx_dim_publisher_info pi on pi.publisher_id::varchar = ad.pub_id::varchar
        left outer join andromeda.rx_dim_publisher_operations_owner oo on oo.user_id = pi.operations_owner_id
      where event_time >= current_date()-90
        and event_time < current_date()
        and rx_ssp_name ilike 'rmp%'
        and revenue > 0
      Group by 1, 2, 3, 4
      Order by 1, 2, 3, 4
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: pub_id {
    type: string
    label: "Publisher ID"
    sql: ${TABLE}.pub_id ;;
  }

  dimension: publisher_name {
    type: string
    label: "Publisher"
    sql: ${TABLE}.publisher_name ;;
  }

  dimension: user_name {
    type: string
    label: "Owner"
    sql: ${TABLE}.user_name ;;
  }

  dimension: manager_type {
    type: string
    label: "Owner Type"
    sql: ${TABLE}.manager_type ;;
  }

  dimension: last_rev_date {
    type: date
    label: "Last RevGen Date"
    sql: ${TABLE}.Last_Rev_Date ;;
  }

  dimension: active_rev_days {
    type: number
    label: "RevGen Days"
    sql: ${TABLE}.Active_Rev_Days ;;
  }


  measure: revenue {
    type: sum
    label: "90-Day Revenue"
    value_format: "$#,##0"
    sql: ${TABLE}.Revenue ;;
  }

  measure: avg_rev {
    type: sum
    label: "Avg Revenue"
    value_format: "$#,##0"
    sql: ${TABLE}.Avg_Rev ;;
  }

  set: detail {
    fields: [
      pub_id,
      publisher_name,
      user_name,
      manager_type,
      last_rev_date,
      active_rev_days
    ]
  }
}
