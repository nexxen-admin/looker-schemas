view: tpa_email_via_system_activity {
  sql_table_name: BI_DSP.tpa_email_via_system_activity ;;

  dimension: active_tpa_external_id {
    type: string
    sql: ${TABLE}.active_tpa_external_id ;;
  }
  dimension_group: email_datetime {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.email_datetime ;;
  }
  dimension: email_third_party_impressions {
    type: number
    sql: ${TABLE}.email_third_party_impressions ;;
  }
  dimension: email_tpa_external_id {
    type: string
    sql: ${TABLE}.email_tpa_external_id ;;
  }
  dimension_group: pck_end {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.pck_end ;;
  }
  dimension_group: pck_start {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.pck_start ;;
  }
  measure: count {
    type: count
  }
}
