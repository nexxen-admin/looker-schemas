connection: "bi_prod"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

access_grant: can_view_fusion_explores {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}

explore: dsrs_requests {
  #required_access_grants: [can_view_fusion_explores]
  label: "DSRS Request Statistics"
}

explore: kong_consumers {
  #required_access_grants: [can_view_fusion_explores]
  label: "Kong Consumers Statistics"
}
