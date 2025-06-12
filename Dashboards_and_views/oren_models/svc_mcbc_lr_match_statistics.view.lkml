view: MCBC_LR_Match_Statistics {
    derived_table: {
      sql:
          select Data_Source,
            Category,
            Last_File_Update,
            Graph_Match_Timestamp,
            Total_File_IDs,
            Distinct_File_IDs,
            Matched_Graph_TUIDs,
            Matched_Graph_Device_IDs,
            Matched_Graph_Person_IDs,
            Matched_Graph_Household_IDs,
            Create_Time,
            Update_Time
        from BI.SVC_MCBC_Match_Statistics_by_Category_Source
        ;;
    }


  dimension: Data_Source {
    type: string
    sql: ${TABLE}."Data_Source" ;;
  }dimension: Category {
    type: string
    sql: ${TABLE}."Category" ;;
  }
  dimension_group: last_file_update {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Last_File_Update ;;
  }
  dimension_group: graph_match_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Graph_Match_Timestamp ;;
  }
  dimension_group: create_time {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Create_Time ;;
  }
  dimension_group: update_time {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.Update_Time ;;
  }

  #Measures
  measure: total_file_ids {
    type: sum
    sql: ${TABLE}.Total_File_IDs ;;
    value_format: "#,##0"
  }
  measure: distinct_file_ids {
    type: sum
    sql: ${TABLE}.Distinct_File_IDs ;;
    value_format: "#,##0"
  }
  measure: Matched_Graph_TUIDs {
    type: sum
    sql: ${TABLE}.Matched_Graph_TUIDs ;;
    value_format: "#,##0"
  }
  measure: matched_graph_device_ids {
    type: sum
    sql: ${TABLE}.Matched_Graph_Device_IDs ;;
    value_format: "#,##0"
  }
  measure: matched_graph_person_ids {
    type: sum
    sql: ${TABLE}.Matched_Graph_Person_IDs ;;
    value_format: "#,##0"
  }
  measure: matched_graph_household_ids {
    type: sum
    sql: ${TABLE}.Matched_Graph_Household_IDs ;;
    value_format: "#,##0"
  }

  set: detail {
    fields: [
    Data_Source,
    Category,
    last_file_update_date,
    graph_match_timestamp_date,
    create_time_date,
    update_time_date,
    total_file_ids,
    distinct_file_ids,
    Matched_Graph_TUIDs,
    matched_graph_device_ids,
    matched_graph_person_ids,
    matched_graph_household_ids
    ]
  }
}
