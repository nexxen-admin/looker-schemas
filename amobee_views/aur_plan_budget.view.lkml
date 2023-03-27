view: aur_plan_budget {

  derived_table: {
    sql: SELECT c.pl_plan_id AS PLAN_ID
              ,sum(c.campaign_units) as PLAN_UNITS
              ,sum(c.campaign_budget) as PLAN_BUDGET
      FROM dim.campaign_details c
      GROUP BY c.pl_plan_id ;;
  }

  dimension: plan_id {
    type: number
    hidden: yes
    sql: ${TABLE}.PLAN_ID ;;
  }

  dimension: plan_units {
    type: number
    label: "Plan Units"
    view_label: "Plan"
    description: "Total Units reserved for the Plan."
    sql: ${TABLE}.PLAN_UNITS ;;
  }

  dimension: plan_budget {
    type: number
    label: "Plan Budget"
    view_label: "Plan"
    description: "Total Budget reserved for the Plan."
    value_format_name: decimal_2
    sql: ${TABLE}.PLAN_BUDGET ;;
  }



}
