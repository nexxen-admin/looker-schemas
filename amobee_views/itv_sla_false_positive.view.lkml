view: sla_false_positive {
  sql_table_name: "SLA"."SLA_FALSE_POSITIVE"
    ;;

  dimension: comments {
    type: string
    sql: ${TABLE}."COMMENTS" ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}."CREATED_TIME" ;;
  }

  dimension: false_positive_count {
    type: number
    sql: ${TABLE}."FALSE_POSITIVE_COUNT" ;;
  }

  dimension_group: sla_report_date {
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
    sql: ${TABLE}."SLA_REPORT_DATE" ;;
  }

  dimension_group: last_modified {
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
    sql: ${TABLE}."LAST_MODIFIED_TIME" ;;
  }

  dimension_group: sla_report {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."SLA_REPORT_DATE" ;;
  }

  dimension: sla_report_info_id {
    type: number
    sql: ${TABLE}."SLA_REPORT_INFO_ID" ;;
    value_format_name: id
  }

  dimension: ticket {
    type: string
    sql: ${TABLE}."TICKET" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
