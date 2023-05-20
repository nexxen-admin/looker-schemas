view: pf_resource_sheet {


   derived_table: {
     sql:select
  init.in_number as intiative_id,
  init.in_summary as initative,
  pfs.pf_number as pf,
  pfs.pf_summary as pf_summary,
  pfs.pf_status as pf_status,
  tag.tag as pf_tag,
  pf_pct_complete.pct_complete as pf_pct_complete,
  blocking_epics.bl_epic_number as epic,
  blocking_epics.bl_epic_summary as epic_summary,
  leaf_project.pkey||'-'||leaf_issue.issuenum as leaf_issue,
  leaf_issue.summary as leaf_issue_summary,
  leaf_status.pname as leaf_status,
  leaf_assignee.display_name as leaf_assignee,
  cfv.numbervalue as leaf_days,
  cfv2.numbervalue as leaf_days_remaining,
  current_date + cast(coalesce(case when cfv2.numbervalue >365 then 365 else cfv2.numbervalue end ,0) as int) as date_available
FROM
(select
  pf.id as pf_id,
  pf.summary as pf_summary,
  pfproj.pkey||'-'||pf.issuenum as pf_number,
  status.pname as pf_status
  from jiraissue pf
  join project pfproj on pf.project = pfproj.id
  left join issuestatus status on pf.issuestatus = status.id
  where pfproj.pkey = 'PF'
    and status.pname not in ('Closed', 'Released')
    ) pfs --get all open PFs
LEFT JOIN
(select
  issue.id as pf_id,
  linkedissue.id as bl_epic_id,
  li_project.pkey||'-'||linkedissue.issuenum as bl_epic_number,
  linkedissue.summary as bl_epic_summary
from jiraissue issue
join issuelink link on issue.id = link.destination and link.linktype = 10000
join jiraissue linkedissue on link.source = linkedissue.id
join project li_project on linkedissue.project = li_project.id
join issuetype li_type on linkedissue.issuetype = li_type.id
where li_type.pname = 'Epic') blocking_epics on pfs.pf_id = blocking_epics.pf_id  --get all epics blocking the pfs
LEFT JOIN (select
  issue.id as pf_id,
  linkedissue.id as in_id,
  li_project.pkey||'-'||linkedissue.issuenum as in_number,
  linkedissue.summary as in_summary
from jiraissue issue
join issuelink link on issue.id = link.destination and link.linktype = 10000
join jiraissue linkedissue on link.source = linkedissue.id
join project li_project on linkedissue.project = li_project.id
join issuetype li_type on linkedissue.issuetype = li_type.id
where li_project.pkey = 'IN'
    UNION
  select
  issue.id as pf_id,
  linkedissue.id as in_id,
  li_project.pkey||'-'||linkedissue.issuenum as in_number,
  linkedissue.summary as in_summary
from jiraissue issue
join issuelink link on issue.id = link.source and link.linktype = 10000
join jiraissue linkedissue on link.destination = linkedissue.id
join project li_project on linkedissue.project = li_project.id
join issuetype li_type on linkedissue.issuetype = li_type.id
where li_project.pkey = 'IN'
          ) init on init.pf_id = pfs.pf_id  -- get all Initiatives for the PFs
LEFT join issuelink leaflink on blocking_epics.bl_epic_id = leaflink.source
LEFT join jiraissue leaf_issue on leaflink.destination = leaf_issue.id and leaflink.linktype = 10200 -- get leaf level issues for those epics
LEFT join project leaf_project on leaf_issue.project = leaf_project.id
LEFT join issuestatus leaf_status on leaf_issue.issuestatus = leaf_status.id --and leaf_status.pname not in ('Done', 'Closed', 'Released')
LEFT join (select
            au.user_key,
            t.display_name,
            t.email_address
          from
            public.app_user au
              join
              (
                select
                  cu.lower_user_name,
                  cu.display_name,
                  cu.email_address,
                  row_number() over (partition by cu.lower_user_name order by cu.directory_id desc) as rn
                from
                  public.cwd_user cu
              ) as t
                on au.lower_user_name = t.lower_user_name
          where
            t.rn = 1) leaf_assignee on leaf_assignee.user_key = leaf_issue.assignee  -- assignee for leafs
  LEFT JOIN customfieldvalue cfv on leaf_issue.id = cfv.issue
                            and cfv.customfield = 16826 --days
    LEFT JOIN customfieldvalue cfv2 on leaf_issue.id = cfv2.issue
                            and cfv2.customfield = 16827 --remaining
  LEFT JOIN (select
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
          t.is_leaf_issue) pf_pct_complete on pf_pct_complete.issueid = pfs.pf_id
  LEFT JOIN (with in_tag as (
            select
              ji.id,
              lpad(coalesce(trunc(max(cfv.numbervalue)), 9999)::text, 4, '0') as tag
            from
              jiraissue ji
                join project p
                  on ji.project = p.id
                join issuetype it
                  on ji.issuetype = it.id
                left join customfieldvalue cfv
                  on ji.id = cfv.issue and
                     cfv.customfield = 16604 -- Order
            where
              p.pkey = 'IN' and
              it.pname = 'New Feature'
            group by
              ji.id
          ), pf_tag as (
            select
              t2.id,
              concat_ws('.', lpad(t2.bucket::text, 4, '0'), lpad(least(9999, trunc(t2.value * t2.completeness * t2.cost * t2.complexity * t2.urgency))::text, 4, '0')) as tag
            from
            (
              select
                t.id,
                t.bucket,
                t.value,
                t.completeness,
                t.cost,
                t.complexity,
                case
                  when t.duedate is not null then
                    greatest(1, trunc(log(2, greatest(1, (t.duedate at time zone 'UTC')::date - (current_timestamp at time zone 'UTC')::date)::numeric / 7)))
                  else
                    t.cost
                end as urgency
              from
              (
                select
                  ji.id,
                  ji.duedate,
                  case
                    when issue_with_fix_version.issue_id is not null then issue_with_fix_version.bucket
                    when issue_blocking_in_1.issue_id is not null then 0
                    when issue_with_scheduled_sprint.issue_id is not null then 100
                    else 1000
                  end as bucket,
                  greatest(1, 5 - coalesce(issue_score_value.client_requested_count, 0)) as value,
                  greatest(1, trunc(5 - coalesce(issue_score_completeness.complete_value, 0) * 5)) as completeness,
                  greatest(1, trunc(log(2, ((coalesce(issue_score_cost.days, 0) + 1) / 7)::numeric))) as cost,
                  greatest(1, coalesce(issue_score_complexity.team_count, 0)) as complexity
                from
                  jiraissue ji
                    join project p
                      on ji.project = p.id
                    join issuetype it
                      on ji.issuetype = it.id
                    left join
                    (
                      select
                        ji.id as issue_id,
                        greatest(1, ascii(upper(substring(pv.vname /* fix version */ from '\s*(.)'))) - ascii('H') + 1) as bucket
                      from
                        jiraissue ji
                          join project p
                            on ji.project = p.id
                          join nodeassociation na
                            on ji.id = na.source_node_id
                          join projectversion pv
                            on na.sink_node_id = pv.id
                      where
                        p.pkey = 'PF' and
                        na.source_node_entity = 'Issue' and
                        na.association_type = 'IssueFixVersion'
                    ) as issue_with_fix_version
                      on ji.id = issue_with_fix_version.issue_id
                    left join
                    (
                      select
                        src.id as issue_id
                      from
                        issuelink lnk
                          join jiraissue src
                            on lnk.source = src.id
                          join project srcp
                            on src.project = srcp.id
                          join jiraissue dest
                            on lnk.destination = dest.id
                          join project destp
                            on dest.project = destp.id
                      where
                        lnk.linktype = 10000 and /* Blocks */
                        srcp.pkey = 'PF' and
                        destp.pkey = 'IN' and
                        dest.issuenum = 1
                    ) as issue_blocking_in_1
                      on ji.id = issue_blocking_in_1.issue_id
                    left join
                    (
                      select distinct
                        ji.id as issue_id
                      from
                        jiraissue ji
                          join project p
                            on ji.project = p.id
                          join customfieldvalue cfv
                            on ji.id = cfv.issue
                      where
                        p.pkey = 'PF' and
                        cfv.customfield = 10007 and /* Sprint */
                        cfv.stringvalue = '532' /* Scheduled */
                    ) as issue_with_scheduled_sprint
                      on ji.id = issue_with_scheduled_sprint.issue_id
                    left join
                    (
                      select
                        ji.id as issue_id,
                        count(*) as client_requested_count
                      from
                        jiraissue ji
                          join project p
                            on ji.project = p.id
                          join customfieldvalue cfv
                            on ji.id = cfv.issue
                      where
                        p.pkey = 'PF' and
                        cfv.customfield = 13319 /* Client Requested */
                      group by
                        ji.id
                    ) as issue_score_value
                      on ji.id = issue_score_value.issue_id
                    left join
                    (
                      select
                        t.issue_id,
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
                          when sum(t.days) > 0 then 1 - coalesce(sum(t.remaining), 0) / sum(t.days)
                          else 0
                        end as complete_value
                      from
                      (
                        select
                          ji.id as issue_id,
                          st.pname as issue_status,
                          count(lnk.id) over (partition by ji.id) = 0 as is_leaf_issue,
                          cfv.numbervalue as days,
                          cfv2.numbervalue as remaining
                        from
                          jiraissue ji
                            join project p
                              on ji.project = p.id
                            left join issuestatus st
                              on ji.issuestatus = st.id
                            left join issuelink lnk
                              on ji.id = lnk.destination and
                                 lnk.linktype = 10000 -- Blocks
                            left join customfieldvalue cfv
                              on lnk.source = cfv.issue and
                                 cfv.customfield = 16826 -- Days
                            left join customfieldvalue cfv2
                              on lnk.source = cfv2.issue and
                                 cfv2.customfield = 16827 -- Remaining
                        where
                          p.pkey = 'PF'
                      ) as t
                      group by
                        t.issue_id,
                        t.issue_status,
                        t.is_leaf_issue
                    ) as issue_score_completeness
                      on ji.id = issue_score_completeness.issue_id
                    left join
                    (
                      select
                        ji.id as issue_id,
                        max(cfv.numbervalue) as days
                      from
                        jiraissue ji
                          join project p
                            on ji.project = p.id
                          join customfieldvalue cfv
                            on ji.id = cfv.issue
                      where
                        p.pkey = 'PF' and
                        cfv.customfield = 16826 -- Days
                      group by
                        ji.id
                    ) as issue_score_cost
                      on ji.id = issue_score_cost.issue_id
                    left join
                    (
                      select
                        coalesce(inward.issue_id, outward.issue_id) as issue_id,
                        coalesce(inward.team_count, outward.team_count) as team_count
                      from
                      (
                        select
                          dest.id as issue_id,
                          count(distinct case when srcp.pkey in ('LUCY', 'MAYA', 'DATA', 'OPT', 'BUI', 'ELIZA', 'OASYS', 'PAPI', 'UXD', 'TIOT') then srcp.pkey end) as team_count
                        from
                          issuelink lnk
                            join jiraissue src
                              on lnk.source = src.id
                            join project srcp
                              on src.project = srcp.id
                            join jiraissue dest
                              on lnk.destination = dest.id
                            join project destp
                              on dest.project = destp.id
                        where
                          destp.pkey = 'PF'
                        group by
                          dest.id
                      ) as inward
                          full join
                          (
                            select
                              src.id as issue_id,
                              count(distinct case when destp.pkey in ('LUCY', 'MAYA', 'DATA', 'OPT', 'BUI', 'ELIZA', 'OASYS', 'PAPI', 'UXD', 'TIOT') then destp.pkey end) as team_count
                            from
                              issuelink lnk
                                join jiraissue src
                                  on lnk.source = src.id
                                join project srcp
                                  on src.project = srcp.id
                                join jiraissue dest
                                  on lnk.destination = dest.id
                                join project destp
                                  on dest.project = destp.id
                            where
                              srcp.pkey = 'PF'
                            group by
                              src.id
                          ) as outward
                            on inward.issue_id = outward.issue_id
                    ) as issue_score_complexity
                      on ji.id = issue_score_complexity.issue_id
                where
                  p.pkey = 'PF' and
                  it.pname = 'New Feature'
              ) as t
            ) as t2
          ), epic_tag as (
            select
              ji.id,
              concat_ws('.', coalesce(max(pf.tag), '9999.9999'), lpad(coalesce(trunc(max(cfv.numbervalue)), 9999)::text, 4, '0')) as tag
            from
              jiraissue ji
                join project p
                  on ji.project = p.id
                join issuetype it
                  on ji.issuetype = it.id
                left join
                (
                  select
                    lnk.source as source_issue_id,
                    min(pf.tag) as tag
                  from
                    issuelink lnk
                      join pf_tag pf
                        on lnk.destination = pf.id
                  where
                    lnk.linktype = 10000 -- Blocks
                  group by
                    lnk.source
                ) as pf
                  on ji.id = pf.source_issue_id
                left join customfieldvalue cfv
                  on ji.id = cfv.issue and
                     cfv.customfield = 16604 -- Order
            where
              p.pkey in ('LUCY', 'MAYA', 'DATA', 'OPT', 'BUI', 'ELIZA', 'OASYS', 'PAPI', 'UXD', 'TIOT') and
              it.pname = 'Epic'
            group by
              ji.id
          ), other_tag as (
            select
              ji.id,
              concat_ws('.', coalesce(max(epic.tag), max(epic2.tag), '9999.9999.9999'), lpad(coalesce(trunc(max(cfv.numbervalue)), 9999)::text, 4, '0')) as tag
            from
              jiraissue ji
                join project p
                  on ji.project = p.id
                join issuetype it
                  on ji.issuetype = it.id
                left join
                (
                  select
                    lnk.destination as destination_issue_id,
                    min(epic.tag) as tag
                  from
                    issuelink lnk
                      join epic_tag epic
                        on lnk.source = epic.id
                  where
                    lnk.linktype = 10200 -- Epic-Story Link
                  group by
                    lnk.destination
                ) as epic
                  on ji.id = epic.destination_issue_id
                left join
                (
                  select
                    lnk.source as source_issue_id,
                    min(epic.tag) as tag
                  from
                    issuelink lnk
                      join epic_tag epic
                        on lnk.destination = epic.id
                  where
                    lnk.linktype = 10000 -- Blocks
                  group by
                    lnk.source
                ) as epic2
                  on ji.id = epic2.source_issue_id
                left join customfieldvalue cfv
                  on ji.id = cfv.issue and
                     cfv.customfield = 16604 -- Order
            where
              p.pkey in ('LUCY', 'MAYA', 'DATA', 'OPT', 'BUI', 'ELIZA', 'OASYS', 'PAPI', 'UXD', 'TIOT') and
              it.pname in ('Task', 'New Feature', 'Bug')
            group by
              ji.id
          )
          select * from in_tag union all
          select * from pf_tag union all
          select * from epic_tag union all
          select * from other_tag) tag on tag.id = pfs.pf_id  --get pf tags
where coalesce(leaf_status.pname, 'N/A') not in ('Done', 'Closed', 'Released')       ;;
  }

  dimension: initative_id {
     description: "The ID of the Intitative"
     type: string
     sql: ${TABLE}.intiative_id ;;
  }

  dimension: initative {
    description: "The summary of the initative."
    type: string
    sql: ${TABLE}.initative ;;
  }

  dimension: pf_id {
    description: "The ID of the Platform Feature"
    type: string
    sql: ${TABLE}.pf ;;
  }

  dimension: pf {
    description: "The summary of the platform feature"
    type: string
    sql: ${TABLE}.pf_summary ;;
  }

  dimension: pf_status {
    description: "The current status of the PF"
    type: string
    sql: ${TABLE}.pf_status ;;
  }

  dimension: pf_tag {
    description: "The tag of the PF as it is stored in JIRA"
    type: string
    sql: ${TABLE}.pf_tag ;;
  }

  dimension: pf_pct_complete {
    description: "The % complete of the PF"
    type: string
    value_format_name: percent_0
    sql: ${TABLE}.pf_pct_complete ;;
  }

  dimension: epic {
    description: "The ID of the epcis associated with the PF (if any)."
    type: string
    sql: ${TABLE}.epic ;;
  }

  dimension: epic_summary {
    description: "The summary of the epcis associated with the PF (if any)."
    type: string
    sql: ${TABLE}.epic_summary ;;
  }

  dimension: leaf_issue {
    description: "The ID of the leaf level issues assigned to the epic or PF (if any)."
    type: string
    sql: ${TABLE}.leaf_issue ;;
  }

  dimension: leaf_issue_summary{
    description: "The summary of the leaf level issues assigned to the epic or PF (if any)."
    type: string
    sql: ${TABLE}.leaf_issue_summary ;;
  }


  dimension: leaf_status {
    description: "The current status of the leaf level issue."
    type: string
    sql: ${TABLE}.leaf_status ;;
  }

  dimension: leaf_assignee {
    description: "The current assignee of the leaf level issue."
    type: string
    sql: ${TABLE}.leaf_assignee ;;
  }

  dimension: leaf_days {
    description: "The number of days of work in the leaf level issue based on the t-shirt size."
    type: number
    hidden: yes
    sql: ${TABLE}.leaf_days ;;
  }

  measure: sum_leaf_days {
    description: "The number of days of work in the leaf level issue based on the t-shirt size."
    type: sum
    label: "Leaf Total Work Days"
    sql: ${leaf_days} ;;
  }

  dimension: leaf_days_remaining {
    description: "The number of days of work remaining for the leaf level ticket based on % complete and days of work."
    type: number
    hidden: yes
    sql: ${TABLE}.leaf_days_remaining ;;
  }

  measure: sum_leaf_days_remaining {
    description: "The number of days of work remaining for the leaf level ticket based on % complete and days of work."
    type: sum
    label: "Leaf Work Days Remaining"
    sql: ${leaf_days_remaining} ;;
  }

  dimension: date_available {
    description: "The approximate date that the resource should be finished working on this task."
    type: date
    sql: ${TABLE}.date_available ;;
  }


  }
