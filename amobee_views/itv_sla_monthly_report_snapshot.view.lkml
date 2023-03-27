view: monthly_report_snapshot {

  sql_table_name:
    {% if _model._name == 'itv_sla' %}
      SLA.MONTHLY_REPORT_SNAPSHOT
    {% elsif _model._name == 'dsp_sla' %}
      SLA_DSP.MONTHLY_REPORT_SNAPSHOT
    {% else %}
      UNDEF_MODEL.MONTHLY_REPORT_SNAPSHOT
    {% endif %} ;;

  dimension: count_numerator {
    type: number
    label: "SLA Count"
    sql: ${TABLE}.count_numerator ;;
    value_format_name: id
  }

  dimension: count_numerator_format {
    type: number
    label: "SLA Count"
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
    label: "SLA Value Raw"
    type: number
    sql: ${TABLE}."SLA_VALUE" ;;
  }

  dimension: sla_value_format {
    label: "SLA Value"
    type:  string
    sql: CASE
    WHEN sla_report_info.sla_value_type = 0 THEN (round(${sla_value}, 4) * 100) || '%'
    ELSE ${sla_value} || ''
    END ;;
  }

  dimension: total_denominator {
    type: number
    label: "Metric Total Raw"
    sql: ${TABLE}."TOTAL_DENOMINATOR" ;;
  }

  dimension: total_denominator_format {
    type: number
    label: "Total Count"
    value_format: "#,##0"
    sql: CASE
    WHEN ${total_denominator} != -1 THEN ${total_denominator}
    ELSE ${count_numerator}
    END ;;
  }

  dimension: sla_status {
    label: "SLA Score"
    sql: CASE
      WHEN ${count_numerator} = 0 AND ${total_denominator} = 0 THEN 'No Data'
      WHEN sla_report_info.sla_value_type = 1 AND ${sla_value} > 0 THEN 'Fail'
      WHEN sla_report_info.sla_value_type = 0 AND ${sla_value} < sla_report_info.sla_high_threshold_value THEN 'Fail'
      ELSE 'Pass'
      END ;;
  }

  dimension: sla_status_color {
    label: "SLA Score"
    sql: ${sla_status} ;;
    html:
      {% if value == 'Pass' %}
        <p style="color: green"><b>{{ value }}</b></p>
      {% elsif value == 'No Data' %}
        <p style="color: #ffd500"><b>{{ value }}</b></p>
      {% else %}
        <p style="color: red"><b>{{ value }}</b></p>
      {% endif %};;
  }

  dimension: metric_and_owner {
    label: "Metric Owner / Metric"
    type:  string
    sql:  concat(sla_report_info.metric_owner, ' / ', sla_report_info.name)  ;;

  }

  measure: count {
    type: count
    label: "SLAs"
  }

  measure: monthly_count {
    type: sum
    sql: ${count_numerator_format} ;;
  }

  measure: monthly_total {
    type: sum
    sql: ${total_denominator_format} ;;
  }

  measure: monthly_sla_value {
    type: sum
    sql: ${sla_value} ;;
  }

  measure: montly_total_minus_count {
    type: sum
    sql: ${total_denominator} - ${count_numerator} ;;
  }
}
