connection: "vertica_iad"

include: "/amobee_views/*.view.lkml"

access_grant: can_view_pub_come_looker {
  user_attribute: admins
  allowed_values: ["Looker_Admins"]
}

access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}

explore: amobee_media_daily_mtz_view {
  required_access_grants: [can_view_all_tremor]
}
