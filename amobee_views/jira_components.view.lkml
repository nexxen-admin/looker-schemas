view: components {
  derived_table: {
    sql:
      select na.source_node_id as issue_id,
             string_agg(c.cname, ', ' order by c.cname) as components
      from public.nodeassociation na
      join public.component c on na.sink_node_id = c.id
      where na.association_type = 'IssueComponent'
      group by na.source_node_id ;;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issue_id ;;
  }

  dimension: components {
    type: string
    label: "Components"
    view_label: "Custom Fields"
    sql: ${TABLE}.components ;;
  }
}
