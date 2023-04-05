connection: "druid"

include: "/**/*.view.lkml"

access_grant: can_see_model {
  user_attribute: admins
  allowed_values: ["External_Users"]
}

explore: dod_druid_atv_raw_impression {
  required_access_grants: [can_see_model]
  join: atv_placement_details {
    type: left_outer
    relationship: one_to_many
    sql_on: ${dod_druid_atv_raw_impression.placement_id} = ${atv_placement_details.placement_id} ;;
  }
  label: "Druid Raw Impression Metrics"
  description: "This explore includes raw impression metrics. This data can be analyzed by nearly any facet that is available down to the raw detail of a single impression.
  This data is only available for the last seven days."
}
