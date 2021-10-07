connection: "bi_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                   # include all views in this project
#include: "my_dashboard.dashboard.lookml"    # include a LookML dashboard called my_dashboard
datagroup: CleanCash_datagroup {
  sql_trigger: SELECT max(date_key) FROM dim_date ;;
  max_cache_age: "15 hours"
  label: "Clean Cash Trigger"
  description: "Triggered when new date is added to ETL"
}

explore: fact_ad_daily_agg{
  persist_with: CleanCash_datagroup
  label: "Exchange"
  view_label: "Exchange Measures"

join: dim_date {
  type: inner
  view_label: "Time Frame"
  sql_on: ${dim_date.date_key}=${fact_ad_daily_agg.date_key} ;;
  relationship: many_to_one
}
join: dim_country {
  type: inner
  view_label: "Geo"
  sql_on: ${dim_country.country_key}=${fact_ad_daily_agg.country_key} ;;
  relationship: many_to_one
  }
join: dim_device_type {
  type: inner
  view_label: "Media"
  sql_on: ${dim_device_type.device_type_key}= ${fact_ad_daily_agg.device_type_key};;
  relationship: many_to_one
}
join: dim_imp_type {
  type: inner
  view_label: "Media"
  sql_on: ${dim_imp_type.imp_type_key}=${fact_ad_daily_agg.imp_type_key};;
  relationship: many_to_one
}
join: dim_response_status {
  type: inner
  view_label: "DSP"
  sql_on: ${dim_response_status.response_status_key}=${fact_ad_daily_agg.response_status_key};;
  relationship: many_to_one
}
join: dim_request_status {
  type: inner
  view_label: "SSP"
  sql_on: ${dim_request_status.request_status_key}= ${fact_ad_daily_agg.request_status_key};;
  relationship: many_to_one
}

join: dim_imp_sub_type {
  type: inner
  view_label: "Media"
  sql_on: ${dim_imp_sub_type.imp_sub_type_key}=${dim_imp_sub_type.imp_sub_type_key};;
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
  sql_on: ${dim_deal_type.deal_type_key}=${fact_ad_daily_agg_with_date.deal_type_key } ;;
  relationship: many_to_one
}
join: dim_placement {
  type: inner
  view_label: "Media"
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
  sql_on: ${dim_publisher_ssp.pub_ssp_key}=${fact_ad_daily_agg.pub_ssp_key};;
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
join: dim_dsp_flight {
  type: inner
  sql_on: ${dim_dsp_flight.flight_key}=${fact_ad_daily_agg.dsp_flight_key};;
  relationship: many_to_one
  fields: []
}
join: dim_employee {
  type: inner
  view_label: "Employee"
  sql_on: ${dim_employee.employee_key}=${dim_publisher.bizdev_owner_key};;
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
  sql_on: ${dim_dsp.dsp_key}=${dim_dsp_flight.dsp_key};;
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
  sql_on: ${dim_dsp_seat.dsp_seat_key}=${fact_ad_daily_agg.dsp_seat_key};;
  relationship: many_to_one
  fields: []
}
join: dim_seat {
  type: inner
  view_label: "DSP"
  sql_on: ${dim_seat.seat_key}=${dim_dsp_seat.seat_key};;
  relationship: many_to_one
}

}
