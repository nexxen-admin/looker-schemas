view: opt_smart_kpi {
  sql_table_name: AN_SMART..kpi ;;
  dimension: kpi_id {
    description: "kpi_id"
    type: number
    sql: ${TABLE}.kpi_id ;;
    value_format_name: id
  }

  dimension: description {
    description: "description"
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: min_rev_dist_pct {
    description: "min_rev_dist_pct"
    type: number
    sql: ${TABLE}.min_rev_dist_pct ;;
  }

  dimension: max_rev_dist_pct {
    description: "max_rev_dist_pct"
    type: number
    sql: ${TABLE}.max_rev_dist_pct ;;
  }

  dimension: build_kpi_constraints {
    description: "build_kpi_constraints"
    type: number
    sql: ${TABLE}.build_kpi_constraints ;;
  }

  dimension: adv_objective_code {
    description: "adv_objective_code"
    type: string
    sql: ${TABLE}.adv_objective_code ;;
  }

  dimension: cpu_type_id {
    description: "cpu_type_id"
    type: number
    sql: ${TABLE}.cpu_type_id ;;
    value_format_name: id
  }

  dimension: is_per_thousand {
    description: "is_per_thousand"
    type: number
    sql: ${TABLE}.is_per_thousand ;;
  }

  dimension: is_tv {
    description: "is_tv"
    type: number
    sql: ${TABLE}.is_tv ;;
  }

  dimension: is_allocation_scenario {
    description: "is_allocation_scenario"
    type: number
    sql: ${TABLE}.is_allocation_scenario ;;
  }


}
