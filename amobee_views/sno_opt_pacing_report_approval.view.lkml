view: sno_opt_pacing_report_approval {
  sql_table_name: (
    SELECT approval."APPROVAL_STATE", approval."CHANGEDBY", approval."CHANGEDON", approval."CREATEDON", approval."REPORT_ID"
    FROM "OPT"."PACING_REPORT_APPROVAL" approval
    QUALIFY ROW_NUMBER() OVER (PARTITION BY approval."REPORT_ID" ORDER BY approval."APPROVAL_STATE" = 'approved' DESC, approval."CREATEDON" DESC) = 1
    ) ;;
  label: "Pacing Report Approval"

  dimension: report_id {
    type: string
    primary_key: yes
    sql: ${TABLE}."REPORT_ID" ;;
  }

  dimension: approval_state {
    type: string
    sql: ${TABLE}."APPROVAL_STATE" ;;
  }

  dimension: changedby {
    type: string
    sql: ${TABLE}."CHANGEDBY" ;;
  }

  dimension_group: changedon {
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
    sql: ${TABLE}."CHANGEDON" ;;
  }

  dimension_group: createdon {
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
    sql: ${TABLE}."CREATEDON" ;;
  }

  measure: latest_approved {
    type: date_time
    label: "Last Report Approval Date"
    sql: MAX(${changedon_raw}) ;;
  }
}
