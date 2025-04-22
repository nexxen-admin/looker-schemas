view: sno_fce_atv_fdp_data_sbx {
  derived_table: {
    sql: select t.iid, t.data_vals:start_date_time::string as start_date_time, count(*) as count, sum(t.data_vals:requests::int) as sum_requests from SBX.FCE_ATV_FDP_DATA.DATA as t group by t.iid, t.data_vals:start_date_time::string;;
  }

  dimension: iid {
    type: number
    sql: ${TABLE}."IID" ;;
    value_format_name: id
  }

  dimension: start_date_time {
    description: "Start date time represented in UTC"
    type: date_time
    sql:  CONVERT_TIMEZONE('UTC', TO_TIMESTAMP_TZ(${TABLE}."START_DATE_TIME")) ;;
  }

  dimension: count {
    type: number
    sql: ${TABLE}."COUNT" ;;
  }

  dimension: sum_requests {
    type: number
    sql: ${TABLE}."SUM_REQUESTS" ;;
  }

  dimension: sbx_to_prod {
    type: number
    sql: ${sum_requests} / ${sno_fce_atv_fdp_data_prod.sum_requests} ;;
  }

  dimension: sbx_to_itv {
    type: number
    sql: ${sum_requests} / ${sno_fce_atv_fdp_data_itv.sum_requests} ;;
  }

  set: detail {
    fields: [iid, start_date_time, count, sum_requests]
  }
}
