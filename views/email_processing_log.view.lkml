view: email_processing_log {
  sql_table_name: BI_DSP.email_processing_log ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: email_fetch_status {
    type: string
    sql: ${TABLE}.email_fetch_status ;;
  }
  dimension: email_subject {
    type: string
    sql: ${TABLE}.email_subject ;;
  }
  dimension_group: fetched {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.fetched_at ;;
  }
  dimension_group: file_processed {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.file_processed_at ;;
  }
  dimension: file_processing_error_reason {
    type: string
    sql: ${TABLE}.file_processing_error_reason ;;
  }
  dimension: file_processing_status {
    type: string
    sql: ${TABLE}.file_processing_status ;;
  }
  dimension: filename {
    type: string
    sql: ${TABLE}.filename ;;
  }
  dimension: message_id {
    type: string
    sql: ${TABLE}.message_id ;;
  }
  dimension: sender_email {
    type: string
    sql: ${TABLE}.sender_email ;;
  }
  dimension_group: sent_datetime {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.sent_datetime ;;
  }
  dimension: source_folder {
    type: string
    sql: ${TABLE}.source_folder ;;
    # hidden: yes
  }

  measure: latest_file_processed_at {
    type: max
    sql: ${file_processed_raw} ;;
    label: "Latest File Processed Time"
    description: "Shows the most recent file_processed_at timestamp per ID"
  }

  measure: count {
    type: count
    drill_fields: [id, filename]
  }
}
