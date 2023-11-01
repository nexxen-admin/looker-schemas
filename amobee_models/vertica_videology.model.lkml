connection: "amobee_prod"
label: "Delivery"
# include all the views
include: "/**/vertica_views/*.view.lkml"
case_sensitive: no

# include all the dashboards
#include: "*.dashboard"

access_grant: can_use_explore { user_attribute: is_itv_user allowed_values: ["no"] }



explore: v_hourly_analytics {

  view_name: v_hourly_analytics
  label: "Vertica Request and Impression Metrics"
  description: "This explore includes both impression and request metrics. This data can be analyzed by the core supply and demand dimensions,
  as well as supplemental facets such as daypart, demographics, domains and geo. This data is available by-day as far back as July 2017
  and by-hour for the last seven days."
  sql_always_where: ({% if _user_attributes['access_filter_office_id'] == '>=0, NULL' %} TRUE {% else %} (${v_platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }}) OR ${v_supply_platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }})) {% endif %}) AND
                    ({% if _user_attributes['access_filter_platform_client_id'] == '>=0, NULL' %} TRUE {% else %} (${v_campaign_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${v_placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${v_platform_client.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) {% endif %}) AND
                    ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} ( ${v_campaign_details_base.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) AND ( ${v_placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;

  fields: [ALL_FIELDS*, -v_hourly_analytics.sum_floor_price,-v_hourly_analytics.sum_revenue,
    -v_flight_media_details_base.demoaud, -v_hourly_analytics.sum_unserved_requests,
    -v_advertiser_brand_details.future_advertisers, -v_customer_details.future_customers]

  join: v_bt_cost_attributes_hourly_analytics {
    view_label: "Request and Impression Metrics"
    relationship: one_to_many
    sql_on: ${v_bt_cost_attributes_hourly_analytics.pk_id} = ${v_hourly_analytics.pk_id} and ${v_hourly_analytics.source} = ${v_bt_cost_attributes_hourly_analytics.source};;
  }

  join: v_load_tracking {
    relationship: many_to_one
    sql_on: ${v_load_tracking.schema_name} = 'RAWDB' and ${v_load_tracking.table_name} = 'HOURLY_ANALYTICS' ;;
  }

  join: v_flight_media_details_base {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.flight_media_id} = ${v_hourly_analytics.flight_media} ;;
  }

  join: v_demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_demand_mart_load_tracking.start_timezone}  ;;
  }

  join: v_flight_details {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.flight_id} = ${v_flight_details.flight_id} ;;
  }

  join: v_campaign_details_base {
    relationship: many_to_one
    sql_on: ${v_flight_details.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
  }

  join: v_campaign_days {
    relationship: many_to_one
    sql_on: ${v_flight_details.campaign_id} = ${v_campaign_days.campaign_id} ;;
  }

  join: v_advertiser_brand_details {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.advertiser_brand_id} = ${v_advertiser_brand_details.advertiser_brand_id} ;;
  }

  join:  v_insertion_order_details {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.insertion_order_id} = ${v_insertion_order_details.insertion_order_id};;
  }

  join: v_customer_details {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.customer_id} = ${v_customer_details.customer_id} ;;
  }

  join: v_customer_country {
    relationship: many_to_one
    sql_on: ${v_customer_details.country_id} = ${v_customer_country.country_id} ;;
  }


  join:  v_account_exec {
    relationship: many_to_one
    sql_on: ${v_insertion_order_details.account_rep} = ${v_account_exec.id} ;;
  }

  join: v_placement_details_base {
    relationship: many_to_one
    sql_on: ${v_placement_details_base.placement_id} = ${v_hourly_analytics.placement_id} ;;
  }

  join: v_placement_timezone {
    relationship: many_to_one
    sql_on: ${v_placement_details_base.placement_timezone_id} = ${v_placement_timezone.timezone_id} ;;
  }

  join: v_bt_data_provider_core {
    relationship: many_to_one
    sql_on: ${v_bt_cost_attributes_hourly_analytics.bt_provider} = ${v_bt_data_provider_core.user_data_vendor_id}  ;;
  }

  join: v_bt_cluster_provider_core {
    relationship: many_to_one
    sql_on: ${v_hourly_analytics.bt_cluster_provider} = ${v_bt_cluster_provider_core.user_data_vendor_id} ;;
  }

  join: v_platform_client {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.platform_client_id} = ${v_platform_client.platform_client_id} ;;
  }

  join: v_supply_platform_client {
    from: v_platform_client
    relationship: many_to_one
    sql_on: ${v_placement_details_base.platform_client_id} = ${v_supply_platform_client.platform_client_id} ;;
    view_label: "Supply Platform Client"
    fields: [business_region, office_name, platform_client_active]
  }

  join: v_timezone {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_timezone.timezone_id} ;;
  }

  join: v_demo_provider {
    relationship: many_to_one
    sql_on: ${v_hourly_analytics.demo_provider} = ${v_demo_provider.user_data_vendor_id} ;;
  }

  join: v_daypart {
    relationship: many_to_many
    sql_on: ${v_hourly_analytics.daypart_id} = ${v_daypart.hour_daypart_id} ;;
  }

  join: v_retargeting_attribute {
    relationship: many_to_one
    sql_on: ${v_bt_cost_attributes_hourly_analytics.bt_cost_attribute} = ${v_retargeting_attribute.retargeting_attribute_id}  ;;
  }

  join: v_hourly_analytics_derived {
    view_label: "Relative changes"
    relationship: many_to_one
    sql_on: ${v_hourly_analytics.demand_date_date} = TO_CHAR(TIMESTAMPADD(DAY, 1, TO_TIMESTAMP(${v_hourly_analytics_derived.demand_date})), 'YYYY-MM-DD') ;;
  }

  join: v_plan_currency {
    relationship: many_to_one
    sql_on: ${v_placement_details_base.preferred_currency_id} = ${v_plan_currency.currency_id} ;;
    fields: []
  }

  join: v_attribute_lookup_platformid{
    relationship: many_to_one
    sql_on: ${v_attribute_lookup_platformid.attr_id} = ${v_hourly_analytics.platformid} ;;
  }

  join: v_attribute_lookup_browserid{
    relationship: many_to_one
    sql_on: ${v_attribute_lookup_browserid.attr_id} = ${v_hourly_analytics.browserid} ;;

  }
  join: v_attribute_lookup_deviceid{
    relationship: many_to_one
    sql_on: ${v_attribute_lookup_deviceid.attr_id} =  ${v_hourly_analytics.deviceid} ;;

  }

}


explore: v_hourly_analytics_wopr_only {
  label: "Vertica Request and Impression Metrics (for WOPR only)"
  required_access_grants: [can_use_explore]
  extends: [v_hourly_analytics]
  fields: [ALL_FIELDS*, -v_advertiser_brand_details.future_advertisers, -v_customer_details.future_customers]
}


explore: v_hourly_logging_audit {

  label: "Vertica Logging Audit"
  hidden: yes

  join: v_flight_media_details_base {
    relationship: many_to_one
    sql_on: ${v_hourly_logging_audit.flight_media_id} = ${v_flight_media_details_base.flight_media_id} ;;
  }

  join: v_timezone {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_timezone.timezone_id} ;;
    fields: []
  }

  join: v_campaign_details_base {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.campaign_id} ;;
    fields: []
  }

  join: v_platform_client {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.platform_client_id} = ${v_platform_client.platform_client_id} ;;
    fields: []
  }
}


explore: v_domain_spreader {

  label: "Vertica Domain Spreader"
  description: "This explore is used to monitor the percent of impressions served to any single domain URL, per campaign."
  hidden: yes
  fields: [ALL_FIELDS*, -v_campaign_details_base.campaign_name_custom,-v_campaign_details_base.agency_fee]

  join: v_campaign_details_base {
    relationship: many_to_one
    sql_on: ${v_domain_spreader.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
  }

  join: v_timezone {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.timezone_id} = ${v_timezone.timezone_id} ;;
    fields: []
  }

  join: v_platform_client {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.platform_client_id} = ${v_platform_client.platform_client_id} ;;
    fields: []
  }
}


# explore: v_frequency_by_tier {


