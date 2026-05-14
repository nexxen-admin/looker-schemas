view: drr_daily_revenue_report_base {
  sql_table_name: bi.DRR_Daily_Revenue_Report ;;

  dimension: category {
    type: string
    sql: ${TABLE}.Category ;;
  }
  dimension: create_timestamp {
    type: date_time
    hidden: yes
    sql:  ${TABLE}.Create_Timestamp ;;
  }
  dimension: device_type {
    type: string
    sql: ${TABLE}.Device_Type ;;
  }
  dimension_group: event {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Event_Date ;;
  }
  dimension: file_record {
    type: string
    sql: ${TABLE}.File_Record ;;
  }
  dimension: impression_type {
    type: string
    sql: ${TABLE}.Impression_Type ;;
  }
  dimension: media_type {
    type: string
    sql: ${TABLE}.Media_Type ;;
  }
  dimension: record_type {
    type: string
    sql: ${TABLE}.Record_Type ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }
  dimension: subcategory {
    type: string
    sql: ${TABLE}.Subcategory ;;
  }

  measure: revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Revenue ;;
  }
  measure: cost {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Cost ;;
  }
  measure: net_revenue {
    type: sum
    value_format: "$#,##0.00"
    sql: ${TABLE}.Revenue -  ${TABLE}.Cost ;;
  }
  measure: margin {
    type: number
    label: "Margin (Take rate)"
    value_format: "0.00%"
    sql: ${net_revenue}/${revenue} ;;
  }
  measure: last_updated {
    type: max
    label: "Last Updated"
    sql: ${create_timestamp} ;;
  }
}
