connection: "vertica_iad"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                   # include all views in this project
#include: "my_dashboard.dashboard.lookml"    # include a LookML dashboard called my_dashboard
datagroup: CleanCash_datagroup {
  sql_trigger: SELECT max(date_key) FROM bi_new.V_Fact_Ad_Daily_Agg ;;
  max_cache_age: "15 hours"
  label: "Clean Cash Trigger"
  description: "Triggered when new date is added to ETL"
}
datagroup: TapticaCleanCash_datagroup {
  sql_trigger: SELECT max(app_event_time) FROM bi_new.appsflyer ;;
  max_cache_age: "15 hours"
  label: "Clean Cash Trigger"
  description: "Triggered when new date is added to ETL"
}


access_grant: can_view_pub_come_looker {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}

access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}

access_grant: can_view_imp_r {
  user_attribute: ds
  allowed_values: ["DS"]
}
access_grant: Mitzi {
  user_attribute: mitzi
  allowed_values: ["DS","MM"]
}
access_grant: can_view_candidates {
  user_attribute: candidates
  allowed_values: ["candidates"]
}

access_grant: can_view_Taptica {
  user_attribute: taptica
  allowed_values: ["Taptica"]
}

access_grant: can_view_aniview {
  user_attribute: aniview
  allowed_values: ["Aniview"]
}

explore: ani_view_data {
  label: "Aniview"
  required_access_grants: [can_view_aniview]
}

explore: impression_r {
  label: "Impression Raw Data"
  hidden: yes
  always_filter: {
    filters:[impression_r.dspdealid: ""]
  }

  # join: dim_publisher_ssp {
  #   type: left_outer
  #   view_label: "SSP"
  #   sql_on: ${dim_publisher_ssp.pub_id}=${impression_r.pubid} ;;
  #   relationship: many_to_one
  # }
}

explore: appsflyer{
  label: "Appsflyer"
  persist_with:TapticaCleanCash_datagroup
  required_access_grants: [can_view_Taptica]
}

explore: appsflyer_agg{
  label: "Appsflyer Daily"
  required_access_grants: [can_view_Taptica]
}



explore: publishers_report_monthly_for_finance {
  required_access_grants: [can_view_pub_come_looker]
  label: "publishers report monthly for finance"
}

explore: v_fact_ad_daily {
  required_access_grants: [can_view_all_tremor]
  label: "Fact Ad Daily Exchange"


  join: dim_publisher_ssp {
    type: inner
    view_label: "SSP"
    sql_on: ${dim_publisher_ssp.pub_ssp_key}=${v_fact_ad_daily.pub_ssp_key};;
    relationship: many_to_one
    #fields: []
  }

join: dim_publisher  {
  type: inner
  sql_on: ${dim_publisher.pub_key}=${dim_publisher_ssp.pub_key} ;;
  relationship: many_to_one
}

join: v_dim_employee_biz_dev {
  type: inner
  sql_on: ${v_dim_employee_biz_dev.employee_key}=${dim_publisher.bizdev_owner_key} ;;
  relationship: many_to_one
}

  join: v_dim_employee_pub_ops {
    type: inner
    sql_on: ${v_dim_employee_pub_ops.employee_key}=${dim_publisher.ops_owner_key} ;;
    relationship: many_to_one
  }

  join: dim_dsp {
    type: inner
    sql_on: ${dim_dsp.dsp_key}=${v_fact_ad_daily.dsp_key} ;;
    relationship: many_to_one
  }
  hidden: yes
}


