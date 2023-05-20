view: customfieldvalue_pod {
  derived_table: {
    sql:
      SELECT
        cf_pod.issue,
        unnest(regexp_split_to_array(cf_pod.stringvalue, '[,]')) AS pod_id
      FROM public.customfieldvalue  AS cf_pod
      WHERE cf_pod.customfield = 22240
  ;;
  }

  dimension: issue_id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.issue ;;
  }

  dimension: pod_id {
    type: string
    hidden: yes
    sql: ${TABLE}.pod_id ;;
  }
}
