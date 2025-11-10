connection: "bi_stby"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project

access_grant: can_view_pub_come_looker {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}


access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}


explore: forecast_data {

  access_filter: {
    field: forecast_data.strat_sales_team
    user_attribute: forecast_strat
  }
  access_filter: {
    field: forecast_data.new_enterprise_team
    user_attribute: forecast_enterprise
  }

  label: "Forecast New"
  required_access_grants: [can_view_all_tremor]
  sql_always_where: ${io_super_region} ILIKE '%NAM%'
  AND ${snapshot_forecast_checkbox} = 1
  --AND ${schedule_is_free} = 0
  AND ${opportunity_record_type} NOT ILIKE '%MSA Contract Opportunity%'
  AND ${opportunity_record_type} NOT ILIKE '%Upsell Opportunity%';;

  join: forecast_dim_sfdb_opportunity {
    type: left_outer
    sql_on: ${forecast_data.opportunity_id} = ${forecast_dim_sfdb_opportunity.id} ;;
    relationship: many_to_one
    fields: [
      vertical,
      status_reason__c,
      win_reason__c,
      win_reason_details__c,
      loss_reason__c,
      loss_reason_details__c
    ]
  }
}

explore: forecast_top20_opp_view {

}

explore: market_expectation {
  label: "Forecast Market Expectation"
  required_access_grants: [can_view_all_tremor]
}

