view: issue_completion {

   derived_table: {
  sql:  select
          t.issue_id as issueid,
          coalesce(max(t.issue_days), 0) as days_to_complete,
          coalesce(max(t.issue_remaining), 0) as days_remaining,
          case
            when t.is_leaf_issue then
              case
                when t.issue_status in ('Backlog', 'On Hold') then 0
                when t.issue_status in ('Open', 'Reopened', 'To Do') then 0.05
                when t.issue_status in ('In Requirements', 'Requirement Analysis', 'Awaiting Acceptance', 'Awaiting Clarification', 'Business Review', 'Issue Review', 'Product Review', 'PR Review', 'Awaiting approval', 'Awaiting Rollback', 'Ready for PR') then 0.1
                when t.issue_status in ('Tech Review', 'In Review', 'Acceptance Criteria', 'Awaiting Design') then 0.15
                when t.issue_status in ('Design', 'Technical Design', 'In Design', 'Selected for Development', 'Awaiting Development', 'Awaiting Implementation') then 0.2
                when t.issue_status in ('In Development', 'In Progress') then 0.5
                when t.issue_status in ('Code Review', 'Code Review/Testing', 'Testing/Code Review', 'Testing', 'Dev Testing', 'In Testing', 'Quality Testing', 'QA/PO Verification') then 0.75
                when t.issue_status in ('Integration Testing', 'End to End Testing', 'Beta Testing', 'Ready for Staging', 'Ready for E2E', 'Ready for PIT', 'Ready for CAT') then 0.8
                when t.issue_status in ('In Master', 'Ready for UAT', 'UAT Staged', 'Staged', 'Applied in E2E', 'Applied in PIT', 'Applied in CAT', 'Awaiting Validation') then 0.85
                when t.issue_status in ('UAT', 'In UAT', 'End User UAT') then 0.9
                when t.issue_status in ('Ready for Scheduling', 'Awaiting Release', 'Awaiting Deployment', 'Production Staged') then 0.95
                when t.issue_status in ('Not Released', 'Released', 'Released to External', 'Closed', 'Resolved', 'Done', 'Discarded', 'Rejected', 'Cancelled') then 1
                else 0
              end
            when sum(t.linked_issue_days) > 0 then 1 - coalesce(sum(t.linked_issue_remaining), 0) / sum(t.linked_issue_days)
            else 0
          end as pct_complete
        from
        (
          select
            ji.id as issue_id,
            st.pname as issue_status,
            cfv.numbervalue as issue_days,
            cfv2.numbervalue as issue_remaining,
            count(lnk.id) over (partition by ji.id) = 0 as is_leaf_issue,
            li.numbervalue as linked_issue_days,
            li2.numbervalue as linked_issue_remaining
          from
            jiraissue ji
              left join issuestatus st
                on ji.issuestatus = st.id
              left join customfieldvalue cfv
                on ji.id = cfv.issue and
                   cfv.customfield = 16826 -- Days
              left join customfieldvalue cfv2
                on ji.id = cfv2.issue and
                   cfv2.customfield = 16827 -- Remaining
              left join issuelink lnk
                on ji.id = lnk.source and
                   lnk.linktype = 10200 -- Epic-Story Link
              left join customfieldvalue li
                on lnk.destination = li.issue and
                   li.customfield = 16826 -- Days
              left join customfieldvalue li2
                on lnk.destination = li2.issue and
                   li2.customfield = 16827 -- Remaining
          where
            ji.issuetype = '6' -- Epic
        ) as t
        group by
          t.issue_id,
          t.issue_status,
          t.is_leaf_issue
        union all
        select
          t.issue_id as issueid,
          coalesce(max(t.issue_days), 0) as days_to_complete,
          coalesce(max(t.issue_remaining), 0) as days_remaining,
          case
            when t.is_leaf_issue then
              case
                when t.issue_status in ('Backlog', 'On Hold') then 0
                when t.issue_status in ('Open', 'Reopened', 'To Do') then 0.05
                when t.issue_status in ('In Requirements', 'Requirement Analysis', 'Awaiting Acceptance', 'Awaiting Clarification', 'Business Review', 'Issue Review', 'Product Review', 'PR Review', 'Awaiting approval', 'Awaiting Rollback', 'Ready for PR') then 0.1
                when t.issue_status in ('Tech Review', 'In Review', 'Acceptance Criteria', 'Awaiting Design') then 0.15
                when t.issue_status in ('Design', 'Technical Design', 'In Design', 'Selected for Development', 'Awaiting Development', 'Awaiting Implementation') then 0.2
                when t.issue_status in ('In Development', 'In Progress') then 0.5
                when t.issue_status in ('Code Review', 'Code Review/Testing', 'Testing/Code Review', 'Testing', 'Dev Testing', 'In Testing', 'Quality Testing', 'QA/PO Verification') then 0.75
                when t.issue_status in ('Integration Testing', 'End to End Testing', 'Beta Testing', 'Ready for Staging', 'Ready for E2E', 'Ready for PIT', 'Ready for CAT') then 0.8
                when t.issue_status in ('In Master', 'Ready for UAT', 'UAT Staged', 'Staged', 'Applied in E2E', 'Applied in PIT', 'Applied in CAT', 'Awaiting Validation') then 0.85
                when t.issue_status in ('UAT', 'In UAT', 'End User UAT') then 0.9
                when t.issue_status in ('Ready for Scheduling', 'Awaiting Release', 'Awaiting Deployment', 'Production Staged') then 0.95
                when t.issue_status in ('Not Released', 'Released', 'Released to External', 'Closed', 'Resolved', 'Done', 'Discarded', 'Rejected', 'Cancelled') then 1
                else 0
              end
            when sum(t.linked_issue_days) > 0 then 1 - coalesce(sum(t.linked_issue_remaining), 0) / sum(t.linked_issue_days)
            else 0
          end as pct_complete
        from
        (
          select
            ji.id as issue_id,
            st.pname as issue_status,
            cfv.numbervalue as issue_days,
            cfv2.numbervalue as issue_remaining,
            count(lnk.id) over (partition by ji.id) = 0 as is_leaf_issue,
            li.numbervalue as linked_issue_days,
            li2.numbervalue as linked_issue_remaining
          from
            jiraissue ji
              left join issuestatus st
                on ji.issuestatus = st.id
              left join customfieldvalue cfv
                on ji.id = cfv.issue and
                   cfv.customfield = 16826 -- Days
              left join customfieldvalue cfv2
                on ji.id = cfv2.issue and
                   cfv2.customfield = 16827 -- Remaining
              left join issuelink lnk
                on ji.id = lnk.destination and
                   lnk.linktype = 10000 -- Blocks
              left join customfieldvalue li
                on lnk.source = li.issue and
                   li.customfield = 16826 -- Days
              left join customfieldvalue li2
                on lnk.source = li2.issue and
                   li2.customfield = 16827 -- Remaining
          where
            ji.issuetype <> '6' -- not Epic
        ) as t
        group by
          t.issue_id,
          t.issue_status,
          t.is_leaf_issue ;;
}

   dimension: id {
    description: "The id of the JIRA Issue."
    hidden: yes
    primary_key: yes
     type: number
     sql: ${TABLE}.issueid ;;
   }

  measure: days_to_complete {
    view_label: "Issue"
    label: "Days To Complete"
    description: "The total number of days expected to complete the epic based on the t-shirt sizes for all of the leaf level tasks in the epic.
      X-Small is 7 days, Small is 15 days, Medium is 30 days, Large is 90 days and X-Large is 180 days.  If t-shirt size is not set it will default to 0 days."
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.days_to_complete ;;
  }

  measure: percent_complete {
    view_label: "Issue"
    label: "Percent to Complete"
    description: "The average percent complete based on the percent complete of all of the linked issues in the Epic.  There are other statuses included
    but loosely this is defined as Backlog - 0%, In Requirements - 5%, In Tech Review - 15%, In Design - 20%, In Development - 50%, in Testing - 80%,
    Applied in Pre-Prod enviornments - 85%, in UAT - 90%, Awaiting Production release - 95%, Released - 100%."
    type: average
    value_format_name: percent_2
    sql: ${TABLE}.pct_complete ;;
  }

  measure: remaining_days {
    view_label: "Issue"
    label: "Remaining Days"
    description: "This is a derived field calculated by taking the days to complete * (1 - perecnt complete).  It will give you an estimate of remaining
    work for all issues in the epic based on the status of all of the issues in the epics and their estimated effort.  See percent complete and days to complete
    for descriptions of those calculations."
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.days_remaining ;;

  }

}
