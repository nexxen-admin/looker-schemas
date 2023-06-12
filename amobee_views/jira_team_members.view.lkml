view: team_members {
  derived_table: {
    sql:  select
            au.user_key,
            t.display_name,
            t.email_address,
            t.active
          from
            public.app_user au
              join
              (
                select
                  cu.lower_user_name,
                  cu.display_name,
                  cu.email_address,
                  cu.active,
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

  dimension: member {
    type: string
    label: "Member"
    view_label: "Team Members"
    sql: ${TABLE}.display_name ;;
  }

  dimension: assignee_email {
    type: string
    label: "Member Email"
    view_label: "Team Members"
    sql: ${TABLE}.email_address ;;
  }

  dimension: is_active {
    type: string
    label: "Member is active"
    view_label: "Team Members"
    sql:  CASE WHEN ${TABLE}.active = 1  THEN 'Yes'
          WHEN ${TABLE}.active = 0 THEN 'No'
          ELSE null END ;;
  }
}
