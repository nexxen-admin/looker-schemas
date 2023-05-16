connection: "snowflake_dbaadmin"
label: "Snowflake"

include: "snodba_*.view.lkml"         # include all views in this project
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

explore: account_query_history {
  label: "Warehouse Weekly Statistics"
  join: account_warehouse_metering_history {
    relationship: one_to_one
    type: inner
    sql_on: ${account_warehouse_metering_history.warehouse_name} = ${account_query_history.warehouse_name}
        AND ${account_warehouse_metering_history.capture_date} =   ${account_query_history.capture_date};;
  }

  join: account_warehouse_load_history {
    relationship: one_to_one
    type: inner
    sql_on:   ${account_query_history.warehouse_name} = ${account_warehouse_load_history.warehouse_name}
          AND ${account_query_history.capture_date} =   ${account_warehouse_load_history.capture_date}
          ;;
  }
}

explore: account_users {}

explore: account_tables {
  join: account_table_storage_metrics {
    relationship: one_to_one
    type: inner
    sql_on: ${account_tables.table_id} = ${account_table_storage_metrics.id} ;;
  }
}

explore: snodba_account_db_storage_history {
  label: "DB account storage"
}

explore: account_full_query_history {

}

explore: account_full_query_history_daily {

}

explore: account_query_history_clean {}

explore: new_query_history {}

explore: new_warehouse_cost {}
