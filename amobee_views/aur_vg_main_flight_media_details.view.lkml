view: vg_main_flight_media_details {
  label: "Flight Media"
  sql_table_name: vg_main.flight_media_details ;;



  dimension: daily_ccp_eoc_audit {
    type: number
    sql: ${TABLE}.daily_ccp_eoc_audit ;;
  }


  dimension: flight_media_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.flight_media_id ;;
  }

measure: sum_daily_ccp_eoc_audit {
  type: sum
  label: "Daily Delivery Cap"
  view_label: "Metrics"
  description: "The number of units to delivery for today including any audit factor."
  value_format_name: decimal_0
  sql: ${daily_ccp_eoc_audit} ;;
}


}
