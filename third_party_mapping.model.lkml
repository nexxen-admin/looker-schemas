connection: "vertica_iad"

include: "/views/third_party_reporting_fields_mapping.view"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard


access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}

access_grant: can_view_pub_come_looker {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}

explore: third_party_reporting_fields_mapping {
  label: "third_party_reporting_fields_mapping"
  hidden: no
}
