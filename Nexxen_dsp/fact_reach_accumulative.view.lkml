view: fact_reach_accumulative {
  sql_table_name: BI_DSP.fact_reach_accumulative ;;

  dimension: advertiser_id_key {
    type: number
    value_format_name: id
    sql: ${TABLE}.advertiser_id_key ;;
    hidden: yes
  }

  dimension_group: date_key_in_timezone {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    label: "Date in Timezone"
    sql: ${TABLE}.date_key_in_timezone ;;
  }

  measure: accumulative_unique_users {
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.accumulative_unique_users ;;
  }

  measure: impressions {
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.impressions ;;
  }

  measure: unique_users {
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.unique_users ;;
  }

}
