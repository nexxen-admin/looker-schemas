view: issuecreator {
  derived_table: {
    sql:  select
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
            t.rn = 1 ;;
  }

  dimension: user_key {
    type: string
    hidden: yes
    sql: ${TABLE}.user_key ;;
  }

  dimension: creator {
    type: string
    label: "Creator"
    view_label: "Issue"
    sql: ${TABLE}.display_name ;;
  }

  dimension: creator_email {
    type: string
    label: "Creator Email"
    view_label: "Issue"
    sql: ${TABLE}.email_address ;;
  }

}
