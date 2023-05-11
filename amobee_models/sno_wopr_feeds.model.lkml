
connection: "snowflake"
include: "/**/*.view.lkml"

access_grant: can_see_model {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}


access_grant: can_use_explore { user_attribute: is_itv_user allowed_values: ["no"] }

explore: cadreon_daily_monthly_feed {
  hidden: yes
  required_access_grants: [can_use_explore, can_see_model]
  view_name: sno_supply_hourly_core_metrics
  join: flight_media_details_base {
    type: inner
    sql_on: ${sno_supply_hourly_core_metrics.flight_media_id}=${flight_media_details_base.flight_media_id} ;;
    relationship: many_to_one
  }

  join: campaign_details_base {
    type: inner
    sql_on: ${campaign_details_base.campaign_id} = ${flight_media_details_base.campaign_id} ;;
    relationship: many_to_one
  }

  join: platform_client {
    type: left_outer
    relationship: many_to_one
    sql_on: ${campaign_details_base.platform_client_id} = ${platform_client.platform_type_id} ;;
    fields: []
  }

  join: advertiser_brand_details  {
    type: inner
    sql_on: ${campaign_details_base.advertiser_brand_id} = ${advertiser_brand_details.advertiser_brand_id} ;;
    relationship: many_to_one
  }

  join: placement_details_base {
    type: inner
    sql_on: ${sno_supply_hourly_core_metrics.placement_id} = ${placement_details_base.placement_id} ;;
    relationship: many_to_one
  }

  join: insertion_order_details   {
    type: inner
    sql_on: ${campaign_details_base.insertion_order_id} = ${insertion_order_details.insertion_order_id} ;;
    relationship: many_to_one
  }

  join: timezone {
    relationship: many_to_one
    sql_on: ${flight_media_details_base.starttimezone_id} = ${timezone.timezone_id} ;;
  }

}
