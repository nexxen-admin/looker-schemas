connection: "purple_labs"

include: "/**/*.view.lkml"
include: "/**/*.dashboard.lookml"

explore: purple_labs_audience_quality {
  label: "Purple Labs Audience Quality"
  hidden: no
  access_filter: {
    field: purple_labs_audience_quality.market_id
    user_attribute: purple_labs
  }
}

explore: purplelabs_audience_quality_monthly {
  label: "Purple Labs Audience Quality Monthly"
  hidden: no
  access_filter: {
    field: purplelabs_audience_quality_monthly.market_id
    user_attribute: purple_labs
  }
}

explore: purplelabs_script_metrics {
  label: "Purple Labs Script Metrics"
  hidden: no
  access_filter: {
    field: purplelabs_script_metrics.market_id
    user_attribute: purple_labs
  }
}
