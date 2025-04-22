view: v_pl_plan_agg {
  label: "Plan"
  derived_table: {
    sql: SELECT c.pl_plan_id
                ,sum(coalesce(f.contracted_units,0)) as contracted_units
         FROM DIM.FLIGHT_DETAILS_VIEW f
          JOIN DIM.CAMPAIGN_DETAILS_BASE_VIEW c
           ON f.campaign_id = c.campaign_id and f.flight_active = 1
         GROUP BY c.pl_plan_id ;;
  }

  dimension: pl_plan_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.PL_PLAN_ID ;;
  }

  measure: plan_contracted_units {
    type: sum
    label: "Plan Contracted Units"
    sql: ${TABLE}.CONTRACTED_UNITS ;;
  }
}
