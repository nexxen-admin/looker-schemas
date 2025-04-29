view: dim_dsp_insertion_order {
  sql_table_name: BI_DSP.dim_dsp_insertion_order ;;

  dimension: advertiser_id {
    type: number
    sql: ${TABLE}.advertiser_id ;;
    hidden:  yes
  }

  dimension: insertion_order_id {
    type: number
    sql: ${TABLE}.insertion_order_id ;;
    hidden:  yes
  }
  dimension: campaign {
    type: string
    sql: ${TABLE}.campaign ;;
  }
  dimension_group: overall_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.overall_end_date ;;
  }
  dimension_group: overall_start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.overall_start_date ;;
  }
  dimension: workflow_status_id {
    type: number
    sql: ${TABLE}.workflow_status_id ;;
  }
}
