view: dim_seat {
  sql_table_name: BI_New.V_Dim_Seat ;;

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

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
    hidden: yes
  }

  dimension: seat_id {
    label: "Seat"
    type: string
    sql: ${TABLE}.Seat_ID ;;
    hidden: yes

  }

  dimension: seat_key {
    type: number
    sql: ${TABLE}.Seat_Key ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: []
    hidden: yes
  }
}