explore: extend_Inbound_Exchange {
  extends: [fact_ad_daily_agg]
  from: fact_ad_daily_agg
  required_access_grants: [can_view_all_tremor]
  access_filter: {
    field: v_dim_employee_pub_ops.employee_name
    user_attribute: allowed_users
  }


  always_filter: {
    filters: [dim_date.date_key_date: "last 14 days ago for 14 days"]
  }
  persist_with: CleanCash_datagroup
  label: "Inbound Exchange Extend"
  view_label: "Measures"

  join: dim_date {
    type: inner
    view_label: "Time Frame"
    sql_on: ${dim_date.date_key_raw}=${fact_ad_daily_agg.date_key_raw} ;;
    relationship: many_to_one
  }

  join: dim_country {
    type: inner
    view_label: "Geo"
    sql_on: ${dim_country.country_key}=${fact_ad_daily_agg.country_key} ;;
    relationship: many_to_one
  }

  join: dim_buying_channel {
    type:  inner
    view_label: "Buying Channel"
    sql_on: ${dim_buying_channel.buying_channel_key}=${fact_ad_daily_agg.buying_channel_key};;
    relationship: many_to_one


  }

  join: dim_media_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_media_type.media_type_key}=${fact_ad_daily_agg.media_type_key};;
    relationship: many_to_one
  }
  join: dim_rg_blocked {
    type: full_outer
    view_label: "Impression Attributes"
    sql_on: ${dim_rg_blocked.rg_blocked_key}=${fact_ad_daily_agg.rg_blocked_key} ;;
    relationship: many_to_one
  }

  join: dim_rg_blocked_reason {
    type: full_outer
    view_label: "Impression Attributes"
    sql_on: ${dim_rg_blocked_reason.rg_blocked_reason_key}=${fact_ad_daily_agg.rg_blocked_reason_key} ;;
    relationship: many_to_one
  }


  join: dim_user_matched {
    type: full_outer
    view_label: "Request Attributes"
    sql_on: ${dim_user_matched.user_matched_key}=${fact_ad_daily_agg.user_matched_key} ;;
    relationship: many_to_one
  }

  join: dim_video_linearity {
    type: full_outer
    view_label: "Request Attributes"
    sql_on: ${dim_video_linearity.video_linearity_key}=${fact_ad_daily_agg.video_Linearity_key} ;;
    relationship: many_to_one
  }


  join: dim_video_simple_size {
    type: full_outer
    view_label: "Ad Size"
    sql_on: ${dim_video_simple_size.video_simple_size_key}=${fact_ad_daily_agg.video_simple_size_key} ;;
    relationship: many_to_one
  }
  join: dim_ad_size_width {
    type: full_outer
    view_label: "Ad Size"
    sql_on: ${dim_ad_size_width.ad_size_width_key}=${fact_ad_daily_agg.ad_size_width_key} ;;
    relationship: many_to_one
  }


  join: dim_ad_size_height {
    type: full_outer
    view_label: "Ad Size"
    sql_on: ${dim_ad_size_height.ad_size_height_key}=${fact_ad_daily_agg.ad_size_height_key} ;;
    relationship: many_to_one
  }

  join: dim_dsp_data_center {
    type: full_outer
    view_label: "DSP"
    sql_on: ${dim_dsp_data_center.dsp_key}=${fact_ad_daily_agg.dsp_key}
      AND ${dim_dsp_data_center.data_center_key}=${fact_ad_daily_agg.data_center_key};;
    relationship: many_to_one
  }

  join: dim_os {
    type: full_outer
    view_label: "Request Attributes"
    sql_on: ${dim_os.os_key}=${fact_ad_daily_agg.os_key} ;;
    relationship: many_to_one

  }

  join: dim_deal_brand {
    type: full_outer
    view_label: "Deal"
    sql_on: ${dim_deal_brand.deal_brand_key}=${dim_deal.deal_brand_key};;
    relationship: many_to_one
  }

  join: dim_deal_priority {
    type: full_outer
    view_label: "Deal"
    sql_on: ${dim_deal_priority.deal_priority_key}=${dim_deal.deal_priority_key};;
    relationship: many_to_one
  }

  join: dim_deal_agency {
    type: full_outer
    view_label: "Deal"
    sql_on: ${dim_deal_agency.deal_agency_key}=${dim_deal.deal_agency_key};;
    relationship: many_to_one
  }


  join: dim_data_center {
    type:  inner
    view_label: "Data Center"
    sql_on: ${dim_data_center.data_center_key}=${fact_ad_daily_agg.data_center_key};;
    relationship: many_to_one

  }

  join: dim_dsp_deal_type {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_deal_type.dsp_deal_type_key}=${fact_ad_daily_agg.dsp_deal_type_key};;
    relationship: many_to_one
  }

  join: dim_device_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_device_type.device_type_key}= ${fact_ad_daily_agg.device_type_key};;
    relationship: many_to_one
  }
  join: dim_imp_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_imp_type.imp_type_key}=${fact_ad_daily_agg.imp_type_key};;
    relationship: many_to_one
  }
  join: dim_response_status {
    type: inner
    view_label: "Response Attributes"
    sql_on: ${dim_response_status.response_status_key}=${fact_ad_daily_agg.response_status_key};;
    relationship: many_to_one
  }
  join: dim_request_status {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_request_status.request_status_key}= ${fact_ad_daily_agg.request_status_key};;
    relationship: many_to_one
  }

  join: dim_imp_sub_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_imp_sub_type.imp_sub_type_key}=${fact_ad_daily_agg.imp_sub_type_key};;
    relationship: many_to_one
  }

  join: dim_a_domain  {
    type: inner
    view_label: "Domain"
    sql_on: ${dim_a_domain.a_domain_key}=${fact_ad_daily_agg.a_domain_key};;
    relationship: many_to_one
  }
  join: dim_o_domain {
    type: inner

    view_label: "Domain"
    sql_on: ${dim_o_domain.o_domain_key}=${fact_ad_daily_agg.o_domain_key};;
    relationship: many_to_one
  }
  join: dim_deal {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal.deal_key}=${fact_ad_daily_agg.deal_key};;
    relationship: many_to_one
  }


  join: dim_deal_type {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal_type.deal_type_key}=${dim_deal.deal_type_key} ;;
    relationship: many_to_one
  }
  join: dim_placement {
    type: inner
    view_label: "Placement"
    sql_on: ${dim_placement.placement_key}=${fact_ad_daily_agg.placement_key};;
    relationship: many_to_one
  }
  join: dim_publisher_traffic_source {
    type: inner
    view_label: "Traffic Source"
    sql_on: ${dim_publisher_traffic_source.pub_ts_key}=${dim_placement.pub_ts_key};;
    relationship: many_to_one
  }
  join: dim_traffic_source {
    type: inner
    view_label: "Traffic Source"
    sql_on: ${dim_traffic_source.ts_key}=${dim_publisher_traffic_source.ts_key};;
    relationship: many_to_one
  }

  join: dim_publisher_ssp {
    type: inner
    view_label: "SSP"
    sql_on: ${dim_publisher_ssp.pub_ssp_key}=${fact_ad_daily_agg.pub_ssp_key};;
    relationship: many_to_one
    #fields: []
  }
  join: dim_publisher {
    type: inner
    view_label: "Publishers"
    sql_on: ${dim_publisher.pub_key}=${dim_publisher_ssp.pub_key} ;;
    relationship: many_to_one
  }


  join: dim_ssp {
    type: inner
    view_label: "SSP"
    sql_on: ${dim_ssp.ssp_key}=${dim_publisher_ssp.ssp_key};;
    relationship: many_to_one
  }
  join: dim_dsp_flight {
    type: inner
    sql_on: ${dim_dsp_flight.dsp_flight_key}=${fact_ad_daily_agg.dsp_flight_key};;
    relationship: many_to_one
    fields: []
  }

  join: v_dim_employee_biz_dev {
    type: inner
    view_label: "Employee"
    sql_on: ${v_dim_employee_biz_dev.employee_key}=${dim_publisher.bizdev_owner_key};;
    relationship: many_to_one
  }
  join: v_dim_employee_pub_ops {
    type: inner
    view_label: "Employee"
    sql_on: ${v_dim_employee_pub_ops.employee_key}=${dim_publisher.ops_owner_key};;
    relationship: many_to_one
  }
  join: dim_employee {
    type: inner
    view_label: "Employee"
    sql_on: ${dim_employee.employee_key}=${dim_publisher.ops_owner_key};;
    relationship: many_to_one
  }

  join: dim_flight {
    type: inner
    view_label: "Flight"
    sql_on: ${dim_flight.flight_key}=${dim_dsp_flight.flight_key};;
    relationship: many_to_one
  }
  join: dim_dsp {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp.dsp_key}=${fact_ad_daily_agg.dsp_key};;
    relationship: many_to_one
  }
  join: dim_dsp_account {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_account.dsp_account_key}=${dim_dsp.dsp_account_key};;
    relationship: many_to_one
  }
  join: dim_dsp_seat {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_seat.dsp_seat_key}=${fact_ad_daily_agg.dsp_seat_key};;
    relationship: many_to_one

  }
  join: dim_seat {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_seat.seat_key}=${dim_dsp_seat.seat_key};;
    relationship: many_to_one
  }
  hidden: yes
}

