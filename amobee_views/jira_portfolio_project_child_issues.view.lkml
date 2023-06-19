view: portfolio_project_child_issues {
  derived_table: {
    sql:
      SELECT
        i.id,
        c.portfolio_project_id
      FROM
        jiraissue i
      LEFT JOIN project p ON i.project = p.id
      JOIN (
        SELECT
          i.id AS portfolio_project_id,
          unnest(regexp_split_to_array(cfv.textvalue, '[,;]')) AS issue_key
       FROM public.jiraissue i
       LEFT JOIN public.customfieldvalue AS cfv ON cfv.issue = i.id AND cfv.customfield = 19345
       WHERE i.issuetype = '14'
       AND i.project = 17190
     ) c ON c.issue_key = p.pkey || '-' || i.issuenum
  ;;
  }

  dimension: issue_id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: portfolio_project_id {
    type: number
    hidden: yes
    sql: ${TABLE}.portfolio_project_id ;;
  }
}
