connection: "vertica_iad"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
 #include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

access_grant: can_view_pub_come_looker {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}


access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}

explore: dim_dsp_monthly_strategic_targets  {
  label: "Monthly Strategic Targets"
}

explore: dim_dsp_monthly_enterprise_targets  {
  label: "Monthly Enterprise Targets"
}

explore: monthly_strategic_targets_changes  {
  label: "Monthly Strategic Targets Changes"
}

explore: monthly_enterprise_targets_changes {
  label: "Monthly Enterprise Targets Changes"
}

explore: fact_sfdb_forecast_snapshot {
  label: "Fact sfdb Forecast Snapshot"
     sql_always_where: ${fact_sfdb_forecast_snapshot.io_super_region} = 'NAM'
                        AND ${fact_sfdb_forecast_snapshot.io_type} <> 'PMP'
                        AND ${fact_sfdb_forecast_snapshot.new_enterprise_team} <> 'EMEA'
                        AND ${fact_sfdb_forecast_snapshot.io_type} IS NOT NULL;;
}

explore: fact_target_forecast_strategy_summary  {
}

explore: fact_target_forecast_enterprise_summary  {
}

#### FORECAST JOINED TABLE ####
explore: forecast_dim_sfdb_opportunity {
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
