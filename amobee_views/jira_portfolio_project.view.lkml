view: portfolio_project {
  derived_table: {
    sql:
      SELECT
        i.id,
        i.issuestatus,
        p.pkey||'-'|| i.issuenum AS issue_key,
        i.summary
      FROM public.jiraissue i
      LEFT JOIN public.project AS p ON i.project = p.id
  ;;
  }

  dimension: id {
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: issue_key {
    type: string
    hidden: yes
    sql: ${TABLE}.issue_key;;
  }

  dimension: key_and_summary {
    type: string
    label: "Project"
    view_label: "Portfolio Project"
    link: {
      label: "JIRA Link"
      url: "https://jira-tech.amobee.com/browse/{{ issue_key }}"
      icon_url: "https://jira.atlassian.com/favicon.ico"}
    sql: ${TABLE}.issue_key || ' - ' || ${TABLE}.summary;;
  }

  dimension: issuestatus {
    type: string
    hidden: yes
    sql: ${TABLE}.issuestatus ;;
  }
}
