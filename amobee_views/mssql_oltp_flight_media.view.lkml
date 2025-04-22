view: mssql_oltp_flight_media {
  sql_table_name: dbo.flight_media (NOLOCK) ;;
  label: "Flight Media"

  dimension: flight_media_id {
    primary_key: yes
    type: number
    label: "Flight Media ID"
    description: "The internal identifier of the Flight Media."
    sql: ${TABLE}.flight_media_id ;;
    value_format_name: id
  }

  dimension: active {
    type: yesno
    label: "Flight Media Active"
    description: "A yes/no indicator if the flight media is currently active."
    sql: ${TABLE}.active = 1 ;;
  }

  dimension: media_id {
    type: number
    label: "Media ID"
    description: "The internal identifier of the Media."
    sql: ${TABLE}.media_id ;;
    value_format_name: id
  }

  dimension: flight_id {
    type: number
    hidden: yes
    sql: ${TABLE}.flight_id ;;
  }
}
