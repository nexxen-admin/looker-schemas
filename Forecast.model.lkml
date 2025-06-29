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
