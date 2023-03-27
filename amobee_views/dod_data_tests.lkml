test: dod_test_dsp_media_and_bids {
  explore_source: dsp_media_and_bids {
    column: market_id {}
    column: impression {}
    column: count {}
    filters: {
      field: dsp_media_and_bids.__time_time
      value: "20 hours ago"
    }
  }
  assert: assert_condition {
    expression: ${dsp_media_and_bids.impression} >= 0 AND NOT is_null(${dsp_media_and_bids.market_id}) ;;
  }
}
