connection: "vertica_dm3"

include: "/views/dwh_validation_config.view.lkml"
include: "/views/dwh_validation_results.view.lkml"

explore: dwh_validation_results {
  label: "DWH Validation Results"
  description: "Validation execution audit log joined with validation configuration"

  join: dwh_validation_config {
    type: left_outer
    sql_on: ${dwh_validation_results.validation_id} = ${dwh_validation_config.validation_id} ;;
    relationship: many_to_one
  }
}