#The normal contents of the Explore follow
#}




explore: fact_ad_daily_agg{
  view_name: fact_ad_daily_agg

  #always_filter: {
  # filters: [dim_date.date_key_date: "last 14 days ago for 14 days"]
  #}
  persist_with: CleanCash_datagroup
  label: "Inbound Exchange"
  view_label: "Measures"
  required_access_grants: [can_view_all_tremor]


  join: dim_date {
    type: inner
    view_label: "Time Frame"
    sql_on: ${dim_date.date_key_raw}=${fact_ad_daily_agg.date_key_raw} ;;
    relationship: many_to_one
  }

  join: exchange_rev_ops_targets {
    type: inner
    view_label: "Exchange RevOps Targets"
    sql_on: ${exchange_rev_ops_targets.date_key_raw}=${dim_date.date_key_raw} ;;
    relationship: one_to_one
  }

  join: dim_country {
    type: inner
    view_label: "Geo"
    sql_on: ${dim_country.country_key}=${fact_ad_daily_agg.country_key} ;;
    relationship: many_to_one
  }

  join: dim_buying_channel {
    type:  inner
    view_label: "Buying Channel"
    sql_on: ${dim_buying_channel.buying_channel_key}=${fact_ad_daily_agg.buying_channel_key};;
    relationship: many_to_one
  }

  join: dim_deal_auction_type {
    type:  inner
    view_label: "Buying Channel"
    sql_on: ${dim_deal_auction_type.deal_auction_type_key}=${fact_ad_daily_agg.Deal_Auction_Type_Key};;
    relationship: many_to_one
  }

  join: v_dim_platformfee_type {
    type: inner
    view_label: "Platform Fee Type"
    sql_on: ${v_dim_platformfee_type.platformfee_type_key}=${fact_ad_daily_agg.platformfee_type_key} ;;
    relationship: many_to_one

  }

  join: dim_media_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_media_type.media_type_key}=${fact_ad_daily_agg.media_type_key};;
    relationship: many_to_one
  }

  join: dim_media_name {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_media_name.media_name_key}=${fact_ad_daily_agg.media_name_key};;
    relationship: many_to_one
  }

  join: dim_rg_blocked {
    type: inner
    view_label: "Impression Attributes"
    sql_on: ${dim_rg_blocked.rg_blocked_key}=${fact_ad_daily_agg.rg_blocked_key} ;;
    relationship: many_to_one
  }

  join: dim_rg_blocked_reason {
    type: inner
    view_label: "Impression Attributes"
    sql_on: ${dim_rg_blocked_reason.rg_blocked_reason_key}=${fact_ad_daily_agg.rg_blocked_reason_key} ;;
    relationship: many_to_one
  }


  join: dim_user_matched {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_user_matched.user_matched_key}=${fact_ad_daily_agg.user_matched_key} ;;
    relationship: many_to_one
  }

  join: dim_video_linearity {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_video_linearity.video_linearity_key}=${fact_ad_daily_agg.video_Linearity_key} ;;
    relationship: many_to_one
  }


  join: dim_video_simple_size {
    type: inner
    view_label: "Ad Size"
    sql_on: ${dim_video_simple_size.video_simple_size_key}=${fact_ad_daily_agg.video_simple_size_key} ;;
    relationship: many_to_one
  }
  join: dim_ad_size_width {
    type: inner
    view_label: "Ad Size"
    sql_on: ${dim_ad_size_width.ad_size_width_key}=${fact_ad_daily_agg.ad_size_width_key} ;;
    relationship: many_to_one
  }


  join: dim_ad_size_height {
    type: inner
    view_label: "Ad Size"
    sql_on: ${dim_ad_size_height.ad_size_height_key}=${fact_ad_daily_agg.ad_size_height_key} ;;
    relationship: many_to_one
  }

  join: dim_dsp_data_center {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_data_center.dsp_key}=${fact_ad_daily_agg.dsp_key}
      AND ${dim_dsp_data_center.data_center_key}=${fact_ad_daily_agg.data_center_key};;
    relationship: many_to_one
  }

  join: dim_os {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_os.os_key}=${fact_ad_daily_agg.os_key} ;;
    relationship: many_to_one

  }
  join: dim_deal_brand {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal_brand.deal_brand_key}=${dim_deal.deal_brand_key};;
    relationship: many_to_one
  }

  join: dim_deal_priority {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal_priority.deal_priority_key}=${dim_deal.deal_priority_key};;
    relationship: many_to_one
  }

  join: dim_deal_agency {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal_agency.deal_agency_key}=${dim_deal.deal_agency_key};;
    relationship: many_to_one
  }
  join: dim_deal_agency_hold_co {
    type: full_outer
    view_label: "Deal"
    sql_on: ${dim_deal_agency_hold_co.deal_agency_key}=${dim_deal.deal_agency_key};;
    relationship: many_to_one
  }

  join: dim_data_center {
    type:  inner
    view_label: "Data Center"
    sql_on: ${dim_data_center.data_center_key}=${fact_ad_daily_agg.data_center_key};;
    relationship: many_to_one

  }

  join: dim_dsp_deal_type {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_deal_type.dsp_deal_type_key}=${fact_ad_daily_agg.dsp_deal_type_key};;
    relationship: many_to_one
  }

  join: dim_device_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_device_type.device_type_key}= ${fact_ad_daily_agg.device_type_key};;
    relationship: many_to_one
  }
  join: dim_imp_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_imp_type.imp_type_key}=${fact_ad_daily_agg.imp_type_key};;
    relationship: many_to_one
  }
  join: dim_response_status {
    type: inner
    view_label: "Response Attributes"
    sql_on: ${dim_response_status.response_status_key}=${fact_ad_daily_agg.response_status_key};;
    relationship: many_to_one
  }
  join: dim_request_status {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_request_status.request_status_key}= ${fact_ad_daily_agg.request_status_key};;
    relationship: many_to_one
  }

  join: dim_imp_sub_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_imp_sub_type.imp_sub_type_key}=${fact_ad_daily_agg.imp_sub_type_key};;
    relationship: many_to_one
  }

  join: dim_a_domain  {
    type: inner
    view_label: "Domain"
    sql_on: ${dim_a_domain.a_domain_key}=${fact_ad_daily_agg.a_domain_key};;
    relationship: many_to_one
  }
  join: dim_o_domain {
    type: inner

    view_label: "Domain"
    sql_on: ${dim_o_domain.o_domain_key}=${fact_ad_daily_agg.o_domain_key};;
    relationship: many_to_one
  }
  join: dim_deal {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal.deal_key}=${fact_ad_daily_agg.deal_key};;
    relationship: many_to_one
  }


  join: dim_deal_type {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal_type.deal_type_key}=${dim_deal.deal_type_key} ;;
    relationship: many_to_one
  }
  join: dim_placement {
    type: inner
    view_label: "Placement"
    sql_on: ${dim_placement.placement_key}=${fact_ad_daily_agg.placement_key};;
    relationship: many_to_one
  }
  join: dim_publisher_traffic_source {
    type: inner
    view_label: "Traffic Source"
    sql_on: ${dim_publisher_traffic_source.pub_ts_key}=${dim_placement.pub_ts_key};;
    relationship: many_to_one
  }
  join: dim_traffic_source {
    type: inner
    view_label: "Traffic Source"
    sql_on: ${dim_traffic_source.ts_key}=${dim_publisher_traffic_source.ts_key};;
    relationship: many_to_one
  }

  join: dim_publisher_ssp {
    type: inner
    view_label: "SSP"
    sql_on: ${dim_publisher_ssp.pub_ssp_key}=${fact_ad_daily_agg.pub_ssp_key};;
    relationship: many_to_one
    #fields: []
  }
  join: dim_publisher {
    type: inner
    view_label: "Publishers"
    sql_on: ${dim_publisher.pub_key}=${dim_publisher_ssp.pub_key} ;;
    relationship: many_to_one
  }
  join: dim_ssp {
    type: inner
    view_label: "SSP"
    sql_on: ${dim_ssp.ssp_key}=${dim_publisher_ssp.ssp_key};;
    relationship: many_to_one
  }
  join: dim_dsp_flight {
    type: inner
    sql_on: ${dim_dsp_flight.dsp_flight_key}=${fact_ad_daily_agg.dsp_flight_key};;
    relationship: many_to_one
    fields: []
  }

  join: v_dim_employee_biz_dev {
    type: inner
    view_label: "Employee"
    sql_on: ${v_dim_employee_biz_dev.employee_key}=${fact_ad_daily_agg.bizdev_owner_key}  ;;
    relationship: many_to_one
  }

  join: v_dim_employee_pub_ops {
    type: inner
    view_label: "Employee"
    sql_on: ${v_dim_employee_pub_ops.employee_key}=${fact_ad_daily_agg.operations_owner_key}  ;;
    relationship: many_to_one
  }

  join: dim_employee {
    type: full_outer
    view_label: "Employee"
    sql_on: ${dim_employee.employee_key}=${fact_ad_daily_agg.bizdev_owner_key} or
      ${dim_employee.employee_key}=${fact_ad_daily_agg.operations_owner_key};;
    relationship: many_to_one
  }

  join: dim_flight {
    type: inner
    view_label: "Flight"
    sql_on: ${dim_flight.flight_key}=${dim_dsp_flight.flight_key};;
    relationship: many_to_one
  }
  join: dim_dsp {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp.dsp_key}=${fact_ad_daily_agg.dsp_key};;
    relationship: many_to_one
  }
  join: dim_dsp_account {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_account.dsp_account_key}=${dim_dsp.dsp_account_key};;
    relationship: many_to_one
  }
  join: dim_dsp_seat {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_seat.dsp_seat_key}=${fact_ad_daily_agg.dsp_seat_key};;
    relationship: many_to_one
  }

  join: dim_dsp_seat_hold_co  {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_seat_hold_co.dsp_account_id} = ${dim_dsp_account.dsp_account_id} AND
      ${dim_dsp_seat_hold_co.seat_id} = ${dim_dsp_seat.seat_id};;
    relationship: many_to_one
  }
  join: dim_seat {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_seat.seat_key}=${dim_dsp_seat.seat_key};;
    relationship: many_to_one
  }

  join: dim_genre_norm {
    type: inner
    view_label: "Content Attributes"
    sql_on: ${dim_genre_norm.Genre_Norm_key}=${fact_ad_daily_agg.Genre_Norm_Key};;
    relationship: many_to_one
  }
  join: dim_content_rating_norm {
    type: inner
    view_label: "Content Attributes"
    sql_on: ${dim_content_rating_norm.content_rating_norm_key}=${fact_ad_daily_agg.Content_Rating_Norm_Key};;
    relationship: many_to_one
  }

  join: dim_content_network {
    type: inner
    view_label: "Content Attributes"
    sql_on: ${dim_content_network.content_network_key}=${fact_ad_daily_agg.Content_Network_Key};;
    relationship: many_to_one
  }
  join: dim_content_language_norm {
    type: inner
    view_label: "Content Attributes"
    sql_on: ${dim_content_language_norm.content_language_norm_key}=${fact_ad_daily_agg.Content_Language_Norm_Key};;
    relationship: many_to_one
  }

  join: dim_deal_personnel {
    type: inner
    view_label: "Personnel"
    sql_on: ${dim_deal_personnel.deal_id}=${dim_deal.internal_deal_id} ;;
    relationship: many_to_one
  }
}


