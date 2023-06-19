view: linked_issue_epic {
  derived_table: {
    sql: select

      issue.id as issue_id,
      epic.id as epic_p_id,
      epic_project.pkey || '-' || epic.issuenum as epic_id

      from jiraissue epic
      join issuelink link on epic.id = link.source
      join jiraissue issue on link.destination = issue.id
      join project epic_project on epic.project = epic_project.id
      where link.linktype = 10020
                            ;;
  }

  dimension: linked_issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issue_id ;;
  }

  dimension: linked_epic_link {
    type: string
    label: "Linked Issue Epic Link"
    view_label: "Linked Issues"
    link: {    label: "JIRA Link"
      url: "https://jira-tech.amobee.com/browse/{{value}}"}
    sql: ${TABLE}.epic_id ;;
  }
}
