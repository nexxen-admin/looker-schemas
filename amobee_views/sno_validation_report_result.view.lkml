view: sno_validation_report_result {
  label: "Validation Report Result"
  sql_table_name: OPT.VALIDATION_REPORT_RESULT ;;

  dimension: campaign_id {
    type: number
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: report_id {
    type: number
    hidden: yes
    sql: ${TABLE}.report_id ;;
  }

  dimension: request_id {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.request_id ;;
  }

  dimension: platform_client_id {
    type: number
    hidden: yes
    sql: ${TABLE}.platform_client_id ;;
  }

  dimension: passed {
    type: yesno
    label: "Validation Is Passed"
    sql: ${TABLE}.passed ;;
  }

  dimension_group: createdon {
    type: time
    label: "Validation"
    timeframes: [raw, date, time, week, month, quarter, year]
    sql: ${TABLE}.createdon ;;
  }

  dimension: rule_group_id {
    type: number
    hidden: yes
    sql: ${TABLE}.rule_group_id ;;
  }

  dimension: rule_group_name {
    type: string
    label: "Rule Group Name"
    sql: ${TABLE}.rule_group_name ;;
  }

  measure: count_passed {
    type: sum
    label: "Passed Reports Count"
    sql: CASE WHEN ${passed} THEN 1 ELSE 0 END ;;
  }

  measure: count_failed {
    type: sum
    label: "Failed Reports Count"
    sql: CASE WHEN ${passed} THEN 0 ELSE 1 END ;;
  }
}
