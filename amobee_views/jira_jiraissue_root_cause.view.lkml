view: jiraissue_root_cause {
  label: "Issue"
  derived_table: {
    sql:  select
            issue.id as issue_id,
            linked_issue.id as root_cause_id,
            linked_issue_proj.pkey || '-' || linked_issue.issuenum as root_cause
          from
            public.jiraissue issue
              join public.issuelink link
                on issue.id = link.destination
              join public.jiraissue linked_issue
                on link.source = linked_issue.id
              join public.project linked_issue_proj
                on linked_issue.project = linked_issue_proj.id
              join public.issuelinktype link_type
                on link.linktype = link_type.id
          where
            link_type.inward = 'is caused by' ;;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issue_id ;;
  }

  dimension: root_cause_id {
    type: number
    hidden: yes
    sql: ${TABLE}.root_cause_id ;;
  }

  dimension: root_cause {
    type: string
    label: "Root Cause"
    view_label: "Linked Issues"
    description: "Issue linked by means of 'is caused by' link type"
    sql: ${TABLE}.root_cause ;;
  }

  measure: count_root_cause {
    type: count_distinct
    label: "Root Cause Count"
    view_label: "Linked Issues"
    description: "Distinct count of issues linked by means of 'is caused by' link type"
    sql: ${root_cause_id} ;;
  }
}
