test: videology_test_hourly_analytics {
  explore_source: hourly_analytics {
    column: sum_impressions {}
    column: sum_bt_cost_markup { field: bt_cost_attributes.sum_bt_cost_markup }
    column: dst_begin_datetm { field: flight_media_details_base.dst_begin_datetm }
    column: flight_id { field: flight_details.flight_id }
    column: campaign_id { field: campaign_details_base.campaign_id }
    column: Campaign_total_days { field: campaign_days.Campaign_total_days }
    column: advertiser_id { field: advertiser_brand_details.advertiser_id }
    column: advertiser_brand_id { field: advertiser_brand_details.advertiser_brand_id }
    column: insertion_order_id { field: insertion_order_details.insertion_order_id }
    column: customer_name { field: customer_details.customer_name }
    column: country_description { field: customer_country.country_description }
    column: placement_name { field: placement_details_base.placement_name }
    column: description { field: bt_data_provider_core.description }
    column: description { field: bt_cluster_provider_core.description }
    column: business_region { field: platform_client.business_region }
    column: description { field: demo_provider.description }
    column: retargeting_attribute_id { field: retargeting_attribute.retargeting_attribute_id }
    filters: {
      field: hourly_analytics.raw_demand_date
      value: "8 hours ago"
    }
  }
  assert: assert_condition {
    expression: ${hourly_analytics.sum_impressions} >= 0 ;;
  }
}

test: videology_test_hourly_analytics_distinct_date {
  explore_source: hourly_analytics {
    column: sum_impressions {}
    column: count_distinct_demand_date {}
    filters: {
      field: hourly_analytics.raw_demand_date
      value: "28 hours ago"
    }
  }
  assert: assert_condition {
    expression: ${hourly_analytics.count_distinct_demand_date} = 1 ;;
  }
}

test: videology_test_hourly_analytics_aggregations {
  explore_source: hourly_analytics {
    column: sum_impressions {}
    column: avg_impressions {}
    column: min_impressions {}
    column: max_impressions {}
    filters: {
      field: hourly_analytics.raw_demand_date
      value: "28 hours ago"
    }
  }
  assert: assert_condition {
    expression: ${hourly_analytics.sum_impressions} >= 0 AND ${hourly_analytics.avg_impressions} >= 0 AND ${hourly_analytics.min_impressions} >= 0 AND ${hourly_analytics.max_impressions} >= 0 ;;
  }
}

test: videology_test_hourly_analytics_wopr_only {
  explore_source: hourly_analytics_wopr_only {
    column: sum_impressions { field: hourly_analytics.sum_impressions }
    column: sum_bt_cost_markup { field: bt_cost_attributes.sum_bt_cost_markup }
    column: dst_begin_datetm { field: flight_media_details_base.dst_begin_datetm }
    column: flight_id { field: flight_details.flight_id }
    column: campaign_id { field: campaign_details_base.campaign_id }
    column: Campaign_total_days { field: campaign_days.Campaign_total_days }
    column: advertiser_id { field: advertiser_brand_details.advertiser_id }
    column: advertiser_brand_id { field: advertiser_brand_details.advertiser_brand_id }
    column: insertion_order_id { field: insertion_order_details.insertion_order_id }
    column: customer_name { field: customer_details.customer_name }
    column: country_description { field: customer_country.country_description }
    column: placement_name { field: placement_details_base.placement_name }
    column: description { field: bt_data_provider_core.description }
    column: description { field: bt_cluster_provider_core.description }
    column: business_region { field: platform_client.business_region }
    column: description { field: demo_provider.description }
    column: retargeting_attribute_id { field: retargeting_attribute.retargeting_attribute_id }
    filters: {
      field: hourly_analytics.raw_demand_date
      value: "8 hours ago"
    }
  }
  assert: assert_condition {
    expression: ${hourly_analytics.sum_impressions} >= 0 ;;
  }
}

test: videology_test_raw_impression {
  explore_source: raw_impression {
    column: sum_impressions {}
    column: sum_bt_cost_markup { field: bt_cost_attributes.sum_bt_cost_markup }
    column: campaign_name { field: campaign_details_base.campaign_name }
    column: platform_client_description { field: platform_client.platform_client_description }
    column: platform_client { field: placement_details_base.platform_client }
    column: sum_of_violations { field: brand_frequency_cap_violations.sum_of_violations }
    filters: {
      field: raw_impression.epoch_raw_date
      value: "8 hours ago"
    }
  }
  assert: assert_condition {
    expression: ${raw_impression.sum_impressions} >= 0 ;;
  }
}

test: videology_test_portfolio_trends {
  explore_source: portfolio_trends {
    column: pct_abc_ccp {}
    column: platform_client_description { field: platform_client.platform_client_description }
    column: advertiser_name { field: advertiser_brand_details.advertiser_name }
    column: count_of_insertion_orders { field: insertion_order_details.count_of_insertion_orders }
    column: customer_name { field: customer_details.customer_name }
    filters: {
      field: portfolio_trends.reportyear
      value: "2022"
    }
    filters: {
      field: portfolio_trends.reportmonth
      value: "04"
    }
  }
  assert: assert_condition {
    expression: ${insertion_order_details.count_of_insertion_orders} >= 0 ;;
  }
}
