connection: "snowflake"

include: "sno_*.view"        # include all views in this project
#include: "*.dashboard.lookml"  # include all dashboards in this project

#explore: quarterly_ad_reach_frequency {
  #view_name: sno_viewer_exposure_quarterly_facts
  #label: "TV Ad Reach/Frequency Quarterly Metrics"
  #fields: [ALL_FIELDS*]
  #description: "This can be used to obtain TV Ad viewing reach/frequency by broadcast quarter"
  #view_name: viewing_fact
  #fields: [viewing_fact.viewer_key,viewing_fact.ad_content_key, viewing_fact.metric_type,viewing_fact.timeperiod_quarter_key,
  #  viewing_fact.ad_exposure_frequency, viewing_fact.ad_impressions, viewing_fact.ad_reach_by_freq, viewing_fact.ad_imps_by_freq,
  #  quarterly_viewer_rta_group.rta_group_id, quarterly_viewer_rta_group.effective_weight]
  #label: "TV Ad Reach/Frequency Metrics"
  #description: "This can be used to obtain TV Ad viewing reach/frequency by broadcast quarter"

  #join: viewer_weekly {
  #  relationship: many_to_one
  #  sql_on: ${viewer_weekly.timeperiod_date_key} = ${viewing_fact.timeperiod_week_key}
  #    and ${viewer_weekly.viewer_key} = ${viewing_fact.viewer_key};;
  #}

  #join: viewer_monthly {
  #  relationship: one_to_many
  #  sql_on: ${viewer_monthly.timeperiod_date_key} = ${viewing_fact.timeperiod_month_key}
  #    and ${viewer_monthly.viewer_key} = ${viewing_fact.viewer_key};;
  #}

  #join: viewer_quarterly {
  #  relationship: one_to_one
  #  sql_on: ${viewer_quarterly.timeperiod_date_key} = ${viewing_fact.timeperiod_quarter_key}
  #    and ${viewer_quarterly.viewer_key} = ${viewing_fact.viewer_key};;
  #}

  #join: weekly_viewer_rta_group {
  #  relationship: many_to_one
  #  sql_on: ${viewer_weekly.timeperiod_date_key} = ${weekly_viewer_rta_group.timeperiod_date_key}
  #    and ${viewer_weekly.viewer_key} = ${weekly_viewer_rta_group.viewer_key} ;;
  #}

  #join: monthly_viewer_rta_group {
  #  relationship: many_to_one
  #  sql_on: ${viewer_monthly.timeperiod_date_key} = ${monthly_viewer_rta_group.timeperiod_date_key}
  #    and ${viewer_monthly.viewer_key} = ${monthly_viewer_rta_group.viewer_key};;
  #}

  #join: quarterly_viewer_rta_group {
  #  relationship: many_to_one
  #  sql_on: ${viewer_quarterly.timeperiod_date_key} = ${quarterly_viewer_rta_group.timeperiod_date_key}
  #    and ${viewer_quarterly.viewer_key} = ${quarterly_viewer_rta_group.viewer_key};;
  #}

  #join: weekly_viewer_avid {
  #  relationship: many_to_one
  #  sql_on: ${viewer_weekly.timeperiod_date_key} = ${weekly_viewer_avid.timeperiod_date_key}
  #    and ${viewer_weekly.viewer_key} = ${weekly_viewer_avid.viewer_key};;
  #}

  #join: monthly_viewer_avid {
  #  relationship: many_to_one
  #  sql_on: ${viewer_monthly.timeperiod_date_key} = ${monthly_viewer_avid.timeperiod_date_key}
  #    and ${viewer_monthly.viewer_key} = ${monthly_viewer_avid.viewer_key};;
  #}

  #join: quarterly_viewer_avid {
  #  relationship: many_to_one
  #  sql_on: ${viewer_quarterly.timeperiod_date_key} = ${quarterly_viewer_avid.timeperiod_date_key}
  #    and ${viewer_quarterly.viewer_key} = ${quarterly_viewer_avid.viewer_key};;
  #}

  #join:  media_content {
  #  relationship: many_to_one
  #  sql_on: ${media_content.media_content_key} = ${viewing_fact.media_content_key} ;;
  #}

  #join:  ad_content {
  #  relationship: many_to_one
  #  sql_on: ${ad_content.ad_content_key} = ${viewing_fact.ad_content_key} ;;
  #}


#}

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
