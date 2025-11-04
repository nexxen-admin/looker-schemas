connection: "vertica_iad"

include: "/**/*.view.lkml"                 # include all views in this project

access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}

explore: DRR {
  view_name: drr
  required_access_grants: [can_view_all_tremor]
}

explore: DRR_Legacy {
  view_name: drr_legacy
  required_access_grants: [can_view_all_tremor]
}
