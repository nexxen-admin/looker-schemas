view: daily_report_snapshot {

  sql_table_name: DAILY_REPORT_SNAPSHOT ;;

  label: "itv_sla_daily_report_snapshot"

  dimension: count_numerator {
    type: number
    label: "SLA Count"
    sql: ${TABLE}."COUNT_NUMERATOR" ;;
    value_format_name: id
  }

  dimension: count_numerator_format {
    type: number
    value_format: "#,##0"
    sql: CASE
          WHEN ${count_numerator} != -1 THEN ${count_numerator}
          ELSE ${count_numerator}
          END ;;
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
    label: "Report Date"
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
    label: "SLA Id"
    # hidden: yes
    sql: ${TABLE}."SLA_REPORT_INFO_ID" ;;
    value_format_name: id
  }

  dimension: sla_value {
    type: number
    label: "SLA Value Raw"
    sql: ${TABLE}."SLA_VALUE" ;;
  }

  dimension: sla_value_format {
    label: "SLA Value"
    type:  string
    sql: CASE
          WHEN sla_report_info.sla_value_type = 0 THEN concat((round(${sla_value}, 4) * 100), '%')
          ELSE concat(${sla_value},'')
          END ;;
  }

  dimension: total_denominator {
    type: number
    sql: ${TABLE}."TOTAL_DENOMINATOR" ;;
  }

  dimension: total_denominator_format {
    type: number
    label: "Total Count"
    value_format: "#,##0"
    sql: CASE
          WHEN ${total_denominator} != -1 THEN ${total_denominator}
          ELSE 0
          END ;;
  }

  dimension: sla_status {
    label: "Meets SLA"
    sql: CASE
          WHEN sla_report_info.sla_value_type = 1 AND ${sla_value} > 0 THEN 'No'
          WHEN sla_report_info.sla_value_type = 0 AND ${sla_value} < sla_report_info.sla_high_threshold_value THEN 'No'
          ELSE 'Yes'
          END ;;
  }

  # This is for line visualization and drilling a set
  measure: meet_sla {
    type: sum
    label: "Meets SLA"
    value_format_name: decimal_0
    drill_fields: [detail*]
    sql: CASE
          WHEN sla_report_info.sla_value_type = 1 AND ${sla_value} > 0 THEN 0
          WHEN sla_report_info.sla_value_type = 0 AND ${sla_value} < sla_report_info.sla_high_threshold_value THEN 0
          ELSE 1
          END ;;
  }

  measure: count {
    type: count
    drill_fields: [sla_report_info.sla_report_info_id, sla_report_info.name]
  }

  measure: count_sla_met {
      type: count
      filters: {
        field: sla_status
        value: "Yes"
      }
  }

  measure: daily_count {
    type: sum
    sql: ${count_numerator_format} ;;
  }

  measure: daily_total {
    type: sum
    sql: ${total_denominator_format} ;;
  }

  measure: daily_sla_value {
    type: sum
    sql: ${sla_value} ;;
  }

  measure: daily_total_minus_count {
    type: sum
    sql: ${total_denominator} - ${count_numerator} ;;
  }

  set: detail {
    fields: [report_date, sla_report_info_id, sla_report_info.name, sla_report_info.sla_high_threshold_value_formatted, sla_value_format, sla_status, count_numerator, total_denominator_format]
  }
}
