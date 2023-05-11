view: median_response {
  derived_table: {
    sql:
  SELECT jiraissue.id AS "issue_id"
    ,DATE_PART('day', external_comments.created_date - jiraissue.created) * 1440 + DATE_PART('hour', external_comments.created_date - jiraissue.created) * 60 + DATE_PART('minute', external_comments.created_date - jiraissue.created) AS "response_time_min"
    ,DATE_PART('day', external_comments.created_date - jiraissue.created) * 24 + DATE_PART('hour', external_comments.created_date - jiraissue.created) + DATE_PART('minute', external_comments.created_date - jiraissue.created) / 60 AS "response_time_hour"
    ,DATE_PART('day', external_comments.created_date - jiraissue.created) + (DATE_PART('hour', external_comments.created_date - jiraissue.created) / 24) + (DATE_PART('minute', external_comments.created_date - jiraissue.created) / 1440) AS "response_time_day"

  FROM PUBLIC.jiraissue AS jiraissue
  LEFT JOIN PUBLIC.project AS project ON jiraissue.project = project.id
  LEFT JOIN (
    SELECT a.issueid
      ,min(a.created)::TIMESTAMP AS created_date
    FROM PUBLIC.jiraaction a
    LEFT JOIN entity_property ep ON a.id = ep.entity_id
    WHERE a.actiontype = 'comment'
      AND ep.property_key = 'sd.public.comment'
      AND ep.json_value = '{"internal":false}'
    GROUP BY a.issueid
    ) AS external_comments ON jiraissue.id = external_comments.issueid
  GROUP BY 1
    ,2
    ,3
    ,4 ;;

    }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issue_id ;;
  }

  measure: med_response_time_min {
    type: number
    label: "Median Response Time (Minutes)"
    description: "Median time between opening of Issue and the first external response, in Minutes."
    view_label: "Issue Comments"
    value_format_name: decimal_0
    sql: PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY response_time_min)  ;;
  }

  measure: med_response_time_hour {
    type: number
    label: "Median Response Time (Hours)"
    view_label: "Issue Comments"
    description: "Median time between opening of Issue and the first external response, in Hours."
    value_format_name: decimal_2
    sql: PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY response_time_hour)  ;;
  }

  measure: med_response_time_days {
    type: number
    label: "Median Response Time (Days)"
    view_label: "Issue Comments"
    description: "Median time between opening of Issue and the first external response, in Days."
    value_format_name: decimal_2
    sql: PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY response_time_day)  ;;
  }


  }
