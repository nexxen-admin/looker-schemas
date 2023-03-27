view: trafficked_flights {

  derived_table: {
    sql: select distinct flight_id as FLIGHT_ID
    from dim.flight_media_details
      ;;
  }

  dimension: flight_id {
    description: "Unique ID for each user that has ordered"
    type: number
    hidden: yes
    sql: ${TABLE}.FLIGHT_ID ;;
  }

  filter: filter_on_flight_id {
    type: yesno
    label: "Trafficked Flights Only"
    view_label: "Flight"
    description: "Include this field as a filter in your Look to exclude flights without flight media."
    sql: true ;;
  }

}
