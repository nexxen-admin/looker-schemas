view: dim_dsp_flight {
  sql_table_name: BI_New.Dim_DSP_Flight ;;

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

  dimension: dsp_flight_key {
    type: number
    sql: ${TABLE}.DSP_Flight_Key ;;
  }

  dimension: dsp_key {
    type: number
    sql: ${TABLE}.DSP_Key ;;
  }

  dimension: dsp_name {
    type: string
    sql: ${TABLE}.DSP_Name ;;
  }

  dimension: flight_id {
    type: string
    sql: ${TABLE}.Flight_ID ;;
  }

  dimension: flight_key {
    type: number
    sql: ${TABLE}.Flight_Key ;;
  }

  dimension: ri_info {
    type: string
    sql: ${TABLE}.RI_Info ;;
  }

  measure: count {
    type: count
    drill_fields: [dsp_name]
  }
}
