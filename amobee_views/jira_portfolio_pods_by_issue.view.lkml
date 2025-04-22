view: portfolio_pods_by_issue {
  derived_table: {
    sql:
      WITH customfieldvalue_pod AS (SELECT
        cf_pod.issue as issue_id,
        unnest(regexp_split_to_array(cf_pod.stringvalue, '[,]')) AS pod_id
      FROM public.customfieldvalue  AS cf_pod
      WHERE cf_pod.customfield = 22240)
      SELECT
        cfp.issue_id,
        string_agg(plan."TITLE", ' , ') AS pods
      FROM customfieldvalue_pod cfp
      LEFT JOIN public."AO_D9132D_PLAN" AS plan ON cfp.pod_id::int = plan."ID"
      WHERE cfp.pod_id is not null
    GROUP BY 1
    ;;
}

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issue_id ;;
  }

  dimension: pods {
    type: string
    view_label: "Portfolio Project"
    label: "PODs"
    sql: ${TABLE}.pods ;;
  }
}
