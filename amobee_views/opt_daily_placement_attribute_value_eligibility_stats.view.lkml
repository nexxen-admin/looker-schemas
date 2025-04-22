view: daily_placement_attribute_value_eligibility_stats {
  sql_table_name: AN_RESEARCH.dbo.daily_placement_attribute_value_eligibility_stats ;;

  dimension: attribute_value_id {
    type: number
    hidden: yes
    sql: ${TABLE}.attribute_value_id ;;
  }

  dimension: eligible_requests {
    type: number
    view_label: "Attribute Value Eligibility Metrics"
    sql: ${TABLE}.eligible_requests ;;
  }

  dimension: job_flow_step_id {
    type: number
    hidden: yes
    sql: ${TABLE}.job_flow_step_id ;;
  }

  dimension_group: keydate {
    type: time
    label: "Event"
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
    view_label: "Attribute Value Eligibility Facets"
    sql: ${TABLE}.keydate ;;
  }

  dimension: placement_id {
    type: number
    view_label: "Attribute Value Eligibility Facets"
    sql: ${TABLE}.placement_id ;;
    value_format_name: id
  }

  dimension: total_requests {
    type: number
    view_label: "Attribute Value Eligibility Metrics"
    sql: ${TABLE}.total_requests ;;
  }

  measure: count {
    type: count
    hidden: yes
    drill_fields: []
  }
}