#   label: "Frequency By Tier"
#   hidden: yes
#   description: "Campaign or Plan To-Date Delivery Statistics by Frequency Tier. This Explore allows you to view delivery statistics bucketed into frequencies
#   that campaigns or plans were viewed. Frequencies are limited to [1-7], meaning delivery statistics are only included for users who saw campaigns and plans
#   between 1 and 7 times."

#   join: campaign_details_base {
#     relationship: many_to_one
#     fields: [v_campaign_details_base.campaign_name,v_campaign_details_base.plan_name, v_campaign_details_base.platform_client_description]
#     sql_on:{% if sno_frequency_by_tier.campaign_id._in_query %} ${sno_frequency_by_tier.campaign_id} = ${v_campaign_details_base.campaign_id}
#       {% elsif sno_frequency_by_tier.plan_id._in_query %} ${sno_frequency_by_tier.plan_id} = ${v_campaign_details_base.pl_plan_id} {% endif %} ;;
#   }

# }


# explore: v_daily_bt_acquisition {
#   required_access_grants: [can_use_explore]
#   label: "BT Acquisition"
#   description: "Information on the data points we acquired for a segment. This is based on data sent to us by third party vendors and is independent from request information.  This data is available by-day, as far back as October 2009."
#   fields: [ALL_FIELDS*, -v_advertiser_brand_details.future_advertisers, -v_customer_details.future_customers]

#   join: retargeting_attribute {
#     relationship: many_to_one
#     sql_on: ${v_daily_bt_acquisition.retargeting_attribute_id} = ${v_retargeting_attribute.retargeting_attribute_id} ;;
#   }

#   join: v_data_vendor_operation {
#     relationship: many_to_one
#     sql_on: ${v_daily_bt_acquisition.operation} = ${v_data_vendor_operation.operation_id} ;;
#   }

#   join: v_user_id_type {
#     relationship: many_to_one
#     sql_on: ${v_daily_bt_acquisition.id_type} = ${v_user_id_type.user_id_type} ;;
#   }

#   join: v_campaign_target {
#     relationship: one_to_many
#     sql_on: ${v_retargeting_attribute.retargeting_attribute_id} = ${v_campaign_target.attribute_value_id} ;;
#   }

#   join: v_campaign_details_base {
#     relationship: many_to_one
#     sql_on: ${v_campaign_target.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
#   }

#   join: v_flight_media_details_base {
#     relationship: one_to_many
#     sql_on: ${v_campaign_details_base.campaign_id} = ${v_flight_media_details_base.campaign_id} ;;
#   }

#   join: v_advertiser_brand_details {
#     relationship: many_to_one
#     sql_on: ${v_campaign_details_base.advertiser_brand_id} = ${v_advertiser_brand_details.advertiser_brand_id} ;;
#   }

#   join: v_customer_details {
#     relationship: many_to_one
#     sql_on: ${v_campaign_details_base.customer_id} = ${v_customer_details.customer_id} ;;
#   }

#   join: v_timezone {
#     relationship: many_to_one
#     sql_on: ${v_campaign_details_base.timezone_id} = ${v_timezone.timezone_id} ;;
#     fields: []
#   }

#   join: v_platform_client {
#     relationship: many_to_one
#     sql_on: ${v_campaign_details_base.platform_client_id} = ${v_platform_client.platform_client_id} ;;
#     fields: []
#   }
# }


# explore: v_retargeting_attribute {
#   required_access_grants: [can_use_explore]
#   label: "Segments and Reach/Cookies"
#   description: "This Explore is used to pull segments with no uniques."
#   fields: [ALL_FIELDS*, -v_retargeting_attribute.dst_createdon_date, -v_retargeting_attribute.dst_createdon_time,
#     -v_retargeting_attribute.dst_createdon_week, -v_retargeting_attribute.dst_createdon_month,
#     -v_retargeting_attribute.dst_createdon_quarter,  -v_retargeting_attribute.dst_createdon_year,
#     -v_retargeting_attribute.dst_createdon_raw]

#   join: v_daily_bt_acquisition {
#     relationship: one_to_many
#     sql_on: ${v_daily_bt_acquisition.retargeting_attribute_id} = ${v_retargeting_attribute.retargeting_attribute_id} ;;
#   }

#   join: v_attribute_value_metrics {
#     relationship: one_to_many
#     sql_on: ${v_retargeting_attribute.retargeting_attribute_id} = ${v_attribute_value_metrics.attribute_value_id}
#       AND ${v_attribute_value_metrics.attribute_id} = 20 ;;
#   }

#   join: v_attribute_value_metrics_country {
#     relationship: many_to_one
#     sql_on: ${v_attribute_value_metrics.country_id} = ${v_attribute_value_metrics_country.country_id};;
#   }
# }



