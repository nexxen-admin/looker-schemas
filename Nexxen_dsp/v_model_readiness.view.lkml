view: dsp_model_readiness {
  sql_table_name: BI_DSP.V_model_readiness ;;

  dimension_group: last_business {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.last_business_date ;;
  }

  dimension_group: last_readiness_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.last_readiness_timestamp ;;
  }

  dimension: model_name {
    type: string
    sql: ${TABLE}.model_name ;;
  }

  measure: count {
    type: count
    drill_fields: [model_name]
  }
}
