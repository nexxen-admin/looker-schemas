test: mssql_oltp_reference_test_placement {
  explore_source: placement {
    column: description { field: mssql_oltp_platform_client.description }
    column: partner_name { field: partner.partner_name }
    column: end_datetm_date { field: placement_payout_schedule.end_datetm_date }
    column: count {}
  }
  assert: assert_condition {
    expression: ${placement.count} >= 0 AND NOT is_null(${mssql_oltp_platform_client.description}) ;;
  }
}

test: mssql_oltp_reference_test_hourly_filler_placement_stats_details {
  explore_source: hourly_filler_placement_stats_details {
    column: fillers_served_last_24 {}
    column: partner_name { field: partner.partner_name }
    column: max_units_today { field: mssql_oltp_fm_pid_statistics.max_units_today }
    filters: {
      field: hourly_filler_placement_stats_details.keydate_date
      value: "2 days"
    }
  }
  assert: assert_condition {
    expression: ${hourly_filler_placement_stats_details.fillers_served_last_24} >= 0 AND NOT is_null(${partner.partner_name}) ;;
  }
}