explore: v_daily_core_stats {

  label: "Vertica Impression Metrics"
  description: "This explore includes impression metrics along with the demand and supply dimensions they can be aggregated by.
  Data is available by-day, as far back as November 2015.  You will only find demand which has had delivery, campaigns which have yet to have
  any impressions delivered will not appear in this explore."
  sql_always_where: ({% if v_daily_core_stats.demand_date._in_query or v_daily_core_stats.demand_week._in_query %}COALESCE(${v_daily_core_stats.demand_raw}, '9999-12-31') >= (SELECT MIN(DEMAND_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% elsif v_daily_core_stats.EST_date._in_query or v_daily_core_stats.EST_week._in_query %}COALESCE(${v_daily_core_stats.EST_raw}, '9999-12-31') >= (SELECT MIN(EST_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% elsif v_daily_core_stats.gmt_date._in_query or v_daily_core_stats.gmt_week._in_query %}COALESCE(${v_daily_core_stats.gmt_raw}, '9999-12-31') >= (SELECT MIN(GMT_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% elsif v_daily_core_stats.region_date._in_query or v_daily_core_stats.region_week._in_query %}COALESCE(${v_daily_core_stats.region_raw}, '9999-12-31') >= (SELECT MIN(REGION_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% else %}TRUE{% endif %}) AND
                      ({% if _user_attributes['access_filter_office_id'] == '>=0, NULL' %} TRUE {% else %} (${v_platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }}) OR ${v_supply_platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }})) {% endif %}) AND
                      ({% if _user_attributes['access_filter_platform_client_id'] == '>=0, NULL' %} TRUE {% else %} (${v_campaign_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${v_placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${v_platform_client.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) {% endif %}) AND
                      ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} ( ${v_campaign_details_base.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) AND ( ${v_placement_details_base.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;

  join: v_flight_media_details_base {
    relationship: many_to_one
    sql: {% if v_flight_media_details_base.future_flight_media._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.FLIGHT_MEDIA_DETAILS_BASE_VIEW  AS v_flight_media_details_base ON ${v_flight_media_details_base.flight_media_id} = ${v_daily_core_stats.flight_media_id} ;;
  }

  join: v_deal_flight_media_details {
    fields: [
      v_deal_flight_media_details.external_buyer_media_id,
      v_deal_flight_media_details.seller_customer_name,
      v_deal_flight_media_details.seller_advertiser_name,
      v_deal_flight_media_details.seller_brand_name]
    relationship: one_to_one
    sql_on: ${v_flight_media_details_base.flight_media_id} = ${v_deal_flight_media_details.seller_flight_media_id};;
  }

  join: v_demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_demand_mart_load_tracking.start_timezone} ;;
  }

  join: v_demand_mart_load_tracking_start_timezone {
    relationship: many_to_one
    sql_on: ${v_demand_mart_load_tracking.start_timezone} = ${v_demand_mart_load_tracking_start_timezone.timezone_id} ;;
  }

  join: v_flight_details {
    sql: {% if v_flight_details.future_flights._in_query %}FULL OUTER JOIN DIM.FLIGHT_DETAILS_VIEW AS v_flight_details ON ${v_flight_media_details_base.flight_id} = ${v_flight_details.flight_id}
      {% else %}LEFT JOIN DIM.FLIGHT_DETAILS_VIEW AS v_flight_details ON ${v_flight_media_details_base.flight_id} = ${v_flight_details.flight_id} {% endif %} ;;
    relationship: many_to_one
  }

  join: v_flight_demand_units_budget{
    relationship: many_to_one
    sql_on: ${v_flight_demand_units_budget.flight_id} = ${v_flight_details.flight_id}
      and ${v_flight_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: v_campaign_details_base {
    relationship: many_to_one
    sql_on: ${v_flight_details.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
  }

  join: v_expected_delivery {
    relationship: one_to_many
    sql_on: {% if v_flight_details.flight_id._in_query or v_flight_details.flight_description._in_query or v_flight_media_details_base.flight_description._in_query %} ${v_flight_details.flight_id} = ${v_expected_delivery.flight_id}
      {% else %} ${v_campaign_details_base.campaign_id} = ${v_expected_delivery.campaign_id}  {% endif %} ;;
  }

  join: v_timezone {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_timezone.timezone_id} ;;
  }

  join: v_pl_plan {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.pl_plan_id} = ${v_pl_plan.pl_plan_id};;
  }

  join: v_campaign_days {
    relationship: many_to_one
    sql_on: ${v_flight_details.campaign_id} = ${v_campaign_days.campaign_id} ;;
  }

  join: v_campaign_objectives {
    relationship: one_to_one
    sql_on: ${v_campaign_objectives.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
  }

  join: v_campaign_demand_units_budget{
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.campaign_id} = ${v_campaign_demand_units_budget.campaign_id}
          and ${v_campaign_demand_units_budget.flight_id} IS NULL
          and ${v_campaign_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: v_required_delivery_today {
    relationship: many_to_one
    sql_on: ${v_daily_core_stats.flight_media_id} = ${v_required_delivery_today.flight_media_id} ;;
  }

  join: v_customer_details {
    relationship: many_to_one
    sql: {% if v_customer_details.future_customers._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.CUSTOMER_DETAILS_VIEW  AS v_customer_details ON ${v_campaign_details_base.customer_id} = ${v_customer_details.customer_id} ;;
  }

  join: v_customer_country {
    relationship: many_to_one
    sql_on: ${v_customer_details.country_id} = ${v_customer_country.country_id} ;;
  }

  join: v_advertiser_brand_details {
    relationship: many_to_one
    sql: {% if v_advertiser_brand_details.future_advertisers._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.ADVERTISER_BRAND_DETAILS_VIEW  AS v_advertiser_brand_details ON ${v_campaign_details_base.advertiser_brand_id} = ${v_advertiser_brand_details.advertiser_brand_id} ;;
  }

  join:  v_insertion_order_details {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.insertion_order_id} = ${v_insertion_order_details.insertion_order_id};;
  }

  join:  v_account_exec {
    relationship: many_to_one
    sql_on: ${v_insertion_order_details.account_rep} = ${v_account_exec.id} ;;
  }

  join: v_placement_details_base {
    relationship: many_to_one
    sql_on: ${v_placement_details_base.placement_id} = ${v_daily_core_stats.placement_id} ;;
  }

  join: v_platform_client {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.platform_client_id} = ${v_platform_client.platform_client_id} ;;
  }

  join: v_supply_platform_client {
    from: v_platform_client
    relationship: many_to_one
    sql_on: ${v_placement_details_base.platform_client_id} = ${v_supply_platform_client.platform_client_id} ;;
    view_label: "Supply Platform Client"
    fields: [business_region, office_name, platform_client_active]
  }

  join: v_reach_and_frequency {
    relationship: many_to_one
    sql_on: ${v_reach_and_frequency.flight_media_id} = ${v_daily_core_stats.flight_media_id}
      AND ${v_reach_and_frequency.placement_id} = ${v_daily_core_stats.placement_id}
      AND ${v_reach_and_frequency.demand_date} = ${v_daily_core_stats.demand_raw} ;;
  }

  join: v_daily_core_stats_yesterday {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.flight_media_id} = ${v_daily_core_stats_yesterday.flight_media_id}
      {% if v_placement_details_base._in_query %} AND v_placement_details_base.placement_id = ${v_daily_core_stats_yesterday.placement_id} {% endif %} ;;
  }

  join: v_insertion_order_demand_units_budget {
    relationship: many_to_one
    sql_on: ${v_insertion_order_demand_units_budget.insertion_order_id} = ${v_insertion_order_details.insertion_order_id}
          and ${v_insertion_order_demand_units_budget.pl_plan_id} IS NULL
          and ${v_insertion_order_demand_units_budget.campaign_id} IS NULL
          and ${v_insertion_order_demand_units_budget.flight_id} IS NULL
          and ${v_insertion_order_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: v_campaign_addon_product {
    relationship: one_to_many
    sql_on: ${v_campaign_addon_product.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
  }

  join: v_campaign_product{
    relationship: one_to_one
    fields: []
    sql_on: ${v_campaign_product.product_id}  = ${v_campaign_addon_product.product_id};;
  }

  join: v_campaign_product_exchange_rates {
    from: v_hourly_exchange_rates
    relationship: many_to_one
    fields: []
    sql_on: ${v_platform_client.default_currency_id} = ${v_campaign_product_exchange_rates.currency_id_to}
          and ${v_campaign_product_exchange_rates.currency_id_from} = ${v_campaign_product.currency_id}
          and ${v_campaign_product_exchange_rates.key_date_raw} = current_date ;;
  }

  join: v_campaign_target_description {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.campaign_id} = ${v_campaign_target_description.campaign_id};;
  }

  join: v_campaign_pacing_by_day {
    view_label: "Impression Metrics"
    relationship: many_to_one
    sql_on: ${v_daily_core_stats.demand_raw} = ${v_campaign_pacing_by_day.demand_date}
      and ${v_campaign_details_base.campaign_id} = ${v_campaign_pacing_by_day.campaign_id} ;;
  }

  join: v_trafficked_flights {
    relationship: one_to_one
    type: inner
    sql_on: ${v_flight_details.flight_id} = ${v_trafficked_flights.flight_id} ;;
  }

  join: v_plan_currency {
    relationship: one_to_one
    sql_on: ${v_plan_currency.currency_id} = ${v_pl_plan.native_currency_id} ;;
  }

  join: v_campaign_postalcode {
    relationship: one_to_many
    sql_on: ${v_campaign_details_base.campaign_id} = ${v_campaign_postalcode.campaign_id} ;;
  }

  join: v_pl_plan_agg {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.pl_plan_id} = ${v_pl_plan_agg.pl_plan_id} ;;
  }

  join: v_campaign_geolocation {
    relationship: one_to_one
    sql_on: ${v_campaign_details_base.campaign_id} = ${v_campaign_geolocation.campaign_id} ;;
  }

}


explore: v_daily_data_usage {

  label: "Vertica Data Usage Metrics"
  description: "This explore includes data provider cost and usage metrics. Cost and usage metrics are recorded when data on a user is used to deliver an impression.
  Cost and usage are commonly segmented down to source provider, data provider, payee provider and retargeting attribute. The data is available by-day, as far back as January 2014."
  sql_always_where: ({% if v_daily_data_usage.demand_date_date._in_query or v_daily_data_usage.demand_date_week._in_query %}COALESCE(${v_daily_data_usage.demand_date_raw}, '9999-12-31') >= (SELECT MIN(DEMAND_DATE) FROM RAWDB.daily_data_usage)
                    {% elsif v_daily_data_usage.EST_date_date._in_query or v_daily_data_usage.EST_date_week._in_query %}COALESCE(${v_daily_data_usage.est_date_raw}, '9999-12-31') >= (SELECT MIN(EST_DATE) FROM RAWDB.daily_data_usage)
                    {% elsif v_daily_data_usage.gmt_date_date._in_query or v_daily_data_usage.gmt_date_week._in_query %}COALESCE(${v_daily_data_usage.gmt_date_raw}, '9999-12-31') >= (SELECT MIN(GMT_DATE) FROM RAWDB.daily_data_usage)
                    {% elsif v_daily_data_usage.region_date_date._in_query or v_daily_data_usage.region_date_week._in_query %}COALESCE(${v_daily_data_usage.region_date_raw}, '9999-12-31') >= (SELECT MIN(REGION_DATE) FROM RAWDB.daily_data_usage)
                    {% else %}TRUE{% endif %}) AND
                    ({% if _user_attributes['access_filter_office_id'] == '>=0, NULL' %} TRUE {% else %} (${v_platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }}) OR ${v_supply_platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }})) {% endif %}) AND
                    ({% if _user_attributes['access_filter_platform_client_id'] == '>=0, NULL' %} TRUE {% else %} (${v_campaign_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${v_placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${v_platform_client.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) {% endif %}) AND
                    ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} ( ${v_campaign_details_base.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) AND ( ${v_placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;
  fields: [ALL_FIELDS*, -v_advertiser_brand_details.future_advertisers, -v_customer_details.future_customers]

  join: v_flight_media_details_base {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.flight_media_id} = ${v_daily_data_usage.flight_media_id} ;;
  }

  join: v_demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_demand_mart_load_tracking.start_timezone}  ;;
  }

  join: v_flight_details {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.flight_id} = ${v_flight_details.flight_id} ;;
  }

  join: v_campaign_details_base {
    relationship: many_to_one
    sql_on: ${v_flight_details.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
  }

  join: v_timezone {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_timezone.timezone_id} ;;
  }

  join: v_campaign_days {
    relationship: many_to_one
    sql_on: ${v_flight_details.campaign_id} = ${v_campaign_days.campaign_id} ;;
  }

  join: v_customer_details {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.customer_id} = ${v_customer_details.customer_id} ;;
  }

  join: v_customer_country {
    relationship: many_to_one
    sql_on: ${v_customer_details.country_id} = ${v_customer_country.country_id} ;;
  }


  join: v_advertiser_brand_details {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.advertiser_brand_id} = ${v_advertiser_brand_details.advertiser_brand_id} ;;
  }

  join:  v_insertion_order_details {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.insertion_order_id} = ${v_insertion_order_details.insertion_order_id};;
  }

  join: v_placement_details_base {
    relationship: many_to_one
    sql_on: ${v_placement_details_base.placement_id} = ${v_daily_data_usage.placement_id} ;;
  }

  join: v_demo_provider {
    relationship: many_to_one
    sql_on: ${v_demo_provider.user_data_vendor_id} = ${v_daily_data_usage.data_provider_id}
      and ${v_daily_data_usage.data_cost_type} = 2;;
  }

  join: v_retargeting_attribute {
    relationship: many_to_one
    sql_on: ${v_daily_data_usage.cost_attribute_id} = ${v_retargeting_attribute.retargeting_attribute_id} ;;
  }

  join: v_user_data_vendor {
    relationship: many_to_one
    sql_on: ${v_daily_data_usage.data_provider_id} = ${v_user_data_vendor.user_data_vendor_id} ;;
  }

  join: v_platform_client {
    relationship: many_to_one
    sql_on: ${v_platform_client.platform_client_id} = ${v_campaign_details_base.platform_client_id} ;;
  }

  join: v_supply_platform_client {
    from: v_platform_client
    relationship: many_to_one
    sql_on: ${v_placement_details_base.platform_client_id} = ${v_supply_platform_client.platform_client_id} ;;
    view_label: "Supply Platform Client"
    fields: [business_region, office_name, platform_client_active]
  }
}



explore: v_demand_metrics {

  view_name: v_daily_core_stats
  label: "Vertica Demand Metrics"
  description: "This explore includes impression metrics along with the demand dimensions they can be aggregated by. Additional demand metrics such as CCP and allocation,
  and the absence of supply dimensions differentiate this from the 'Impression Metrics' explore. Data is available by-day, as far back as November 2015.
  You will only find demand which has had delivery, campaigns which have yet to have
  any impressions delivered will not appear in this explore."
  access_filter: {
    field: v_platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: v_campaign_details_base.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if v_daily_core_stats.demand_date._in_query or v_daily_core_stats.demand_week._in_query %}COALESCE(${v_daily_core_stats.demand_raw}, '9999-12-31') >= (SELECT MIN(DEMAND_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% elsif v_daily_core_stats.EST_date._in_query or v_daily_core_stats.EST_week._in_query %}COALESCE(${v_daily_core_stats.EST_raw}, '9999-12-31') >= (SELECT MIN(EST_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% elsif v_daily_core_stats.gmt_date._in_query or v_daily_core_stats.gmt_week._in_query %}COALESCE(${v_daily_core_stats.gmt_raw}, '9999-12-31') >= (SELECT MIN(GMT_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% elsif v_daily_core_stats.region_date._in_query or v_daily_core_stats.region_week._in_query %}COALESCE(${v_daily_core_stats.region_raw}, '9999-12-31') >= (SELECT MIN(REGION_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% else %}TRUE{% endif %}) AND
                      ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} (${v_campaign_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) AND (${v_platform_client.platform_client_id} IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;
  join: v_daily_core_stats_yesterday_demand {
    relationship: many_to_one
    sql_on: ${v_daily_core_stats.flight_media_id} = ${v_daily_core_stats_yesterday_demand.flight_media_id}
      and ${v_daily_core_stats.placement_id} = ${v_daily_core_stats_yesterday_demand.placement_id};;
  }

  join: v_mediaplanner_allocation_view {
    type: full_outer
    relationship: many_to_many
    sql_on: ${v_daily_core_stats.flight_media_id} = ${v_mediaplanner_allocation_view.flight_media_id} and
      ${v_daily_core_stats._demand_date} = ${v_mediaplanner_allocation_view.allocation_date_date} ;;
  }

  join: v_mediaplanner_allocation_yesterday {
    type: full_outer
    relationship: many_to_one
    sql_on: {% if v_mediaplanner_allocation_view._in_query %}COALESCE(${v_daily_core_stats.flight_media_id}, v_mediaplanner_allocation_view.FLIGHT_MEDIA_ID){% else %}${v_daily_core_stats.flight_media_id}{% endif %} = ${v_mediaplanner_allocation_yesterday.flight_media_id} ;;
  }

  join:  v_daily_ccp_metrics {
    type: full_outer
    relationship: many_to_one
    sql_on: ${v_daily_ccp_metrics.flight_media_id} = {% if v_mediaplanner_allocation_view._in_query or v_mediaplanner_allocation_yesterday._in_query %}COALESCE(${v_daily_core_stats.flight_media_id}{% if v_mediaplanner_allocation_view._in_query %}, v_mediaplanner_allocation_view.FLIGHT_MEDIA_ID{% endif %}{% if v_mediaplanner_allocation_yesterday._in_query %}, v_mediaplanner_allocation_yesterday.FLIGHT_MEDIA_ID{% endif %}){% else %}${v_daily_core_stats.flight_media_id}{% endif %}
      and ${v_daily_ccp_metrics.keydate_raw} = {% if v_daily_core_stats.gmt_date._is_selected
        or v_daily_core_stats.gmt_week._is_selected or v_daily_core_stats.gmt_month._is_selected
        or v_daily_core_stats.gmt_quarter._is_selected or v_daily_core_stats.gmt_year._is_selected %}{% if v_mediaplanner_allocation_view._in_query %}COALESCE(${v_daily_core_stats.gmt_raw}, v_mediaplanner_allocation_view.ALLOCATION_DATE){% else %}${v_daily_core_stats.gmt_raw}{% endif %}{% else %}{% if v_mediaplanner_allocation_view._in_query %}COALESCE(${v_daily_core_stats.demand_raw}, v_mediaplanner_allocation_view.ALLOCATION_DATE){% else %}${v_daily_core_stats.demand_raw}{% endif %}{% endif %} ;;
  }

  join: v_flight_media_details_base {
    relationship: many_to_one
    sql: {% if v_flight_media_details_base.future_flight_media._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.FLIGHT_MEDIA_DETAILS_BASE_VIEW  AS v_flight_media_details_base ON {% if v_mediaplanner_allocation_view._in_query or v_mediaplanner_allocation_yesterday._in_query or v_daily_ccp_metrics._in_query %}COALESCE(${v_daily_core_stats.flight_media_id}{% if v_mediaplanner_allocation_view._in_query %}, v_mediaplanner_allocation_view.FLIGHT_MEDIA_ID{% endif %}{% if v_mediaplanner_allocation_yesterday._in_query %}, v_mediaplanner_allocation_yesterday.FLIGHT_MEDIA_ID{% endif %}{% if v_daily_ccp_metrics._in_query %}, v_daily_ccp_metrics.FLIGHT_MEDIA_ID{% endif %}){% else %}${v_daily_core_stats.flight_media_id}{% endif %} = ${v_flight_media_details_base.flight_media_id} ;;
  }

  join: v_demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_demand_mart_load_tracking.start_timezone} ;;
  }

  join: v_demand_mart_load_tracking_start_timezone {
    relationship: many_to_one
    sql_on: ${v_demand_mart_load_tracking.start_timezone} = ${v_demand_mart_load_tracking_start_timezone.timezone_id} ;;
  }

  join: v_flight_details {
    sql: {% if v_flight_details.future_flights._in_query %}FULL OUTER JOIN DIM.FLIGHT_DETAILS_VIEW AS v_flight_details ON ${v_flight_media_details_base.flight_id} = ${v_flight_details.flight_id}
      {% else %}LEFT JOIN DIM.FLIGHT_DETAILS_VIEW AS v_flight_details ON ${v_flight_media_details_base.flight_id} = ${v_flight_details.flight_id} {% endif %} ;;
    relationship: many_to_one
  }

  join: v_trafficked_flights {
    relationship: one_to_one
    type: inner
    sql_on: ${v_flight_details.flight_id} = ${v_trafficked_flights.flight_id} ;;
  }

  join: v_required_delivery_today {
    relationship: many_to_one
    sql_on: ${v_daily_core_stats.flight_media_id} = ${v_required_delivery_today.flight_media_id} ;;
  }

  join: v_campaign_details_base {
    relationship: many_to_one
    sql: {% if v_campaign_bookings._in_query %}FULL OUTER JOIN DIM.CAMPAIGN_DETAILS_BASE_VIEW AS v_campaign_details_base ON ${v_flight_details.campaign_id} = ${v_campaign_details_base.campaign_id}
      {% else %}LEFT JOIN DIM.CAMPAIGN_DETAILS_BASE_VIEW AS v_campaign_details_base ON ${v_flight_details.campaign_id} = ${v_campaign_details_base.campaign_id} {% endif %} ;;
  }

  join: v_expected_delivery {
    relationship: one_to_many
    sql_on: {% if v_flight_details.flight_id._in_query or v_flight_details.flight_description._in_query or v_flight_media_details_base.flight_description._in_query %} ${v_flight_details.flight_id} = ${v_expected_delivery.flight_id}
      {% else %} ${v_campaign_details_base.campaign_id} = ${v_expected_delivery.campaign_id}  {% endif %} ;;
  }

  join: v_timezone {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_timezone.timezone_id} ;;
  }

  join: v_pl_plan {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.pl_plan_id} = ${v_pl_plan.pl_plan_id};;
  }

  join: v_campaign_days {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.campaign_id} = ${v_campaign_days.campaign_id} ;;
  }

  join: v_customer_details {
    relationship: many_to_one
    sql: {% if v_customer_details.future_customers._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.CUSTOMER_DETAILS_VIEW  AS v_customer_details ON ${v_campaign_details_base.customer_id} = ${v_customer_details.customer_id} ;;
  }

  join: v_campaign_bookings {
    relationship: many_to_one
    sql_on: ${v_campaign_bookings.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
  }

  join: v_customer_country {
    relationship: many_to_one
    sql_on: ${v_customer_details.country_id} = ${v_customer_country.country_id} ;;
  }


  join: v_advertiser_brand_details {
    relationship: many_to_one
    sql: {% if v_advertiser_brand_details.future_advertisers._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.ADVERTISER_BRAND_DETAILS_VIEW  AS v_advertiser_brand_details ON ${v_campaign_details_base.advertiser_brand_id} = ${v_advertiser_brand_details.advertiser_brand_id} ;;
  }

  join:  v_insertion_order_details {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.insertion_order_id} = ${v_insertion_order_details.insertion_order_id};;
  }

  join: v_platform_client {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.platform_client_id} = ${v_platform_client.platform_client_id} ;;
  }

  join: v_flight_demand_units_budget {
    relationship: many_to_one
    sql_on: ${v_flight_details.flight_id} = ${v_flight_demand_units_budget.flight_id}
      and ${v_flight_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: v_campaign_demand_units_budget {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.campaign_id} = ${v_campaign_demand_units_budget.campaign_id}
          and ${v_campaign_demand_units_budget.flight_id} IS NULL
          and ${v_campaign_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: v_insertion_order_demand_units_budget {
    relationship: many_to_one
    sql_on: ${v_insertion_order_demand_units_budget.insertion_order_id} = ${v_insertion_order_details.insertion_order_id}
          and ${v_insertion_order_demand_units_budget.pl_plan_id} IS NULL
          and ${v_insertion_order_demand_units_budget.campaign_id} IS NULL
          and ${v_insertion_order_demand_units_budget.flight_id} IS NULL
          and ${v_insertion_order_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: v_campaign_target_description {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.campaign_id} = ${v_campaign_target_description.campaign_id};;
  }

  join: v_campaign_pacing_by_day {
    view_label: "Impression Metrics"
    relationship: many_to_one
    sql_on: ${v_daily_core_stats.demand_raw} = ${v_campaign_pacing_by_day.demand_date}
      and ${v_campaign_details_base.campaign_id} = ${v_campaign_pacing_by_day.campaign_id} ;;
  }

  join: v_campaign_postalcode {
    relationship: one_to_many
    sql_on: ${v_campaign_details_base.campaign_id} = ${v_campaign_postalcode.campaign_id} ;;
  }

  join: v_pl_plan_agg {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.pl_plan_id} = ${v_pl_plan_agg.pl_plan_id} ;;
  }

  join: v_campaign_geolocation {
    relationship: one_to_one
    sql_on: ${v_campaign_details_base.campaign_id} = ${v_campaign_geolocation.campaign_id} ;;
  }
}



# explore: v_conversion_fact {
#   required_access_grants: [can_use_explore]
#   label: "Conversion Metrics"
#   description: "This explore includes conversion metrics along with the supply and demand dimensions they can be aggregated by. Conversions are recorded when a pixel is fired, usually associated with a campaign.
#   Advertisers will place these pixels on their sites to record some action being done by the user. This data is available by-hour, as far back as August 2013."
#   fields: [ALL_FIELDS*, -v_advertiser_brand_details.future_advertisers]

#   join: v_action_pixel {
#     relationship: many_to_one
#     sql_on: ${v_action_pixel.action_pixel_id} = ${v_conversion_fact.action_pixel_id} ;;
#   }

#   join: v_flight_media_details_base {
#     relationship: many_to_one
#     sql_on: ${v_flight_media_details_base.flight_media_id} = ${v_conversion_fact.flight_media_id} ;;
#   }

#   # join: demand_mart_load_tracking {
#   #   relationship: many_to_one
#   #   sql_on: ${flight_media_details_base.starttimezone_id} = ${demand_mart_load_tracking.start_timezone} and
#   #     ${demand_mart_load_tracking.schema_name} = 'demand_mart' and
#   #     ${demand_mart_load_tracking.table_name} = 'daily_core_stats' ;;
#   # }

#   join: v_flight_details {
#     relationship: many_to_one
#     sql_on: ${v_flight_media_details_base.flight_id} = ${v_flight_details.flight_id} ;;
#   }

#   join: v_campaign_details_base {
#     relationship: many_to_one
#     sql_on: ${v_flight_details.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
#   }

#   join: v_timezone {
#     relationship: many_to_one
#     sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_timezone.timezone_id} ;;
#   }

#   join: v_campaign_days {
#     relationship: many_to_one
#     sql_on: ${v_flight_details.campaign_id} = ${v_campaign_days.campaign_id} ;;
#   }

#   join: v_advertiser_brand_details {
#     relationship: many_to_one
#     sql_on: ${v_campaign_details_base.advertiser_brand_id} = ${v_advertiser_brand_details.advertiser_brand_id} ;;
#   }

#   join: v_placement_details_base {
#     relationship: many_to_one
#     sql_on: ${v_placement_details_base.placement_id} = ${v_conversion_fact.placement_id} ;;
#   }

#   join: v_platform_client {
#     relationship: many_to_one
#     sql_on: ${v_campaign_details_base.platform_client_id} = ${v_platform_client.platform_client_id} ;;
#   }

#   join: v_daypart {
#     relationship: many_to_one
#     sql_on: ${v_daypart.daypart_id} = ${v_conversion_fact.daypart} ;;
#   }

#   join: v_geodata {
#     relationship: many_to_one
#     sql_on: ${v_geodata.geoid} = ${v_conversion_fact.geo} ;;
#   }


# }


# explore: v_survey_fact_derived {
#   required_access_grants: [can_use_explore]
#   label: "Brandscore Metrics"
#   description: "Survey and Brandscore Metrics."
# }




# explore: tpm_metrics {

#   hidden: yes
#   label: "Third Party Metrics"
#   description: "This explore includes metrics that we have ingested from Third Parties."

#   join: campaign_details_base {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.campaign_id} = ${tpm_metrics.campaign_id} ;;
#   }

#   join: flight_media_details_base {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.campaign_id} = ${flight_media_details_base.campaign_id} ;;
#   }

#   join: demand_mart_load_tracking {
#     relationship: many_to_one
#     sql_on: ${flight_media_details_base.starttimezone_id} = ${demand_mart_load_tracking.start_timezone} and
#       ${demand_mart_load_tracking.schema_name} = 'demand_mart' and
#       ${demand_mart_load_tracking.table_name} = 'daily_core_stats' ;;
#   }

#   join: campaign_days {
#     relationship: many_to_one
#     sql_on: ${tpm_metrics.campaign_id} = ${campaign_days.campaign_id} ;;
#   }

#   join: placement_details_base {
#     relationship: many_to_one
#     sql_on: ${placement_details_base.placement_id} = ${tpm_metrics.placement_id}  ;;
#   }

#   join: timezone {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.timezone_id} = ${timezone.timezone_id} ;;
#     fields: []
#   }

#   join: platform_client {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
#     fields: []
#   }
# }




explore: v_raw_impression {

  label: "Vertica Raw Impression Metrics"
  description: "This explore includes raw impression metrics. This data can be analyzed by nearly any facet that is available down to the raw detail of a single impression.
  This data is only available for the last seven days."
  sql_always_where: ({% if _user_attributes['access_filter_office_id'] == '>=0, NULL' %} TRUE {% else %} (${v_platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }}) OR ${v_supply_platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }})) {% endif %}) AND
                    ({% if _user_attributes['access_filter_platform_client_id'] == '>=0, NULL' %} TRUE {% else %} (${v_campaign_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${v_placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${v_platform_client.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) {% endif %}) AND
                    ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} ( ${v_campaign_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) AND ( ${v_placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;
  fields: [ALL_FIELDS*, -v_advertiser_brand_details.future_advertisers, -v_customer_details.future_customers, -v_daily_ccp_metrics.exp_rev, -v_daily_ccp_metrics.sum_daily_ccp_eoc_audit_yesterday, -v_daily_ccp_metrics.daily_ccp_eoc_audit_diff_yesterday_gmt]

  join: v_bt_cost_attributes {
    view_label: "Raw Impression Metrics"
    relationship: one_to_many
    sql_on: ${v_bt_cost_attributes.bt_id} = ${v_raw_impression.bt_id};;
  }

  join: v_flight_media_details_base {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.flight_media_id} = ${v_raw_impression.flight_media} ;;
  }

  join: v_demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_demand_mart_load_tracking.start_timezone}  ;;
  }

  join: v_flight_details {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.flight_id} = ${v_flight_details.flight_id} ;;
  }

  join: v_campaign_details_base {
    relationship: many_to_one
    sql_on: ${v_flight_details.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
  }

  join: v_campaign_days {
    relationship: many_to_one
    sql_on: ${v_flight_details.campaign_id} = ${v_campaign_days.campaign_id} ;;
  }

  join: v_campaign_pacing_by_day {
    view_label: "Raw Impression Metrics"
    relationship: many_to_one
    sql_on: ${v_raw_impression.demand_date_raw} = ${v_campaign_pacing_by_day.demand_date}
      and ${v_campaign_details_base.campaign_id} = ${v_campaign_pacing_by_day.campaign_id} ;;
  }

  join: v_advertiser_brand_details {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.advertiser_brand_id} = ${v_advertiser_brand_details.advertiser_brand_id} ;;
  }

  join:  v_insertion_order_details {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.insertion_order_id} = ${v_insertion_order_details.insertion_order_id};;
  }

  join:  v_account_exec {
    relationship: many_to_one
    sql_on: ${v_insertion_order_details.account_rep} = ${v_account_exec.id} ;;
  }

  join: v_placement_details_base {
    relationship: many_to_one
    sql_on: ${v_placement_details_base.placement_id} = ${v_raw_impression.placement_id} ;;
  }

  join: v_bt_data_provider_core {
    relationship: many_to_one
    sql_on: ${v_bt_cost_attributes.bt_provider} = ${v_bt_data_provider_core.user_data_vendor_id} ;;
  }

  join: v_bt_cluster_provider_core {
    relationship: many_to_one
    sql_on: ${v_raw_impression.bt_cluster_provider} = ${v_bt_cluster_provider_core.user_data_vendor_id} ;;
  }

  join: v_demo_provider {
    relationship: many_to_one
    sql_on: ${v_raw_impression.demoproviderid} = ${v_demo_provider.user_data_vendor_id} ;;
  }

  join: v_platform_client {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.platform_client_id} = ${v_platform_client.platform_client_id} ;;
  }

  join: v_supply_platform_client {
    from: v_platform_client
    relationship: many_to_one
    sql_on: ${v_placement_details_base.platform_client_id} = ${v_supply_platform_client.platform_client_id} ;;
    view_label: "Supply Platform Client"
    fields: [business_region, office_name, platform_client_active]
  }

  join: v_customer_details {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.customer_id} = ${v_customer_details.customer_id} ;;
  }

  join: v_timezone {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_timezone.timezone_id} ;;
  }

  join: v_campaign_details_plan {
    relationship: many_to_one
    sql_on: ${v_raw_impression.campaign_id} = ${v_campaign_details_plan.campaign_id} ;;
  }

  join: v_hourly_exchange_rates {
    relationship: many_to_one
    sql_on: ${v_raw_impression.payout_currency} = ${v_hourly_exchange_rates.currency_from}
              AND date_trunc('hour', ${v_raw_impression.keydate_raw}) = ${v_hourly_exchange_rates.keydate}
              AND ${v_hourly_exchange_rates.currency_to} = 'USD';;
  }

  # join: v_v_conversion_fact {
  #   relationship: many_to_many
  #   sql_on: ${v_raw_impression.adid} = ${v_conversion_fact.exposure_uniqueid} and
  #           ${v_raw_impression.flight_media} = ${v_conversion_fact.flight_media_id} and
  #           ${v_raw_impression.placement_id} = ${v_conversion_fact.placement_id} ;;
  # }

  # join: v_action_pixel {
  #   relationship: many_to_one
  #   sql_on: ${v_conversion_fact.action_pixel_id} = ${v_action_pixel.action_pixel_id} ;;
  # }

  join: v_brand_frequency_cap_violations {
    relationship: one_to_one
    sql_on: ${v_raw_impression.pk_id} = ${v_brand_frequency_cap_violations.pk_id};;
  }

  join: v_placement_frequency_cap_violations {
    relationship: one_to_one
    sql_on: ${v_raw_impression.pk_id} = ${v_placement_frequency_cap_violations.pk_id};;
  }

  join: v_flight_frequency_cap_violations {
    relationship: one_to_one
    sql_on: ${v_raw_impression.pk_id} = ${v_flight_frequency_cap_violations.pk_id};;
  }

  join:v_flight_media_frequency_cap_violations {
    relationship: one_to_one
    sql_on: ${v_raw_impression.pk_id} = ${v_flight_media_frequency_cap_violations.pk_id};;
  }

  join: v_campaign_frequency_cap_violations {
    relationship: one_to_one
    sql_on: ${v_raw_impression.pk_id} = ${v_campaign_frequency_cap_violations.pk_id};;
  }

  join: v_plan_frequency_cap_violations {
    relationship: one_to_one
    sql_on: ${v_raw_impression.pk_id} = ${v_plan_frequency_cap_violations.pk_id};;
  }

  join: v_insertion_order_demand_units_budget {
    relationship: many_to_one
    sql_on: ${v_insertion_order_demand_units_budget.insertion_order_id} = ${v_insertion_order_details.insertion_order_id}
          and ${v_insertion_order_demand_units_budget.pl_plan_id} IS NULL
                and ${v_insertion_order_demand_units_budget.campaign_id} IS NULL
                and ${v_insertion_order_demand_units_budget.flight_id} IS NULL
                and ${v_insertion_order_demand_units_budget.flight_media_id} IS NULL;;
  }

  join:  v_daily_ccp_metrics {
    type: full_outer
    relationship: many_to_one
    sql_on: ${v_daily_ccp_metrics.campaign_id} = ${v_raw_impression.campaign_id}
      and ${v_daily_ccp_metrics.keydate_raw} = ${v_raw_impression.keydate_date} ;;
  }

  join: v_partner_media {
    view_label: "Media"
    relationship: many_to_many
    sql_on: ${v_flight_media_details_base.media_id} = ${v_partner_media.media_id} AND ${v_placement_details_base.partner_id} = ${v_partner_media.partner_id} ;;
  }

  join: v_opt_misdelivery {
    view_label: "Raw Impression Metrics"
    relationship: many_to_many
    sql_on: ${v_raw_impression.keydate_date} = ${v_opt_misdelivery.keydate} AND ${v_raw_impression.campaign_id} = ${v_opt_misdelivery.campaign_id} ;;
  }

  join: v_campaign_first_delivery {
    view_label: "Campaign"
    relationship: one_to_one
    sql_on: ${v_campaign_details_base.campaign_id} = ${v_campaign_first_delivery.campaign_id} ;;
  }

  join: v_attribute_lookup_platformid{
    relationship: many_to_one
    sql_on: ${v_attribute_lookup_platformid.attr_id} = ${v_raw_impression.platformid} ;;

  }

  join: v_attribute_lookup_ageid{
    relationship: many_to_one
    sql_on: ${v_attribute_lookup_ageid.attr_id} =  ${v_raw_impression.ageid} ;;
  }

  join: v_attribute_lookup_browserid{
    relationship: many_to_one
    sql_on: ${v_attribute_lookup_browserid.attr_id} = ${v_raw_impression.browserid} ;;

  }

  join: v_attribute_lookup_deviceid{
    relationship: many_to_one
    sql_on: ${v_attribute_lookup_deviceid.attr_id} =  ${v_raw_impression.deviceid} ;;
  }


  join: v_attribute_lookup_languageid{
    relationship: many_to_one
    sql_on: ${v_attribute_lookup_languageid.attr_id} = ${v_raw_impression.languageid} ;;

  }

  join: v_attribute_lookup_genderid{
    relationship: many_to_one
    sql_on: ${v_attribute_lookup_genderid.attr_id} =  ${v_raw_impression.genderid} ;;
  }
}




