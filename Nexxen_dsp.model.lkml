connection: "vertica_iad"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"
#include: "*.dashboard.lookml"
# include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
datagroup: CleanCash_datagroup {
  sql_trigger: SELECT max(date_key) FROM BI_DSP.fact_nexxen_dsp  ;;
  max_cache_age: "15 hours"
  label: "Clean Cash Trigger"
  description: "Triggered when new date is added to ETL"
}

access_grant: can_view_pub_come_looker {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}

access_grant: billing_report_group {
  user_attribute: billing_group
  allowed_values: ["yes"]
}


access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}

explore: billing_temp_nov {
  #required_access_grants: [billing_report_group]
  label: "Billing US Final"
  # hidden: yes
}

explore: monthly_billing_override_data {
  required_access_grants: [billing_report_group]
  label: "Monthly Billing Override Data"
  # hidden: yes
}
explore: v_monthly_dato_billing_report_diff{
    label: "Datorama Looker Diff"
}

explore: v_monthly_billing_report_diff_live_locked {
 label: "Diff Report"
}

explore: v_monthly_dato_billing_report_diff_on_locked {
  label: "Billing Diff Report Locked"
}

explore: monthly_billing_locked_report{
 label: "Locked Report"
}





#explore: v_monthly_billing_report_diff_live_locked {
# required_access_grants: [billing_report_group]
#  label: "Monthly Billing Report Diff Live Locked"
#  # hidden: yes
#}

#explore: monthly_billing_locked_report {
#  required_access_grants: [billing_report_group]
#  label: "Monthly billing locked report"
  # hidden: yes
#}



explore: fact_reach_frequency {
  required_access_grants: [can_view_all_tremor]
  view_name: fact_reach_frequency
  label: "Nexxen dsp - Reach"
  persist_with: CleanCash_datagroup
  view_label: "Measures"
  hidden: yes
}

