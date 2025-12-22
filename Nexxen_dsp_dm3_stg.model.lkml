connection: "vertica_dm3_staging"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"

datagroup: CleanCash_datagroup {
  sql_trigger: SELECT max(date_key) FROM BI_DSP.fact_nexxen_dsp  ;;
  max_cache_age: "15 hours"
  label: "Clean Cash Trigger"
  description: "Triggered when new date is added to ETL"
}

access_grant: billing_report_group {
  user_attribute: billing_group
  allowed_values: ["yes"]
}

access_grant: can_view_all_tremor {
  user_attribute: all_tremor
  allowed_values: ["all_tremor"]
}

explore:  monthly_international_billing_locked_report {
  label: "International Locked Report"
}