# explore: portfolio_trends {

#   label: "Portfolio Trends"
#   description: "This explore includes Portfolio Trends and can be sliced by various demand-level dimensions."
#   access_filter: {
#     field: platform_client.office_id
#     user_attribute: access_filter_office_id
#   }
#   access_filter: {
#     field: campaign_details_base.platform_client_id
#     user_attribute: access_filter_platform_client_id
#   }

#   sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} (${campaign_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;

#   fields: [ALL_FIELDS*, -advertiser_brand_details.future_advertisers, -customer_details.future_customers]

#   join: campaign_details_base {
#     relationship: many_to_one
#     sql_on: ${portfolio_trends.campaign} = ${campaign_details_base.campaign_id} ;;
#   }

#   join: platform_client {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
#   }

#   join: flight_media_details_base {
#     relationship: many_to_one
#     fields: []
#     sql_on: ${campaign_details_base.campaign_id} = ${flight_media_details_base.campaign_id} ;;
#   }

#   join: advertiser_brand_details {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
#   }

#   join:  insertion_order_details {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.insertion_order_id} = ${insertion_order_details.insertion_order_id};;
#   }
#   join: customer_details {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
#   }

#   join: timezone {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.timezone_id} = ${timezone.timezone_id} ;;
#   }

# }

# explore: daily_campaign_retargeting_stats {
#   required_access_grants: [can_use_explore]
#   label: "Campaign Targeted/Untargeted Stats"
#   description:"This explore includes data segments where campaigns have delivered (Retargeting Billable impressions)"
#   fields: [ALL_FIELDS*,-campaign_details_base.agency_fee, -advertiser_brand_details.future_advertisers, -customer_details.future_customers]