explore: fact_ad_hourly_agg{
  always_filter: {
    filters: [dim_date_hourly.date_time_key_date: "last 10 days "]

  }
  required_access_grants: [can_view_all_tremor]

  persist_with: CleanCash_datagroup
  label: "Inbound Exchange Hourly"
  view_label: "Measures"


  join: dim_date_hourly {
    type: inner
    view_label: "Time Frame Hourly"
    sql_on: ${dim_date_hourly.date_time_key_raw}=${fact_ad_hourly_agg.datetime_key_raw} ;;
    relationship: many_to_one
  }

  join: dim_rg_blocked {
    type: full_outer
    view_label: "Request Attributes"
    sql_on: ${dim_rg_blocked.rg_blocked_key}=${fact_ad_hourly_agg.rg_blocked_key} ;;
    relationship: many_to_one
  }

  join: dim_rg_blocked_reason {
    type: full_outer
    view_label: "Request Attributes"
    sql_on: ${dim_rg_blocked_reason.rg_blocked_reason_key}=${fact_ad_hourly_agg.rg_blocked_reason_key} ;;
    relationship: many_to_one
  }


  join: dim_user_matched {
    type: full_outer
    view_label: "Request Attributes"
    sql_on: ${dim_user_matched.user_matched_key}=${fact_ad_hourly_agg.user_matched_key} ;;
    relationship: many_to_one
  }


  join: dim_video_linearity {
    type: full_outer
    view_label: "Request Attributes"
    sql_on: ${dim_video_linearity.video_linearity_key}=${fact_ad_hourly_agg.video_Linearity_key} ;;
    relationship: many_to_one
  }


  join: dim_video_simple_size {
    type: full_outer
    view_label: "Ad Size"
    sql_on: ${dim_video_simple_size.video_simple_size_key}=${fact_ad_hourly_agg.video_simple_size_key} ;;
    relationship: many_to_one
  }
  join: dim_ad_size_width {
    type: full_outer
    view_label: "Ad Size"
    sql_on: ${dim_ad_size_width.ad_size_width_key}=${fact_ad_hourly_agg.ad_size_width_key} ;;
    relationship: many_to_one
  }


  join: dim_ad_size_height {
    type: full_outer
    view_label: "Ad Size"
    sql_on: ${dim_ad_size_height.ad_size_height_key}=${fact_ad_hourly_agg.ad_size_height_key} ;;
    relationship: many_to_one
  }

  join: dim_dsp_data_center {
    type: full_outer
    view_label: "DSP"
    sql_on: ${dim_dsp_data_center.dsp_key}=${fact_ad_hourly_agg.dsp_key}
      AND ${dim_dsp_data_center.data_center_key}=${fact_ad_hourly_agg.data_center_key};;
    relationship: many_to_one
  }

  join: dim_os {
    type: full_outer
    view_label: "Request Attributes"
    sql_on: ${dim_os.os_key}=${fact_ad_hourly_agg.os_key} ;;
    relationship: many_to_one

  }
  join: dim_deal_brand {
    type: full_outer
    view_label: "Deal"
    sql_on: ${dim_deal_brand.deal_brand_key}=${dim_deal.deal_brand_key};;
    relationship: many_to_one
  }

  join: dim_deal_priority {
    type: full_outer
    view_label: "Deal"
    sql_on: ${dim_deal_priority.deal_priority_key}=${dim_deal.deal_priority_key};;
    relationship: many_to_one
  }

  join: dim_deal_agency {
    type: full_outer
    view_label: "Deal"
    sql_on: ${dim_deal_agency.deal_agency_key}=${dim_deal.deal_agency_key};;
    relationship: many_to_one
  }


  join: dim_country {
    type: inner
    view_label: "Geo"
    sql_on: ${dim_country.country_key}=${fact_ad_hourly_agg.country_key} ;;
    relationship: many_to_one
  }

  join: dim_buying_channel {
    type:  inner
    view_label: "Buying Channel"
    sql_on: ${dim_buying_channel.buying_channel_key}=${fact_ad_hourly_agg.buying_channel_key};;
    relationship: many_to_one


  }

  join: dim_media_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_media_type.media_type_key}=${fact_ad_hourly_agg.media_type_key};;
    relationship: many_to_one
  }

  join: dim_data_center {
    type:  inner
    view_label: "Data Center"
    sql_on: ${dim_data_center.data_center_key}=${fact_ad_hourly_agg.data_center_key};;
    relationship: many_to_one

  }

  join: dim_dsp_deal_type {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_deal_type.dsp_deal_type_key}=${fact_ad_hourly_agg.dsp_deal_type_key};;
    relationship: many_to_one
  }

  join: dim_device_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_device_type.device_type_key}= ${fact_ad_hourly_agg.device_type_key};;
    relationship: many_to_one
  }
  join: dim_imp_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_imp_type.imp_type_key}=${fact_ad_hourly_agg.imp_type_key};;
    relationship: many_to_one
  }
  join: dim_response_status {
    type: inner
    view_label: "Response Attributes"
    sql_on: ${dim_response_status.response_status_key}=${fact_ad_hourly_agg.response_status_key};;
    relationship: many_to_one
  }
  join: dim_request_status {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_request_status.request_status_key}= ${fact_ad_hourly_agg.request_status_key};;
    relationship: many_to_one
  }

  join: dim_imp_sub_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_imp_sub_type.imp_sub_type_key}=${fact_ad_hourly_agg.imp_sub_type_key};;
    relationship: many_to_one
  }

  join: dim_a_domain  {
    type: inner
    view_label: "Domain"
    sql_on: ${dim_a_domain.a_domain_key}=${fact_ad_hourly_agg.a_domain_key};;
    relationship: many_to_one
  }
  join: dim_o_domain {
    type: inner
    view_label: "Domain"
    sql_on: ${dim_o_domain.o_domain_key}=${fact_ad_hourly_agg.o_domain_key};;
    relationship: many_to_one
  }
  join: dim_deal {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal.deal_key}=${fact_ad_hourly_agg.deal_key};;
    relationship: many_to_one
  }


  join: dim_deal_type {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal_type.deal_type_key}=${dim_deal.deal_type_key} ;;
    relationship: many_to_one
  }
  join: dim_placement {
    type: inner
    view_label: "Placement"
    sql_on: ${dim_placement.placement_key}=${fact_ad_hourly_agg.placement_key};;
    relationship: many_to_one
  }
  join: dim_publisher_traffic_source {
    type: inner
    view_label: "Traffic Source"
    sql_on: ${dim_publisher_traffic_source.pub_ts_key}=${dim_placement.pub_ts_key};;
    relationship: many_to_one
  }
  join: dim_traffic_source {
    type: inner
    view_label: "Traffic Source"
    sql_on: ${dim_traffic_source.ts_key}=${dim_publisher_traffic_source.ts_key};;
    relationship: many_to_one
  }

  join: dim_publisher_ssp {
    type: inner
    sql_on: ${dim_publisher_ssp.pub_ssp_key}=${fact_ad_hourly_agg.pub_ssp_key};;
    relationship: many_to_one
    fields: []
  }
  join: dim_publisher {
    type:full_outer
    view_label: "Publishers"
    sql_on: ${dim_publisher.pub_key}=${dim_publisher_ssp.pub_key} ;;
    relationship: many_to_one
  }
  join: dim_ssp {
    type: inner
    view_label: "SSP"
    sql_on: ${dim_ssp.ssp_key}=${dim_publisher_ssp.ssp_key};;
    relationship: many_to_one
  }
  join: dim_dsp_flight {
    type: inner
    sql_on: ${dim_dsp_flight.dsp_flight_key}=${fact_ad_hourly_agg.dsp_flight_key};;
    relationship: many_to_one
    fields: []
  }
  join: dim_employee {
    type: inner
    view_label: "Employee"
    sql_on: ${dim_employee.employee_key}=${dim_publisher.bizdev_owner_key};;
    relationship: many_to_one
  }
  join: v_dim_employee_biz_dev {
    type: inner
    view_label: "Employee"
    sql_on: ${v_dim_employee_biz_dev.employee_key}=${dim_publisher.bizdev_owner_key};;
    relationship: many_to_one
  }
  join: v_dim_employee_pub_ops {
    type: inner
    view_label: "Employee"
    sql_on: ${v_dim_employee_pub_ops.employee_key}=${dim_publisher.ops_owner_key};;
    relationship: many_to_one
  }

  join: dim_flight {
    type: inner
    view_label: "Flight"
    sql_on: ${dim_flight.flight_key}=${dim_dsp_flight.flight_key};;
    relationship: many_to_one
  }
  join: dim_dsp {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp.dsp_key}=${fact_ad_hourly_agg.dsp_key};;
    relationship: many_to_one
  }
  join: dim_dsp_account {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_account.dsp_account_key}=${dim_dsp.dsp_account_key};;
    relationship: many_to_one
  }
  join: dim_dsp_seat {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_seat.dsp_seat_key}=${fact_ad_hourly_agg.dsp_seat_key};;
    relationship: many_to_one

  }
  join: dim_seat {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_seat.seat_key}=${dim_dsp_seat.seat_key};;
    relationship: many_to_one
  }
}






