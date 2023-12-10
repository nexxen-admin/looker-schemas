connection: "vertica_amobee"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
datagroup: CleanCash_datagroup {
  sql_trigger: SELECT max(date_key) FROM BI_DSP.fact_nexxen_dsp  ;;
  max_cache_age: "15 hours"
  label: "Clean Cash Trigger"
  description: "Triggered when new date is added to ETL"
}


access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}


explore: fact_nexxen_dsp  {
  required_access_grants: [can_view_all_tremor]
  view_name: fact_nexxen_dsp
  persist_with: CleanCash_datagroup
  label: "Nexxen dsp"
  view_label: "Measures"

  join: dim_dsp_creative {
    type: inner
    view_label: "Creative"
    sql_on: ${dim_dsp_creative.creative_id_key}=${fact_nexxen_dsp.creative_id_key} ;;
    relationship: many_to_one
  }

  join: v_dim_dsp_date {
    type: inner
    view_label: "Time Frame"
    sql_on: ${v_dim_dsp_date.date_key_raw} = ${fact_nexxen_dsp.date_key_in_timezone_raw} ;;
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
    view_label: "Salsforce Account"
    sql_on: ${dim_sfdb_account.account_id_key} = ${fact_nexxen_dsp.account_id_key};;
    relationship: many_to_one

  }

  join: dim_sfdb_opportunity {
    type: inner
    view_label: "Salsforce Opportunity"
    sql_on: ${dim_sfdb_opportunity.opportunity_id_key} = ${fact_nexxen_dsp.opportunity_id_key} ;;
    relationship: many_to_one
  }
  join: dim_sfdb_opportunitylineitemschedule {
    type: inner
    view_label: "Salsforce Opportunity Line Item Flight"
    sql_on: ${dim_sfdb_opportunitylineitemschedule.opportunitylineitemschedule_key} = ${fact_nexxen_dsp.opportunitylineitemschedule_key} ;;
    relationship: many_to_one
  }

  join: v_dim_sfdb_opportunitylineitemschedule_looker {
    type: inner
    view_label: "Salsforce Opportunity Line Item Flight"
    sql_on: ${v_dim_sfdb_opportunitylineitemschedule_looker.opportunitylineitem_key} = ${fact_nexxen_dsp.opportunitylineitem_key}
    and ${fact_nexxen_dsp.date_key_in_timezone_raw}>= ${v_dim_sfdb_opportunitylineitemschedule_looker.scheduledate_raw} and
    ${fact_nexxen_dsp.date_key_in_timezone_raw} <= ${v_dim_sfdb_opportunitylineitemschedule_looker.end_date__c_raw};;
    relationship: many_to_one

  }
  join:  dim_sfdb_opportunitylineitem {
    type: inner
    view_label: "Salsforce Opportunity Line Item"
    sql_on: ${dim_sfdb_opportunitylineitem.opportunitylineitem_key} =${fact_nexxen_dsp.opportunitylineitem_key} ;;
    relationship: many_to_one


  }

  join: dim_sfdb_user {

    type: inner
    view_label: "Employee"
    sql_on: ${dim_sfdb_user.user_key_id}=${fact_nexxen_dsp.user_key_id};;
    relationship: many_to_one

  }


}
