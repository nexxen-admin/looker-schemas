# ***External Comments Only***

view: external_comments {
  derived_table: {
    sql:  select
            a.issueid,
            min(a.created)::timestamp as created_date
          from
            public.jiraaction a
              left join entity_property ep
                on a.id = ep.entity_id
          where
            a.actiontype = 'comment'
        and ep.property_key = 'sd.public.comment'
        and ep.json_value = '{"internal":false}'
        group by a.issueid
            ;;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issueid ;;
  }

  dimension: response_time {
    type: number
    label: "External Reponse Time (Minutes)"
    view_label: "Issue Comments"
    sql: DATE_PART('day', ${created_raw} - ${jiraissue.created_raw}) * 1440
          + DATE_PART('hour', ${created_raw} - ${jiraissue.created_raw}) * 60
          + DATE_PART('minute', ${created_raw} - ${jiraissue.created_raw} ) ;;
  }

  measure: avg_response_time_min {
    type: number
    label: "Average Reponse Time (Minutes)"
    description: "Average time between opening of Issue and the first external response, in Minutes."
    view_label: "Issue Comments"
    value_format_name: decimal_0
    sql: avg(DATE_PART('day', ${created_raw} - ${jiraissue.created_raw}) * 1440
          + DATE_PART('hour', ${created_raw} - ${jiraissue.created_raw}) * 60
          + DATE_PART('minute', ${created_raw} - ${jiraissue.created_raw} )) ;;
  }

  measure: avg_response_time_hr {
    type: number
    label: "Average Reponse Time (Hours)"
    description: "Average time between opening of Issue and the first external response, in Hours."
    view_label: "Issue Comments"
    value_format_name: decimal_2
    sql: avg(DATE_PART('day', ${created_raw} - ${jiraissue.created_raw}) * 24
          + DATE_PART('hour', ${created_raw} - ${jiraissue.created_raw})
            + DATE_PART('minute', ${created_raw} - ${jiraissue.created_raw}) / 60) ;;
  }

  measure: avg_response_time_day {
    type: number
    label: "Average Reponse Time (Days)"
    description: "Average time between opening of Issue and the first external response, in Days."
    view_label: "Issue Comments"
    value_format_name: decimal_2
    sql: avg(DATE_PART('day', ${created_raw} - ${jiraissue.created_raw})
          + (DATE_PART('hour', ${created_raw} - ${jiraissue.created_raw}) / 24)
          + (DATE_PART('minute', ${created_raw} - ${jiraissue.created_raw}) / 1440) ) ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    label: "External Comment Created"
    hidden: yes
    view_label: "Issue Comments"
    sql:${TABLE}.created_date ;;
  }

}
