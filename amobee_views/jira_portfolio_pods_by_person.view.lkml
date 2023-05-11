view: portfolio_pods_by_person {
  derived_table: {
    sql:
      SELECT
        res."PERSON_ID",
        string_agg(distinct plan."TITLE", ', ') AS pods,
        string_agg(distinct team."TITLE", ', ') AS teams
      FROM public."AO_82B313_RESOURCE"  AS res
      LEFT JOIN public."AO_82B313_TEAM"  AS team ON (res."TEAM_ID") = (team."ID")
      LEFT JOIN public."AO_D9132D_PLANTEAM"  AS plan_team ON (team."ID") = (plan_team."TEAM_ID")
      LEFT JOIN public."AO_D9132D_PLAN"  AS plan ON (plan_team."PLAN_ID") = (plan."ID")
      GROUP BY 1
    ;;
  }

  dimension: person_id {
    type: string
    hidden: yes
    sql: ${TABLE}."PERSON_ID" ;;
  }

  dimension: pods {
    type: string
    view_label: "Portfolio Project"
    label: "Assigned PODs"
    sql: ${TABLE}.pods ;;
  }

  dimension: teams {
    type: string
    view_label: "Portfolio Project"
    label: "Assigned POD Teams"
    sql: ${TABLE}.teams ;;
  }
}
