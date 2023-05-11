view: epic {
  derived_table: {
    sql:
      with cte_user as (
        select
          user_name,
          display_name,
          row_number() over (partition by user_name) as rn
        from cwd_user
      )
      select
        b.id as issue_id,
        a.id as epic_p_id,
        d.pkey || '-' || a.issuenum as epic_id,
        e.display_name as epic_assignee,
        a.created as created_date,
        a.description as epic_description,
        a.resolutiondate as resolution_date,
        a.summary as epic_summary,
        a.updated as updated_date,
        s.pname as epic_status
      from jiraissue a
      join issuelink c on a.id = c.source
      join jiraissue b on c.destination = b.id
      join project d on a.project = d.id
      join issuestatus s on a.issuestatus = s.id
      left join cte_user e on a.assignee = e.user_name and e.rn = 1
        where c.linktype = 10020
  ;;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issue_id ;;
  }


  dimension: epic_id {
    type: string
    label: "Epic ID"
    view_label: "Epic"
    link: {    label: "JIRA Link"
      url: "https://jira-tech.amobee.com/browse/{{value}}"}
    sql:${TABLE}.epic_id ;;
  }

  dimension: assignee {
    type: string
    label: "Assignee"
    view_label: "Epic"
    sql: ${TABLE}.epic_assignee ;;
  }

  dimension: status {
    type: string
    label: "Status"
    view_label: "Epic"
    sql: ${TABLE}.epic_status ;;
  }


  dimension_group: created {
    type: time
    label: "Epic Created"
    view_label: "Epic"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_date ;;
  }


  dimension: description {
    type: string
    label: "Description"
    view_label: "Epic"
    sql: ${TABLE}.epic_description ;;
  }

  dimension_group: resolutiondate {
    type: time
    label: "Resolution"
    view_label: "Epic"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.resolution_date ;;
  }


  dimension: summary {
    type: string
    label: "Summary"
    view_label: "Epic"
    sql: ${TABLE}.epic_summary ;;
  }


  dimension_group: updated {
    type: time
    label: "Updated"
    view_label: "Epic"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updated_date ;;
  }

}
