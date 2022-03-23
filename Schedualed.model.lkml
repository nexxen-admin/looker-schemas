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

explore: publishers_report_monthly_for_finance {
  required_access_grants: [can_view_pub_come_looker]
  label: "publishers report monthly for finance"
}

explore: temp_di_pub_com_looker_test {
  required_access_grants: [can_view_pub_come_looker]
}

explore: TaxAct_Hourly_Test {
  required_access_grants: [can_view_pub_come_looker]
  label: "Derek's Data"
}

explore: taxact_daily_report {
  required_access_grants: [can_view_pub_come_looker]
  label: "Derek's Data"
}

explore: pointsbet_february {
  required_access_grants: [can_view_pub_come_looker]
  label: "Derek's Data"
}

explore: covered_ca {
  required_access_grants: [can_view_pub_come_looker]
  label: "Derek's Data"
}
