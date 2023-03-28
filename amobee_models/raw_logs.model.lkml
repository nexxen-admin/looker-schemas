connection: "snowflake"

include: "/**/*.view.lkml"
case_sensitive: no


explore: auction_log {
  label: "Raw Auction Logs"
  fields: [ALL_FIELDS*,-flight_media_details_base.yj_begin_datetime_local, -flight_media_details_base.yj_end_datetime_local, -placement_details_base.platform_client_xaxis, -campaign_details_buyer.campaign_name_custom, -campaign_details_seller.campaign_name_custom]

  join: placement_details_base {
    relationship: many_to_one
    view_label: "Seller Placement"
    type: left_outer
    sql_on: ${auction_log.placement_id} = ${placement_details_base.placement_id} ;;
  }

  join: campaign_details_seller {
    from: campaign_details_base
    relationship: many_to_one
    view_label: "Seller Deal Campaign"
    sql_on: ${auction_log.deal_id} = ${campaign_details_seller.campaign_id} ;;
  }

  join: flight_media_details_base {
    view_label: "Buyer Flight Media"
    relationship: many_to_one
    sql_on: case when length(${auction_log.buyer_creative_id}) = 0 then '0' else ${auction_log.buyer_creative_id} end = cast(${flight_media_details_base.media_id} as varchar) ;;
  }

  join: campaign_details_buyer {
    from: campaign_details_base
    view_label: "Buyer Campaign"
    relationship: many_to_one
    sql_on: ${flight_media_details_base.campaign_id} = ${campaign_details_buyer.campaign_id} ;;
  }

  join: platform_client {
    type: left_outer
    relationship: many_to_one
    sql_on: ${placement_details_base.platform_client_id} = ${platform_client.platform_client_id} ;;
    fields: []
  }

  join: timezone {
    relationship: many_to_one
    fields: []
    sql_on: ${flight_media_details_base.starttimezone_id} = ${timezone.timezone_id} ;;
  }
}
