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

access_grant: can_view_aniview {
  user_attribute: aniview
  allowed_values: ["Aniview"]

}

explore: unruly_player_demands {
  view_name: unruly_player_demands
  label: "Unruly Player Demands"
  required_access_grants: [can_view_aniview]
  # access_filter: {
  #   field: dim_employee.employee_name
  #   user_attribute: unruly_player
  # }

  # join: dim_publisher {
  #     type: left_outer
  #   # view_label: "Impression Attributes"
  #     sql_on: ${unruly_player_demands.pub_id}=${dim_publisher.pub_id} ;;
  #     relationship: many_to_one
  #   }

  join: dim_employee {
    type: inner
    sql_on: ${dim_employee.employee_key}=${unruly_player_demands.employee_key} ;;
    relationship: many_to_one
  }

  # join: dim_up_employee_targets {
  #   type: inner
  #   sql_on: ${unruly_player_demands.employee_key}=${dim_up_employee_targets.employee_key} and
  #   ${unruly_player_demands.activity_month}=${dim_up_employee_targets.target_month};;
  #   relationship: many_to_one
  #   required_access_grants: [can_view_pub_come_looker]
  # }

}

explore: unruly_player_supplies {
  label: "Unruly Player Supplies"
  required_access_grants: [can_view_all_tremor]
}

explore: extend_unruly_player_demands {
  extends: [unruly_player_demands]
  label: "Extend Unruly Player Demands"
  from: unruly_player_demands
  required_access_grants: [can_view_aniview]
  access_filter: {
    field: dim_employee.employee_name
    user_attribute: unruly_player
  }

  join: dim_employee {
    type: inner
    sql_on: ${dim_employee.employee_key}=${unruly_player_demands.employee_key} ;;
    relationship: many_to_one
  }

  join: dim_up_employee_targets {
    type: inner
    sql_on: ${unruly_player_demands.employee_key}=${dim_up_employee_targets.employee_key} and
      ${unruly_player_demands.activity_month}=${dim_up_employee_targets.target_month};;
    relationship: many_to_one
    required_access_grants: [can_view_aniview]
  }
}
