view: aur_flight_media_details {
  label: "Flight Media"
  sql_table_name: dim.flight_media_details ;;

  dimension: flight_id {
    type: number
    hidden: yes
    sql: ${TABLE}.flight_id ;;
  }

  dimension: flight_media_active {
    type: yesno
    label: "Flight Media Active"
    view_label: "Flight Media"
    description: "A yes/no indicator if the flight media is currently active"
    sql: ${TABLE}.flight_media_active ;;
  }

  dimension: flight_media_delivery_units {
    type: number
    label: "Flight Media Delivery Units"
    view_label: "Flight Media"
    description: "The total Delivery Units for the Flight Media"

    sql: ${TABLE}.flight_media_delivery_units ;;
  }

  dimension: flight_media_description {
    type: string
    label: "Flight Media"
    view_label: "Flight Media"
    description: "The name of the Flight Media"
    sql: ${TABLE}.flight_media_description ;;
  }

  dimension: flight_media_id {
    type: number
    label: "Flight Media ID"
    view_label: "Flight Media"
    description: "The internal system identifier of the flight media"
    sql: ${TABLE}.flight_media_id ;;
    value_format_name: id
  }

  dimension: flight_media_units {
    type: number
    label: "Flight Media Units"
    view_label: "Flight Media"
    description: "The total units for the flight media"
    sql: ${TABLE}.flight_media_units ;;
  }


}
