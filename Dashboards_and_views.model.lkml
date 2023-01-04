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

}
explore: sam_goal_monitor {
 access_filter: {
     field: sam_goal_monitor.sam
     user_attribute: allowed_users
   }
  label: "SAM Performance Monitor"
  required_access_grants: [can_view_all_tremor]
}

explore: sam {
  access_filter: {
    field: sam.sam
    user_attribute: allowed_users
  }
  label: "SAM Performance Monitor new"
  required_access_grants: [can_view_all_tremor]
}

explore: sam_lt_comm {
   access_filter: {
     field: sam_lt_comm.operations_owner
     user_attribute: allowed_users_sam_lt
   }
  label: "SAM LT Commision"
  required_access_grants: [can_view_all_tremor]
}


explore: sam_performance_monitor_v2 {
  access_filter: {
    field: sam_performance_monitor_v2.sam
    user_attribute: allowed_users
  }
  label: "SAM Performance Monitor V2"
  required_access_grants: [can_view_all_tremor]
}

explore: sam_lt_pub_metrics {
  access_filter: {
    field: sam_lt_pub_metrics.operations_owner
    user_attribute: allowed_users_sam_lt
  }
  label: "SAM + LT Publisher Metrics"
  required_access_grants: [can_view_all_tremor]
}

explore: phase_2_ak {
  label: "Phase 2 - AK"
  required_access_grants: [can_view_all_tremor]
}

explore: spearad_fifa_view {
  label: "FIFA-SpearAd View"
  required_access_grants: [can_view_all_tremor]
}

explore: fifa_dsp_metrics {
  label: "FIFA-DSP View"
  required_access_grants: [can_view_all_tremor]
}

explore: bd_comm {
  label: "BD Comm US"
  required_access_grants: [can_view_all_tremor]
}

explore: bd_comm_intl {
  label: "BD Comm Intl"
  required_access_grants: [can_view_all_tremor]
}

explore: exchange_daily_report_component {
  label: "Exchange Daily Report Component"
  required_access_grants: [can_view_all_tremor]
}

explore: tremor_concentration_report_with_demand_w_out_amobee {
  label: "tremor_concentration_report_with_demand_w_out_amobee"
  required_access_grants: [can_view_all_tremor]
}
