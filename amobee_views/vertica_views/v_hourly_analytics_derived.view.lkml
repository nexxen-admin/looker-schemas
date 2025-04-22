view: v_hourly_analytics_derived {

  # This view is created to join it with hourly_analytics and get dimensions for previous days,
  # it is replacement for LAG() function.
  # See hourly_analytics exlore, this view can be used as:
  # join: hourly_analytics_derived {
  #   view_label: "Relative changes"
  #   relationship: many_to_one
  #   sql_on: ${hourly_analytics.demand_date_date} = TO_CHAR(DATEADD(DAY, 1, TO_TIMESTAMP(${hourly_analytics_derived.demand_date})), 'YYYY-MM-DD') ;;
  # }

  derived_table: {
    sql: select
              TO_DATE(hourly_analytics.DEMAND_DATE) as demand_date,
              COALESCE(SUM(hourly_analytics.IMPRESSIONS), 0) as sum_impressions,
              COALESCE(SUM(CASE WHEN hourly_analytics.ADSERVER_CODE = 1 then hourly_analytics.PUBLISHER_REQUESTS else 0 end ), 0) as sum_served_requests
        from RAWDB.analytics_view AS hourly_analytics
        where hourly_analytics.DEMAND_DATE >= TIMESTAMPADD('day', -60, CURRENT_DATE()) group by TO_DATE(hourly_analytics.DEMAND_DATE);;
  }

  dimension: demand_date {
    hidden: yes
    type: date
    sql: ${TABLE}."DEMAND_DATE" ;;
  }

  dimension: sum_impressions {
    label: "Sum Impressions Previous Day"
    description: "The total impressions"
    type: number
    sql: ${TABLE}."SUM_IMPRESSIONS" ;;
  }

  dimension: sum_served_requests {
    label: "Sum Served Requests Previous Day"
    description: "The total served requests"
    type: number
    sql: ${TABLE}."SUM_SERVED_REQUESTS" ;;
  }

  measure: impressions_change_relative_to_previous_day {
    type: number
    label: "Impressions change relative to previous day"
    description: "Impressions change relative to previous day"
    value_format_name: percent_2
    sql: (${v_hourly_analytics.sum_impressions} - ${sum_impressions}) / nullif(${sum_impressions}, 0) ;;
  }

  measure: served_requests_change_relative_to_previous_day {
    type: number
    label: "Served requests change relative to previous day"
    description: "Served requests change relative to previous day"
    value_format_name: percent_2
    sql: (${v_hourly_analytics.sum_served_requests} - ${sum_served_requests}) / nullif(${sum_served_requests}, 0) ;;
  }

  set: detail {
    fields: [demand_date, sum_impressions, sum_served_requests]
  }
}
