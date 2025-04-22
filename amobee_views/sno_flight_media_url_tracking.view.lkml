view: flight_media_url_tracking {
  sql_table_name: DIM.FLIGHT_MEDIA_URL_TRACKING_VIEW ;;

  dimension: flight_media_id {
    type: number
    hidden: yes
    sql: ${TABLE}.FLIGHT_MEDIA_ID ;;
  }

  dimension: tracking_type {
    type: string
    label: "Flight Media Tracking Type"
    view_label: "Flight Media"
    description: "Type of tracking (Start, 25, 50, 75, End, Click, Destination)"
    sql: ${TABLE}.TRACKING_TYPE ;;
    bypass_suggest_restrictions: yes
  }

  dimension: tracking_urls {
    type: string
    label: "Flight Media Tracking URL"
    view_label: "Flight Media"
    description: "Flight Media Tracking URLs, by Tracking Type"
    sql: ${TABLE}.TRACKING_URLS ;;
    suggestable: no
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
