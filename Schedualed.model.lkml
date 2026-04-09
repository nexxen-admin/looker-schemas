connection: "vertica_iad"

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

access_grant: allowed_users_sam_lt {
  user_attribute: allowed_users_sam_lt
  allowed_values: ["allowed_users_sam_lt"]
}

access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}


# explore: publishers_report_monthly_for_finance {
#   required_access_grants: [allowed_users_sam_lt]
#   label: "publishers report monthly for finance"
#   # hidden: yes
# }

explore: daily_publisher_report_pluto {
  #required_access_grants: [can_view_pub_come_looker]
  label: "Daily_Publisher_Reports"
  hidden: yes
}

explore: temp_di_pub_com_looker_test {
  required_access_grants: [can_view_pub_come_looker]
  hidden: yes
}

explore: audigent_kroger_deal_data {
  required_access_grants: [can_view_pub_come_looker]
  label: "Audigent Kroger Data - UTC"
  hidden: yes
}

explore: omp_gross_net_by_month {
  #required_access_grants: [can_view_pub_come_looker]
  label: "OMP Gross & Net by Month (2023)"
  hidden: yes
}


explore: QPSxRPM {
  required_access_grants: [can_view_pub_come_looker]
  label: "QPSxRPM Supply"
  hidden: yes
}