explore: fact_nexxen_dsp  {
  required_access_grants: [can_view_all_tremor]
  view_name: fact_nexxen_dsp
  persist_with: CleanCash_datagroup
  label: "Nexxen dsp"
  view_label: "Measures"

  join: dim_dsp_inventory_source {
    type: left_outer
    view_label: "Inventory Source"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp.inventory_source_key}=${dim_dsp_inventory_source.inventory_source_key} ;;
  }

  # join: dim_dsp_environment {
  #   type: left_outer
  #   view_label: "Environment"
  #   relationship: many_to_one
  #   sql_on: ${fact_nexxen_dsp.environment_key}=${dim_dsp_environment.environment_key} ;;
  # }

  join: dim_dsp_format {
    type: left_outer
    view_label: "Request Attributes"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp.format_id}=${dim_dsp_format.format_id} ;;
  }
  join: dim_dsp_creative_size {
    type: left_outer
    view_label: "Creative"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp.creative_size_key}=${dim_dsp_creative_size.creative_size_key} ;;
  }
  join: dim_dsp_dma{
    type: left_outer
    view_label: "Geo"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp.dma_key}=${dim_dsp_dma.dma_key} ;;
  }
  join: dim_dsp_device_type {
    type: left_outer
    view_label: "Request Attributes"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp.device_type_key}=${dim_dsp_device_type.device_type_key} ;;
  }
  join: dim_dsp_city {
    type: left_outer
    view_label: "Geo"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp.city_key}=${dim_dsp_city.city_id_key} ;;
  }

  join: dim_dsp_beacon {
    type: left_outer
    view_label: "Beacon"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp.beacon_key}=${dim_dsp_beacon.beacon_key} ;;
  }

  join: dim_dsp_country {
    type: left_outer
    view_label: "Geo"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp.country_key}=${dim_dsp_country.country_key} ;;
  }

  join: dim_dsp_region{
    type: left_outer
    view_label: "Geo"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp.region_key}=${dim_dsp_region.region_key} ;;
  }

  join: dim_dsp_mobile_app {
    type: left_outer
    view_label: "Request Attributes"
    relationship: many_to_one
    sql_on: ${fact_nexxen_dsp.mobile_app_key}=${dim_dsp_mobile_app.mobile_app_key} ;;
  }

  join: dim_dsp_creative {
    type: left_outer
    view_label: "Creative"
    sql_on: ${dim_dsp_creative.creative_id_key}=${fact_nexxen_dsp.creative_id_key} ;;
    relationship: many_to_one
  }

  # join: dim_dsp_environment {
  #   type: left_outer
  #   view_label: "Environment"
  #   sql_on: ${dim_dsp_environment.environment_key}=${fact_nexxen_dsp.environment_key} ;;
  #   relationship: many_to_one
  # }

  join: dim_dsp_creative_file {
    type:left_outer
    view_label: "Creative"
    sql_on: ${dim_dsp_creative_file.creative_file_key} = ${fact_nexxen_dsp.creative_file_key};;
    relationship: many_to_one
  }

  join: dim_dsp_device_manufacturer {
    type:left_outer
    view_label: "Request Attributes"
    sql_on: ${dim_dsp_device_manufacturer.device_manufacturer_key} = ${fact_nexxen_dsp.device_manufacturer_key};;
    relationship: many_to_one
  }

  join: ncd_pacing {
    type: inner
    view_label: "Salesforce Opportunity Line Item"
    sql_on: ${ncd_pacing.opportunitylineitem_key}=${dim_sfdb_opportunitylineitem.opportunitylineitem_key} AND ${ncd_pacing.date_key_in_timezone_date}=${v_dim_dsp_date.date_key_date};;
    relationship: many_to_one
  }

  join: dim_dsp_monthly_manual_adjustment {
    type:left_outer
    view_label: "Manual Billing ADJ"
    sql_on: ${dim_dsp_monthly_manual_adjustment.manual_adjustment_key} = ${fact_nexxen_dsp.manual_adjustment_key};;
    relationship: many_to_one
  }

  join: dim_dsp_netsuite_invoice{
    type:left_outer
    view_label: "Netsuite Billing Fields"
    sql_on: ${dim_dsp_netsuite_invoice.netsuite_invoice_key} = ${fact_nexxen_dsp.netsuite_invoice_key};;
    relationship: many_to_one
  }

  join: dim_dsp_creative_file_tracking_url {
    type: left_outer
    view_label: "Creative"
    sql_on: ${dim_dsp_creative_file_tracking_url.creative_file_id} = ${dim_dsp_creative_file.creative_file_id}
    and ${dim_dsp_creative_file_tracking_url.platform_id} = ${dim_dsp_creative_file.platform_id};;
    relationship: many_to_one
  }


  join: v_dim_dsp_date {
    type: inner
    view_label: "Time Frame"
    sql_on: ${v_dim_dsp_date.date_key_raw} = ${fact_nexxen_dsp.date_key_in_timezone_raw} ;;
    relationship: many_to_one

  }
  join: dim_sfdb_legal_entity {
    type: inner
    view_label: "Legal Entity"
    sql_on: ${dim_sfdb_legal_entity.id} = ${dim_sfdb_account.legal_entity__c} ;;
    relationship: many_to_one

  }


  join: dim_dsp_advertiser {

    type: inner
    view_label: "Advertiser"
    sql_on: ${dim_dsp_advertiser.advertiser_id_key} = ${fact_nexxen_dsp.advertiser_id_key} ;;
    relationship: many_to_one
  }

  join: dim_dsp_market {
    type: inner
    view_label: "Market"
    sql_on: ${dim_dsp_market.market_id_key} = ${fact_nexxen_dsp.market_id_key};;
    relationship: many_to_one
  }


  join: dim_dsp_package_budget_schedule {
    type: inner
    view_label: "DSP Flight & Package"
    sql_on:${dim_dsp_package_budget_schedule.package_budget_schedule_key}=${fact_nexxen_dsp.package_budget_schedule_key};;
    relationship: many_to_one
  }

  join: dim_sfdb_account {
    type: inner
    view_label: "Salesforce Account"
    sql_on: ${dim_sfdb_account.account_id_key} = ${fact_nexxen_dsp.account_id_key};;
    relationship: many_to_one

  }
  join: dim_sfdb_po__c {

    type: left_outer
    view_label: "Salesforce Purchase Order"
    sql_on: ${dim_sfdb_po__c.account_aid__c} = ${dim_sfdb_account.id} ;;
    relationship: many_to_one

  }

  join: dim_sfdb_opportunity {
    type: inner
    view_label: "Salesforce Opportunity"
    sql_on: ${dim_sfdb_opportunity.opportunity_id_key} = ${fact_nexxen_dsp.opportunity_id_key} ;;
    relationship: many_to_one
  }

  # join: v_dim_sfdb_opportunitylineitemschedule_looker {
  #   type: inner
  #   view_label: "Salesforce Opportunity Line Item Flight"
  #   sql_on: ${v_dim_sfdb_opportunitylineitemschedule_looker.opportunitylineitem_key} = ${fact_nexxen_dsp.opportunitylineitem_key}
  #   and ${fact_nexxen_dsp.date_key_in_timezone_raw}>= ${v_dim_sfdb_opportunitylineitemschedule_looker.scheduledate_raw} and
  #   ${fact_nexxen_dsp.date_key_in_timezone_raw} <= ${v_dim_sfdb_opportunitylineitemschedule_looker.end_date__c_raw};;
  #   relationship: many_to_one

  # }

  join: dim_sfdb_opportunitylineitemschedule {
    type: inner
    view_label: "Salesforce Opportunity Line Item Flight"
    sql_on: ${dim_sfdb_opportunitylineitemschedule.opportunitylineitemschedule_key}=${fact_nexxen_dsp.opportunitylineitemschedule_key} ;;
    relationship: many_to_one
  }
  join:  dim_sfdb_opportunitylineitem {
    type: inner
    view_label: "Salesforce Opportunity Line Item"
    sql_on: ${dim_sfdb_opportunitylineitem.opportunitylineitem_key} =${fact_nexxen_dsp.opportunitylineitem_key} ;;
    relationship: many_to_one


  }


  join: dim_sfdb_user {

    type: inner
    view_label: "Employee"
    sql_on: ${dim_sfdb_user.user_key_id}=${fact_nexxen_dsp.user_key_id};;
    relationship: many_to_one

  }

  join: datorama_dsp_third_party {
    type: full_outer
    view_label: "3rd Party Data"
    sql_on: ${datorama_dsp_third_party.third_party_key}=${fact_nexxen_dsp.third_party_key} ;;
    relationship: many_to_one
  }

  join: v_dim_netsuite_daily_exchange_rate_target_currency {
    type: inner
    view_label: "Netsuite Target Currency"
    sql_on: ${v_dim_netsuite_daily_exchange_rate_target_currency.netsuite_daily_exchange_rate_key}=${fact_nexxen_dsp.exchange_rate_to_target_currency_key} ;;
    relationship: many_to_one
  }

  join: v_dim_netsuite_daily_exchange_rate_usd_currency {
    type: inner
    view_label: "Netsuite USD Currency"
    sql_on: ${v_dim_netsuite_daily_exchange_rate_usd_currency.netsuite_daily_exchange_rate_key}=${fact_nexxen_dsp.exchange_rate_to_usd_currency_key} ;;
    relationship: many_to_one
  }

  join: dim_sfdb_related_accounts {
    type: left_outer
    view_label: "Salesforce Account"
    sql_on: ${dim_sfdb_related_accounts.id}=${dim_sfdb_opportunity.related_account__c} ;;
    relationship: many_to_one
  }

  join: dim_sfdb_user_opportunity_owner {
    type: inner
    view_label: "Employee"
    sql_on: ${dim_sfdb_user_opportunity_owner.opp_owner_id}=${dim_sfdb_opportunity.ownerid} ;;
    relationship: many_to_one
  }

  join: v_dim_sfdb_opportunitylineitemschedule_new {
    type: inner
    view_label: "Salesforce Opportunity Line Item Schedule"
    sql_on: ${v_dim_sfdb_opportunitylineitemschedule_new.opportunitylineitem_key}=${fact_nexxen_dsp.opportunitylineitem_key}
      and ${fact_nexxen_dsp.date_key_month}=${v_dim_sfdb_opportunitylineitemschedule_new.event_month_month};;
    relationship: many_to_one
  }

  join: dim_dsp_package {
    type: inner
    view_label: "Package"
    sql_on: ${dim_dsp_package.package_id_key}=${fact_nexxen_dsp.package_id_key} ;;
    relationship: many_to_one
  }

  join: dim_dsp_line_item {
    type: inner
    view_label: "Line Item"
    sql_on: ${dim_dsp_line_item.line_item_id_key}=${fact_nexxen_dsp.line_item_key} ;;
    relationship: many_to_one
  }

  join: dim_dsp_target_deal {
    type: inner
    view_label: "Target Deal"
    sql_on: ${dim_dsp_line_item.line_item_id}=${dim_dsp_target_deal.line_item_id} ;;
    relationship: many_to_one
  }

  join: dim_dsp_publisher_deal {
    type: inner
    view_label: "Publisher Deal"
    sql_on: ${dim_dsp_target_deal.publisher_deal_id}=${dim_dsp_publisher_deal.publisher_deal_id};;
    relationship: many_to_one
  }

  join: dim_dsp_insertion_order {
    type: inner
    view_label: "Insertion Order"
    sql_on: ${dim_dsp_line_item.insertion_order_id}=${dim_dsp_insertion_order.insertion_order_id} ;;
    relationship: many_to_one
  }

  join: dim_sfdb_account_opportunity_billling_account_name {
    type: inner
    view_label: "Salesforce Opportunity"
    sql_on: ${fact_nexxen_dsp.opportunity_id_key}=${dim_sfdb_account_opportunity_billling_account_name.opportunity_id_key} ;;
    relationship: many_to_one
  }



  # join: advertisers_email {
  #   type: inner
  #   sql_on: ${dim_dsp_advertiser.advertiser_id}=${advertisers_email.advertiser_id} ;;
  #   relationship: many_to_one
  # }

}
