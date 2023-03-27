view: sno_hist_users_history {
  sql_table_name: PLATFORMDATA.hist.v_users_history ;;

  dimension: user_id {
    type: string
    label: "User Id"
    description: "ID of the User"
    sql: ${TABLE}.userid ;;
  }

  dimension: operation {
    type: number
    label: "Change Operation"
    description: "Operation for the change 1=delete,2=add,4=update"
    sql: ${TABLE}.operation ;;
  }

  dimension: old_login_date {
    type: date_time
    label: "Previous login date"
    description: "Date of the previous login"
    sql: ${TABLE}.OLD_LASTLOGINDATE ;;
  }

  dimension: new_login_date {
    type: date_time
    label: "New login date"
    description: "Date of the new login"
    sql: ${TABLE}.OLD_LASTLOGINDATE ;;
  }


  dimension_group: eventtime {
    type: time
    label: "Event Time"
    description: "The date/time of the event"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.eventtime ;;
  }


  measure: count {
    type: count
    label: "Count"
    description: "The count of rows in the results"
    drill_fields: [user_id]
  }
}