#   join: campaign_details_base {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.campaign_id} = ${daily_campaign_retargeting_stats.campaign_id} ;;
#   }

# #   join: flight_media_details_base {
# #     relationship: one_to_many
# #     sql_on: ${campaign_details_base.campaign_id} = ${flight_media_details_base.campaign_id} ;;
# #   }

#   join: advertiser_brand_details {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
#   }

#   join: customer_details {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
#   }

#   join: retargeting_attribute {
#     relationship: many_to_one
#     sql_on: ${daily_campaign_retargeting_stats.retargeting_attribute_id} = ${retargeting_attribute.retargeting_attribute_id} ;;
#   }

#   join: timezone {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.timezone_id} = ${timezone.timezone_id} ;;
#     fields: []
#   }

#   join: platform_client {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
#     fields: []
#   }
# }

# explore: sno_demand_raw_impression_validation {
#   required_access_grants: [can_use_explore]
#   label: "Demand Raw Impression Validation"
#   hidden: yes

#   always_filter: {
#     filters: [sno_demand_raw_impression_validation.demand_date: "3 days"]
#   }

#   join: timezone {
#     relationship: many_to_one
#     sql_on: ${sno_demand_raw_impression_validation.timezone_id} = ${timezone.timezone_id} ;;
#   }

#   join: sno_demand_validation {
#     relationship: one_to_many
#     sql_on:
#       ${sno_demand_raw_impression_validation.demand_date} = ${sno_demand_validation.demand_date}
#       AND ${sno_demand_raw_impression_validation.timezone_id} = ${sno_demand_validation.timezone_id};;
#   }
# }

