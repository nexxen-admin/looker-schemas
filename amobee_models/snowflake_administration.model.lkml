connection: "snowflake_dbaadmin"
label: "Snowflake"

include: "/**/*.view.lkml"         # include all views in this project
#include: "*.dashboard.lookml"  # include all dashboards in this project

explore: snowflake_query_history {}




explore:  snodba_database_storage_history_mtd{
  label: "Database Storage"
}


explore: warehouse_metering_history {
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
