view: aur_flight_details {
  sql_table_name: dim.flight_details ;;

  dimension_group: begin_datetime_local {
    type: time
    label: "Flight Start Date - Local"
    view_label: "Flight"
    description: "The start date of the flight in the demand timezone."
    timeframes: [
      time
    ]
    sql: ${TABLE}.begin_datetime_local ;;
  }

  dimension_group: begin_datetm {
    type: time
    label: "Flight Start Date"
    view_label: "Flight"
    description: "The start date of the flight in the GMT."
    timeframes: [
      time
    ]
    sql: ${TABLE}.begin_datetm ;;
  }

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension_group: end_datetime_local {
    type: time
    label: "Flight End Date - Local"
    view_label: "Flight"
    description: "The end date of the flight in the demand timezone."
    timeframes: [
      time
    ]
    sql: ${TABLE}.end_datetime_local ;;
  }

  dimension_group: end_datetm {
    type: time
    label: "Flight End Date"
    view_label: "Flight"
    description: "The end date of the flight in the GMT."
    timeframes: [
      time
    ]
    sql: ${TABLE}.end_datetm ;;
  }

  dimension: flight_active {
    type: yesno
    label: "Flight Active"
    view_label: "Flight"
    description: "A yes/no indiciator if the flight is currently active."
    sql: ${TABLE}.flight_active ;;
  }

  dimension: flight_budget {
    type: number
    label: "Flight Budget"
    view_label: "Flight"
    description: "The total flight budget in demand currency."
    sql: ${TABLE}.flight_budget ;;
  }

  dimension: flight_contracted_units {
    type: number
    label: "Flight Contracted Units"
    view_label: "Flight"
    description: "The total flight contracted units."
    sql: ${TABLE}.flight_contracted_units ;;
  }

  dimension: flight_delivery_units {
    type: number
    label: "Flight Delivery Units"
    view_label: "Flight"
    description: "The total flight delivery units."
    sql: ${TABLE}.flight_delivery_units ;;
  }

  dimension: flight_description {
    type: string
    label: "Flight Name"
    view_label: "Flight"
    description: "The name of the flight."
    sql: ${TABLE}.flight_description ;;
  }

  dimension: flight_id {
    type: number
    label: "Flight ID"
    view_label: "Flight"
    description: "The internal system identifier of the flight."
    sql: ${TABLE}.flight_id ;;
    value_format_name: id
  }

  dimension: flight_units {
    type: number
    label: "Flight Units"
    view_label: "Flight"
    description: "The total flight units."
    sql: ${TABLE}.flight_units ;;
  }

}
