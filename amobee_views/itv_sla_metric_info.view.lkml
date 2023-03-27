view: metric_info {

  sql_table_name:
    {% if _model._name == 'itv_sla' %}
      SLA.METRIC_INFO
    {% elsif _model._name == 'dsp_sla' %}
      SLA_DSP.METRIC_INFO
    {% else %}
      UNDEF_MODEL.METRIC_INFO
    {% endif %} ;;

  dimension: component {
    type: string
    sql: ${TABLE}."COMPONENT" ;;
  }

  dimension: metric_id {
    type: string
    sql: ${TABLE}."METRIC_ID" ;;
  }

  dimension: time_unit {
    type: number
    sql: ${TABLE}."TIME_UNIT" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
