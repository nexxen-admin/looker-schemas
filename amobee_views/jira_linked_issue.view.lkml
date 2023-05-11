view: linked_issue {
    derived_table: {
      sql: select

  issue.id as issue_id,
  ltype.outward as link_type,
  linked_issue.id as linked_issue_id,
  linked_iss_proj.pkey || '-' || linked_issue.issuenum as linked_issue,
  linked_issue.summary as linked_issue_summary,
  linked_assignee.display_name as linked_issue_assignee,
  linked_status.pname as linked_issue_status,
  linked_type.pname as linked_issue_type,
  linked_issue.description as linked_issue_description,
  linked_issue.resolutiondate as linked_issue_resolution_date,
  linked_iss_proj.pname as project_name,
  res.description as resolution,
  sprintoption."NAME" as sprint

  from jiraissue issue
  join issuelink link on issue.id = link.source
  join jiraissue linked_issue on link.destination = linked_issue.id
  join issuelinktype ltype on link.linktype = ltype.id
  left join cwd_user linked_assignee on linked_issue.assignee = linked_assignee.user_name and linked_assignee.active = 1
  join issuestatus linked_status on linked_issue.issuestatus = linked_status.id
  join issuetype linked_type on linked_issue.issuetype = linked_type.id
  join project linked_iss_proj on linked_issue.project = linked_iss_proj.id
  left join resolution res on issue.resolution = res.id
  left join customfieldvalue sprintcat on linked_issue.id = sprintcat.issue and sprintcat.customfield = 10941
  left join "AO_60DB71_SPRINT" sprintoption on sprintcat.stringvalue = cast(sprintoption."ID" as varchar(32))



UNION


  select

  issue.id as issue_id,
  ltype.inward as link_type,
  linked_issue.id as linked_issue_id,
  linked_iss_proj.pkey || '-' || linked_issue.issuenum as linked_issue,
  linked_issue.summary as linked_issue_summary,
  linked_assignee.display_name as linked_issue_assignee,
  linked_status.pname as linked_issue_status,
  linked_type.pname as linked_issue_type,
  linked_issue.description as linked_issue_description,
  linked_issue.resolutiondate as linked_issue_resolution_date,
  linked_iss_proj.pname as project_name,
  res.description as resolution,
  sprintoption."NAME" as sprint

  from jiraissue issue
  join issuelink link on issue.id = link.destination
  join jiraissue linked_issue on link.source = linked_issue.id
  join issuelinktype ltype on link.linktype = ltype.id
  left join cwd_user linked_assignee on linked_issue.assignee = linked_assignee.user_name and linked_assignee.active = 1
  join issuestatus linked_status on linked_issue.issuestatus = linked_status.id
  join issuetype linked_type on linked_issue.issuetype = linked_type.id
  join project linked_iss_proj on linked_issue.project = linked_iss_proj.id
  left join resolution res on issue.resolution = res.id
  left join customfieldvalue sprintcat on linked_issue.id = sprintcat.issue and sprintcat.customfield = 10941
  left join "AO_60DB71_SPRINT" sprintoption on sprintcat.stringvalue = cast(sprintoption."ID" as varchar(32))

                     ;;
    }

    dimension: issue_id {
      type: number
      hidden: yes
      sql: ${TABLE}.issue_id ;;
    }

  dimension: linked_issue_id {
    type: number
    hidden: yes
    view_label: "Linked Issues"
    label: "Linked Issue ID"
    sql: ${TABLE}.linked_issue_id ;;
  }

    dimension: resolution {
      type: string
      hidden: yes
      sql: ${TABLE}.resolution ;;
    }

    dimension: link_type {
      type: string
      label: "Link Type"
      view_label: "Linked Issues"
      sql: ${TABLE}.link_type ;;
    }

  dimension: link_issue {
    type: string
    label: "Linked Issue"
    view_label: "Linked Issues"
    link: {    label: "JIRA Link"
      url: "https://jira-tech.amobee.com/browse/{{value}}"}
    sql: ${TABLE}.linked_issue ;;
  }

  dimension: link_summary {
    type: string
    label: "Linked Issue Summary"
    view_label: "Linked Issues"
    sql: ${TABLE}.linked_issue_summary ;;
  }

  dimension: link_assignee {
    type: string
    label: "Linked Issue Assignee"
    view_label: "Linked Issues"
    sql: ${TABLE}.linked_issue_assignee ;;
  }

  dimension: link_status {
    type: string
    label: "Linked Issue Status"
    view_label: "Linked Issues"
    sql: ${TABLE}.linked_issue_status ;;
  }
  dimension: link_issue_type {
    type: string
    label: "Linked Issue Type"
    view_label: "Linked Issues"
    sql: ${TABLE}.linked_issue_type ;;
  }

  dimension: link_description {
    type: string
    label: "Linked Issue Description"
    view_label: "Linked Issues"
    sql: ${TABLE}.linked_issue_description ;;
  }

  dimension: link_project_name {
    type: string
    label: "Linked Project Name"
    view_label: "Linked Issues"
    sql: ${TABLE}.project_name ;;
  }

  dimension: link_issue_sprint {
    type: string
    label: "Linked Issue Sprint"
    view_label: "Linked Issues"
    description: "The sprint of the linked issue as assigned in the linked issue"
    sql: ${TABLE}.sprint ;;
  }

  dimension_group: linked_issue_resolution_date {
    type: time
    label: "Linked Issue Resolution"
    view_label: "Linked Issues"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.linked_issue_resolution_date ;;
  }

  dimension: pager_duty_service {
    type: string
    hidden: yes
    sql: coalesce(case when ${link_project_name} = 'Pager Duty' then regexp_replace(replace(btrim(substring(${link_summary} from 'Service:([^,]*)')), ' ', '-'), '-{2,}', '-', 'g') end, '') ;;
  }

  dimension: pager_duty_platform {
    type: string
    label: "Linked Issue PagerDuty Platform"
    view_label: "Linked Issues"
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
  }
}
