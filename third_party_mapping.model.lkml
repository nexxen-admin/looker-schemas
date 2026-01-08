connection: "vertica_dm3"

#include: #"/views/third_party_reporting_fields_mapping.view"                # include all views in the views/ folder in this project
 include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard


access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}

explore: third_party_reporting_fields_mapping {
  required_access_grants: [can_view_all_tremor]
  label: "third_party_reporting_fields_mapping"
  hidden: no
}
