view: sno_validation_rule_result {
  label: "Validation Report Result"
  sql_table_name: OPT.VALIDATION_RULE_RESULT ;;

  dimension: id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: request_id {
    type: string
    hidden: yes
    sql: ${TABLE}.request_id ;;
  }

  dimension: rule_id {
    type: number
    label: "Error Code"
    sql: ${TABLE}.rule_id ;;
  }

  dimension: rule_name {
    type: string
    label: "Validation Check"
    sql: ${TABLE}.rule_name ;;
  }

  dimension: passed {
    type: yesno
    label: "Validation Check Is Passed"
    sql: ${TABLE}.passed ;;
  }

  dimension: optional {
    type: yesno
    hidden: yes
    sql: ${TABLE}.optional ;;
  }

  dimension: error_description {
    type: string
    label: "Description"
    sql: ${TABLE}.error_description ;;
  }

  dimension_group: createdon {
    type: time
    label: "Validation Rule"
    timeframes: [raw, date, time, week, month, quarter, year]
    sql: ${TABLE}.createdon ;;
  }

  dimension: duration {
    type: number
    label: "Duration"
    description: "Duration of a rule validation in seconds."
    sql: ${TABLE}.duration ;;
  }

  dimension: resolution_responsibility {
    type: string
    label: "Resolution Responsibility"
    sql: CASE WHEN ${rule_id} in (4, 11, 14, 21, 22, 7, 17, 5) THEN 'Amobee'
       WHEN ${rule_id} in (2, 12) THEN 'Amobee / Client'
       WHEN ${rule_id} in (9, 10) THEN 'Client'
       WHEN ${rule_id} in (3, 13, 16, 23, 24) THEN 'Measurement Provider'
       WHEN ${rule_id} in (1) THEN 'Measurement Provider / Client'
       WHEN ${rule_id} in (20) THEN 'Nielsen'
      END ;;
  }

  measure: count_passed {
    type: sum
    label: "Passed Rule Count"
    sql: CASE WHEN ${passed} THEN 1 ELSE 0 END ;;
  }

  measure: count_failed {
    type: sum
    label: "Failed Rule Count"
    sql: CASE WHEN ${passed} THEN 0 ELSE 1 END ;;
  }
}
