connection: "bi_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: v_fact_ad_events_hourly_agg {
  always_filter: {
    filters: [v_fact_ad_events_hourly_agg.date_time_key: "last 14 days ago for 14 days"]
  }
  #persist_with: CleanCash_datagroup
  label: "TVDSP"
  view_label: "Measures"

  join: v_dim_ad_orientation {
    type: inner
    view_label: "Ad Oriantation"
    sql_on: ${v_dim_ad_orientation.ad_orientation_key}=${v_fact_ad_events_hourly_agg.ad_orientation_key};;
    relationship: many_to_one
  }

  join: v_dim_flight_tv {
    type: inner
    view_label: "Flight"
    sql_on: ${v_dim_flight_tv.flight_key}=${v_fact_ad_events_hourly_agg.flight_key};;
    relationship: many_to_one

  }

  join: v_dim_ad_position {
    type: inner
    view_label: "Ad Position"
    sql_on: ${v_dim_ad_position.ad_position_key}=${v_fact_ad_events_hourly_agg.ad_position_key} ;;
    relationship: many_to_one
  }

  join: v_dim_app_name {
    type: inner
    view_label: "App Name"
    sql_on: ${v_dim_app_name.app_name_key}= ${v_fact_ad_events_hourly_agg.app_name_key};;
    relationship: many_to_one
  }

  join: v_dim_app_bundle {
    type: inner
    view_label: "App Bundle"
    sql_on: ${v_dim_app_bundle.app_bundle_key}=${v_fact_ad_events_hourly_agg.app_bundle_key};;
    relationship: many_to_one
  }

  join: v_dim_browser_type {
    type: inner
    view_label: "Browser Type"
    sql_on: ${v_dim_browser_type.browser_type_key}=${v_fact_ad_events_hourly_agg.browser_type_key} ;;
    relationship: many_to_one
  }

  join: v_dim_content_category {

    type: inner
    view_label: "Content Category"
    sql_on: ${v_dim_content_category.content_category_key}=${v_fact_ad_events_hourly_agg.content_category_key} ;;
    relationship: many_to_one
  }

  join: v_dim_country_tv {

    type: inner
    view_label: "Country"
    sql_on: ${v_dim_country_tv.country_key}=${v_fact_ad_events_hourly_agg.country_key} ;;
    relationship: many_to_one
  }

  join: v_dim_cpa_custom_value {

    type: inner
    view_label: "CPA"
    sql_on: ${v_dim_cpa_custom_value.cpa_custom_value_key}=${v_fact_ad_events_hourly_agg.cpa_custom_value_key} ;;
    relationship: many_to_one
  }

  join: v_dim_creative {
    type: inner
    view_label: "Creative"
    sql_on: ${v_dim_creative.creative_key}=${v_fact_ad_events_hourly_agg.creative_key} ;;
    relationship: many_to_one
  }

  join: v_dim_creative_type {

    type: inner
    view_label: "Creative Type"
    sql_on: ${v_dim_creative.creative_type_key}=${v_fact_ad_events_hourly_agg.creative_type_key} ;;
    relationship: many_to_one
  }

  join: v_dim_custom_action {
    view_label: "Custom Action"
    type: inner
    sql_on: ${v_dim_custom_action.custom_action_key}=${v_fact_ad_events_hourly_agg.custom_action_key} ;;
    relationship: many_to_one
  }

  join: v_dim_dma {
    view_label: "DMA"
    type: inner
    sql_on: ${v_dim_dma.dma_key}y}=${v_fact_ad_events_hourly_agg.dma_key} ;;
    relationship: many_to_one
  }
  join: v_dim_deal {
    view_label: "Deal"
    type: inner
    sql_on: ${v_dim_deal.deal_key}=${v_fact_ad_events_hourly_agg.deal_key} ;;
    relationship: many_to_one
  }
  join: v_dim_domain {
    view_label: "Domain"
    type: inner
    sql_on: ${v_dim_domain.domain_key}=${v_fact_ad_events_hourly_agg.domain_key} ;;
    relationship: many_to_one
  }


  join: v_dim_genre {
    view_label: "Genre"
    type: inner
    sql_on: ${v_dim_genre.genre_key}=${v_fact_ad_events_hourly_agg.genre_key} ;;
    relationship: many_to_one
  }


  join: v_dim_network {
    view_label: "Network"
    type: inner
    sql_on: ${v_dim_network.network_key}=${v_fact_ad_events_hourly_agg.network_key} ;;
    relationship: many_to_one
  }

  join: v_dim_os {
    view_label: "OS"
    type: inner
    sql_on: ${v_dim_os.os_key}=${v_fact_ad_events_hourly_agg.os_key} ;;
    relationship: many_to_one
  }

  join: v_dim_product_type {
    view_label: "Product Type"
    type: inner
    sql_on: ${v_dim_product_type.product_type_key}=${v_fact_ad_events_hourly_agg.product_type_key} ;;
    relationship: many_to_one
  }

  join: v_dim_rtb_app {
    view_label: "RTB App"
    type: inner
    sql_on: ${v_dim_rtb_app.rtb_app_key}=${v_fact_ad_events_hourly_agg.rtb_app_key} ;;
    relationship: many_to_one
  }


  join: v_dim_rtb_media {
    view_label: "RTB Media"
    type: inner
    sql_on: ${v_dim_rtb_media.rtb_media_key}=${v_fact_ad_events_hourly_agg.rtb_media_key} ;;
    relationship: many_to_one
  }

  join: v_dim_rtb_publisher {
    view_label: "RTB Publisher"
    type: inner
    sql_on: ${v_dim_rtb_publisher.rtb_publisher_key}=${v_fact_ad_events_hourly_agg.rtb_publisher_key} ;;
    relationship: many_to_one
  }


  join: v_dim_rtb_site_name {
    view_label: "RTB Site Name"
    type: inner
    sql_on: ${v_dim_rtb_site_name.rtb_site_name_key}=${v_fact_ad_events_hourly_agg.rtb_site_name_key} ;;
    relationship: many_to_one
  }
  join: v_dim_screen_type {
    view_label: "Screen Type"
    type: inner
    sql_on: ${v_dim_screen_type.screen_type_key}=${v_fact_ad_events_hourly_agg.screen_type_key} ;;
    relationship: many_to_one
  }
  join: v_dim_ssp_tv {
    view_label: "SSP"
    type: inner
    sql_on: ${v_dim_ssp_tv.ssp_key}=${v_fact_ad_events_hourly_agg.ssp_key} ;;
    relationship: many_to_one
  }
  join: v_dim_video_type {
    view_label: "Video Type"
    type: inner
    sql_on: ${v_dim_video_type.video_type_key}=${v_fact_ad_events_hourly_agg.video_type_key} ;;
    relationship: many_to_one
  }
}