# explore: sno_supply_raw_impression_validation {
#   required_access_grants: [can_use_explore]
#   label: "Supply Raw Impression Validation"
#   hidden: yes

#   always_filter: {
#     filters: [sno_supply_raw_impression_validation.supply_date: "3 days"]
#   }

#   join: timezone {
#     relationship: many_to_one
#     sql_on: ${sno_supply_raw_impression_validation.timezone_id} = ${timezone.timezone_id} ;;
#   }

#   join: sno_supply_validation {
#     relationship: one_to_many
#     sql_on:
#       ${sno_supply_raw_impression_validation.supply_date} = ${sno_supply_validation.supply_date}
#       AND ${sno_supply_raw_impression_validation.timezone_id} = ${sno_supply_validation.timezone_id};;
#   }
# }

# explore: demand_warehouse_validation {

#   label: "Demand Warehouse Validation"
#   hidden: yes
# }

# explore: supply_warehouse_validation {

#   label: "Supply Warehouse Validation"
#   hidden: yes

# }

explore: v_retarg_by_vendor_coverage {
  required_access_grants: [can_use_explore]
  hidden: yes
  label: "Source Provider Coverage Metrics"
  description: "Vendors that have provided BT attributes within sampled request data are extracted to estimate overall source provider coverage.
  No metric from this dataset should be compared to anything else since it’s not using the same data source. Data is available for the last 90 days."
}

