connection: "amobee_prod"
label: "Delivery"
# include all the views
include: "/**/*.view.lkml"
case_sensitive: no

# include all the dashboards
#include: "*.dashboard"

access_grant: can_use_explore { user_attribute: is_itv_user allowed_values: ["no"] }



explore: hourly_analytics {

  view_name: hourly_analytics
  label: "Request and Impression Metrics"
  description: "This explore includes both impression and request metrics. This data can be analyzed by the core supply and demand dimensions,
  as well as supplemental facets such as daypart, demographics, domains and geo. This data is available by-day as far back as July 2017
  and by-hour for the last seven days."
  sql_always_where: ({% if _user_attributes['access_filter_office_id'] == '>=0, NULL' %} TRUE {% else %} (${platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }}) OR ${supply_platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }})) {% endif %}) AND
                    ({% if _user_attributes['access_filter_platform_client_id'] == '>=0, NULL' %} TRUE {% else %} (${campaign_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${platform_client.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) {% endif %}) AND
                    ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${campaign_details_base.platform_client_id} IS NULL OR ${campaign_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) AND (${placement_details_base.platform_client_id} IS NULL OR ${placement_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;

  fields: [ALL_FIELDS*, -hourly_analytics.sum_floor_price,-hourly_analytics.sum_revenue,
    -flight_media_details_base.demoaud, -hourly_analytics.sum_unserved_requests,
    -advertiser_brand_details.future_advertisers, -customer_details.future_customers]

  join: bt_cost_attributes {
    view_label: "Request and Impression Metrics"
    relationship: one_to_many
    type: cross
  }

  join: load_tracking {
    relationship: many_to_one
    sql_on: ${load_tracking.schema_name} = 'rawdb' and ${load_tracking.table_name} = 'hourly_analytics' ;;
  }

  join: flight_media_details_base {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.flight_media_id} = ${hourly_analytics.flight_media} ;;
  }

  join: demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${demand_mart_load_tracking.start_timezone} and
      ${demand_mart_load_tracking.schema_name} = 'demand_mart' and
      ${demand_mart_load_tracking.table_name} = 'daily_core_stats' ;;
  }

  join: flight_details {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.flight_id} = ${flight_details.flight_id} ;;
  }

  join: campaign_details_base {
    relationship: many_to_one
    sql_on: ${flight_details.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: campaign_days {
    relationship: many_to_one
    sql_on: ${flight_details.campaign_id} = ${campaign_days.campaign_id} ;;
  }

  join: advertiser_brand_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
  }

  join:  insertion_order_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.insertion_order_id} = ${insertion_order_details.insertion_order_id};;
  }

  join: customer_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
  }

  join: customer_country {
    relationship: many_to_one
    sql_on: ${customer_details.country_id} = ${customer_country.country_id} ;;
  }


  join:  account_exec {
    relationship: many_to_one
    sql_on: ${insertion_order_details.account_rep} = ${account_exec.id} ;;
  }

  join: placement_details_base {
    relationship: many_to_one
    sql_on: ${placement_details_base.placement_id} = ${hourly_analytics.placement_id} ;;
  }

  join: placement_timezone {
    relationship: many_to_one
    sql_on: ${placement_details_base.placement_timezone_id} = ${placement_timezone.timezone_id} ;;
  }

  join: bt_data_provider_core {
    relationship: many_to_one
    sql_on: ${bt_cost_attributes.bt_provider} = ${bt_data_provider_core.user_data_vendor_id} ;;
  }

  join: bt_cluster_provider_core {
    relationship: many_to_one
    sql_on: ${hourly_analytics.bt_cluster_provider} = ${bt_cluster_provider_core.user_data_vendor_id} ;;
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
  }

  join: supply_platform_client {
    from: platform_client
    relationship: many_to_one
    sql_on: ${placement_details_base.platform_client_id} = ${supply_platform_client.platform_client_id} ;;
    view_label: "Supply Platform Client"
    fields: [business_region, office_name, platform_client_active]
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${timezone.timezone_id} ;;
  }

  join: demo_provider {
    relationship: many_to_one
    sql_on: ${hourly_analytics.demo_provider} = ${demo_provider.user_data_vendor_id} ;;
  }

  join: daypart {
    relationship: many_to_many
    sql_on: ${hourly_analytics.daypart_id} = ${daypart.hour_daypart_id} ;;
  }

  join: retargeting_attribute {
    relationship: many_to_one
    sql_on: ${bt_cost_attributes.bt_cost_attribute} = ${retargeting_attribute.retargeting_attribute_id} ;;
  }

  join: hourly_analytics_derived {
    view_label: "Relative changes"
    relationship: many_to_one
    sql_on: ${hourly_analytics.demand_date_date} = TO_CHAR(DATEADD(DAY, 1, TO_TIMESTAMP(${hourly_analytics_derived.demand_date})), 'YYYY-MM-DD') ;;
  }

  join: plan_currency {
    relationship: many_to_one
    sql_on: ${placement_details_base.preferred_currency_id} = ${plan_currency.currency_id} ;;
    fields: []
  }

}

explore: hourly_analytics_wopr_only {
  label: "Request and Impression Metrics (for WOPR only)"
  required_access_grants: [can_use_explore]
  extends: [hourly_analytics]
  fields: [ALL_FIELDS*, -advertiser_brand_details.future_advertisers, -customer_details.future_customers]
}

explore: hourly_logging_audit {

  label: "Logging Audit"
  hidden: yes

  join: flight_media_details_base {
   relationship: many_to_one
   sql_on: ${hourly_logging_audit.flight_media_id} = ${flight_media_details_base.flight_media_id} ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${timezone.timezone_id} ;;
    fields: []
  }

  join: campaign_details_base {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.campaign_id} ;;
    fields: []
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
    fields: []
  }
}

