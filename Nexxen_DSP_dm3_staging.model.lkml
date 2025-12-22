connection: "vertica_dm3_staging"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"
#include: "*.dashboard.lookml"
# include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard
datagroup: CleanCash_datagroup {
  sql_trigger: SELECT max(date_key) FROM BI_DSP.fact_nexxen_dsp  ;;
  max_cache_age: "15 hours"
  label: "Clean Cash Trigger"
  description: "Triggered when new date is added to ETL"
}

explore: billing_international_media_io {
  label: "Billing International - STAGING"
  hidden: yes
}
