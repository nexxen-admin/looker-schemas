view: monthly_gw_report_snapshot {
  sql_table_name: SLA.MONTHLY_GW_REPORT_SNAPSHOT ;;

  dimension: count_numerator {
    type: number
    sql: ${TABLE}."COUNT_NUMERATOR" ;;
    value_format_name: id
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

  dimension: platform_client_ids {
    type: string
    sql: ${TABLE}."PLATFORM_CLIENT_IDS" ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}."REGION" ;;
  }

  dimension_group: report {
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
    sql: ${TABLE}."REPORT_DATE" ;;
  }

  dimension: sla_report_info_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."SLA_REPORT_INFO_ID" ;;
    value_format_name: id
  }

  dimension: sla_value {
    type: number
    sql: ${TABLE}."SLA_VALUE" ;;
  }

  dimension: total_denominator {
    type: number
    sql: ${TABLE}."TOTAL_DENOMINATOR" ;;
  }

  measure: count {
    type: count
    drill_fields: [sla_report_info.sla_report_info_id, sla_report_info.name]
  }
}
