test: real_time_delivery_test_flight_media_statistics {
  explore_source: flight_media_statistics {
    column: sum_units_today {}
    column: lastimp_datetm {}
    column: count_of_placements { field: aur_placement_details.count_of_placements }
    column: campaign_status { field: aur_campaign_details.campaign_status }
  }
  assert: assert_condition {
    expression: ${flight_media_statistics.sum_units_today} >= 0 AND NOT is_null(${flight_media_statistics.sum_units_today}) ;;
  }
}
