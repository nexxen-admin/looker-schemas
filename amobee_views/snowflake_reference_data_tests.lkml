test: snowflake_reference_test_campaign_details_base {
  explore_source: campaign_details_base {
    column: campaign_id {}
    column: campaign_name {}
    column: dst_begin_datetime_local_time {}
    column: max_cpu {}
    column: count_of_campaigns {}
    column: count {}
    column: plan_name {}
    column: plan_contracted_units { field: pl_plan_agg.plan_contracted_units }
    column: contracted_budget { field: flight_details.contracted_budget }
    column: sum_budget { field: flight_demand_units_budget.sum_budget }
  }
  assert: assert_condition {
    expression: NOT is_null(${campaign_details_base.campaign_id}) ;;
  }
}

test: snowflake_reference_test_placement_details_base {
  explore_source: placement_details_base {
    column: placement_id {}
    column: platform_client_id {}
    column: count_of_supply_platform_clients {}
    column: max_fallback_type_id {}
  }
  assert: assert_condition {
    expression: NOT is_null(${placement_details_base.placement_id}) ;;
  }
}
