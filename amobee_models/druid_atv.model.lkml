connection: "druid_iad_prod"

include: "/**/*.view.lkml"


explore: dod_druid_atv_raw_impression {

  join: atv_placement_details {
    type: left_outer
    relationship: one_to_many
    sql_on: ${dod_druid_atv_raw_impression.placement_id} = ${atv_placement_details.placement_id} ;;
  }
  label: "Druid Raw Impression Metrics"
  description: "This explore includes raw impression metrics. This data can be analyzed by nearly any facet that is available down to the raw detail of a single impression.
  This data is only available for the last seven days."
}