# explore: v_lm_serendipity {
#   required_access_grants: [can_use_explore]
#   label: "Lucy Slice and Dice"
#   group_label: "Lucy Slice and Dice"
# }



explore: v_blacklist_whitelist{

  view_name: v_blacklist_whitelist
  label: "Vertica Blacklist Whitelist Report"
  description: "Blacklist Whitelist Tracking Report"
  access_filter: {
    field: v_platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: v_placement_details_base.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} (${v_placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;

  join: v_bl_wl_pid_hour_requests {
    relationship: many_to_one
    type: left_outer
    sql_on:
    ${v_blacklist_whitelist.placement_id} =  ${v_bl_wl_pid_hour_requests.placement_id}
    AND ${v_blacklist_whitelist.keydate_raw} =  ${v_bl_wl_pid_hour_requests.keydate}
    ;;
  }

  join: v_placement_details_base {
    relationship: many_to_one
    sql_on: ${v_placement_details_base.placement_id} = ${v_blacklist_whitelist.placement_id} ;;
    fields: [placement_country_id, platform_client_id]
  }

  join: v_timezone {
    relationship: many_to_one
    sql_on: ${v_placement_details_base.placement_timezone_id} = ${v_timezone.timezone_id} ;;
    fields: []
  }

  join: v_platform_client {
    relationship: many_to_one
    view_label: "Supply Platform Client"
    sql_on: ${v_placement_details_base.platform_client_id} = ${v_platform_client.platform_client_id} ;;
    fields: [v_platform_client.office_id]
  }

}



# explore: suggest_demand_ref {

#   access_filter: {
#     field: suggest_demand_ref.country_id
#     user_attribute: access_filter_country_id
#   }
#   access_filter: {
#     field: suggest_demand_ref.platform_client_id
#     user_attribute: access_filter_platform_client_id
#   }

#   sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} (${suggest_demand_ref.platform_client_id} IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;

#   hidden: yes
# }

# explore: suggest_supply_ref {

#   access_filter: {
#     field: suggest_supply_ref.placement_country_id
#     user_attribute: access_filter_country_id
#   }
#   access_filter: {
#     field: suggest_supply_ref.platform_client_id
#     user_attribute: access_filter_platform_client_id
#   }

#   sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} (${suggest_supply_ref.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;

#   hidden: yes
# }

# explore: sno_load_tracking_whse_validation {
#   required_access_grants: [can_use_explore]
#   label: "Load tracking warehouse validation"
#   view_name: timezone

#   join: sno_demand_load_tracking_whse_validation {
#     relationship: one_to_many
#     sql_on: ${timezone.timezone_id} = ${sno_demand_load_tracking_whse_validation.start_timezone} ;;
#   }

#   join: sno_supply_load_tracking_whse_validation {
#     relationship: one_to_many
#     sql_on: ${timezone.timezone_id} = ${sno_supply_load_tracking_whse_validation.start_timezone} ;;
#   }
# }

# explore: sno_sas_monitoring {
#   required_access_grants: [can_use_explore]
#   label: "SAS forecasting monitoring"
#   view_name: sno_fce_atv_fdp_data_prod

#   join: sno_fce_atv_fdp_data_itv {
#     relationship: many_to_many
#     sql_on: ${sno_fce_atv_fdp_data_prod.start_date_time} = ${sno_fce_atv_fdp_data_itv.start_date_time};;
#   }

#   join: sno_fce_atv_fdp_data_sbx {
#     relationship: many_to_many
#     sql_on: ${sno_fce_atv_fdp_data_prod.start_date_time} = ${sno_fce_atv_fdp_data_sbx.start_date_time};;
#   }
# }

# explore: fce_atv_fdp_forecasts_data {

#   label: "ITV Forecast"
#   description: "This explore includes forecasting data. This data can be fetched for specific forecast - use Forecasts Info parameters to filter for required forecast."
#   # sql_always_where: acess is limited by filtering in fce_atv_fdp_forecasts_info view
#   always_join: [fce_atv_fdp_forecasts_info] # important for access limiting


#   join: fce_atv_fdp_forecasts_info {
#     relationship: many_to_one
#     type: inner # important for access limiting
#     sql_on: ${fce_atv_fdp_forecasts_data.iid} = ${fce_atv_fdp_forecasts_info.iid} ;;
#   }

#   join: fce_atv_fdp_data_attr {
#     relationship: many_to_one
#     sql_on: ${fce_atv_fdp_forecasts_data.pool_id} = ${fce_atv_fdp_data_attr.pool_id} ;;
#   }
# }

# explore: sno_opt_viewing_spot_level_pacing {
#   required_access_grants: [can_use_explore]
#   label: "OPT Pacing"

#   fields: [ALL_FIELDS*,-campaign_details_base.agency_fee]

#   join: sno_opt_pacing_report_approval {
#     relationship: many_to_one
#     sql_on: ${sno_opt_viewing_spot_level_pacing.report_id} = ${sno_opt_pacing_report_approval.report_id} ;;
#   }

#   join: sno_opt_viewing_spot_level_pacing_latest_report {
#     relationship: many_to_one
#     type: inner
#     sql_on: ${sno_opt_viewing_spot_level_pacing.campaign_id} = ${sno_opt_viewing_spot_level_pacing_latest_report.campaign_id} AND ${sno_opt_viewing_spot_level_pacing.run_raw} = ${sno_opt_viewing_spot_level_pacing_latest_report.latest_run_date} ;;
#   }

#   join: sno_converged_approved_campaigns {
#     relationship: many_to_one
#     sql_on: ${sno_opt_viewing_spot_level_pacing.campaign_id} = ${sno_converged_approved_campaigns.campaign_id} and ${sno_converged_approved_campaigns.approved_campaign_status} in (3,4) ;;
#   }

#   join: campaign_details_base {
#     relationship: many_to_one
#     sql_on: ${sno_opt_viewing_spot_level_pacing.campaign_id} = ${campaign_details_base.campaign_id} ;;
#   }

#   join: flight_details {
#     relationship: one_to_many
#     sql_on: ${campaign_details_base.campaign_id} = ${flight_details.campaign_id} ;;
#     fields: []
#   }

#   join: flight_media_details_base {
#     relationship: many_to_one
#     sql_on: ${flight_details.flight_id} = ${flight_media_details_base.flight_id} ;;
#     fields: []
#   }

#   join: advertiser_brand_details {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
#   }

#   join: platform_client {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
#   }

#   join: customer_details {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
#   }

#   join: customer_country {
#     relationship: many_to_one
#     sql_on: ${customer_details.country_id} = ${customer_country.country_id} ;;
#   }

#   join: timezone {
#     relationship: many_to_one
#     sql_on: ${campaign_details_base.timezone_id} = ${timezone.timezone_id} ;;
#     fields: []
#   }

#   join: sno_validation_report_result {
#     relationship: many_to_many
#     sql_on: ${sno_opt_viewing_spot_level_pacing.report_id} = ${sno_validation_report_result.report_id} ;;
#   }

#   join: sno_validation_rule_result {
#     relationship: one_to_many
#     sql_on: ${sno_validation_report_result.request_id} = ${sno_validation_rule_result.request_id} ;;
#   }

#   join: tpm_metrics {
#     relationship: many_to_many
#     sql_on: ${sno_opt_viewing_spot_level_pacing.campaign_id} = ${tpm_metrics.campaign_id} ;;
#     fields: [tpm_metrics.daypart]
#   }

#   sql_always_where: {% if sno_opt_viewing_spot_level_pacing.show_only_latest_report._parameter_value == "latest_any" or sno_opt_viewing_spot_level_pacing.show_only_latest_report._parameter_value == "latest_approved" %} ${sno_opt_viewing_spot_level_pacing_latest_report.campaign_id} IS NOT NULL {% else %} TRUE {% endif %}
#     AND {% if sno_opt_viewing_spot_level_pacing.show_only_latest_report._parameter_value == "latest_approved" %} ${sno_opt_pacing_report_approval.approval_state} = 'approved' {% else %} TRUE {% endif %} ;;
# }

# explore: sno_smartmon_events_forecast_error_metrics {

#   label: "Forecast Error Metrics"

#   sql_always_where: (${sno_smartmon_events_forecast_error_metrics.name} = 'forecast_error_metrics') AND
#     ({% if _user_attributes['is_itv_user'] == 'yes' %}${sno_smartmon_events_forecast_error_metrics.partner_id} = 5951{% else %} TRUE {% endif %}) ;;
# }
