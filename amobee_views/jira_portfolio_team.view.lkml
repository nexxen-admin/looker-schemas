view: portfolio_team {
    sql_table_name: public."AO_82B313_TEAM" ;;

    dimension: id {
      primary_key: yes
      type: number
      hidden: yes
      sql: ${TABLE}."ID" ;;
    }

    dimension: team {
      type: string
      label: "Assigned POD Team"
      view_label: "Portfolio Project"
      sql: ${TABLE}."TITLE" ;;
    }

    dimension: atv_team {
      type: string
      label: "Assigned ATV Capacity Team"
      view_label: "Portfolio Project"
      sql: CASE WHEN ${portfolio_plan.program_id} = 20 THEN ${team}
        ELSE null END;;
    }
}
