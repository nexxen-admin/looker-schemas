view: svc_mcbc_lr_match_statistics {
  sql_table_name: bi.SVC_MCBC_LR_Match_Statistics ;;

  dimension_group: create_time {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Create_Time ;;
  }
  dimension: distinct_file_ids {
    type: number
    value_format_name: id
    sql: ${TABLE}.Distinct_File_IDs ;;
    value_format: "#,##0"
  }
  dimension_group: graph_match_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Graph_Match_Timestamp ;;
  }
  dimension_group: last_file_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Last_File_Update ;;
  }
  dimension: matched_graph_device_ids {
    type: number
    value_format_name: id
    sql: ${TABLE}.Matched_Graph_Device_IDs ;;
    value_format: "#,##0"
  }
  dimension: matched_graph_household_ids {
    type: number
    value_format_name: id
    sql: ${TABLE}.Matched_Graph_Household_IDs ;;
    value_format: "#,##0"
  }
  dimension: matched_graph_person_ids {
    type: number
    value_format_name: id
    sql: ${TABLE}.Matched_Graph_Person_IDs ;;
    value_format: "#,##0"
  }
  dimension: total_file_ids {
    type: number
    value_format_name: id
    sql: ${TABLE}.Total_File_IDs ;;
    value_format: "#,##0"
  }
  dimension_group: update_time {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Update_Time ;;
  }
  measure: count {
    type: count
  }
}
