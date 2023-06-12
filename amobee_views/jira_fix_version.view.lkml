view: fix_version {
  derived_table: {
    sql:
      select
        na.source_node_id as id,
        pv.vname as fix_version,
        string_agg(pv.vname, ', ') over (partition by na.source_node_id) as fix_version_list
      from
        public.projectversion pv
          join nodeassociation na
            on pv.id = na.sink_node_id and na.association_type = 'IssueFixVersion';;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: fix_version {
    type: string
    view_label: "Issue"
    label: "Fix Version"
    description: "The latest fix version associated with the JIRA Issue."
    sql: ${TABLE}.fix_version ;;
  }

  dimension: fix_version_list {
    type: string
    label: "Fix Versions List"
    view_label: "Issue"
    sql: ${TABLE}.fix_version_list ;;
  }

  measure: count_of_fix_versions {
    type: number
    label: "Count of Fix Versions"
    view_label: "Issue"
    description: "The distinct count of fix versions."
    sql: count(distinct ${fix_version}) ;;
  }
}
