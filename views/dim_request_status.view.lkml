view: dim_request_status {
  sql_table_name: BI_New.V_Dim_Request_Status ;;

  dimension_group: db_create {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Create_Date ;;
    hidden: yes
  }

  dimension_group: db_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DB_Update_Date ;;
    hidden: yes
  }

  dimension:  is_valid_requests {
    label: "Is Valid Requests"
    sql: case
    when ${TABLE}.Request_Status in ('nodsp','nodspbids','bidresponse','pass')
    then 'True' else 'False'
    end
    ;;
  }

  dimension: request_status {
    label: "Request Status"
    type: string
    sql: case
    when ${TABLE}.Request_Status = 'unknown' then 'Admissible'
    else ${TABLE}.Request_Status
    end;;
  }

  dimension: request_status_key {
    type: number
    sql: ${TABLE}.Request_Status_Key ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