explore: sno_domain_spreader {

  label: "Domain Spreader"
  description: "This explore is used to monitor the percent of impressions served to any single domain URL, per campaign."
  hidden: yes
  fields: [ALL_FIELDS*, -campaign_details_base.campaign_name_custom,-campaign_details_base.agency_fee]

  join: campaign_details_base {
    relationship: many_to_one
    sql_on: ${sno_domain_spreader.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${campaign_details_base.timezone_id} = ${timezone.timezone_id} ;;
    fields: []
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
    fields: []
  }
}

explore: sno_frequency_by_tier {


  label: "Frequency By Tier"
  hidden: yes
  description: "Campaign or Plan To-Date Delivery Statistics by Frequency Tier. This Explore allows you to view delivery statistics bucketed into frequencies
  that campaigns or plans were viewed. Frequencies are limited to [1-7], meaning delivery statistics are only included for users who saw campaigns and plans
  between 1 and 7 times."

  join: campaign_details_base {
    relationship: many_to_one
    fields: [campaign_details_base.campaign_name,campaign_details_base.plan_name, campaign_details_base.platform_client_description]
    sql_on:{% if sno_frequency_by_tier.campaign_id._in_query %} ${sno_frequency_by_tier.campaign_id} = ${campaign_details_base.campaign_id}
    {% elsif sno_frequency_by_tier.plan_id._in_query %} ${sno_frequency_by_tier.plan_id} = ${campaign_details_base.pl_plan_id} {% endif %} ;;
  }

}



explore: daily_bt_acquisition {
  required_access_grants: [can_use_explore]
  label: "BT Acquisition"
  description: "Information on the data points we acquired for a segment. This is based on data sent to us by third party vendors and is independent from request information.  This data is available by-day, as far back as October 2009."
  fields: [ALL_FIELDS*, -advertiser_brand_details.future_advertisers, -customer_details.future_customers]

 join: retargeting_attribute {
    relationship: many_to_one
    sql_on: ${daily_bt_acquisition.retargeting_attribute_id} = ${retargeting_attribute.retargeting_attribute_id} ;;
  }

  join: data_vendor_operation {
    relationship: many_to_one
    sql_on: ${daily_bt_acquisition.operation} = ${data_vendor_operation.operation_id} ;;
  }

  join: user_id_type {
    relationship: many_to_one
    sql_on: ${daily_bt_acquisition.id_type} = ${user_id_type.user_id_type} ;;
  }

  join: sno_campaign_target {
    relationship: one_to_many
    sql_on: ${retargeting_attribute.retargeting_attribute_id} = ${sno_campaign_target.attribute_value_id} ;;
  }

  join: campaign_details_base {
    relationship: many_to_one
    sql_on: ${sno_campaign_target.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: flight_media_details_base {
    relationship: one_to_many
    sql_on: ${campaign_details_base.campaign_id} = ${flight_media_details_base.campaign_id} ;;
  }

  join: advertiser_brand_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
  }

  join: customer_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${campaign_details_base.timezone_id} = ${timezone.timezone_id} ;;
    fields: []
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
    fields: []
  }
}

explore: retargeting_attribute {
  required_access_grants: [can_use_explore]
  label: "Segments and Reach/Cookies"
  description: "This Explore is used to pull segments with no uniques."
  fields: [ALL_FIELDS*, -retargeting_attribute.dst_createdon_date, -retargeting_attribute.dst_createdon_time,
    -retargeting_attribute.dst_createdon_week, -retargeting_attribute.dst_createdon_month,
    -retargeting_attribute.dst_createdon_quarter, -retargeting_attribute.dst_createdon_year,
    -retargeting_attribute.dst_createdon_raw]

  join: daily_bt_acquisition {
    relationship: one_to_many
    sql_on: ${daily_bt_acquisition.retargeting_attribute_id} = ${retargeting_attribute.retargeting_attribute_id} ;;
  }

  join: sno_attribute_value_metrics {
    relationship: one_to_many
    sql_on: ${retargeting_attribute.retargeting_attribute_id} = ${sno_attribute_value_metrics.attribute_value_id}
      AND ${sno_attribute_value_metrics.attribute_id} = 20 ;;
  }

  join: sno_attribute_value_metrics_country {
    relationship: many_to_one
    sql_on: ${sno_attribute_value_metrics.country_id} = ${sno_attribute_value_metrics_country.country_id};;
  }
}

explore: daily_core_stats {

  label: "Impression Metrics"
  description: "This explore includes impression metrics along with the demand and supply dimensions they can be aggregated by.
  Data is available by-day, as far back as November 2015.  You will only find demand which has had delivery, campaigns which have yet to have
  any impressions delivered will not appear in this explore."
  sql_always_where: ({% if daily_core_stats.demand_date._in_query or daily_core_stats.demand_week._in_query %}COALESCE(${daily_core_stats.demand_raw}, '9999-12-31') >= (SELECT MIN(DEMAND_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% elsif daily_core_stats.EST_date._in_query or daily_core_stats.EST_week._in_query %}COALESCE(${daily_core_stats.EST_raw}, '9999-12-31') >= (SELECT MIN(EST_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% elsif daily_core_stats.gmt_date._in_query or daily_core_stats.gmt_week._in_query %}COALESCE(${daily_core_stats.gmt_raw}, '9999-12-31') >= (SELECT MIN(GMT_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% elsif daily_core_stats.region_date._in_query or daily_core_stats.region_week._in_query %}COALESCE(${daily_core_stats.region_raw}, '9999-12-31') >= (SELECT MIN(REGION_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% else %}TRUE{% endif %}) AND
                      ({% if _user_attributes['access_filter_office_id'] == '>=0, NULL' %} TRUE {% else %} (${platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }}) OR ${supply_platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }})) {% endif %}) AND
                      ({% if _user_attributes['access_filter_platform_client_id'] == '>=0, NULL' %} TRUE {% else %} (${campaign_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${platform_client.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) {% endif %}) AND
                      ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${campaign_details_base.platform_client_id} IS NULL OR ${campaign_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) AND (${placement_details_base.platform_client_id} IS NULL OR ${placement_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;

  join: flight_media_details_base {
    relationship: many_to_one
    sql: {% if flight_media_details_base.future_flight_media._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.FLIGHT_MEDIA_DETAILS_BASE  AS flight_media_details_base ON ${flight_media_details_base.flight_media_id} = ${daily_core_stats.flight_media_id} ;;
  }

  join: deal_flight_media_details {
    fields: [
      deal_flight_media_details.external_buyer_media_id,
      deal_flight_media_details.seller_customer_name,
      deal_flight_media_details.seller_advertiser_name,
      deal_flight_media_details.seller_brand_name]
    relationship: one_to_one
    sql_on: ${flight_media_details_base.flight_media_id} = ${deal_flight_media_details.seller_flight_media_id};;
  }

  join: demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${demand_mart_load_tracking.start_timezone} and
      ${demand_mart_load_tracking.schema_name} = 'demand_mart' and
      ${demand_mart_load_tracking.table_name} = 'daily_core_stats' ;;
  }

  join: demand_mart_load_tracking_start_timezone {
    relationship: many_to_one
    sql_on: ${demand_mart_load_tracking.start_timezone} = ${demand_mart_load_tracking_start_timezone.timezone_id} ;;
  }

  join: flight_details {
    sql: {% if flight_details.future_flights._in_query %}FULL OUTER JOIN DIM.FLIGHT_DETAILS AS flight_details ON ${flight_media_details_base.flight_id} = ${flight_details.flight_id}
         {% else %}LEFT JOIN DIM.FLIGHT_DETAILS AS flight_details ON ${flight_media_details_base.flight_id} = ${flight_details.flight_id} {% endif %} ;;
    relationship: many_to_one
  }

  join: flight_demand_units_budget{
    relationship: many_to_one
    sql_on: ${flight_demand_units_budget.flight_id} = ${flight_details.flight_id}
    and ${flight_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: campaign_details_base {
    relationship: many_to_one
    sql_on: ${flight_details.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: expected_delivery {
    relationship: one_to_many
    sql_on: {% if flight_details.flight_id._in_query or flight_details.flight_description._in_query or flight_media_details_base.flight_description._in_query %} ${flight_details.flight_id} = ${expected_delivery.flight_id}
            {% else %} ${campaign_details_base.campaign_id} = ${expected_delivery.campaign_id}  {% endif %} ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${timezone.timezone_id} ;;
  }

  join: pl_plan {
    relationship: many_to_one
    sql_on: ${campaign_details_base.pl_plan_id} = ${pl_plan.pl_plan_id};;
  }

  join: campaign_days {
    relationship: many_to_one
    sql_on: ${flight_details.campaign_id} = ${campaign_days.campaign_id} ;;
  }

  join: campaign_objectives {
    relationship: one_to_one
    sql_on: ${campaign_objectives.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: campaign_demand_units_budget{
    relationship: many_to_one
    sql_on: ${campaign_details_base.campaign_id} = ${campaign_demand_units_budget.campaign_id}
    and ${campaign_demand_units_budget.flight_id} IS NULL
    and ${campaign_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: required_delivery_today {
    relationship: many_to_one
    sql_on: ${daily_core_stats.flight_media_id} = ${required_delivery_today.flight_media_id} ;;
  }

  join: customer_details {
    relationship: many_to_one
    sql: {% if customer_details.future_customers._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.CUSTOMER_DETAILS  AS customer_details ON ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
  }

  join: customer_country {
    relationship: many_to_one
    sql_on: ${customer_details.country_id} = ${customer_country.country_id} ;;
  }

  join: advertiser_brand_details {
    relationship: many_to_one
    sql: {% if advertiser_brand_details.future_advertisers._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.ADVERTISER_BRAND_DETAILS  AS advertiser_brand_details ON ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
  }

  join:  insertion_order_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.insertion_order_id} = ${insertion_order_details.insertion_order_id};;
  }

  join:  account_exec {
    relationship: many_to_one
    sql_on: ${insertion_order_details.account_rep} = ${account_exec.id} ;;
  }

  join: placement_details_base {
    relationship: many_to_one
    sql_on: ${placement_details_base.placement_id} = ${daily_core_stats.placement_id} ;;
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
  }

  join: supply_platform_client {
    from: platform_client
    relationship: many_to_one
    sql_on: ${placement_details_base.platform_client_id} = ${supply_platform_client.platform_client_id} ;;
    view_label: "Supply Platform Client"
    fields: [business_region, office_name, platform_client_active]
  }

  join: reach_and_frequency {
    relationship: many_to_one
    sql_on: ${reach_and_frequency.flight_media_id} = ${daily_core_stats.flight_media_id}
      AND ${reach_and_frequency.placement_id} = ${daily_core_stats.placement_id}
      AND ${reach_and_frequency.demand_date} = ${daily_core_stats.demand_raw} ;;
  }

  join: daily_core_stats_yesterday {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.flight_media_id} = ${daily_core_stats_yesterday.flight_media_id}
    {% if placement_details_base._in_query %} AND PLACEMENT_DETAILS_BASE.placement_id = ${daily_core_stats_yesterday.placement_id} {% endif %} ;;
  }

  join: insertion_order_demand_units_budget {
    relationship: many_to_one
    sql_on: ${insertion_order_demand_units_budget.insertion_order_id} = ${insertion_order_details.insertion_order_id}
    and ${insertion_order_demand_units_budget.pl_plan_id} IS NULL
    and ${insertion_order_demand_units_budget.campaign_id} IS NULL
    and ${insertion_order_demand_units_budget.flight_id} IS NULL
    and ${insertion_order_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: campaign_addon_product {
    relationship: one_to_many
    sql_on: ${campaign_addon_product.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: campaign_product{
    relationship: one_to_one
    fields: []
    sql_on: ${campaign_product.product_id}  = ${campaign_addon_product.product_id};;
  }

  join: campaign_product_exchange_rates {
    from: hourly_exchange_rates
    relationship: many_to_one
    fields: []
    sql_on: ${platform_client.default_currency_id} = ${campaign_product_exchange_rates.currency_id_to}
          and ${campaign_product_exchange_rates.currency_id_from} = ${campaign_product.currency_id}
          and ${campaign_product_exchange_rates.key_date_raw} = current_date ;;
  }

  join: campaign_target_description {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.campaign_id} = ${campaign_target_description.campaign_id};;
  }

  join: campaign_pacing_by_day {
  view_label: "Impression Metrics"
    relationship: many_to_one
    sql_on: ${daily_core_stats.demand_raw} = ${campaign_pacing_by_day.demand_date}
          and ${campaign_details_base.campaign_id} = ${campaign_pacing_by_day.campaign_id} ;;
  }

  join: trafficked_flights {
    relationship: one_to_one
    type: inner
    sql_on: ${flight_details.flight_id} = ${trafficked_flights.flight_id} ;;
  }

  join: plan_currency {
    relationship: one_to_one
    sql_on: ${plan_currency.currency_id} = ${pl_plan.native_currency_id} ;;
  }

  join: campaign_postalcode {
    relationship: one_to_many
    sql_on: ${campaign_details_base.campaign_id} = ${campaign_postalcode.campaign_id} ;;
  }

  join: pl_plan_agg {
    relationship: many_to_one
    sql_on: ${campaign_details_base.pl_plan_id} = ${pl_plan_agg.pl_plan_id} ;;
  }

  join: campaign_geolocation {
    relationship: one_to_one
    sql_on: ${campaign_details_base.campaign_id} = ${campaign_geolocation.campaign_id} ;;
  }

}


explore: daily_data_usage {

  label: "Data Usage Metrics"
  description: "This explore includes data provider cost and usage metrics. Cost and usage metrics are recorded when data on a user is used to deliver an impression.
  Cost and usage are commonly segmented down to source provider, data provider, payee provider and retargeting attribute. The data is available by-day, as far back as January 2014."
  sql_always_where: ({% if daily_data_usage.demand_date_date._in_query or daily_data_usage.demand_date_week._in_query %}COALESCE(${daily_data_usage.demand_date_raw}, '9999-12-31') >= (SELECT MIN(DEMAND_DATE) FROM EDW.daily_data_usage)
                    {% elsif daily_data_usage.EST_date_date._in_query or daily_data_usage.EST_date_week._in_query %}COALESCE(${daily_data_usage.est_date_raw}, '9999-12-31') >= (SELECT MIN(EST_DATE) FROM EDW.daily_data_usage)
                    {% elsif daily_data_usage.gmt_date_date._in_query or daily_data_usage.gmt_date_week._in_query %}COALESCE(${daily_data_usage.gmt_date_raw}, '9999-12-31') >= (SELECT MIN(GMT_DATE) FROM EDW.daily_data_usage)
                    {% elsif daily_data_usage.region_date_date._in_query or daily_data_usage.region_date_week._in_query %}COALESCE(${daily_data_usage.region_date_raw}, '9999-12-31') >= (SELECT MIN(REGION_DATE) FROM EDW.daily_data_usage)
                    {% else %}TRUE{% endif %}) AND
                    ({% if _user_attributes['access_filter_office_id'] == '>=0, NULL' %} TRUE {% else %} (${platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }}) OR ${supply_platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }})) {% endif %}) AND
                    ({% if _user_attributes['access_filter_platform_client_id'] == '>=0, NULL' %} TRUE {% else %} (${campaign_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${platform_client.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) {% endif %}) AND
                    ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${campaign_details_base.platform_client_id} IS NULL OR ${campaign_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) AND (${placement_details_base.platform_client_id} IS NULL OR ${placement_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;
  fields: [ALL_FIELDS*, -advertiser_brand_details.future_advertisers, -customer_details.future_customers]

  join: flight_media_details_base {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.flight_media_id} = ${daily_data_usage.flight_media_id} ;;
  }

  join: demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${demand_mart_load_tracking.start_timezone} and
      ${demand_mart_load_tracking.schema_name} = 'demand_mart' and
      ${demand_mart_load_tracking.table_name} = 'daily_core_stats' ;;
  }

  join: flight_details {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.flight_id} = ${flight_details.flight_id} ;;
  }

  join: campaign_details_base {
    relationship: many_to_one
    sql_on: ${flight_details.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${timezone.timezone_id} ;;
  }

  join: campaign_days {
    relationship: many_to_one
    sql_on: ${flight_details.campaign_id} = ${campaign_days.campaign_id} ;;
  }

  join: customer_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
  }

  join: customer_country {
    relationship: many_to_one
    sql_on: ${customer_details.country_id} = ${customer_country.country_id} ;;
  }


  join: advertiser_brand_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
  }

  join:  insertion_order_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.insertion_order_id} = ${insertion_order_details.insertion_order_id};;
  }

  join: placement_details_base {
    relationship: many_to_one
    sql_on: ${placement_details_base.placement_id} = ${daily_data_usage.placement_id} ;;
  }

  join: demo_provider {
    relationship: many_to_one
    sql_on: ${demo_provider.user_data_vendor_id} = ${daily_data_usage.data_provider_id}
    and ${daily_data_usage.data_cost_type} = 2;;
  }

  join: retargeting_attribute {
    relationship: many_to_one
    sql_on: ${daily_data_usage.cost_attribute_id} = ${retargeting_attribute.retargeting_attribute_id} ;;
  }

  join: user_data_vendor {
    relationship: many_to_one
    sql_on: ${daily_data_usage.data_provider_id} = ${user_data_vendor.user_data_vendor_id} ;;
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${platform_client.platform_client_id} = ${campaign_details_base.platform_client_id} ;;
  }

  join: supply_platform_client {
    from: platform_client
    relationship: many_to_one
    sql_on: ${placement_details_base.platform_client_id} = ${supply_platform_client.platform_client_id} ;;
    view_label: "Supply Platform Client"
    fields: [business_region, office_name, platform_client_active]
  }
}


explore: demand_metrics {

  view_name: daily_core_stats
  label: "Demand Metrics"
  description: "This explore includes impression metrics along with the demand dimensions they can be aggregated by. Additional demand metrics such as CCP and allocation,
  and the absence of supply dimensions differentiate this from the 'Impression Metrics' explore. Data is available by-day, as far back as November 2015.
  You will only find demand which has had delivery, campaigns which have yet to have
  any impressions delivered will not appear in this explore."
  access_filter: {
    field: platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: campaign_details_base.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if daily_core_stats.demand_date._in_query or daily_core_stats.demand_week._in_query %}COALESCE(${daily_core_stats.demand_raw}, '9999-12-31') >= (SELECT MIN(DEMAND_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% elsif daily_core_stats.EST_date._in_query or daily_core_stats.EST_week._in_query %}COALESCE(${daily_core_stats.EST_raw}, '9999-12-31') >= (SELECT MIN(EST_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% elsif daily_core_stats.gmt_date._in_query or daily_core_stats.gmt_week._in_query %}COALESCE(${daily_core_stats.gmt_raw}, '9999-12-31') >= (SELECT MIN(GMT_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% elsif daily_core_stats.region_date._in_query or daily_core_stats.region_week._in_query %}COALESCE(${daily_core_stats.region_raw}, '9999-12-31') >= (SELECT MIN(REGION_DATE) FROM DEMAND_MART.DAILY_CORE_STATS)
                      {% else %}TRUE{% endif %}) AND
                      ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${campaign_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) AND (${platform_client.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;
  join: daily_core_stats_yesterday_demand {
    relationship: many_to_one
    sql_on: ${daily_core_stats.flight_media_id} = ${daily_core_stats_yesterday_demand.flight_media_id}
      and ${daily_core_stats.placement_id} = ${daily_core_stats_yesterday_demand.placement_id};;
  }

  join: mediaplanner_allocation_view {
    type: full_outer
    relationship: many_to_many
    sql_on: ${daily_core_stats.flight_media_id} = ${mediaplanner_allocation_view.flight_media_id} and
            ${daily_core_stats._demand_date} = ${mediaplanner_allocation_view.allocation_date_date} ;;
  }

  join: mediaplanner_allocation_yesterday {
    type: full_outer
    relationship: many_to_one
    sql_on: {% if mediaplanner_allocation_view._in_query %}COALESCE(${daily_core_stats.flight_media_id}, mediaplanner_allocation_view.FLIGHT_MEDIA_ID){% else %}${daily_core_stats.flight_media_id}{% endif %} = ${mediaplanner_allocation_yesterday.flight_media_id} ;;
  }

  join:  daily_ccp_metrics {
    type: full_outer
    relationship: many_to_one
    sql_on: ${daily_ccp_metrics.flight_media_id} = {% if mediaplanner_allocation_view._in_query or mediaplanner_allocation_yesterday._in_query %}COALESCE(${daily_core_stats.flight_media_id}{% if mediaplanner_allocation_view._in_query %}, mediaplanner_allocation_view.FLIGHT_MEDIA_ID{% endif %}{% if mediaplanner_allocation_yesterday._in_query %}, mediaplanner_allocation_yesterday.FLIGHT_MEDIA_ID{% endif %}){% else %}${daily_core_stats.flight_media_id}{% endif %}
      and ${daily_ccp_metrics.keydate_raw} = {% if daily_core_stats.gmt_date._is_selected
        or daily_core_stats.gmt_week._is_selected or daily_core_stats.gmt_month._is_selected
        or daily_core_stats.gmt_quarter._is_selected or daily_core_stats.gmt_year._is_selected %}{% if mediaplanner_allocation_view._in_query %}COALESCE(${daily_core_stats.gmt_raw}, mediaplanner_allocation_view.ALLOCATION_DATE){% else %}${daily_core_stats.gmt_raw}{% endif %}{% else %}{% if mediaplanner_allocation_view._in_query %}COALESCE(${daily_core_stats.demand_raw}, mediaplanner_allocation_view.ALLOCATION_DATE){% else %}${daily_core_stats.demand_raw}{% endif %}{% endif %} ;;
  }

  join: flight_media_details_base {
    relationship: many_to_one
    sql: {% if flight_media_details_base.future_flight_media._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.FLIGHT_MEDIA_DETAILS_BASE  AS flight_media_details_base ON {% if mediaplanner_allocation_view._in_query or mediaplanner_allocation_yesterday._in_query or daily_ccp_metrics._in_query %}COALESCE(${daily_core_stats.flight_media_id}{% if mediaplanner_allocation_view._in_query %}, mediaplanner_allocation_view.FLIGHT_MEDIA_ID{% endif %}{% if mediaplanner_allocation_yesterday._in_query %}, mediaplanner_allocation_yesterday.FLIGHT_MEDIA_ID{% endif %}{% if daily_ccp_metrics._in_query %}, daily_ccp_metrics.FLIGHT_MEDIA_ID{% endif %}){% else %}${daily_core_stats.flight_media_id}{% endif %} = ${flight_media_details_base.flight_media_id} ;;
  }

  join: demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${demand_mart_load_tracking.start_timezone} and
      ${demand_mart_load_tracking.schema_name} = 'demand_mart' and
      ${demand_mart_load_tracking.table_name} = 'daily_core_stats' ;;
  }

  join: demand_mart_load_tracking_start_timezone {
    relationship: many_to_one
    sql_on: ${demand_mart_load_tracking.start_timezone} = ${demand_mart_load_tracking_start_timezone.timezone_id} ;;
  }

  join: flight_details {
    sql: {% if flight_details.future_flights._in_query %}FULL OUTER JOIN DIM.FLIGHT_DETAILS AS flight_details ON ${flight_media_details_base.flight_id} = ${flight_details.flight_id}
      {% else %}LEFT JOIN DIM.FLIGHT_DETAILS AS flight_details ON ${flight_media_details_base.flight_id} = ${flight_details.flight_id} {% endif %} ;;
    relationship: many_to_one
  }

  join: trafficked_flights {
    relationship: one_to_one
    type: inner
    sql_on: ${flight_details.flight_id} = ${trafficked_flights.flight_id} ;;
  }

  join: required_delivery_today {
    relationship: many_to_one
    sql_on: ${daily_core_stats.flight_media_id} = ${required_delivery_today.flight_media_id} ;;
  }

  join: campaign_details_base {
    relationship: many_to_one
    sql: {% if campaign_bookings._in_query %}FULL OUTER JOIN DIM.CAMPAIGN_DETAILS_BASE AS campaign_details_base ON ${flight_details.campaign_id} = ${campaign_details_base.campaign_id}
      {% else %}LEFT JOIN DIM.CAMPAIGN_DETAILS_BASE AS campaign_details_base ON ${flight_details.campaign_id} = ${campaign_details_base.campaign_id} {% endif %} ;;
  }

  join: expected_delivery {
    relationship: one_to_many
    sql_on: {% if flight_details.flight_id._in_query or flight_details.flight_description._in_query or flight_media_details_base.flight_description._in_query %} ${flight_details.flight_id} = ${expected_delivery.flight_id}
            {% else %} ${campaign_details_base.campaign_id} = ${expected_delivery.campaign_id}  {% endif %} ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${timezone.timezone_id} ;;
  }

  join: pl_plan {
    relationship: many_to_one
    sql_on: ${campaign_details_base.pl_plan_id} = ${pl_plan.pl_plan_id};;
  }

  join: campaign_days {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.campaign_id} = ${campaign_days.campaign_id} ;;
  }

  join: customer_details {
    relationship: many_to_one
    sql: {% if customer_details.future_customers._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.CUSTOMER_DETAILS  AS customer_details ON ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
  }

  join: campaign_bookings {
    relationship: many_to_one
    sql_on: ${campaign_bookings.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: customer_country {
    relationship: many_to_one
    sql_on: ${customer_details.country_id} = ${customer_country.country_id} ;;
  }


  join: advertiser_brand_details {
    relationship: many_to_one
    sql: {% if advertiser_brand_details.future_advertisers._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.ADVERTISER_BRAND_DETAILS  AS advertiser_brand_details ON ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
  }

  join:  insertion_order_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.insertion_order_id} = ${insertion_order_details.insertion_order_id};;
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
  }

  join: flight_demand_units_budget {
    relationship: many_to_one
    sql_on: ${flight_details.flight_id} = ${flight_demand_units_budget.flight_id}
      and ${flight_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: campaign_demand_units_budget {
    relationship: many_to_one
    sql_on: ${campaign_details_base.campaign_id} = ${campaign_demand_units_budget.campaign_id}
          and ${campaign_demand_units_budget.flight_id} IS NULL
          and ${campaign_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: insertion_order_demand_units_budget {
    relationship: many_to_one
    sql_on: ${insertion_order_demand_units_budget.insertion_order_id} = ${insertion_order_details.insertion_order_id}
          and ${insertion_order_demand_units_budget.pl_plan_id} IS NULL
          and ${insertion_order_demand_units_budget.campaign_id} IS NULL
          and ${insertion_order_demand_units_budget.flight_id} IS NULL
          and ${insertion_order_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: campaign_target_description {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.campaign_id} = ${campaign_target_description.campaign_id};;
  }

  join: campaign_pacing_by_day {
    view_label: "Impression Metrics"
    relationship: many_to_one
    sql_on: ${daily_core_stats.demand_raw} = ${campaign_pacing_by_day.demand_date}
      and ${campaign_details_base.campaign_id} = ${campaign_pacing_by_day.campaign_id} ;;
  }

  join: campaign_postalcode {
    relationship: one_to_many
    sql_on: ${campaign_details_base.campaign_id} = ${campaign_postalcode.campaign_id} ;;
  }

  join: pl_plan_agg {
    relationship: many_to_one
    sql_on: ${campaign_details_base.pl_plan_id} = ${pl_plan_agg.pl_plan_id} ;;
  }

  join: campaign_geolocation {
    relationship: one_to_one
    sql_on: ${campaign_details_base.campaign_id} = ${campaign_geolocation.campaign_id} ;;
  }
}

explore: conversion_fact {
  required_access_grants: [can_use_explore]
  label: "Conversion Metrics"
  description: "This explore includes conversion metrics along with the supply and demand dimensions they can be aggregated by. Conversions are recorded when a pixel is fired, usually associated with a campaign.
  Advertisers will place these pixels on their sites to record some action being done by the user. This data is available by-hour, as far back as August 2013."
  fields: [ALL_FIELDS*, -advertiser_brand_details.future_advertisers]

  join: action_pixel {
    relationship: many_to_one
    sql_on: ${action_pixel.action_pixel_id} = ${conversion_fact.action_pixel_id} ;;
  }

  join: flight_media_details_base {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.flight_media_id} = ${conversion_fact.flight_media_id} ;;
  }

  join: demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${demand_mart_load_tracking.start_timezone} and
      ${demand_mart_load_tracking.schema_name} = 'demand_mart' and
      ${demand_mart_load_tracking.table_name} = 'daily_core_stats' ;;
  }

  join: flight_details {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.flight_id} = ${flight_details.flight_id} ;;
  }

  join: campaign_details_base {
    relationship: many_to_one
    sql_on: ${flight_details.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${timezone.timezone_id} ;;
  }

  join: campaign_days {
    relationship: many_to_one
    sql_on: ${flight_details.campaign_id} = ${campaign_days.campaign_id} ;;
  }

  join: advertiser_brand_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
  }

  join: placement_details_base {
    relationship: many_to_one
    sql_on: ${placement_details_base.placement_id} = ${conversion_fact.placement_id} ;;
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
  }

  join: daypart {
    relationship: many_to_one
    sql_on: ${daypart.daypart_id} = ${conversion_fact.daypart} ;;
  }

  join: geodata {
    relationship: many_to_one
    sql_on: ${geodata.geoid} = ${conversion_fact.geo} ;;
  }


}

explore: survey_fact_derived {
  required_access_grants: [can_use_explore]
  label: "Brandscore Metrics"
  description: "Survey and Brandscore Metrics."
}


explore: tpm_metrics {

  hidden: yes
  label: "Third Party Metrics"
  description: "This explore includes metrics that we have ingested from Third Parties."

  join: campaign_details_base {
    relationship: many_to_one
    sql_on: ${campaign_details_base.campaign_id} = ${tpm_metrics.campaign_id} ;;
  }

  join: flight_media_details_base {
    relationship: many_to_one
    sql_on: ${campaign_details_base.campaign_id} = ${flight_media_details_base.campaign_id} ;;
  }

  join: demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${demand_mart_load_tracking.start_timezone} and
      ${demand_mart_load_tracking.schema_name} = 'demand_mart' and
      ${demand_mart_load_tracking.table_name} = 'daily_core_stats' ;;
  }

  join: campaign_days {
    relationship: many_to_one
    sql_on: ${tpm_metrics.campaign_id} = ${campaign_days.campaign_id} ;;
  }

  join: placement_details_base {
    relationship: many_to_one
    sql_on: ${placement_details_base.placement_id} = ${tpm_metrics.placement_id}  ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${campaign_details_base.timezone_id} = ${timezone.timezone_id} ;;
    fields: []
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
    fields: []
  }
}

explore: raw_impression {

  label: "Raw Impression Metrics"
  description: "This explore includes raw impression metrics. This data can be analyzed by nearly any facet that is available down to the raw detail of a single impression.
  This data is only available for the last seven days."
  sql_always_where: ({% if _user_attributes['access_filter_office_id'] == '>=0, NULL' %} TRUE {% else %} (${platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }}) OR ${supply_platform_client.office_id} IN ({{ _user_attributes['access_filter_office_id'] }})) {% endif %}) AND
                    ({% if _user_attributes['access_filter_platform_client_id'] == '>=0, NULL' %} TRUE {% else %} (${campaign_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) OR (${platform_client.platform_client_id} IN ({{ _user_attributes['access_filter_platform_client_id'] }})) {% endif %}) AND
                    ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${campaign_details_base.platform_client_id} IS NULL OR ${campaign_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) AND (${placement_details_base.platform_client_id} IS NULL OR ${placement_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;
  fields: [ALL_FIELDS*, -advertiser_brand_details.future_advertisers, -customer_details.future_customers, -daily_ccp_metrics.exp_rev, -daily_ccp_metrics.sum_daily_ccp_eoc_audit_yesterday, -daily_ccp_metrics.daily_ccp_eoc_audit_diff_yesterday_gmt]

  join: bt_cost_attributes {
    view_label: "Raw Impression Metrics"
    relationship: one_to_many
    type: cross
  }

  join: flight_media_details_base {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.flight_media_id} = ${raw_impression.flight_media} ;;
  }

  join: demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${demand_mart_load_tracking.start_timezone} and
      ${demand_mart_load_tracking.schema_name} = 'demand_mart' and
      ${demand_mart_load_tracking.table_name} = 'daily_core_stats' ;;
  }

  join: flight_details {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.flight_id} = ${flight_details.flight_id} ;;
  }

  join: campaign_details_base {
    relationship: many_to_one
    sql_on: ${flight_details.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: campaign_days {
    relationship: many_to_one
    sql_on: ${flight_details.campaign_id} = ${campaign_days.campaign_id} ;;
  }

  join: campaign_pacing_by_day {
    view_label: "Raw Impression Metrics"
    relationship: many_to_one
    sql_on: ${raw_impression.demand_date_raw} = ${campaign_pacing_by_day.demand_date}
      and ${campaign_details_base.campaign_id} = ${campaign_pacing_by_day.campaign_id} ;;
  }

  join: advertiser_brand_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
  }

  join:  insertion_order_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.insertion_order_id} = ${insertion_order_details.insertion_order_id};;
  }

  join:  account_exec {
    relationship: many_to_one
    sql_on: ${insertion_order_details.account_rep} = ${account_exec.id} ;;
  }

  join: placement_details_base {
    relationship: many_to_one
    sql_on: ${placement_details_base.placement_id} = ${raw_impression.placement_id} ;;
  }

  join: bt_data_provider_core {
    relationship: many_to_one
    sql_on: ${bt_cost_attributes.bt_provider} = ${bt_data_provider_core.user_data_vendor_id} ;;
  }

  join: bt_cluster_provider_core {
    relationship: many_to_one
    sql_on: ${raw_impression.bt_cluster_provider} = ${bt_cluster_provider_core.user_data_vendor_id} ;;
  }

  join: demo_provider {
    relationship: many_to_one
    sql_on: ${raw_impression.demoproviderid} = ${demo_provider.user_data_vendor_id} ;;
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
  }

  join: supply_platform_client {
    from: platform_client
    relationship: many_to_one
    sql_on: ${placement_details_base.platform_client_id} = ${supply_platform_client.platform_client_id} ;;
    view_label: "Supply Platform Client"
    fields: [business_region, office_name, platform_client_active]
  }

  join: customer_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${timezone.timezone_id} ;;
  }

  join: campaign_details_plan {
    relationship: many_to_one
    sql_on: ${raw_impression.campaign_id} = ${campaign_details_plan.campaign_id} ;;
  }

  join: hourly_exchange_rates {
    relationship: many_to_one
    sql_on: ${raw_impression.payout_currency} = ${hourly_exchange_rates.currency_from}
              AND date_trunc('hour', ${raw_impression.keydate_raw}) = ${hourly_exchange_rates.keydate}
              AND ${hourly_exchange_rates.currency_to} = 'USD';;
  }

  join: conversion_fact {
    relationship: many_to_many
    sql_on: ${raw_impression.adid} = ${conversion_fact.exposure_uniqueid} and
            ${raw_impression.flight_media} = ${conversion_fact.flight_media_id} and
            ${raw_impression.placement_id} = ${conversion_fact.placement_id} ;;
  }

  join: action_pixel {
    relationship: many_to_one
    sql_on: ${conversion_fact.action_pixel_id} = ${action_pixel.action_pixel_id} ;;
  }

  join: brand_frequency_cap_violations {
    relationship: one_to_one
    sql_on: ${raw_impression.pk_id} = ${brand_frequency_cap_violations.pk_id};;
  }

  join: placement_frequency_cap_violations {
    relationship: one_to_one
    sql_on: ${raw_impression.pk_id} = ${placement_frequency_cap_violations.pk_id};;
  }

  join: flight_frequency_cap_violations {
    relationship: one_to_one
    sql_on: ${raw_impression.pk_id} = ${flight_frequency_cap_violations.pk_id};;
  }

  join: flight_media_frequency_cap_violations {
    relationship: one_to_one
    sql_on: ${raw_impression.pk_id} = ${flight_media_frequency_cap_violations.pk_id};;
  }
  join: campaign_frequency_cap_violations {
    relationship: one_to_one
    sql_on: ${raw_impression.pk_id} = ${campaign_frequency_cap_violations.pk_id};;
  }

  join: plan_frequency_cap_violations {
    relationship: one_to_one
    sql_on: ${raw_impression.pk_id} = ${plan_frequency_cap_violations.pk_id};;
  }

  join: insertion_order_demand_units_budget {
    relationship: many_to_one
    sql_on: ${insertion_order_demand_units_budget.insertion_order_id} = ${insertion_order_details.insertion_order_id}
          and ${insertion_order_demand_units_budget.pl_plan_id} IS NULL
                and ${insertion_order_demand_units_budget.campaign_id} IS NULL
                and ${insertion_order_demand_units_budget.flight_id} IS NULL
                and ${insertion_order_demand_units_budget.flight_media_id} IS NULL;;
  }

  join:  daily_ccp_metrics {
    type: full_outer
    relationship: many_to_one
    sql_on: ${daily_ccp_metrics.campaign_id} = ${raw_impression.campaign_id}
      and ${daily_ccp_metrics.keydate_raw} = ${raw_impression.keydate_date} ;;
  }

  join: partner_media {
    view_label: "Media"
    relationship: many_to_many
    sql_on: ${flight_media_details_base.media_id} = ${partner_media.media_id} AND ${placement_details_base.partner_id} = ${partner_media.partner_id} ;;
  }

  join: sno_opt_misdelivery {
    view_label: "Raw Impression Metrics"
    relationship: many_to_many
    sql_on: ${raw_impression.keydate_date} = ${sno_opt_misdelivery.keydate} AND ${raw_impression.campaign_id} = ${sno_opt_misdelivery.campaign_id} ;;
  }

  join: campaign_first_delivery {
    view_label: "Campaign"
    relationship: one_to_one
    sql_on: ${campaign_details_base.campaign_id} = ${campaign_first_delivery.campaign_id} ;;
  }
}


explore: portfolio_trends {

  label: "Portfolio Trends"
  description: "This explore includes Portfolio Trends and can be sliced by various demand-level dimensions."
  access_filter: {
    field: platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: campaign_details_base.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${campaign_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;

  fields: [ALL_FIELDS*, -advertiser_brand_details.future_advertisers, -customer_details.future_customers]

  join: campaign_details_base {
    relationship: many_to_one
    sql_on: ${portfolio_trends.campaign} = ${campaign_details_base.campaign_id} ;;
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
  }

  join: flight_media_details_base {
    relationship: many_to_one
    fields: []
    sql_on: ${campaign_details_base.campaign_id} = ${flight_media_details_base.campaign_id} ;;
  }

  join: advertiser_brand_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
  }

  join:  insertion_order_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.insertion_order_id} = ${insertion_order_details.insertion_order_id};;
  }
  join: customer_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${campaign_details_base.timezone_id} = ${timezone.timezone_id} ;;
  }

}

explore: daily_campaign_retargeting_stats {
  required_access_grants: [can_use_explore]
  label: "Campaign Targeted/Untargeted Stats"
  description:"This explore includes data segments where campaigns have delivered (Retargeting Billable impressions)"
  fields: [ALL_FIELDS*,-campaign_details_base.agency_fee, -advertiser_brand_details.future_advertisers, -customer_details.future_customers]

  join: campaign_details_base {
    relationship: many_to_one
    sql_on: ${campaign_details_base.campaign_id} = ${daily_campaign_retargeting_stats.campaign_id} ;;
  }

#   join: flight_media_details_base {
#     relationship: one_to_many
#     sql_on: ${campaign_details_base.campaign_id} = ${flight_media_details_base.campaign_id} ;;
#   }

  join: advertiser_brand_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
  }

  join: customer_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
  }

  join: retargeting_attribute {
    relationship: many_to_one
    sql_on: ${daily_campaign_retargeting_stats.retargeting_attribute_id} = ${retargeting_attribute.retargeting_attribute_id} ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${campaign_details_base.timezone_id} = ${timezone.timezone_id} ;;
    fields: []
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
    fields: []
  }
}

explore: sno_demand_raw_impression_validation {
  required_access_grants: [can_use_explore]
  label: "Demand Raw Impression Validation"
  hidden: yes

  always_filter: {
    filters: [sno_demand_raw_impression_validation.demand_date: "3 days"]
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${sno_demand_raw_impression_validation.timezone_id} = ${timezone.timezone_id} ;;
  }

  join: sno_demand_validation {
    relationship: one_to_many
    sql_on:
      ${sno_demand_raw_impression_validation.demand_date} = ${sno_demand_validation.demand_date}
      AND ${sno_demand_raw_impression_validation.timezone_id} = ${sno_demand_validation.timezone_id};;
  }
}

explore: sno_supply_raw_impression_validation {
  required_access_grants: [can_use_explore]
  label: "Supply Raw Impression Validation"
  hidden: yes

  always_filter: {
    filters: [sno_supply_raw_impression_validation.supply_date: "3 days"]
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${sno_supply_raw_impression_validation.timezone_id} = ${timezone.timezone_id} ;;
  }

  join: sno_supply_validation {
    relationship: one_to_many
    sql_on:
      ${sno_supply_raw_impression_validation.supply_date} = ${sno_supply_validation.supply_date}
      AND ${sno_supply_raw_impression_validation.timezone_id} = ${sno_supply_validation.timezone_id};;
  }
}

explore: demand_warehouse_validation {

  label: "Demand Warehouse Validation"
  hidden: yes
}

explore: supply_warehouse_validation {

  label: "Supply Warehouse Validation"
  hidden: yes

}

explore: retarg_by_vendor_coverage {
  required_access_grants: [can_use_explore]
  hidden: yes
  label: "Source Provider Coverage Metrics"
  description: "Vendors that have provided BT attributes within sampled request data are extracted to estimate overall source provider coverage.
  No metric from this dataset should be compared to anything else since it’s not using the same data source. Data is available for the last 90 days."
}

explore: lm_serendipity {
  required_access_grants: [can_use_explore]
  label: "Lucy Slice and Dice"
  group_label: "Lucy Slice and Dice"
}

explore: blacklist_whitelist{

  view_name: sno_blacklist_whitelist
  label: "Blacklist Whitelist Report"
  description: "Blacklist Whitelist Tracking Report"
  access_filter: {
    field: platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: placement_details_base.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${placement_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;

  join: sno_bl_wl_pid_hour_requests {
    relationship: many_to_one
    type: left_outer
    sql_on:
    ${sno_blacklist_whitelist.placement_id} =  ${sno_bl_wl_pid_hour_requests.placement_id}
    AND ${sno_blacklist_whitelist.keydate_raw} =  ${sno_bl_wl_pid_hour_requests.keydate}
    ;;
  }

  join: placement_details_base {
    relationship: many_to_one
    sql_on: ${placement_details_base.placement_id} = ${sno_blacklist_whitelist.placement_id} ;;
    fields: [placement_country_id, platform_client_id]
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${placement_details_base.placement_timezone_id} = ${timezone.timezone_id} ;;
    fields: []
  }

  join: platform_client {
    relationship: many_to_one
    view_label: "Supply Platform Client"
    sql_on: ${placement_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
    fields: [platform_client.office_id]
  }

}

explore: suggest_demand_ref {

  access_filter: {
    field: suggest_demand_ref.country_id
    user_attribute: access_filter_country_id
  }
  access_filter: {
    field: suggest_demand_ref.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${suggest_demand_ref.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;

  hidden: yes
}

explore: suggest_supply_ref {

  access_filter: {
    field: suggest_supply_ref.placement_country_id
    user_attribute: access_filter_country_id
  }
  access_filter: {
    field: suggest_supply_ref.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${suggest_supply_ref.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;

  hidden: yes
}

explore: sno_load_tracking_whse_validation {
  required_access_grants: [can_use_explore]
  label: "Load tracking warehouse validation"
  view_name: timezone

  join: sno_demand_load_tracking_whse_validation {
    relationship: one_to_many
    sql_on: ${timezone.timezone_id} = ${sno_demand_load_tracking_whse_validation.start_timezone} ;;
  }

  join: sno_supply_load_tracking_whse_validation {
    relationship: one_to_many
    sql_on: ${timezone.timezone_id} = ${sno_supply_load_tracking_whse_validation.start_timezone} ;;
  }
}

explore: sno_sas_monitoring {
  required_access_grants: [can_use_explore]
  label: "SAS forecasting monitoring"
  view_name: sno_fce_atv_fdp_data_prod

  join: sno_fce_atv_fdp_data_itv {
    relationship: many_to_many
    sql_on: ${sno_fce_atv_fdp_data_prod.start_date_time} = ${sno_fce_atv_fdp_data_itv.start_date_time};;
  }

  join: sno_fce_atv_fdp_data_sbx {
    relationship: many_to_many
    sql_on: ${sno_fce_atv_fdp_data_prod.start_date_time} = ${sno_fce_atv_fdp_data_sbx.start_date_time};;
  }
}

explore: fce_atv_fdp_forecasts_data {

  label: "ITV Forecast"
  description: "This explore includes forecasting data. This data can be fetched for specific forecast - use Forecasts Info parameters to filter for required forecast."
  # sql_always_where: acess is limited by filtering in fce_atv_fdp_forecasts_info view
  always_join: [fce_atv_fdp_forecasts_info] # important for access limiting


  join: fce_atv_fdp_forecasts_info {
    relationship: many_to_one
    type: inner # important for access limiting
    sql_on: ${fce_atv_fdp_forecasts_data.iid} = ${fce_atv_fdp_forecasts_info.iid} ;;
  }

  join: fce_atv_fdp_data_attr {
    relationship: many_to_one
    sql_on: ${fce_atv_fdp_forecasts_data.pool_id} = ${fce_atv_fdp_data_attr.pool_id} ;;
  }
}

explore: sno_opt_viewing_spot_level_pacing {
  required_access_grants: [can_use_explore]
  label: "OPT Pacing"

  fields: [ALL_FIELDS*,-campaign_details_base.agency_fee]

  join: sno_opt_pacing_report_approval {
    relationship: many_to_one
    sql_on: ${sno_opt_viewing_spot_level_pacing.report_id} = ${sno_opt_pacing_report_approval.report_id} ;;
  }

  join: sno_opt_viewing_spot_level_pacing_latest_report {
    relationship: many_to_one
    sql_on: ${sno_opt_viewing_spot_level_pacing.campaign_id} = ${sno_opt_viewing_spot_level_pacing_latest_report.campaign_id} AND ${sno_opt_viewing_spot_level_pacing.run_raw} = ${sno_opt_viewing_spot_level_pacing_latest_report.latest_run_date} ;;
  }

  join: sno_converged_approved_campaigns {
    relationship: many_to_one
    sql_on: ${sno_opt_viewing_spot_level_pacing.campaign_id} = ${sno_converged_approved_campaigns.campaign_id} and ${sno_converged_approved_campaigns.approved_campaign_status} in (3,4) ;;
  }

  join: campaign_details_base {
    relationship: many_to_one
    sql_on: ${sno_opt_viewing_spot_level_pacing.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: flight_details {
    relationship: one_to_many
    sql_on: ${campaign_details_base.campaign_id} = ${flight_details.campaign_id} ;;
    fields: []
  }

  join: flight_media_details_base {
    relationship: many_to_one
    sql_on: ${flight_details.flight_id} = ${flight_media_details_base.flight_id} ;;
    fields: []
  }

  join: advertiser_brand_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
  }

  join: customer_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
  }

  join: customer_country {
    relationship: many_to_one
    sql_on: ${customer_details.country_id} = ${customer_country.country_id} ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${campaign_details_base.timezone_id} = ${timezone.timezone_id} ;;
    fields: []
  }

  join: sno_validation_report_result {
    relationship: many_to_many
    sql_on: ${sno_opt_viewing_spot_level_pacing.report_id} = ${sno_validation_report_result.report_id} ;;
  }

  join: sno_validation_rule_result {
    relationship: one_to_many
    sql_on: ${sno_validation_report_result.request_id} = ${sno_validation_rule_result.request_id} ;;
  }

  join: tpm_metrics {
    relationship: many_to_many
    sql_on: ${sno_opt_viewing_spot_level_pacing.campaign_id} = ${tpm_metrics.campaign_id} ;;
    fields: [tpm_metrics.daypart]
  }

  sql_always_where: {% if sno_opt_viewing_spot_level_pacing.show_only_latest_report._parameter_value == "latest_any" or sno_opt_viewing_spot_level_pacing.show_only_latest_report._parameter_value == "latest_approved" %} ${sno_opt_viewing_spot_level_pacing_latest_report.campaign_id} IS NOT NULL {% else %} TRUE {% endif %}
    AND {% if sno_opt_viewing_spot_level_pacing.show_only_latest_report._parameter_value == "latest_approved" %} ${sno_opt_pacing_report_approval.approval_state} = 'approved' {% else %} TRUE {% endif %} ;;
}

explore: sno_smartmon_events_forecast_error_metrics {

  label: "Forecast Error Metrics"

  sql_always_where: (${sno_smartmon_events_forecast_error_metrics.name} = 'forecast_error_metrics') AND
    ({% if _user_attributes['is_itv_user'] == 'yes' %}${sno_smartmon_events_forecast_error_metrics.partner_id} = 5951{% else %} TRUE {% endif %}) ;;
}
