connection: "snowflake"
label: "Reference"
case_sensitive: no

include: "/**/*.view.lkml"
#include: "*.dashboard.lookml"  # include all dashboards in this project

access_grant: can_use_explore { user_attribute: is_itv_user allowed_values: ["no"] }



explore: campaign_details_base {


  label: "Snowflake Demand Reference"
  description: "This explore includes reference data on the demand side concepts, as well as information within that hierarchy.  This explore
  is designed to get any demand side information even if the campaign has no delivery."
  access_filter: {
    field: platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: campaign_details_base.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${campaign_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;


  join: timezone {
    relationship: many_to_one
    sql_on: ${campaign_details_base.timezone_id} = ${timezone.timezone_id} ;;
  }

  join: pl_plan {
    relationship: many_to_one
    sql_on: ${campaign_details_base.pl_plan_id} = ${pl_plan.pl_plan_id};;
  }

  join: flight_details {
    relationship: one_to_many
    type: left_outer
    sql_on: ${flight_details.campaign_id} = ${campaign_details_base.campaign_id};;
  }

  join: flight_demand_units_budget {
    relationship: many_to_one
    sql_on: ${flight_details.flight_id} = ${flight_demand_units_budget.flight_id}
      and ${flight_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: flight_media_details_base {
    relationship: one_to_many
    type: left_outer
    sql_on: ${flight_media_details_base.flight_id} = ${flight_details.flight_id} ;;
  }

  join: demand_mart_load_tracking {
    from:  load_tracking
    relationship: many_to_one
    sql_on: ${demand_mart_load_tracking.schema_name} = 'rawdb' and
    ${demand_mart_load_tracking.table_name} = 'daily_analytics' ;;
  }

  join: flight_media_url_tracking {
    relationship: many_to_many
    sql_on: ${flight_media_details_base.flight_media_id} = ${flight_media_url_tracking.flight_media_id} ;;
  }

  join: campaign_days {
    relationship: many_to_one
    sql_on: ${campaign_details_base.campaign_id} = ${campaign_days.campaign_id} ;;
  }

  join: campaign_objectives {
    relationship: one_to_one
    sql_on: ${campaign_objectives.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: campaign_target_description {
    relationship: one_to_one
    sql_on: ${campaign_target_description.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: original_fm_created_by {
    relationship: one_to_one
    sql_on: ${original_fm_created_by.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: campaign_url_tracking {
    relationship: one_to_many
    sql_on: ${campaign_details_base.campaign_id} = ${campaign_url_tracking.campaign_id} and ${campaign_url_tracking.active} = TRUE ;;
  }

  join: campaign_demand_units_budget{
    relationship: one_to_many
    sql_on: ${campaign_details_base.campaign_id} = ${campaign_demand_units_budget.campaign_id}
          and ${campaign_demand_units_budget.flight_id} IS NULL
          and ${campaign_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: customer_details {
    relationship: many_to_one
    sql: {% if customer_details.future_customers._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.CUSTOMER_DETAILS  AS customer_details ON ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
  }

  join: advertiser_brand_details {
    relationship: many_to_one
    sql: {% if advertiser_brand_details.future_advertisers._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.ADVERTISER_BRAND_DETAILS  AS advertiser_brand_details ON ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
  }

  join: insertion_order_details {
    relationship: many_to_one
    sql_on: ${campaign_details_base.insertion_order_id} = ${insertion_order_details.insertion_order_id};;
  }

  join: insertion_order_demand_units_budget {
    relationship: many_to_one
    sql_on: ${insertion_order_demand_units_budget.insertion_order_id} = ${insertion_order_details.insertion_order_id}
          and ${insertion_order_demand_units_budget.pl_plan_id} IS NULL
          and ${insertion_order_demand_units_budget.campaign_id} IS NULL
          and ${insertion_order_demand_units_budget.flight_id} IS NULL
          and ${insertion_order_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: account_exec {
    relationship: many_to_one
    sql_on: ${insertion_order_details.account_rep} = ${account_exec.id} ;;
  }

  join: launched_by_userprofile {
    relationship: many_to_one
    sql_on: ${campaign_details_base.launched_by_id} = ${launched_by_userprofile.id} ;;
  }

  join: fm_createdby_userprofile {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.createdby_id} = ${fm_createdby_userprofile.id} ;;
  }

  join: platform_client {
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
  }

  join: campaign_addon_product {
    relationship: many_to_one
    sql_on: ${campaign_addon_product.campaign_id} = ${campaign_details_base.campaign_id} ;;
  }

  join: campaign_product{
    relationship: one_to_one
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

explore: monthly_exchange_rate{

  hidden: yes
  label: "Monthly Exchange Rates"
  description: "Includes monthly averaged exchange rates"
}

explore: tv_flights {
  required_access_grants: [can_use_explore]
  label: "TV Order Metrics"
  description: "This explore includes metrics and facets surrounding TV campaigns. "
  fields: [ALL_FIELDS*,-campaign_details_base.agency_fee, -advertiser_brand_details.future_advertisers, -customer_details.future_customers]

  join: flight_details {
    relationship: many_to_one
    type: left_outer
    sql_on: ${tv_flights.flight_id} = ${flight_details.flight_id};;
  }

  join: campaign_details_base {
    relationship: many_to_one
    type: left_outer
    sql_on: ${campaign_details_base.campaign_id} = ${flight_details.campaign_id}    ;;
  }

  join: demand_mart_load_tracking {
    from: load_tracking
    relationship: many_to_one
    sql_on:  ${demand_mart_load_tracking.schema_name} = 'rawdb' and
      ${demand_mart_load_tracking.table_name} = 'daily_analytics' ;;
  }

  join: tv_economics {
    relationship: many_to_one
    type: left_outer
    sql_on: ${tv_economics.platform_client_id} = ${campaign_details_base.platform_client_id} ;;
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${campaign_details_base.timezone_id} = ${timezone.timezone_id} ;;
  }

  join: advertiser_brand_details {
    relationship: many_to_one
    type: left_outer
    sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
  }

  join: customer_details {
    relationship: many_to_one
    type: left_outer
    sql_on: ${campaign_details_base.customer_id} = ${customer_details.customer_id} ;;
  }

  join: placement_details_base {
    relationship: many_to_one
    sql_on: ${tv_flights.placement_id} = ${placement_details_base.placement_id} ;;
  }

  join: platform_client {
    relationship: many_to_one
    type: left_outer
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
    fields: []
  }
}

explore: placement_details_base {

  label: "Snowflake Supply Reference"
  description: "This explore includes reference data on the supply side concepts, as well as information within that hierarchy.  This explore
  is designed to get any supply side information even if the placement has no delivery."
  access_filter: {
    field: platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: placement_details_base.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${placement_details_base.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;

  join: platform_client {
    relationship: many_to_one
    view_label: "Supply Platform Client"
    sql_on: ${placement_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
  }

}

explore: marketplace_login_history_view {
  required_access_grants: [can_use_explore]
  label: "Marketplace Login History"
  description: "This explore includes login history for marketplace users allowing filtering by time, buyer, and seller."
}

explore: suggest_demand_ref {

  access_filter: {
    field: suggest_demand_ref.country_id
    user_attribute: access_filter_country_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${suggest_demand_ref.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;

  hidden: yes
}

explore: suggest_supply_ref {
  access_filter: {
    field: suggest_supply_ref.placement_country_id
    user_attribute: access_filter_country_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_exclude_platform_client_id'] == 'NULL' %} TRUE {% else %} (${suggest_supply_ref.platform_client_id} NOT IN ({{ _user_attributes['access_filter_exclude_platform_client_id'] }})) {% endif %}) ;;

  hidden: yes
}
