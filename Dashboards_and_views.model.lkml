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
explore:  daily_kpi_s_data{

  label: "Daily KPI's Data"
  required_access_grants: [can_view_candidates]

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
     user_attribute: allowed_users
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
    user_attribute: allowed_users
  }
  label: "SAM + LT Publisher Metrics"
  required_access_grants: [can_view_all_tremor]
}

explore: phase_2_ak {
  label: "Phase 2 - AK"
  required_access_grants: [can_view_all_tremor]
}

explore: tremor_to_unruly {
}
