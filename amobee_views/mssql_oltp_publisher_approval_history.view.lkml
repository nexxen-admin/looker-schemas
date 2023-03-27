view: mssql_oltp_publisher_approval_history {
  label: "Publisher Approval"
  sql_table_name: dbo.publisher_approval_history (NOLOCK) ;;

  dimension: publisher_approval_history_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.publisher_approval_history_id ;;
    value_format_name: id
  }

  dimension_group: changedon {
    type: time
    timeframes: [raw]
    hidden: yes
    sql: ${TABLE}.changedon ;;
  }

  dimension_group: createdon {
    type: time
    timeframes: [raw]
    hidden: yes
    sql: ${TABLE}.createdon ;;
  }

  dimension: publisher_approval_id {
    hidden: yes
    type: number
    sql: ${TABLE}.publisher_approval_id ;;
    value_format_name: id
  }

  dimension: approval_status_id {
    type: number
    hidden: yes
    sql: ${TABLE}.approval_status_id ;;
    value_format_name: id
  }

  dimension: active {
    type: yesno
    hidden: yes
    sql: ${TABLE}.active = 1 ;;
  }

  dimension_group: expiration_date {
    type: time
    timeframes: [raw]
    hidden: yes
    sql: ${TABLE}.expiration_date ;;
  }

  dimension: notes {
    type: string
    hidden: yes
    sql: ${TABLE}.notes ;;
  }

  measure: pending_date {
    type: date_time
    label: "Pending Date"
    sql: MAX(CASE WHEN ${creative_rejection_view.approval_status_id} IN (1, 6) THEN ${createdon_raw} END) ;;
  }

  measure: approved_rejected_date {
    type: date_time
    label: "Approved/Rejected Date"
    sql: MAX(CASE WHEN ${creative_rejection_view.approval_status_id} IN (2, 3) THEN ${createdon_raw} END) ;;
  }
}
