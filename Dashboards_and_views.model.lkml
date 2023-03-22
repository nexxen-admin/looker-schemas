connection: "bi_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
 include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

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
datagroup: ChangeCleanCash_datagroup {
  sql_trigger: SELECT max(hour) FROM tremor_to_unruly ;;
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

access_grant: can_view_candidates {
  user_attribute: candidates
  allowed_values: ["candidates"]
}
#access_grant: can_view_pub_come_looker {
 # user_attribute: allowed_users
  #allowed_values: ["Looker_Admins"]
#}
explore: datorama_forcast_poc {

  required_access_grants: [can_view_all_tremor]
  hidden: yes

}
explore: sam_goal_monitor {
 access_filter: {
     field: sam_goal_monitor.sam
     user_attribute: allowed_users
   }
  label: "SAM Performance Monitor"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: sam {
  access_filter: {
    field: sam.sam
    user_attribute: allowed_users

  }
  label: "SAM Performance Monitor new"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: sam_lt_comm {
   access_filter: {
     field: sam_lt_comm.operations_owner
     user_attribute: allowed_users_sam_lt
   }
  label: "SAM LT Commision"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}


explore: sam_performance_monitor_v2 {
  access_filter: {
    field: sam_performance_monitor_v2.sam
    user_attribute: allowed_users
  }
  label: "SAM Performance Monitor V2"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: sam_lt_pub_metrics {
  access_filter: {
    field: sam_lt_pub_metrics.operations_owner
    user_attribute: allowed_users_sam_lt
  }
  label: "SAM + LT Publisher Metrics"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: phase_2_ak {
  label: "Phase 2 - AK"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: yearly_consolidated_revenue_by_region_with_amobee {
  label: "Yearly Consolidated Revenue by Region With Amobee"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: bid_details_in_app {
  label: "Bid Details - In App"
  required_access_grants: [can_view_all_tremor]
}

explore: spearad_fifa_view {
  label: "FIFA-SpearAd View"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: fifa_dsp_metrics {
  label: "FIFA-DSP View"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: bd_comm {
  label: "BD Comm US"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: bd_comm_intl {
  label: "BD Comm Intl"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: net_revenue_with_demand_ss_fees {
  label: "net revenue with demand ss fees"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: base_data_demand {
  label: "Base Data Demand"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: net_revenue_without_demand_ss_fees {
  label: "net revenue without demand ss fees"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: base_data_without_demand {
  label: "Base Data Without Demand"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: ads_txt_domain_publisher {
  label: "ads_txt_domain_publisher"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: unruly_pmp {
  label: "Unruly PMP"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: deal_splits_owner_report {
  label: "Deal_splits_owner_report"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: active_inactive_publishers {
  label: "Active Inactive Publishers"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}


explore:  exchange_daily_report_component{
  label: "Exchange Daily Report Component"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}


explore:  ivt_report{
  label: "IVT Report"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
  }

explore:  no_bid_reason{
  label: "No_Bid_Reason"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: new_revenue {
  label: "New Revenue"
  #required_access_grants:  [can_view_pub_come_looker]

  join: dim_publisher  {
  type:inner
   sql_on:  ${dim_publisher.pub_id} = ${new_revenue.pub_id};;
  relationship: many_to_one
  }
  join: v_dim_employee_pub_ops {
    type: inner
    view_label: "Employee"
    sql_on: ${v_dim_employee_pub_ops.employee_key}=${dim_publisher.ops_owner_key};;
    relationship: many_to_one
  }
  join: v_dim_employee_biz_dev {
    type: inner
    view_label: "Employee"
    sql_on: ${v_dim_employee_biz_dev.employee_key}=${dim_publisher.bizdev_owner_key};;
    relationship: many_to_one
  }
  hidden: yes

}

explore: investor_kpi{
  label: "Investor KPI"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: pubs_and_advertisers{
  label: "Pubs and Advertisers"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: revenue_vertical_buying_channel{
  label: "Revenue Vertical Buying Channel"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: investor_kpi_excluding_amobee{
  label: "Investor KPI Excluding Amobee"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: pubs_and_advertisers_excluding_amobee{
  label: "Pubs and Adverstisers Excluding Amobee"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: investor_kpi_only_amobee{
  label: "Investor KPI Only Amobee"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}

explore: pubs_and_advertisers_only_amobee{
  label: "Pubs and Advertisers Only Amobee"
  required_access_grants: [can_view_all_tremor]
  hidden: yes
}
