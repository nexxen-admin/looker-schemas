view: jiraissue {
  sql_table_name: public.jiraissue ;;

  dimension: id {
    primary_key: yes
    type: number
    label: "ID"
    view_label: "Issue"
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: issue_id {
    type: string
    label: "Issue ID"
    view_label: "Issue"
    link: {    label: "JIRA Link"
      url: "https://jira-tech.amobee.com/browse/{{value}}"}
    sql: ${project.project_pkey}||'-'||${TABLE}.issuenum ;;
  }

  dimension: assignee {
    type: string
    hidden: yes
    sql: ${TABLE}.assignee ;;
  }

  dimension: component {
    type: number
    hidden: yes
    sql: ${TABLE}.component ;;
  }

  dimension_group: created {
    type: time
    label: "Issue Created"
    view_label: "Issue"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created ;;
  }

  dimension: creator {
    type: string
    hidden: yes
    label: "Creator"
    view_label: "Issue"
    sql: ${TABLE}.creator ;;
  }

  dimension: description {
    type: string
    label: "Description"
    view_label: "Issue"
    sql: ${TABLE}.description ;;
  }

  dimension_group: duedate {
    type: time
    label: "Due"
    view_label: "Issue"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.duedate ;;
  }

  dimension: environment {
    type: string
    label: "Environment"
    view_label: "Issue"
    sql: ${TABLE}.environment ;;
  }

  dimension: fixfor {
    type: number
    hidden: yes
    sql: ${TABLE}.fixfor ;;
  }

  dimension: issuenum {
    type: number
    #hidden: yes
    label: "Issue Number"
    view_label: "Issue"
    sql: ${TABLE}.issuenum ;;
  }

  dimension: issuestatus {
    type: string
    hidden: yes
    sql: ${TABLE}.issuestatus ;;
  }

  dimension: issuetype {
    type: string
    hidden: yes
    sql: ${TABLE}.issuetype ;;
  }

  dimension: pkey {
    type: string
    hidden: yes
    sql: ${TABLE}.pkey ;;
  }

  dimension: priority {
    type: string
    hidden: yes
    sql: ${TABLE}.priority ;;
  }

  dimension: project {
    type: number
    hidden: yes
    sql: ${TABLE}.project ;;
  }

  dimension: reporter {
    type: string
    hidden: yes
    sql: ${TABLE}.reporter ;;
  }

  dimension: resolution {
    type: string
    label: "Resolution"
    hidden: yes
    sql: ${TABLE}.resolution ;;
  }

  dimension_group: resolutiondate {
    type: time
    label: "Resolution"
    view_label: "Issue"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.resolutiondate ;;
  }

  dimension: resolution_month_year {
    type: string
    label: "Resolution Month and Year"
    view_label: "Issue"
    order_by_field: resolutiondate_month
    sql: substring(${resolutiondate_month_name}, 1, 3) || ' ' || ${resolutiondate_year} ;;
  }

  dimension: resolution_date {
    type: number
    label: "Resolution Time in Minutes"
    view_label: "Issue"
    #hidden: yes
    sql: (DATE_PART('day', ${resolutiondate_raw} - ${created_raw}) * 1440
          + DATE_PART('hour', ${resolutiondate_raw} - ${created_raw}) * 60
          + DATE_PART('minute', ${resolutiondate_raw} - ${created_raw})) ;;
  }

  measure: avg_resolution_time_min {
    type: number
    label: "Average Resolution Time (Minutes)"
    description: "Average time between opening of Issue and resolution of Issue, in Minutes."
    view_label: "Issue"
    value_format_name: decimal_0
    sql: avg(DATE_PART('day', ${resolutiondate_raw} - ${created_raw}) * 1440
          + DATE_PART('hour', ${resolutiondate_raw} - ${created_raw}) * 60
          + DATE_PART('minute', ${resolutiondate_raw} - ${created_raw})) ;;
  }

  measure: avg_resolution_time_hr {
    type: number
    label: "Average Resolution Time (Hours)"
    description: "Average time between opening of Issue and resolution of Issue, in Hours."
    view_label: "Issue"
    value_format_name: decimal_2
    sql: avg(DATE_PART('day', ${resolutiondate_raw} - ${created_raw}) * 24
          + DATE_PART('hour', ${resolutiondate_raw} - ${created_raw})
          + DATE_PART('minute', ${resolutiondate_raw} - ${created_raw}) / 60) ;;
  }

  measure: avg_resolution_time_day {
    type: number
    label: "Average Resolution Time in (Days)"
    description: "Average time between opening of Issue and resolution of Issue, in Days."
    view_label: "Issue"
    value_format_name: decimal_2
    sql: avg(DATE_PART('day', ${resolutiondate_raw} - ${created_raw})
          + (DATE_PART('hour', ${resolutiondate_raw} - ${created_raw}) / 24)
          + (DATE_PART('minute', ${resolutiondate_raw} - ${created_raw}) / 1440) ) ;;
  }

  measure: med_response_time_min {
    type: number
    label: "Median Resolution Time (Minutes)"
    view_label: "Issue"
    description: "Median time between opening of Issue and resolution of Issue, in Minutes."
    value_format_name: decimal_0
    sql: PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY (DATE_PART('day', ${resolutiondate_raw} - ${created_raw}) * 1440
          + DATE_PART('hour', ${resolutiondate_raw} - ${created_raw}) * 60
          + DATE_PART('minute', ${resolutiondate_raw} - ${created_raw})))  ;;
  }

  measure: med_response_time_hour {
    type: number
    label: "Median Resolution Time (Hours)"
    view_label: "Issue"
    description: "Median time between opening of Issue and resolution of Issue, in Hours."
    value_format_name: decimal_2
    sql: PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY (DATE_PART('day', ${resolutiondate_raw} - ${created_raw}) * 24
          + DATE_PART('hour', ${resolutiondate_raw} - ${created_raw})
          + DATE_PART('minute', ${resolutiondate_raw} - ${created_raw}) / 60))  ;;
  }

  measure: med_response_time_days {
    type: number
    label: "Median Resolution Time (Days)"
    view_label: "Issue"
    description: "Median time between opening of Issue and resolution of Issue, in Days."
    value_format_name: decimal_2
    sql: PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY (DATE_PART('day', ${resolutiondate_raw} - ${created_raw})
          + (DATE_PART('hour', ${resolutiondate_raw} - ${created_raw}) / 24)
          + (DATE_PART('minute', ${resolutiondate_raw} - ${created_raw}) / 1440)))  ;;
  }

  dimension: security {
    type: number
    hidden: yes
    sql: ${TABLE}.security ;;
  }

  dimension: summary {
    type: string
    label: "Summary"
    view_label: "Issue"
    sql: ${TABLE}.summary ;;
  }

  dimension: timeestimate {
    type: number
    hidden: yes
    sql: ${TABLE}.timeestimate ;;
  }

  dimension: timeoriginalestimate {
    type: number
    hidden: yes
    sql: ${TABLE}.timeoriginalestimate ;;
  }

  dimension: timespent {
    type: number
    hidden: yes
    sql: ${TABLE}.timespent ;;
  }

  dimension_group: updated {
    type: time
    label: "Updated"
    view_label: "Issue"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated ;;
  }

  dimension: votes {
    type: number
    hidden: yes
    sql: ${TABLE}.votes ;;
  }

  dimension: watches {
    type: number
    hidden: yes
    sql: ${TABLE}.watches ;;
  }

  dimension: workflow_id {
    type: number
    hidden: yes
    sql: ${TABLE}.workflow_id ;;
  }


  dimension: anand_grouping {
    type: string
    label: "Anand Grouping"
    view_label: "Anand Metric"
    sql: CASE When ${project.project_pkey} = 'PC' and ${supp_info.root_cause_application} = 'Ad Player' then 'SA'
              when ${project.project_pkey} = 'PC' and ${supp_info.root_cause_application} = 'Adserver' then 'LUCY'
              when ${project.project_pkey} = 'PC' and ${supp_info.root_cause_application} = 'Audience Management' then 'ELIZA'
              when ${project.project_pkey} = 'PC' and ${supp_info.root_cause_application} = 'CPUI' then 'MAYA'
              when ${project.project_pkey} = 'PC' and ${supp_info.root_cause_application} = 'Data' then 'DATA'
              when ${project.project_pkey} = 'PC' and ${supp_info.root_cause_application} = 'Infrastructure(GIO)' then 'TIOT'
              when ${project.project_pkey} = 'PC' and ${supp_info.root_cause_application} = 'MSTR' then 'BUI'
              when ${project.project_pkey} = 'PC' and ${supp_info.root_cause_application} = 'OASYS' then 'OASYS'
              when ${project.project_pkey} = 'PC' and ${supp_info.root_cause_application} = 'OPT' then 'OPT'
              when ${project.project_pkey} = 'PC' and ${supp_info.root_cause_application} = 'Platform APIs' then 'PAPI'
              when ${project.project_pkey} = 'PC' and ${supp_info.root_cause_application} = 'Platform UI' then 'MAYA'
              else ${project.project_pkey}
              end;;
  }


  measure: anand_metric{
    type: sum
    label: "Anand Metric"
    view_label: "Anand Metric"
    sql: Case
          when ${project.project_pkey} = 'PC' and ${TABLE}.issuetype = '10701' and ${supp_info.root_cause} <> 'External Third Party Source' then 50
          when ${project.project_pkey} = 'PC' and ${TABLE}.issuetype = '10700' and ${supp_info.root_cause} <> 'External Third Party Source' then 200
          when ${linked_issue.link_issue} like 'PD%' then 1
          when ${linked_issue.link_issue} like 'TO%' and ${linked_issue.resolution} not in ('User Error', 'Issue Could not be Reproduced')  then 20
          else 0 end;;
  }

  dimension: pager_duty_service {
    type: string
    label: "PagerDuty Service"
    view_label: "PagerDuty Issue"
    sql: coalesce(case when ${project.pname} = 'Pager Duty' then regexp_replace(replace(btrim(substring(${summary} from 'Service:([^,]*)')), ' ', '-'), '-{2,}', '-', 'g') end, '') ;;
    drill_fields: [issue_id]
  }

  dimension: pager_duty_app {
    type: string
    label: "PagerDuty Application"
    view_label: "PagerDuty Issue"
    sql: coalesce(null, '') ;;
    drill_fields: [issue_id]
  }

  dimension: pager_duty_platform {
    type: string
    label: "PagerDuty Platform"
    view_label: "PagerDuty Issue"
    sql: case
           when ${pager_duty_service} in ('IT-Alerts', 'IT-Network', 'IT-On-Call') then 'IT'
           when ${pager_duty_service} in ('ATV-Data-SLA', 'ATV-Data-Nielsen-TV-Processing', 'ATV-Data-Team-Nagios', 'ATV-Data-Team-Non-Critical', 'ATV-Data-Team-Email', 'ATV-Common-Data-Infrastructure', 'ATV-SQL-Prod-notify', 'ATV-SQL-Prod-critical', 'ATV-Eliza-Data', 'ATV-Cora') then 'Cora'
           when ${pager_duty_service} in ('ATV-DMP-Nagios', 'ATV-DMP-Pingdom', 'ATV-DMP-Cloudwatch', 'ATV-DMP-Business-Hours') then 'Eliza'
           when ${pager_duty_service} in ('ATV-GIO-Manual', 'ATV-GIO-Nagios', 'ATV-LibreNMS', 'ATV-GIO-Business-Hours', 'ATV-DevOps-Critical-Tickets') then 'DevOps'
           when ${pager_duty_service} in ('Integration-Team-Alerts') then 'Integrations'
           when ${pager_duty_service} in ('ATV-Lucy-Nagios', 'ATV-Lucy-Pingdom', 'ATV-vAds-Adserver-Critical-Error', 'ATV-vAds-Logger-Critical-Error', 'ATV-vAds-API', 'ATV-vAds-Email', 'ATV-vAds-MRC-Audit-Alert', 'ATV-vAds-Nagios', 'ATV-vAds-Pingdom', 'ATV-Lucy-Business-Hours', 'ATV-Lucy-AdServing-Dev', 'ATV-Lucy-AdServing-Dev-Business-Hours', 'ATV-Digital-Data') then 'Lucy'
           when ${pager_duty_service} in ('ATV-Maya-Pingdom', 'ATV-Maya-vOne-Nagios', 'ATV-Reporting-Data', 'ATV-Papi-Nagios', 'ATV-Maya-Business-Hours', 'ATV-Maya-Business-Hours-Papi', 'ATV-Maya-Business-Hours-DataReporting') then 'Maya'
           when ${pager_duty_service} in ('ATV-Opt-Dev-Emails', 'ATV-OptDev-Nagios', 'OPT-Business-Hours') then 'OptDev'
           when ${pager_duty_service} in ('ATV-RND-Email', 'ATV-RND-Nagios', 'ATV-RND-Prometheus') then 'RnD'
           when ${pager_duty_service} in ('TechOps-ServiceDesk', 'Techops-Email') then 'TechOps'
           when ${pager_duty_service} in ('ATV-Telly-Business-Hours', 'ATV-Telly-Platform') then 'TELLY'
           when ${pager_duty_service} in ('Tier-1-APAC-GroupM-SEA-SD-Alerts', 'Tier-1-APAC-Yahoo!-Japan-SD-Alerts', 'Tier-1-EMEA-Critical-SD-Alerts', 'Tier-1-APAC-Australia-Publisher-SD-Alerts', 'Tier-1-APAC-[Internal]-Y!J-House-Monitoring', 'Tier-1-APAC-CCI-SD-Alerts', 'Tier-1-APAC-[Internal]-AU-House-Monitoring', 'Tier-1-APAC-GroupM-Australia-SD-Alerts') then 'Tier 1'
           when ${pager_duty_service} in ('AWS-CloudWatch-ProdSyseng', 'Ad-Serving-Checks', 'BI-Bruno-Alerts', 'BI-Bruno-alerts-(API)', 'Catchpoint', 'Consul-Monitor', 'Data-Datamine', 'DOD', 'Grafana5API', 'Financial', 'Jira-Sev-1', 'Mail-Systems-LogicMonitor-(Dev)', 'Mail-Systems-LogicMonitor-(Systems)', 'Mail-Systems-Email-Alert', 'Monitis-Keynote-alerts',
             'NOC-Notify', 'NOC-Notify-Email', 'NOC-Notify-Urgent', 'New-Relic', 'New-Relic-Amobee', 'NewRelic-Alert-API', 'NewRelic-System-Alerts', 'Operator-Data-ID-Mapping-DNS', 'Opt-Out-Cookie-Validation-Events', 'Outage-Notification', 'PagerDuty-API', 'Runtime-AdServer', 'RPT:-platform', 'RPT:-social', 'Security-Operations', 'SingtelDirectPipeNotification',
             'Syseng-On-Call-Notify', 'Tech-Ops-Notify-(Mail)', 'TechOps-DBOps', 'TechOps-Network', 'TechOps-Notify-(API)', 'TechOps-Notify-(API2)', 'TechOps-Office-Hours-Incidents') then 'Non ATV'
           else ''
         end ;;
    drill_fields: [issue_id]
  }

  dimension: has_child_issues {
    type: yesno
    view_label: "Issue"
    sql: ${customfieldvalue_child_issues.issue_id} IS NOT NULL ;;
  }

  dimension: productivity_score_days  {
    type: number
    label: "Productivity Score (Days)"
    view_label: "Issue"
    sql: case when ${jiraissue.has_child_issues} then
          case
            when ${t_shirt_size.customvalue} IN ('XXS (1 day)','XXS2 (2 days)','XXS3 (3 days)','XS (1 week)','S (2 weeks)') then 5
            when ${t_shirt_size.customvalue} IN ('M (4 weeks)','L (8 weeks)','XL (16 weeks)','XXL (26 weeks)') then 10
            when ${t_shirt_size.customvalue} IN ('3XL (52 weeks)','4XL (>52 weeks)') then 15
            else null end
          else ${customfieldvalue_days.days} end;;
  }

  measure: count {
    type: count
    view_label: "Issue"
    drill_fields: [id]
  }

  measure: distinct_count {
    type: number
    view_label: "Issue"
    label: "Distinct Issue Count"
    sql: count(distinct ${TABLE}.id) ;;
  }

  measure: distinct_count_with_root_cause {
    type: count_distinct
    label: "Issue With Root Cause Count"
    view_label: "Issue"
    description: "Distinct count of issues with root cause set"
    sql: case when ${jiraissue_root_cause.root_cause_id} is not null then ${id} end ;;
  }

  measure: distinct_count_with_no_root_cause {
    type: count_distinct
    label: "Issue With No Root Cause Count"
    view_label: "Issue"
    description: "Distinct count of issues with no root cause set"
    sql: case when ${jiraissue_root_cause.root_cause_id} is null then ${id} end ;;
  }
}
