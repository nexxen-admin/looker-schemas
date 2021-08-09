view: dim_dsp_seat {
  sql_table_name: BI_New.Dim_DSP_Seat ;;

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
  }

  dimension: dsp_id {
    type: string
    sql: ${TABLE}.DSP_ID ;;
  }

  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
  }

  dimension: dsp_name {
    type: string
    sql: ${TABLE}.DSP_Name ;;
  }

  dimension: dsp_seat_key {
    type: number
    sql: ${TABLE}.DSP_Seat_Key ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  dimension: seat_id {
    type: string
    sql: ${TABLE}.Seat_ID ;;
  }

  dimension: seat_key {
    type: number
    sql: ${TABLE}.Seat_Key ;;
  }

  measure: count {
    type: count
    drill_fields: [dsp_name]
  }
}
