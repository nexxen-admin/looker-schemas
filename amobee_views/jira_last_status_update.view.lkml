view: last_status_update {
  derived_table: {
    sql: SELECT
          cg.issueid,
          MAX(cg.created) as last_status_update
        FROM changegroup cg
        INNER JOIN changeitem ci ON ci.groupid = cg.id
        AND ci.FIELDTYPE = 'jira' AND ci.FIELD = 'status'
        GROUP BY 1
      ;;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issueid ;;
  }

  dimension: last_status_update {
    type: date
    sql: ${TABLE}.last_status_update ;;
    convert_tz: no
  }
}
