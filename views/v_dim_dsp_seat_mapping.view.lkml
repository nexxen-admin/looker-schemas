view: v_dim_dsp_seat_mapping {
  sql_table_name: BI_New.V_Dim_DSP_Seat_Mapping ;;

  dimension: agency {
    type: string
    sql: ${TABLE}.agency ;;
  }
  dimension: bi_dsp_seat_key {
    type: number
    hidden: yes
    sql: ${TABLE}.bi_dsp_seat_key ;;
  }
  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }
  dimension_group: db_created_datetime {
    type: time
    hidden: yes
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.db_created_datetime ;;
  }
  dimension: dsp_account_id {
    type: number
    hidden: yes
    sql: ${TABLE}.dsp_account_id ;;
  }
  dimension: dsp_seat_id {
    type: string
    hidden: yes
    sql: ${TABLE}.dsp_seat_id ;;
  }
  dimension: holdco {
    type: string
    label: "Hold Co"
    sql: ${TABLE}.holdco ;;
  }
  dimension: ingestion_id {
    type: string
    hidden: yes
    sql: ${TABLE}.ingestion_id ;;
  }
  dimension: source_filename {
    type: string
    hidden: yes
    sql: ${TABLE}.source_filename ;;
  }
  dimension: upload_user_email {
    type: string
    hidden: yes
    sql: ${TABLE}.upload_user_email ;;
  }
}
