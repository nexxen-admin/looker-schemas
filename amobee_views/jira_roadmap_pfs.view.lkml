view: roadmap_pfs {
  derived_table: {
    sql: SELECT
        issue.id,
        'Scheduled' ::varchar(10) as in_sprint
        FROM jiraissue issue
        JOIN project p on issue.project = p.id
        LEFT JOIN issuetype isstype on issue.issuetype = isstype.id
        JOIN customfieldvalue cfv on issue.id = cfv.issue
        JOIN customfield cf on cfv.customfield = cf.id and cf.cfname = 'Sprint'
        where cfv.stringvalue = '532'
        and p.pkey = 'PF'
                   ;;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: scheduled {
    type: string
    label: "Scheduled for Roadmap"
    description: "An indicator (scheduled) for PFs that are currently included in the roadmap."
    sql: ${TABLE}.in_sprint ;;
  }

}
