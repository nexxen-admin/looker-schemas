connection: "snowflake_dbaadmin"
label: "Snowflake"

include: "/**/*.view.lkml"         # include all views in this project
#include: "*.dashboard.lookml"  # include all dashboards in this project

access_grant: can_see_model {
  user_attribute: admins
  allowed_values: ["External_Users"]
}


explore: snowflake_query_history {required_access_grants:[can_see_model]}




explore:  snodba_database_storage_history_mtd{
  required_access_grants:[can_see_model]
  label: "Database Storage"
}


explore: warehouse_metering_history {
  required_access_grants:[can_see_model]
  label: "Warehouse Usage"

  join: expected_warehouse_usage {
    relationship: one_to_one
    view_label: "Expected Warehouse Usage"
    type: left_outer
    fields: [expected_credits,expected_spend,avg_expected_credits,avg_expected_spend,sum_expected_credits,sum_expected_spend]
    sql_on: ${expected_warehouse_usage.Dates_raw} = ${warehouse_metering_history.Dates_raw}
      and ${expected_warehouse_usage.warehouse} = ${warehouse_metering_history.warehouse};;
  }

  join: previous_warehouse_usage {
    view_label: "Previous Month Usage"
    from: warehouse_metering_history
    relationship: one_to_one
    type: left_outer
    fields: [avg_credits_spend,avg_credits_used,credit_spend,credits_used,sum_credits_spend,sum_credits_used]
    sql_on: dateadd('month',1,${previous_warehouse_usage.Dates_raw}) = ${warehouse_metering_history.Dates_raw}
      and ${previous_warehouse_usage.warehouse} = ${warehouse_metering_history.warehouse};;
  }
}
