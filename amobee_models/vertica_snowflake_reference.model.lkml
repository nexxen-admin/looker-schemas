connection: "amobee_prod"
label: "Reference"
case_sensitive: no

include: "/**/vertica_views/*.view.lkml"
#include: "*.dashboard.lookml"  # include all dashboards in this project

access_grant: can_use_explore { user_attribute: is_itv_user allowed_values: ["no"] }



explore: v_campaign_details_base {


  label: "Vertica Snowflake Demand Reference"
  description: "This explore includes reference data on the demand side concepts, as well as information within that hierarchy.  This explore
  is designed to get any demand side information even if the campaign has no delivery."
  access_filter: {
    field: v_platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: v_campaign_details_base.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} (${v_campaign_details_base.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;


  join: v_timezone {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.timezone_id} = ${v_timezone.timezone_id} ;;
  }

  join: v_pl_plan {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.pl_plan_id} = ${v_pl_plan.pl_plan_id};;
  }

  join: v_flight_details {
    relationship: one_to_many
    type: left_outer
    sql_on: ${v_flight_details.campaign_id} = ${v_campaign_details_base.campaign_id};;
  }

  join: v_flight_demand_units_budget {
    relationship: many_to_one
    sql_on: ${v_flight_details.flight_id} = ${v_flight_demand_units_budget.flight_id}
      and ${v_flight_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: v_flight_media_details_base {
    relationship: one_to_many
    type: left_outer
    sql_on: ${v_flight_media_details_base.flight_id} = ${v_flight_details.flight_id} ;;
  }

  join: v_demand_mart_load_tracking {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.starttimezone_id} = ${v_demand_mart_load_tracking.start_timezone} ;;
  }

  # join: v_flight_media_url_tracking {
  #   relationship: many_to_many
  #   sql_on: ${v_flight_media_details_base.flight_media_id} = ${v_flight_media_url_tracking.flight_media_id} ;;
  # }

  join: v_campaign_days {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.campaign_id} = ${v_campaign_days.campaign_id} ;;
  }

  join: v_campaign_objectives {
    relationship: one_to_one
    sql_on: ${v_campaign_objectives.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
  }

  join: v_campaign_target_description {
    relationship: one_to_one
    sql_on: ${v_campaign_target_description.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
  }

  join: v_original_fm_created_by {
    relationship: one_to_one
    sql_on: ${v_original_fm_created_by.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
  }

  # join: v_campaign_url_tracking {
  #   relationship: one_to_many
  #   sql_on: ${v_campaign_details_base.campaign_id} = ${v_campaign_url_tracking.campaign_id} and ${v_campaign_url_tracking.active} = TRUE ;;
  # }

  join: v_campaign_demand_units_budget{
    relationship: one_to_many
    sql_on: ${v_campaign_details_base.campaign_id} = ${v_campaign_demand_units_budget.campaign_id}
          and ${v_campaign_demand_units_budget.flight_id} IS NULL
          and ${v_campaign_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: v_customer_details {
    relationship: many_to_one
    sql: {% if v_customer_details.future_customers._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.CUSTOMER_DETAILS_VIEW  AS v_customer_details ON ${v_campaign_details_base.customer_id} = ${v_customer_details.customer_id} ;;
  }

  join: v_advertiser_brand_details {
    relationship: many_to_one
    sql: {% if v_advertiser_brand_details.future_advertisers._in_query %}FULL{% else %}LEFT{% endif %} JOIN DIM.ADVERTISER_BRAND_DETAILS_VIEW  AS v_advertiser_brand_details ON ${v_campaign_details_base.advertiser_brand_id} = ${v_advertiser_brand_details.advertiser_brand_id} ;;
  }

  join: v_insertion_order_details {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.insertion_order_id} = ${v_insertion_order_details.insertion_order_id};;
  }

  join: v_insertion_order_demand_units_budget {
    relationship: many_to_one
    sql_on: ${v_insertion_order_demand_units_budget.insertion_order_id} = ${v_insertion_order_details.insertion_order_id}
          and ${v_insertion_order_demand_units_budget.pl_plan_id} IS NULL
          and ${v_insertion_order_demand_units_budget.campaign_id} IS NULL
          and ${v_insertion_order_demand_units_budget.flight_id} IS NULL
          and ${v_insertion_order_demand_units_budget.flight_media_id} IS NULL;;
  }

  join: v_account_exec {
    relationship: many_to_one
    sql_on: ${v_insertion_order_details.account_rep} = ${v_account_exec.id} ;;
  }

  join: v_launched_by_userprofile {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.launched_by_id} = ${v_launched_by_userprofile.id} ;;
  }

  join: v_fm_createdby_userprofile {
    relationship: many_to_one
    sql_on: ${v_flight_media_details_base.createdby_id} = ${v_fm_createdby_userprofile.id} ;;
  }

  join: v_platform_client {
    relationship: many_to_one
    sql_on: ${v_campaign_details_base.platform_client_id} = ${v_platform_client.platform_client_id} ;;
  }

  join: v_campaign_addon_product {
    relationship: many_to_one
    sql_on: ${v_campaign_addon_product.campaign_id} = ${v_campaign_details_base.campaign_id} ;;
  }

  join: v_campaign_product{
    relationship: one_to_one
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

# explore: monthly_exchange_rate{

#   hidden: yes
#   label: "Monthly Exchange Rates"
#   description: "Includes monthly averaged exchange rates"
# }

# explore: v_tv_flights {
#   required_access_grants: [can_use_explore]
#   label: "TV Order Metrics"
#   description: "This explore includes metrics and facets surrounding TV campaigns. "
#   fields: [ALL_FIELDS*,-v_campaign_details_base.agency_fee, -v_advertiser_brand_details.future_advertisers, -v_customer_details.future_customers]

#   join: v_flight_details {
#     relationship: many_to_one
#     type: left_outer
#     sql_on: ${v_tv_flights.flight_id} = ${v_flight_details.flight_id};;
#   }

#   join: v_campaign_details_base {
#     relationship: many_to_one
#     type: left_outer
#     sql_on: ${v_campaign_details_base.campaign_id} = ${v_flight_details.campaign_id}    ;;
#   }

#   join: v_demand_mart_load_tracking {
#     relationship: many_to_one
#     sql_on: ${v_campaign_details_base.timezone_id} = ${v_demand_mart_load_tracking.start_timezone}  ;;
#   }

#   join: v_tv_economics {
#     relationship: many_to_one
#     type: left_outer
#     sql_on: ${v_tv_economics.platform_client_id} = ${v_campaign_details_base.platform_client_id} ;;
#   }

#   join: v_timezone {
#     relationship: many_to_one
#     sql_on: ${v_campaign_details_base.timezone_id} = ${v_timezone.timezone_id} ;;
#   }

#   join: v_advertiser_brand_details {
#     relationship: many_to_one
#     type: left_outer
#     sql_on: ${v_campaign_details_base.advertiser_brand_id} = ${v_advertiser_brand_details.advertiser_brand_id} ;;
#   }

#   join: v_customer_details {
#     relationship: many_to_one
#     type: left_outer
#     sql_on: ${v_campaign_details_base.customer_id} = ${v_customer_details.customer_id} ;;
#   }

#   join: v_placement_details_base {
#     relationship: many_to_one
#     sql_on: ${v_tv_flights.placement_id} = ${v_placement_details_base.placement_id} ;;
#   }

#   join: v_platform_client {
#     relationship: many_to_one
#     type: left_outer
#     sql_on: ${v_campaign_details_base.platform_client_id} = ${v_platform_client.platform_client_id} ;;
#     fields: []
#   }
# }

explore: v_placement_details_base {

  label: "Vertica Snowflake Supply Reference"
  description: "This explore includes reference data on the supply side concepts, as well as information within that hierarchy.  This explore
  is designed to get any supply side information even if the placement has no delivery."
  access_filter: {
    field: v_platform_client.office_id
    user_attribute: access_filter_office_id
  }
  access_filter: {
    field: v_placement_details_base.platform_client_id
    user_attribute: access_filter_platform_client_id
  }

  sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} (${v_placement_details_base.platform_client_id} IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;

  join: v_platform_client {
    relationship: many_to_one
    view_label: "Supply Platform Client"
    sql_on: ${v_placement_details_base.platform_client_id} = ${v_platform_client.platform_client_id} ;;
  }

}

# explore: marketplace_login_history_view {
#   required_access_grants: [can_use_explore]
#   label: "Marketplace Login History"
#   description: "This explore includes login history for marketplace users allowing filtering by time, buyer, and seller."
# }

# explore: suggest_demand_ref {

#   access_filter: {
#     field: suggest_demand_ref.country_id
#     user_attribute: access_filter_country_id
#   }

#   sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} (${suggest_demand_ref.platform_client_id}  IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;

#   hidden: yes
# }

# explore: suggest_supply_ref {
#   access_filter: {
#     field: suggest_supply_ref.placement_country_id
#     user_attribute: access_filter_country_id
#   }

#   sql_always_where: ({% if _user_attributes['access_filter_include_platform_client_id'] == 'NULL' %} TRUE {% else %} (${suggest_supply_ref.platform_client_id} IN ({{ _user_attributes['access_filter_include_platform_client_id'] }})) {% endif %}) ;;

#   hidden: yes
# }
