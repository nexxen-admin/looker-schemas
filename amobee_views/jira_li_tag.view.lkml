view: li_tag {
  derived_table: {
    sql:  with in_tag as (
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
                        greatest(1, ascii(upper(substring(pv.vname /* fix version */ from '\s*(.)'))) - ascii(upper(substring('{{_user_attributes['last_release_name']}}' from '\s*(.)'))) + 1) as bucket
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
          select * from other_tag ;;
  }

  dimension: id {
    type: number
    hidden: yes
    sql:  ${TABLE}.id ;;
  }

  dimension: tag {
    type: string
    label: "Linked Issue Tag"
    view_label: "Linked Issues"
    sql: ${TABLE}.tag ;;
  }
}
