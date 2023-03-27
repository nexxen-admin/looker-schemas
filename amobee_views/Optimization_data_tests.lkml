test: Optimization_test_opt_misdelivery {
  explore_source: opt_misdelivery {
    column: impressions {}
    column: mean_allocation_share {}
    column: max_allocation {}
    column: campaign_name { field: opt_op_plan_fm_info.campaign_name }
    column: campaign_id {}
    filters: {
      field: opt_misdelivery.utc_date_date
      value: "2 days"
    }
  }
  assert: assert_condition {
    expression: ${opt_misdelivery.impressions} >= 0 AND NOT is_null(${opt_misdelivery.campaign_id}) ;;
  }
}