explore: fact_ad_bid_request_daily_agg{
  #always_filter: {
   # filters: [dim_date.date_key_date: "last 14 days ago for 14 days"]
  #}




  persist_with: CleanCash_datagroup
  label: "Outbound Exchange"
  view_label: "Measures"
  required_access_grants: [can_view_all_tremor]

  join: dim_dsp_data_center {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_data_center.dsp_key}=${fact_ad_bid_request_daily_agg.dsp_key}
      AND ${dim_dsp_data_center.data_center_key}=${fact_ad_bid_request_daily_agg.data_center_key};;
    relationship: many_to_one
  }
  join: dim_date {
    type: inner
    view_label: "Time Frame"
    sql_on: ${dim_date.date_key_raw}=${fact_ad_bid_request_daily_agg.date_key_raw};;
    relationship: many_to_one
  }
  join: dim_country {
    type: inner
    view_label: "Geo"
    sql_on: ${dim_country.country_key}=${fact_ad_bid_request_daily_agg.country_key};;
    relationship: many_to_one
  }

  join: dim_request_status {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_request_status.request_status_key}= ${fact_ad_bid_request_daily_agg.request_status_key};;
    relationship: many_to_one
  }

  join: dim_user_matched {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_user_matched.user_matched_key}=${fact_ad_bid_request_daily_agg.user_matched_key} ;;
    relationship: many_to_one
  }

  join: v_dim_dsp_filter_reason {
    type: inner
    view_label: "Filter Reason"
    sql_on: ${v_dim_dsp_filter_reason.dsp_filter_reason_key}=${fact_ad_bid_request_daily_agg.dsp_filter_reason_key} ;;
    relationship: many_to_one
  }

  join: dim_ad_size_width {
    type: inner
    view_label: "Ad Size"
    sql_on: ${dim_ad_size_width.ad_size_width_key}=${fact_ad_bid_request_daily_agg.ad_size_width_key} ;;
    relationship: many_to_one
  }


  join: dim_ad_size_height {
    type: inner
    view_label: "Ad Size"
    sql_on: ${dim_ad_size_height.ad_size_height_key}=${fact_ad_bid_request_daily_agg.ad_size_height_key} ;;
    relationship: many_to_one
  }

  join: dim_data_center {
    type:  inner
    view_label: "Data Center"
    sql_on: ${dim_data_center.data_center_key}=${fact_ad_bid_request_daily_agg.data_center_key};;
    relationship: many_to_one

  }

  join: dim_device_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_device_type.device_type_key}= ${fact_ad_bid_request_daily_agg.device_type_key};;
    relationship: many_to_one
  }
  join: dim_imp_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_imp_type.imp_type_key}=${fact_ad_bid_request_daily_agg.imp_type_key};;
    relationship: many_to_one
  }

  join: dim_os {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_os.os_key}=${fact_ad_bid_request_daily_agg.os_key} ;;
    relationship: many_to_one

  }


  join: dim_imp_sub_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_imp_sub_type.imp_sub_type_key}=${fact_ad_bid_request_daily_agg.imp_sub_type_key};;
    relationship: many_to_one
  }

  join: dim_o_domain {
    type: inner
    view_label: "Domain"
    sql_on: ${dim_o_domain.o_domain_key}= ${fact_ad_bid_request_daily_agg.o_domain_key};;
    relationship: many_to_one
  }
  join: dim_deal {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal.deal_key}=${fact_ad_bid_request_daily_agg.deal_key};;
    relationship: many_to_one
  }
  join: dim_deal_brand {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal_brand.deal_brand_key}=${dim_deal.deal_brand_key};;
    relationship: many_to_one
  }

  join: dim_deal_priority {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal_priority.deal_priority_key}=${dim_deal.deal_priority_key};;
    relationship: many_to_one
  }

  join: dim_deal_agency {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal_agency.deal_agency_key}=${dim_deal.deal_agency_key};;
    relationship: many_to_one
  }

  join: dim_deal_type {
    type: inner
    view_label: "Deal"
    sql_on: ${dim_deal_type.deal_type_key}=${dim_deal.deal_type_key} ;;
    relationship: many_to_one
  }
  join: dim_placement {
    type: inner
    view_label: "Placement"
    sql_on: ${dim_placement.placement_key}=${fact_ad_bid_request_daily_agg.placement_key};;
    relationship: many_to_one
  }

  join: dim_media_type {
    type: inner
    view_label: "Request Attributes"
    sql_on: ${dim_media_type.media_type_key}=${fact_ad_bid_request_daily_agg.media_type_key};;
    relationship: many_to_one
  }
  join: dim_publisher_traffic_source {
    type: inner
    view_label: "Traffic Source"
    sql_on: ${dim_publisher_traffic_source.pub_ts_key}=${dim_placement.pub_ts_key};;
    relationship: many_to_one
  }
  join: dim_traffic_source {
    type: inner
    view_label: "Traffic Source"
    sql_on: ${dim_traffic_source.ts_key}=${dim_publisher_traffic_source.ts_key};;
    relationship: many_to_one
  }

  join: dim_publisher_ssp {
    type: inner
    sql_on: ${dim_publisher_ssp.pub_ssp_key}=${fact_ad_bid_request_daily_agg.pub_ssp_key};;
    relationship: many_to_one
    fields: []
  }
  join: dim_publisher {
    type: inner
    view_label: "Publishers"
    sql_on: ${dim_publisher.pub_key}=${dim_publisher_ssp.pub_key} ;;
    relationship: many_to_one
  }
  join: dim_ssp {
    type: inner
    view_label: "SSP"
    sql_on: ${dim_ssp.ssp_key}=${dim_publisher_ssp.ssp_key};;
    relationship: many_to_one
  }

  join: dim_employee {
    type: inner
    view_label: "Employee"
    sql_on: ${dim_employee.employee_key}=${dim_publisher.bizdev_owner_key};;
    relationship: many_to_one
  }
  join: v_dim_employee_biz_dev {
    type: inner
    view_label: "Employee"
    sql_on: ${v_dim_employee_biz_dev.employee_key}=${dim_publisher.bizdev_owner_key};;
    relationship: many_to_one
  }
  join: v_dim_employee_pub_ops {
    type: inner
    view_label: "Employee"
    sql_on: ${v_dim_employee_pub_ops.employee_key}=${dim_publisher.ops_owner_key};;
    relationship: many_to_one
  }


  join: dim_dsp {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp.dsp_key}=${fact_ad_bid_request_daily_agg.dsp_key};;
    relationship: many_to_one
  }
  join: dim_dsp_account {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_account.dsp_account_key}=${dim_dsp.dsp_account_key};;
    relationship: many_to_one
  }

  join: dim_dsp_deal_type {
    type: inner
    view_label: "DSP"
    sql_on: ${dim_dsp_deal_type.dsp_deal_type_key}=${fact_ad_bid_request_daily_agg.dsp_deal_type_key};;
    relationship: many_to_one
  }

  join: dim_deal_personnel {
    type: inner
    view_label: "Personnel"
    sql_on: ${dim_deal_personnel.deal_id}=${dim_deal.internal_deal_id} ;;
    relationship: many_to_one
  }

}
