view: customfieldvalue_child_issues {
  derived_table: {
    sql:
      SELECT
        cfv.issue AS issue_id,
        unnest(regexp_split_to_array(cfv.textvalue, '[,;]')) AS child_issue_key
     FROM public.customfieldvalue cfv
     WHERE cfv.customfield = 19345 ;;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issue_id ;;
  }

  dimension: child_issue_key {
    type: string
    view_label: "Custom Fields"
    sql: ${TABLE}.child_issue_key ;;
  }
}
