view: placement_delivery_cap_statistics {
  sql_table_name: dbo.placement_delivery_cap_statistics (NOLOCK) ;;

  dimension: active {
    type: string
    hidden: yes
    sql: ${TABLE}.active ;;
  }

  dimension: createdon {
    type: string
    hidden: yes
    sql: ${TABLE}.createdon ;;
  }

  dimension_group: last_update {
    type: time
    hidden: yes
    timeframes: [raw,time,date,week,month,quarter,year]
    sql: ${TABLE}.last_update_time ;;
  }

  dimension: placement_id {
    type: number
    hidden: yes
    sql: ${TABLE}.placement_id ;;
  }

  dimension: reset_time {
    type: date_time
    label: "Delivery Cap Reset Time"
    description: "Time at which the delivery cap impression count will reset to 0."
    sql: ${TABLE}.reset_time ;;
  }

  dimension: start_time {
    type: date_time
    label: "Delivery Cap Start Time"
    description: "Time at which the delivery cap impression count begins."
    sql: ${TABLE}.start_time ;;
  }

  dimension: units_delivered {
    type: number
    label: "Delivery Cap Units Delivered"
    description: "Number of Units delivered since the Delivery Cap Start Time"
    sql: ${TABLE}.units_delivered ;;
  }

}
