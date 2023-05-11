connection: "bi_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
 include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
access_grant: can_view_pub_come_looker {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]

}
access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}

explore: unruly_player_demands {
  label: "Unruly Player Demands"
  required_access_grants: [can_view_all_tremor]
}

explore: unruly_player_supplies {
  label: "Unruly Player Supplies"
  required_access_grants: [can_view_all_tremor]
}
