view: sno_latest_linkage_date {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql:
       select MAX(timeperiod_date_key) as latest_available_linkage from viewership.viewer_avid
       ;;
  }

  dimension: latest_available_linkage {
    view_label: "Viewing Metrics"
    hidden: no
    description: "The latest linkage data that is available"
    type: string
    sql: ${TABLE}.latest_available_linkage ;;
  }
}
