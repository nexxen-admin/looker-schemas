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
    hidden: no
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
    label: "Email Processing Date"
    hidden: no
  }
  dimension: file_processing_error_reason {
    type: string
    sql: ${TABLE}.file_processing_error_reason ;;
    label: "Error Details"
    hidden: no
  }
  dimension: file_processing_status {
    type: string
    sql: ${TABLE}.file_processing_status ;;
    label: "Status"
    hidden: no
  }
  dimension: filename {
    type: string
    sql: ${TABLE}.filename ;;
  }
  dimension: message_id {
    type: string
    sql: ${TABLE}.message_id ;;
     hidden: no
  }
  dimension: sender_email {
    type: string
    sql: ${TABLE}.sender_email ;;
    hidden: no
  }
  dimension_group: sent_datetime {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.sent_datetime ;;
    label: "Email Send Date"
    hidden: no
  }
  dimension: source_folder {
    type: string
    sql: ${TABLE}.source_folder ;;
    # hidden: yes
  }

  measure: latest_fetched_per_message {
    type: max
    sql: ${fetched_raw} ;;
    label: "Latest Fetched Time per Message ID"
  }

  # measure: count_message_id {
  #   type: count
  #   sql: ${message_id} ;;
  #   label: "Count of Message IDs"
  # }

  measure: count {
    type: count
    drill_fields: [id, filename]
  }
}