explore: fact_forecast_full_summary {
  label: "Forecast Joined Teams"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: dim_dsp_monthly_strategic_targets  {
  required_access_grants: [can_view_all_tremor]
  label: "Monthly Strategic Targets"
}

explore: dim_dsp_monthly_enterprise_targets  {
  required_access_grants: [can_view_all_tremor]
  label: "Monthly Enterprise Targets"
}

explore: monthly_strategic_targets_changes  {
  required_access_grants: [can_view_all_tremor]
  label: "Monthly Strategic Targets Changes"
}

explore: monthly_enterprise_targets_changes {
  required_access_grants: [can_view_all_tremor]
  label: "Monthly Enterprise Targets Changes"
}

explore: fact_sfdb_forecast_snapshot {

  access_filter: {
    field: fact_sfdb_forecast_snapshot.Strat_Sales_Team
    user_attribute: forecast_strat
  }
  access_filter: {
    field: fact_sfdb_forecast_snapshot.new_enterprise_team
    user_attribute: forecast_enterprise
  }

  required_access_grants: [can_view_all_tremor]
  label: "Fact sfdb Forecast Snapshot"



  sql_always_where:
  ${io_super_region} ILIKE '%NAM%'
  AND UPPER(${io_type}) <> 'PMP'
  AND UPPER(${io_type}) IS NOT NULL
  AND UPPER(${revenue_line}) <> 'MISSING'
  AND UPPER(${revenue_line}) <> 'PMP'
  AND ${stage} NOT ILIKE '%Closed Lost%'
  --AND (${new_enterprise_team}) <> 'Unknown'
  AND ${io_type} IS NOT NULL
  AND ${Snapshot_Forecast_Checkbox} = 1
  AND ${schedule_is_free} = 0
  AND ${opportunity_record_type} NOT ILIKE '%MSA Contract Opportunity%'
  AND ${opportunity_record_type} NOT ILIKE '%Upsell Opportunity%'
  --AND ${Snapshot_Forecast_Checkbox} = 1
  AND ${opportunity_name} NOT ilike '%PMP%'
  ;;
  }

explore: fact_target_forecast_strategy_summary  {
  required_access_grants: [can_view_all_tremor]
  sql_always_where: ${Strat_Sales_Team}!='Unknown' ;;

  join: forecast_dim_sfdb_user {
    type: left_outer
    sql_on: ${fact_target_forecast_strategy_summary.seller_key} = ${forecast_dim_sfdb_user.fullname_key} ;;
    relationship: many_to_one
  }

}

# explore: fact_target_forecast_enterprise_summary  {
#   required_access_grants: [can_view_all_tremor]
#   sql_always_where: ${new_enterprise_team}!='Unknown' ;;

#   join: forecast_dim_sfdb_user {
#     type: left_outer
#     sql_on: ${fact_target_forecast_enterprise_summary.generalist_name_key} = ${forecast_dim_sfdb_user.fullname_key} ;;
#     relationship: many_to_one
#   }

# }


# explore: fact_target_forecast_enterprise_summary  {
#   required_access_grants: [can_view_all_tremor]
#   sql_always_where: ${new_enterprise_team}!='Unknown' OR ${account_name} ILIKE ('Klick Health', '301 Digital Media', 'Good Karma Brands', 'Guru', 'Rescue Agency') ;;

#   join: forecast_dim_sfdb_user {
#     type: left_outer
#     sql_on: ${fact_target_forecast_enterprise_summary.generalist_name_key} = ${forecast_dim_sfdb_user.fullname_key} ;;
#     relationship: many_to_one
#   }
# }

explore: fact_target_forecast_enterprise_summary {
  required_access_grants: [can_view_all_tremor]
  # UPDATED sql_always_where CLAUSE using ILIKE
  sql_always_where: ${new_enterprise_team}!='Unknown' OR (
    ${account_name} ILIKE '%Klick Health%' OR
    ${account_name} ILIKE '%301 Digital Media%' OR
    ${account_name} ILIKE '%Good Karma Brands%' OR
    ${account_name} ILIKE '%Guru%' OR
    ${account_name} ILIKE '%U.S. HealthConnect%' OR
    ${account_name} ILIKE '%Active International%'OR
    ${account_name} ILIKE '%Starcom - US%'OR
    ${account_name} ILIKE '%Rescue Agency%'
  ) ;;

  join: forecast_dim_sfdb_user {
    type: left_outer
    sql_on: ${fact_target_forecast_enterprise_summary.generalist_name_key} = ${forecast_dim_sfdb_user.fullname_key} ;;
    relationship: many_to_one
  }
}

#### FORECAST JOINED TABLE ####
explore: forecast_dim_sfdb_opportunity {
  required_access_grants: [can_view_all_tremor]
  label: "Forecasting"

  # label: "Forecast Opportunity Line Item Schedule"

  join: forecast_dim_sfdb_opportunitylineitem {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_opportunity.opportunity_aid__c} = ${forecast_dim_sfdb_opportunitylineitem.opportunityid} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_opportunitylineitemschedule {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_opportunitylineitemschedule.opportunitylineitemid} = ${forecast_dim_sfdb_opportunitylineitem.opportunitylineitem_aid__c} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_account {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_opportunity.accountid} = ${forecast_dim_sfdb_account.account_aid__c} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_user_opportunity_account_manager {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_user_opportunity_account_manager.opp_account_manager_id} = ${forecast_dim_sfdb_opportunity.account_manager__c} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_userrole_account_manager {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_userrole_account_manager.id} = ${forecast_dim_sfdb_user_opportunity_account_manager.opp_account_manager_userroleid} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_user_opportunity_owner {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_user_opportunity_owner.opp_owner_id} = ${forecast_dim_sfdb_opportunity.ownerid} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_userrole_owner {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_userrole_owner.id} = ${forecast_dim_sfdb_user_opportunity_owner.opp_owner_userroleid} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_user_opportunity_delivery_manager {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_user_opportunity_delivery_manager.opp_delivery_manager_id} = ${forecast_dim_sfdb_opportunity.delivery_manager__c} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_userrole_delivery_manager {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_userrole_delivery_manager.id} = ${forecast_dim_sfdb_user_opportunity_delivery_manager.opp_delivery_manager_userroleid} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_opportunity_employee {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_opportunity_employee.opportunity_id} = ${forecast_dim_sfdb_opportunity.opportunity_aid__c} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_account_brand {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_account_brand.account_aid__c} = ${forecast_dim_sfdb_opportunity.related_account_aid__c} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_price_type__c {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_price_type__c.id} = ${forecast_dim_sfdb_opportunitylineitem.price_type__c} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_product_configuration__c {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_opportunitylineitem.product_configuration__c} = ${forecast_dim_sfdb_product_configuration__c.id} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_legal_entity__c {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_legal_entity__c.id} = ${forecast_dim_sfdb_account.legal_entity__c} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_corp_entity__c {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_corp_entity__c.id} = ${forecast_dim_sfdb_opportunity.corp_entity__c} ;;
    relationship: many_to_one
  }

  join: forecast_dim_sfdb_opp_team_member__c {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_opp_team_member__c.opportunity__c} = ${forecast_dim_sfdb_opportunity.opportunity_aid__c} ;;
    relationship: many_to_one
  }

  join: forecast_user_member_c {
    type: left_outer
    sql_on: ${forecast_dim_sfdb_opp_team_member__c.member__c} = ${forecast_user_member_c.aid__c} ;;
    relationship: many_to_one
  }
}
