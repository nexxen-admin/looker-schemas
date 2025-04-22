view: sno_latest_viewing_date {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:
        SELECT
        metric_type
         , dateadd(day, -1, MAX(event_date)) as latest_available_data
       FROM VIEWERSHIP.VIEWING_FACT vf
       WHERE {% condition metric_type %} vf.metric_type  {% endcondition %}
       GROUP BY metric_type
       ;;
  }

  filter: metric_type {
    view_label: "Viewing Metrics"
    description: "Eg. For AED(Ad Exposure Data), type 'AED7'. For AMRLD viewing data, type 'LIVE+SD'(Live+Same Day)"
    type: string
    suggestions: ["AED7","LIVE+SD"]
  }

 dimension: latest_available_data {
    view_label: "Viewing Metrics"
    hidden: no
    description: "The latest data that is available"
    type: date
    sql: ${TABLE}.latest_available_data ;;
  }
}
