view: workflow_history {
  label: "Issue History"
  derived_table: {
    sql:  select
            cg.issueid,
            ci.newstring as status,
            cg.created,
            t2.display_name as author,
            t2.email_address as author_email

            {% if duration_seconds._in_query
              or duration_string._in_query %}
            ,extract(epoch from coalesce(lead(cg.created) over (partition by cg.issueid order by cg.created), current_timestamp) - cg.created) as duration_seconds
            {% endif %}

          from
            public.changeitem ci
              join public.changegroup cg
                on ci.groupid = cg.id
              left join
              (
                select
                  au.user_key,
                  t.display_name,
                  t.email_address
                from
                  public.app_user au
                    join
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
                  t.rn = 1
              ) as t2
                on cg.author = t2.user_key
          where
            ci.field = 'status'

          {% if duration_seconds._in_query
              or duration_string._in_query %}

          union all

          -- for the very first status of the ticket
          select
            change.issueid,
            change.oldstring as status,
            ji.created,
            t2.display_name as author,
            t2.email_address as author_email,
            extract(epoch from change.created - ji.created) as duration_seconds
          from
            (
              select
                cg.issueid,
                ci.oldstring,
                cg.created,
                row_number() over (partition by cg.issueid order by cg.created) as row_num
              from public.changeitem ci
                join public.changegroup cg
                on ci.groupid = cg.id
              where ci.field = 'status'
            ) change
            join jiraissue ji
              on change.issueid = ji.id
              left join
              (
                select
                  au.user_key,
                  t.display_name,
                  t.email_address
                from
                  public.app_user au
                    join
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
                  t.rn = 1
              ) as t2
                on ji.creator = t2.user_key
          where
            change.row_num = 1

          {% endif %} ;;
  }

  dimension: issue_id {
    type: number
    hidden: yes
    sql: ${TABLE}.issueid ;;
  }

  dimension: status {
    type: string
    label: "History Status"
    sql: case when ${TABLE}.issueid is null then ${issuestatus.pname} else ${TABLE}.status end ;;
  }

  dimension: status_date {
    type: date_time
    label: "History Status Date"
    sql: case when ${TABLE}.issueid is null then ${jiraissue.created_raw} else ${TABLE}.created end ;;
  }

  dimension: status_author {
    type: string
    label: "History Status Author"
    sql: case when ${TABLE}.issueid is null then ${issuecreator.creator} else ${TABLE}.author end ;;
  }

  dimension: status_author_email {
    type: string
    label: "History Status Author Email"
    sql: case when ${TABLE}.issueid is null then ${issuecreator.creator_email} else ${TABLE}.author_email end ;;
  }

  measure: duration_seconds {
    type: sum
    label: "History Status Duration (Seconds)"
    sql: case when ${TABLE}.issueid is null then extract(epoch from current_timestamp - ${jiraissue.created_raw}) else ${TABLE}.duration_seconds end ;;
    value_format_name: decimal_3
  }

  measure: duration_string {
    type: string
    label: "History Status Duration"
    sql: case
          when ${duration_seconds} = 0 then '0s'
          when ${duration_seconds} is null then null
          else
            case
              when floor(${duration_seconds} / 604800) > 0  -- 604800 seconds in a week
                then to_char(floor(${duration_seconds} / 604800), '99999w ')
              else ''
            end ||
            case
              when floor(mod(${duration_seconds}::integer, 604800) / 86400) > 0  -- 86400 seconds in a day
                then to_char(floor(mod(${duration_seconds}::integer, 604800) / 86400), '9') || 'd '
              else ''
            end ||
            case
              when floor(mod(${duration_seconds}::integer, 86400) / 3600) > 0  -- 3600 seconds in an hour
                then to_char(floor(mod(${duration_seconds}::integer, 86400) / 3600), '99h ')
              else ''
            end ||
            case
              when floor(mod(${duration_seconds}::integer, 3600) / 60) > 0  -- 60 seconds in a minute
                then to_char(floor(mod(${duration_seconds}::integer, 3600) / 60), '99m ')
              else ''
            end ||
            case
              when mod(${duration_seconds}::integer, 60) > 0
                then to_char(mod(${duration_seconds}::integer, 60), '99') || 's'
              else ''
            end
        end ;;
  }

}
