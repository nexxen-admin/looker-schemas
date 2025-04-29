connection: "vertica_iad"

include: "/views/third_party_reporting_fields_mapping.view"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: third_party_reporting_fields_mapping {
  label: "third_party_reporting_fields_mapping"
  hidden: no
}
