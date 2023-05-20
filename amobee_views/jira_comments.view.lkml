view: comments {
  derived_table: {
    sql:  select
            a.issueid,
            a.actionbody as comment,
            case when strpos(a.author, '@') = 0 then 'Internal' else 'External' end as comment_type,
            a.created as created_date,
            t.display_name as author,
            t.email_address as author_email,
            a.id
          from
            public.jiraaction a
              left join public.app_user au
                on a.author = au.user_key
              left join
              (
                select
                  cu.lower_user_name,
                  cu.display_name,
                  cu.email_address,
                  row_number() over (partition by cu.lower_user_name order by cu.directory_id desc) as rn
                from
                  public.cwd_user cu
              ) as t
                on au.lower_user_name = t.lower_user_name
          where
            a.actiontype = 'comment' and
            t.rn = 1 ;;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issueid ;;
  }

  dimension: comment {
    type: string
    label: "Comment"
    view_label: "Issue Comments"
    sql: ${TABLE}.comment ;;
  }

  dimension: comment_type {
    type: string
    label: "Comment Type"
    view_label: "Issue Comments"
    description: "Determines if a comment is internal or external.  If the author of the comment has @ in the user name then flagged as external else it is a logged in
    Jira user and is flagged as internal."
    sql: ${TABLE}.comment_type ;;
  }

  dimension_group: created_date {
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
    label: "Created Date"
    view_label: "Issue Comments"
    sql:${TABLE}.created_date ;;
  }

  dimension: author {
    type: string
    label: "Author"
    view_label: "Issue Comments"
    sql: ${TABLE}.author ;;
  }

  dimension: author_email {
    type: string
    label: "Author Email"
    view_label: "Issue Comments"
    sql: ${TABLE}.author_email ;;
  }

  dimension: comment_id {
    type: number
    label: "Comment ID"
    primary_key: yes
    sql: ${TABLE}.id ;;
    value_format_name: id
  }

  measure: sum_count_comments {
    type: count_distinct
    label: "Count of Comments"
    view_label: "Issue Comments"
    description: "Count of all comments within Jira Issues."
    sql: ${TABLE}.id ;;
  }

}
