view: monthly_report_info {

  sql_table_name:
    {% if _model._name == 'itv_sla' %}
      SLA.MONTHLY_REPORT_INFO
    {% elsif _model._name == 'dsp_sla' %}
      SLA_DSP.MONTHLY_REPORT_INFO
    {% else %}
      UNDEF_MODEL.MONTHLY_REPORT_INFO
    {% endif %} ;;

  dimension: sla_report_info_id {
    type: number
    sql: ${TABLE}."SLA_REPORT_INFO_ID" ;;
    value_format_name: id
  }

  dimension: report_date {
    type: date
    sql: ${TABLE}."REPORT_DATE" ;;
  }

  dimension: created_time {
    type: date_time
    sql: ${TABLE}."CREATED_TIME" ;;
  }

  dimension: review_comment {
    type: string
    label: "Add'l Notes"
    sql: ${TABLE}."REVIEW_COMMENT" ;;
  }
  # end

  dimension: review_in_progress {
    type: string
    sql: ${TABLE}."REVIEW_IN_PROGRESS" ;;
  }

  dimension: in_review {
    type: string
    label: "In Review?"
    sql: CASE
          WHEN ${review_in_progress} = True THEN 'Yes'
          ELSE 'No'
          END ;;
  }

  dimension: review_false_positive {
    type: string
    sql: ${TABLE}."REVIEW_FALSE_POSITIVE" ;;
  }

  dimension: is_false_positive {
    type: string
    label: "Is False-Positive?"
    sql: CASE
          WHEN ${review_false_positive} = True THEN 'Yes'
          ELSE 'No'
          END ;;
  }

  dimension: review_ticket {
    type: string
    label: "Ticket"
    sql: ${TABLE}."REVIEW_TICKET" ;;
    html: <a href="https://jira-tech.amobee.com/browse/{{value}}" target="_blank"><u>{{value}}</u></a>
    ;;
  }

  # This column is needed as a join field for the
  # monthly_report_snapshot view so that we don't
  # have two records with common values, caused by
  # one record having a monthly_report_info,
  # and another not having that record.
  dimension: join_column {
    type: string
    sql: NULL ;;
  }

  measure: count {
    type: count
  }
}
