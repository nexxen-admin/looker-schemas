view: jira_priority_history {
    label: "Priority History"
    derived_table: {
      sql:  select
            cg.issueid,
            ci.newstring as priority,
            cg.created,
            t2.display_name as author,
            t2.email_address as author_email
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
            ci.field = 'priority' ;;
    }

    dimension: issue_id {
      type: number
      hidden: yes
      sql: ${TABLE}.issueid ;;
    }

    dimension: priority {
      type: string
      label: "History Priority"
      sql: ${TABLE}.priority ;;
    }

    dimension: priority_date {
      type: date_time
      label: "History Priority Date"
      sql: ${TABLE}.created ;;
    }

    dimension: priority_author {
      type: string
      label: "History Priority Author"
      sql: ${TABLE}.author ;;
    }

    dimension: priority_author_email {
      type: string
      label: "History Priority Author Email"
      sql: ${TABLE}.author_email ;;
    }

  }
