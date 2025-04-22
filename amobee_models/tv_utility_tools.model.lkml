connection: "snowflake"

include: "/**/*.view.lkml"       # include all views in this project
#include: "*.dashboard.lookml"  # include all dashboards in this project



explore:  ads_finder {

  view_name: sno_ad_content
  label: "TV Ads Finder"
  fields: [ALL_FIELDS*]
  description: "Use the Ultimate Parent/Parent/Brand/Brand Variant/Creative Description or ad duration fields to find TV Ad Content Key for a broadcast month or quarter "

  join: viewing_fact{
    relationship: one_to_many
    fields: [viewing_fact.event_start_datetime, viewing_fact.timeperiod_quarter_key, viewing_fact.timeperiod_month_key]
    sql_on: ${viewing_fact.ad_content_key} = ${sno_ad_content.ad_content_key};;
  }

  join: media_content{
    relationship: one_to_many
    fields: [media_content.media_content_parent, media_content.media_content_name, media_content.media_daypart_id,media_content.network_daypart_ad_count]
    sql_on: ${media_content.media_content_key} = ${viewing_fact.media_content_key};;
  }
}

explore: latest_date_finder{

  view_name: sno_latest_viewing_date
  label: "AED & Viewing Date Finder"
  fields: [ALL_FIELDS*]
  description: "This can be used to obtain the latest AED or broadcast date for which we have data"
}

explore: latest_linkage_finder{

  view_name: sno_latest_linkage_date
  label: "Monthly Linkage Finder"
  fields: [ALL_FIELDS*]
  description: "This can be used to obtain the latest Linkage for which we have data"
}

explore: ad_cost_finder{

  view_name: sno_ad_cost
  label: "Ad Cost Finder"
  fields: [ALL_FIELDS*]
  description: "This can be used to pull the ad cost"
}
