view: customfieldvalue_incident_start_date {
  sql_table_name: public.customfieldvalue ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: issue {
    type: number
    hidden: yes
    sql: ${TABLE}.issue ;;
  }

  dimension: customfield {
    type: number
    hidden: yes
    sql: ${TABLE}.customfield ;;
  }

  dimension: incident_start_date {
    type: date
    view_label: "Custom Fields"
    sql: ${TABLE}.datevalue ;;
  }

  dimension: incident_start_date_earliest {
    type: date_raw
    hidden: yes
    sql: CASE WHEN ${TABLE}.datevalue IS NULL OR ${jiraissue.created_raw} < ${TABLE}.datevalue THEN ${jiraissue.created_raw} ELSE ${TABLE}.datevalue END ;;
  }

  dimension: incident_resolution_time_days {
    type: number
    label: "Incident Resolution Time (Days)"
    view_label: "Issue"
    description: "Time between Incident Start Date and Resolution Date with added days to DSP tickets according to priority (P0 - 1, P1 - 3, P2&P3 - 7), in Days."
    sql: DATE_PART('day', ${jiraissue.resolutiondate_raw} - ${incident_start_date_earliest})
          + DATE_PART('hour', ${jiraissue.resolutiondate_raw} - ${incident_start_date_earliest}) / 24
          + DATE_PART('minute', ${jiraissue.resolutiondate_raw} - ${incident_start_date_earliest}) / 1440
    + CASE
      WHEN ${which_platform.customvalue} IN ('Audience Suite', 'Campaign Suite', 'Datamine Analytics')
        THEN CASE
              WHEN ${jiraissue.priority} = '10305' THEN 1 -- P0
              WHEN ${jiraissue.priority} = '10306' THEN 3 -- P1
              WHEN ${jiraissue.priority} IN ('10307', '10308') THEN 7 -- P2,P3
              ELSE 0
            END
      ELSE 0
    END
    ;;
  }

  measure: avg_incident_resolution_time_days {
    type: average
    sql_distinct_key: ${jiraissue.id} ;;
    label: "Average Incident Resolution Time (Days)"
    view_label: "Issue"
    description: "Average time between Incident Start Date and Resolution Date with added days to DSP tickets according to priority (P0 - 1, P1 - 3, P2&P3 - 7), in Days."
    value_format_name: decimal_2
    sql: ${incident_resolution_time_days} ;;
  }

  measure: med_incident_resolution_time_days {
    type: median
    sql_distinct_key: ${jiraissue.id} ;;
    label: "Median Incident Resolution Time (Days)"
    view_label: "Issue"
    description: "Median time between Incident Start Date and Resolution Date with added days to DSP tickets according to priority (P0 - 1, P1 - 3, P2&P3 - 7), in Days."
    value_format_name: decimal_2
    sql: ${incident_resolution_time_days} ;;
  }

  measure: perc_95_incident_resolution_time_days {
    type: percentile
    percentile: 95
    sql_distinct_key: ${jiraissue.id} ;;
    label: "Incident Resolution Time 95th percentile (Days)"
    view_label: "Issue"
    description: "95th percentile of time between Incident Start Date and Resolution Date with added days to DSP tickets according to priority (P0 - 1, P1 - 3, P2&P3 - 7), in Days."
    value_format_name: decimal_2
    sql: ${incident_resolution_time_days} ;;
  }
}
