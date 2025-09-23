connection: "ncd_vertica"

include: "/**/*.view.lkml"
include: "/**/*.dashboard.lookml"

explore: purple_labs_audience_quality {
  label: "Purple Labs Audience Quality"
  hidden: no
}

explore: purplelabs_audience_quality_monthly {
  label: "Purple Labs Audience Quality Monthly"
  hidden: no
}

explore: purplelabs_script_metrics {
  label: "Purple Labs Script Metrics"
  hidden: no
}
