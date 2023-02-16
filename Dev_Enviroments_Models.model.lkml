connection: "bi_dev"

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


access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}

access_grant: can_view_pub_come_looker {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}

access_grant: can_view_acr_group {
  user_attribute: acr_group
  allowed_values: ["ACR_Group"]
}


explore: count_device_id_per_os {
  label: "count device id per os"
  required_access_grants: [can_view_acr_group]
}

explore: ACR_daily_count_unique_ip {
  label: "ACR daily count unique_ip"
  required_access_grants: [can_view_acr_group]
}

explore: daily_null_count_all_col {
  label: "daily null count all col"
  required_access_grants: [can_view_acr_group]
}

explore: all_coumns_is_null_chart {
  label: "all coumns is null chart"
  required_access_grants: [can_view_acr_group]
}

explore: acr_weekly_ip_apps {
  label: "acr weekly ip apps"
  required_access_grants: [can_view_acr_group]
}

explore: acr_weekly_app_os_device_count {
  label: "acr weekly app os device count"
  required_access_grants: [can_view_acr_group]
}

explore: acr_weekly_title_device {
  label: "acr weekly title device"
  required_access_grants: [can_view_acr_group]
}

explore: acr_weekly_app_count_title {
  label: "acr weekly app count title"
  required_access_grants: [can_view_acr_group]
}

explore: acr_weekly_unique_program_over_networks_linear {
  label: "acr weekly unique program over networks linear"
  required_access_grants: [can_view_acr_group]
}

explore: monthly_ip_stability {
  label: "monthly ip stability"
  required_access_grants: [can_view_acr_group]
}

explore: monthly_device_count {
  label: "monthly device count"
  required_access_grants: [can_view_acr_group]
}
