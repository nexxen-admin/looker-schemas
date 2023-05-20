view: tier_2_assignee {
  derived_table: {
    sql:  select
            au.user_key,
            t.display_name
          from
            public.app_user au
              join
              (
                select
                  cu.lower_user_name,
                  cu.display_name,
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

  dimension: assignee {
    type: string
    label: "Tier 2 Assignee"
    view_label: "Custom Fields"
    sql: ${TABLE}.display_name ;;
  }
}
