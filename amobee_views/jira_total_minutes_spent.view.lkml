view: total_minutes_spent {
  derived_table: {
    sql:  select
            link.source as issue_id,
            sum(cfv.numbervalue) as total_minutes_spent
          from
            public.issuelink link
              join public.issuelinktype link_type
                on link.linktype = link_type.id
              join public.customfieldvalue cfv
                on link.destination = cfv.issue and cfv.customfield = 18351
          where
            link_type.linkname = 'jira_subtask_link'
          group by
            link.source ;;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issue_id ;;
  }

  dimension: total_minutes_spent {
    type: number
    label: "Total Minutes Spent"
    description: "Sum of Minutes Spent of all subtasks"
    view_label: "Custom Fields"
    sql: ${TABLE}.total_minutes_spent ;;
  }
}
